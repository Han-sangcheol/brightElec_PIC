/*******************************************************************************
 * Communication.c - 통신 오케스트레이션 (조정자 역할)
 *
 * 기능:
 *   - UART2 패킷 수신 ISR (링 버퍼 조립)
 *   - communication() 메인 처리: 수신 → 검증 → 파싱 → 디스패치 → 응답
 *   - Communication_IsHealthy(): 통신 건강 상태 반환 (1초 주기 자체 판단 결과)
 *   - 타이머 카운터 및 RX 카운터 관리
 *
 * 분리된 모듈 호출:
 *   - Protocol.ValidatePacket/ParsePacket/FormatResponse (protocol_adapter)
 *   - CommandHandler_Dispatch/NotifyRx (command_handler)
 *   - UartTx2.Send (uart_wrapper)
 *
 * 적용 패턴:
 *   14: Ring Buffer - rxRingBuffer UART RX 링 버퍼
 *
 * 호출 관계:
 *   UART2 ISR → RingBuffer → communication() → Protocol (protocol_adapter.c)
 *                                              → CommandHandler (command_handler.c)
 *                                              → UartTx2 (uart_wrapper.c)
 ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <xc.h>
#include <string.h>

#include "Communication.h"
#include "protocol_adapter.h"
#include "command_handler.h"
#include "uart_wrapper.h"
#include "ring_buffer.h"

#include "uart2.h"

/* 프로토콜 상수 (패킷 조립용) -------------------------------------------*/
#define dSTX            0x40
#define dETX            0x2A

/*=============================================================================
 * 정적 변수 (오케스트레이션 전용)
 *===========================================================================*/
static volatile uint8_t g_uart2_rx_flag;           /* UART ISR 쓰기, Task 읽기 */
static uint8_t command_rx_buffer[20];              /* rx = Receive, 플래그 기반 동기화 */

static volatile uint8_t g_uart2_tx_flag;           /* UART ISR 쓰기, Task 읽기 */
static volatile uint16_t g_timer1ms_comm;          /* SW Timer 쓰기, Task 읽기 */

static volatile uint16_t g_u16UartRXCounter;       /* UART ISR 쓰기, Task 읽기 */

/* 통신 건강 상태 (1초 주기 자체 판단) */
static uint16_t g_healthCheckTimer;                /* 1ms 카운터 (1초 주기용) */
static uint16_t g_lastRxCount;                     /* 이전 RX 카운터 (비교 기준) */
static bool     g_commHealthy;                     /* 건강 상태: true=수신 있음 */

/* Ring Buffer - UART RX(Receive) 링 버퍼 */
static RingBuffer_t rxRingBuffer;

/* TX(Transmit) 응답 버퍼 */
static uint8_t txBuffer[20];

/*=============================================================================
 * communication - 통신 메인 처리 함수 (메인루프에서 호출)
 *
 * 흐름:
 *   1) g_uart2_rx_flag 확인 (ISR에서 패킷 완성 시 설정)
 *   2) Protocol.ValidatePacket() → Assertion (protocol_adapter)
 *   3) Protocol.ParsePacket()    → Adapter  (protocol_adapter)
 *   4) CommandHandler_Dispatch() → Command  (command_handler)
 *   5) CommandHandler_NotifyRx() → Callback (command_handler)
 *   6) Protocol.FormatResponse() + UartTx2.Send()
 *===========================================================================*/
void communication(MotorData* motorData_cmd, MotorData* motorData_now)
{
    if (g_uart2_rx_flag)
    {
        g_uart2_rx_flag = 0;

        /* Assertion - 패킷 유효성 검증 (protocol_adapter) */
        PacketValidation_e validation = Protocol.ValidatePacket(command_rx_buffer, 18);

        if (validation == PACKET_OK)
        {
            /* Adapter - 프로토콜 파싱 (protocol_adapter) */
            Protocol.ParsePacket(command_rx_buffer, 18);

            /* Command - 명령 ID 추출 및 디스패치 (command_handler) */
            uint8_t cmdId = (Protocol.AsciiToHex(command_rx_buffer[1]) << 4)  /* cmd = Command */
                          |  Protocol.AsciiToHex(command_rx_buffer[2]);
            CommandHandler_Dispatch(cmdId, motorData_cmd);

            /* Callback - RX 이벤트 콜백 실행 (command_handler) */
            CommandHandler_NotifyRx();
        }
    }

    /* TX 응답 전송 */
    if (g_timer1ms_comm >= 100)
    {
        g_timer1ms_comm = 0;

        uint8_t txLen = Protocol.FormatResponse(txBuffer);
        UartTx2.Send(txBuffer, txLen);
    }
}

/*=============================================================================
 * UART2_RxCompleteCallback - UART2 수신 ISR 콜백
 * Ring Buffer 사용하여 패킷 조립
 *===========================================================================*/
void UART2_RxCompleteCallback(void)
{
    static uint8_t rxAssemblyBuf[256];  /* rx = Receive, Buf = Buffer */
    static uint8_t rxIndex = 0;        /* rx = Receive */
    uint8_t rxByte;                    /* rx = Receive */

    /* 오버런 에러 클리어 */
    if (U2STAbits.OERR)
    {
        U2STAbits.OERR = 0;
    }

    if (rxIndex >= 256) rxIndex = 0;

    rxByte = UART2_Drv_Read();

    /* Ring Buffer에도 원시 데이터 저장 (디버그/로그용) */
    RingBuffer_Put(&rxRingBuffer, rxByte);

    /* 패킷 조립 */
    rxAssemblyBuf[rxIndex++] = rxByte;
    rxAssemblyBuf[rxIndex] = 0;

    /* STX 검증 */
    if ((rxAssemblyBuf[0] & 0xff) != dSTX)
    {
        rxIndex = 0;
    }

    /* ETX 감지 → 패킷 완성 */
    if (rxIndex > 3 && (rxAssemblyBuf[rxIndex - 3] & 0xff) == dETX)
    {
        memcpy(command_rx_buffer, rxAssemblyBuf, rxIndex);
        g_uart2_rx_flag = 1;
        g_uart2_tx_flag = 1;
        rxIndex = 0;
    }

    g_u16UartRXCounter++;
}

/*=============================================================================
 * timer1ms_communication - 1ms 타이머 통신 카운터 (SW Timer 콜백)
 * 1) TX 응답 타이머 카운터 증가
 * 2) 1초 주기로 통신 건강 상태 자체 판단 (RX 카운터 변화 감지)
 *===========================================================================*/
void timer1ms_communication(void)
{
    g_timer1ms_comm++;

    /* 1초 주기 통신 건강 상태 판단 */
    g_healthCheckTimer++;
    if (g_healthCheckTimer >= 1000)
    {
        g_healthCheckTimer = 0;
        g_commHealthy = (g_u16UartRXCounter != g_lastRxCount);
        g_lastRxCount = g_u16UartRXCounter;
    }
}

/*=============================================================================
 * Get_Rx_Ccount - RX 카운터 반환 (통신 상태 확인용)
 *===========================================================================*/
uint16_t Get_Rx_Ccount(void)
{
    return g_u16UartRXCounter;
}

/*=============================================================================
 * Communication_IsHealthy - 통신 건강 상태 반환 (단순 getter)
 * timer1ms_communication()에서 1초 주기로 자체 판단한 결과를 반환
 * LedBlinker의 StatusProvider_t 콜백으로 등록 가능
 *
 * return: true=수신 있음(정상), false=수신 없음(이상)
 *===========================================================================*/
bool Communication_IsHealthy(void)
{
    return g_commHealthy;
}
