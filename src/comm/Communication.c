/*******************************************************************************
 * Communication.c - 통신 오케스트레이션 (조정자 역할, HW 독립)
 *
 * 기능:
 *   - communication() 메인 처리: 수신 → 검증 → 파싱 → 디스패치 → 응답
 *   - Communication_IsHealthy(): 통신 건강 상태 반환 (1초 주기 자체 판단 결과)
 *   - 타이머 카운터 및 RX 카운터 관리
 *
 * 분리된 모듈 호출:
 *   - Protocol.ValidatePacket/ParsePacket/FormatResponse (protocol)
 *   - CommandHandler_Dispatch/NotifyRx (command_handler)
 *   - UartTx2.Send (Communication_drv)
 *
 * 계층 구조 (수평 분리):
 *   Application(pmsm.c) → Core(이 파일) → Driver(Communication_drv)
 *                                        → Protocol(protocol)
 *                                        → Command(command_handler)
 *
 * 호출 관계:
 *   Communication_drv ISR → 공유변수 → communication() → Protocol (protocol.c)
 *                                                       → CommandHandler (command_handler.c)
 *                                                       → UartTx2 (Communication_drv.c)
 ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>

#include "Communication.h"
#include "Communication_cfg.h"
#include "Communication_drv.h"
#include "protocol.h"
#include "command_handler.h"

/*=============================================================================
 * 정적 변수 (오케스트레이션 전용)
 *===========================================================================*/
static volatile uint16_t g_timer1ms_comm;          /* SW Timer 쓰기, Task 읽기 */

/* 통신 건강 상태 (1초 주기 자체 판단) */
static uint16_t g_healthCheckTimer;                /* 1ms 카운터 (1초 주기용) */
static uint16_t g_lastRxCount;                     /* 이전 RX 카운터 (비교 기준) */
static bool     g_commHealthy;                     /* 건강 상태: true=수신 있음 */

/* TX(Transmit) 응답 버퍼 */
static uint8_t txBuffer[COMM_TX_PACKET_LEN];

/*=============================================================================
 * communication - 통신 메인 처리 함수 (메인루프에서 호출)
 *
 * 흐름:
 *   1) g_uart2_rx_flag 확인 (ISR에서 패킷 완성 시 설정)
 *   2) Protocol.ValidatePacket() → Assertion (protocol)
 *   3) Protocol.ParsePacket()    → Parsing  (protocol)
 *   4) CommandHandler_Dispatch() → Command  (command_handler)
 *   5) CommandHandler_NotifyRx() → Callback (command_handler)
 *   6) Protocol.FormatResponse() + UartTx2.Send()
 *===========================================================================*/
void communication(void)
{
    if (g_uart2_rx_flag)
    {
        g_uart2_rx_flag = 0;

        /* Assertion - 패킷 유효성 검증 (protocol) */
        PacketValidation_e validation = Protocol.ValidatePacket(command_rx_buffer, COMM_RX_PACKET_LEN);

        if (validation == PACKET_OK)
        {
            /* 프로토콜 파싱 (protocol) */
            Protocol.ParsePacket(command_rx_buffer, COMM_RX_PACKET_LEN);

            /* Command - 명령 ID 추출 및 디스패치 (command_handler) */
            uint8_t cmdId = (Protocol.AsciiToHex(command_rx_buffer[1]) << 4)  /* cmd = Command */
                          |  Protocol.AsciiToHex(command_rx_buffer[2]);
            CommandHandler_Dispatch(cmdId);

            /* Callback - RX 이벤트 콜백 실행 (command_handler) */
            CommandHandler_NotifyRx();
        }
    }

    /* TX 응답 전송 */
    if (g_timer1ms_comm >= COMM_TX_INTERVAL_MS)
    {
        g_timer1ms_comm = 0;

        uint8_t txLen = Protocol.FormatResponse(txBuffer);
        UartTx2.Send(txBuffer, txLen);
    }
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
    if (g_healthCheckTimer >= COMM_HEALTH_PERIOD_MS)
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
