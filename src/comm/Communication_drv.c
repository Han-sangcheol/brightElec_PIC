/*******************************************************************************
 * Communication_drv.c - 통신 드라이버 (프로젝트별 HW 바인딩)
 *
 * 기능:
 *   - UART1/UART2 하드웨어 전송 래퍼 (UartTx1, UartTx2)
 *   - UART2 수신 ISR 콜백 (패킷 조립)
 *   - COMM_Drv API: 패킷 수신 여부/데이터/카운터 (캡슐화된 접근)
 *   - HW 레지스터 직접 접근 집중 (U2STAbits, U1STAHbits)
 *
 * 적용 패턴:
 *   01: Wrapper    - 하드웨어 직접 접근을 래퍼 함수로 감쌈
 *   캡슐화         - ISR 내부 변수를 static으로 소유, API 함수로만 외부 제공
 *
 * 호출 관계:
 *   UART2 HW ISR → UART2_RxCompleteCallback() → 내부 static 변수에 저장
 *   Communication.c → COMM_Drv_IsPacketReady/GetPacket/GetRxPacketCount()
 *   Communication.c → UartTx2.Send() → 이 파일
 *
 * HW 의존 (프로젝트 이식 시 수정 포인트):
 *   - uart1.h: UART1_DataWrite(), UART1_InterruptTransmitFlagClear()
 *   - uart2.h: UART2_Write(), UART2_Drv_Read()
 *   - xc.h:    U2STAbits.OERR, U1STAHbits.UTXBF
 ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include <xc.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "Communication_drv.h"
#include "Communication_cfg.h"

#include "uart1.h"
#include "uart2.h"

/*=============================================================================
 * 패킷 수신 플래그 상태
 *===========================================================================*/
typedef enum {
    RX_FLAG_EMPTY,      /* 수신 패킷 없음 */
    RX_FLAG_READY       /* 패킷 수신 완료 */
} RxFlag_e;

/*=============================================================================
 * ISR 내부 변수 (static 캡슐화 - 외부에서 API 함수로만 접근)
 *===========================================================================*/
static volatile RxFlag_e g_rxFlag;                               /* 패킷 수신 완료 플래그 */
static uint8_t           g_rxPacketBuf[COMM_RX_PACKET_LEN];     /* 수신 완료된 패킷 데이터 */
static volatile uint8_t  g_rxPacketLen;                          /* 수신 완료된 패킷 길이 */
static volatile uint16_t g_rxPacketCount;                        /* 수신 패킷 카운터 (건강상태용) */

/*=============================================================================
 * UARTSend_1 - UART1 전송 (레지스터 직접 접근 래핑)
 * TX 버퍼 풀 대기 후 1바이트씩 전송
 *===========================================================================*/
static void UARTSend_1(uint8_t* data, uint8_t length)
{
    uint8_t i;
    for (i = 0; i < length; i++)
    {
        while (U1STAHbits.UTXBF);
        UART1_InterruptTransmitFlagClear();
        UART1_DataWrite(data[i]);
    }
}

/*=============================================================================
 * UARTSend_2 - UART2 전송 (드라이버 함수 래핑)
 * UART2_Write()로 1바이트씩 전송
 *===========================================================================*/
static void UARTSend_2(uint8_t* data, uint8_t length)
{
    uint8_t i;
    for (i = 0; i < length; i++)
    {
        UART2_Write(data[i]);
    }
}

/*=============================================================================
 * COMM_TxOps_t 인스턴스 - UART 전송 인터페이스
 * 함수포인터 구조체로 UART 전송을 추상화
 *===========================================================================*/
const COMM_TxOps_t UartTx1 = {
    .Send = UARTSend_1
};

const COMM_TxOps_t UartTx2 = {
    .Send = UARTSend_2
};

/*=============================================================================
 * UART2_RxCompleteCallback - UART2 수신 ISR 콜백
 * STX/ETX 기반 패킷 조립, 완성 시 내부 버퍼에 저장
 * HW 레지스터 직접 접근: U2STAbits.OERR, UART2_Drv_Read()
 *===========================================================================*/
void UART2_RxCompleteCallback(void)
{
    static uint8_t rxAssemblyBuf[COMM_RX_ASSEMBLY_SIZE];
    static uint8_t rxIndex = 0;
    uint8_t rxByte;

    /* 오버런 에러 클리어 (HW 레지스터 직접 접근) */
    if (U2STAbits.OERR)
    {
        U2STAbits.OERR = 0;
    }

    rxByte = UART2_Drv_Read();

    /* 버퍼 오버플로 방지 */
    if (rxIndex >= COMM_RX_ASSEMBLY_SIZE) rxIndex = 0;

    /* 패킷 조립 */
    rxAssemblyBuf[rxIndex++] = rxByte;

    /* STX 검증 (첫 바이트가 STX가 아니면 리셋) */
    if (rxAssemblyBuf[0] != COMM_STX)
    {
        rxIndex = 0;
        return;
    }

    /* ETX 감지 → 패킷 완성 */
    if (rxIndex > 3 && rxAssemblyBuf[rxIndex - 3] == COMM_ETX)
    {
        memcpy(g_rxPacketBuf, rxAssemblyBuf, rxIndex);
        g_rxPacketLen = rxIndex;
        g_rxFlag = RX_FLAG_READY;
        g_rxPacketCount++;
        rxIndex = 0;
    }
}

/*=============================================================================
 * COMM_Drv API - 캡슐화된 접근 함수 (Core에서 호출)
 *===========================================================================*/

/*-----------------------------------------------------------------------------
 * COMM_Drv_IsPacketReady - 패킷 수신 완료 여부 반환
 *---------------------------------------------------------------------------*/
bool COMM_Drv_IsPacketReady(void)
{
    return (g_rxFlag == RX_FLAG_READY);
}

/*-----------------------------------------------------------------------------
 * COMM_Drv_GetPacket - 수신 패킷 복사 + 플래그 클리어
 * buf:    복사 대상 버퍼 (호출자 소유)
 * maxLen: 버퍼 최대 크기
 * return: 실제 복사된 패킷 길이
 *---------------------------------------------------------------------------*/
uint8_t COMM_Drv_GetPacket(uint8_t* buf, uint8_t maxLen)
{
    uint8_t len = g_rxPacketLen;

    if (len > maxLen) len = maxLen;

    memcpy(buf, g_rxPacketBuf, len);
    g_rxFlag = RX_FLAG_EMPTY;

    return len;
}

/*-----------------------------------------------------------------------------
 * COMM_Drv_GetRxPacketCount - 수신 패킷 카운터 반환 (건강상태 판단용)
 *---------------------------------------------------------------------------*/
uint16_t COMM_Drv_GetRxPacketCount(void)
{
    return g_rxPacketCount;
}
