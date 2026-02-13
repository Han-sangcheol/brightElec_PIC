/*******************************************************************************
 * Communication.c - 통신 오케스트레이션 (조정자 역할, HW 독립)
 *
 * 기능:
 *   - communication() 메인 처리: 수신 → 검증 → 파싱 → 디스패치 → 응답
 *   - Communication_IsHealthy(): 통신 건강 상태 반환 (1초 주기 판단 결과)
 *   - timer1ms_communication(): SW Timer 콜백 (카운터 증가만)
 *
 * 분리된 모듈 호출:
 *   - COMM_Drv_IsPacketReady/GetPacket/GetRxPacketCount (Communication_drv)
 *   - Protocol.ValidatePacket/ParsePacket/FormatResponse (protocol)
 *   - CommandHandler_Dispatch/NotifyRx (command_handler)
 *   - UartTx2.Send (Communication_drv)
 *
 * 계층 구조 (수평 분리):
 *   Application(pmsm.c) → Core(이 파일) → Driver(Communication_drv API)
 *                                        → Protocol(protocol)
 *                                        → Command(command_handler)
 *
 * 호출 관계:
 *   Communication_drv ISR → static 변수 → COMM_Drv API → communication()
 *                                                       → Protocol (protocol.c)
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
static volatile uint16_t g_healthCheckTimer;       /* SW Timer 쓰기, Task 읽기 */

/* 통신 건강 상태 (communication()에서 1초 주기 판단) */
static uint16_t g_lastRxCount;                     /* 이전 RX 카운터 (비교 기준) */
static bool     g_commHealthy;                     /* 건강 상태: true=수신 있음 */

/* RX/TX 버퍼 (Core 소유) */
static uint8_t rxBuffer[COMM_RX_PACKET_LEN];       /* 수신 패킷 버퍼 */
static uint8_t txBuffer[COMM_TX_PACKET_LEN];       /* 송신 패킷 버퍼 */

/*=============================================================================
 * communication - 통신 메인 처리 함수 (메인루프에서 호출)
 *
 * 흐름:
 *   1) COMM_Drv_IsPacketReady() → 패킷 수신 여부 확인 (drv API)
 *   2) COMM_Drv_GetPacket()     → 패킷 복사 + 플래그 클리어 (drv API)
 *   3) Protocol.ValidatePacket() → Assertion (protocol)
 *   4) Protocol.ParsePacket()    → Parsing  (protocol)
 *   5) CommandHandler_Dispatch() → Command  (command_handler)
 *   6) CommandHandler_NotifyRx() → Callback (command_handler)
 *   7) Protocol.FormatResponse() + UartTx2.Send() (100ms 주기)
 *   8) 통신 건강 상태 판단 (1초 주기, RX 카운터 변화 감지)
 *===========================================================================*/
void communication(void)
{
    if (COMM_Drv_IsPacketReady())
    {
        uint8_t rxLen = COMM_Drv_GetPacket(rxBuffer, COMM_RX_PACKET_LEN);

        /* Assertion - 패킷 유효성 검증 (protocol) */
        PacketValidation_e validation = Protocol.ValidatePacket(rxBuffer, rxLen);

        if (validation == PACKET_OK)
        {
            /* 프로토콜 파싱 (protocol) */
            Protocol.ParsePacket(rxBuffer, rxLen);

            /* Command - 명령 ID 추출 및 디스패치 (command_handler) */
            uint8_t cmdId = (Protocol.AsciiToHex(rxBuffer[1]) << 4)
                          |  Protocol.AsciiToHex(rxBuffer[2]);
            CommandHandler_Dispatch(cmdId);

            /* Callback - RX 이벤트 콜백 실행 (command_handler) */
            CommandHandler_NotifyRx();
        }
    }

    /* TX 응답 전송 (100ms 주기) */
    if (g_timer1ms_comm >= COMM_TX_INTERVAL_MS)
    {
        g_timer1ms_comm = 0;

        uint8_t txLen = Protocol.FormatResponse(txBuffer);
        UartTx2.Send(txBuffer, txLen);
    }

    /* 통신 건강 상태 판단 (1초 주기) */
    if (g_healthCheckTimer >= COMM_HEALTH_PERIOD_MS)
    {
        g_healthCheckTimer = 0;
        g_commHealthy = (COMM_Drv_GetRxPacketCount() != g_lastRxCount);
        g_lastRxCount = COMM_Drv_GetRxPacketCount();
    }
}

/*=============================================================================
 * timer1ms_communication - 1ms 타이머 카운터 (SW Timer 콜백, ISR 컨텍스트)
 * 카운터 증가만 수행, 판단 로직은 communication() Task에서 처리
 *===========================================================================*/
void timer1ms_communication(void)
{
    g_timer1ms_comm++;
    g_healthCheckTimer++;
}

/*=============================================================================
 * Communication_IsHealthy - 통신 건강 상태 반환 (단순 getter)
 * communication()에서 1초 주기로 판단한 결과를 반환
 * LedBlinker의 StatusProvider_t 콜백으로 등록 가능
 *
 * return: true=수신 있음(정상), false=수신 없음(이상)
 *===========================================================================*/
bool Communication_IsHealthy(void)
{
    return g_commHealthy;
}
