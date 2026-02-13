/*******************************************************************************
 * Communication_drv.c - 통신 드라이버 (프로젝트별 HW 바인딩)
 *
 * 기능:
 *   - UART1/UART2 하드웨어 전송 래퍼 (UartTx1, UartTx2)
 *   - UART2 수신 ISR 콜백 (패킷 조립 + Ring Buffer)
 *   - HW 레지스터 직접 접근 집중 (U2STAbits, U1STAHbits)
 *
 * 적용 패턴:
 *   01: Wrapper     - 하드웨어 직접 접근을 래퍼 함수로 감쌈
 *   14: Ring Buffer - rxRingBuffer UART RX 링 버퍼
 *
 * 호출 관계:
 *   UART2 HW ISR → UART2_RxCompleteCallback() → RingBuffer + 패킷 조립
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
#include <string.h>

#include "Communication_drv.h"
#include "Communication_cfg.h"
#include "ring_buffer.h"

#include "uart1.h"
#include "uart2.h"

/*=============================================================================
 * ISR → Core 공유 변수 (이 파일이 소유, Communication_drv.h에서 extern 선언)
 *===========================================================================*/
volatile uint8_t  g_uart2_rx_flag;                          /* 패킷 수신 완료 플래그 */
uint8_t           command_rx_buffer[COMM_TX_PACKET_LEN];    /* 수신 완료된 패킷 데이터 */
volatile uint8_t  g_uart2_tx_flag;                          /* TX 전송 플래그 */
volatile uint16_t g_u16UartRXCounter;                       /* RX 바이트 카운터 */

/* Ring Buffer - UART RX(Receive) 링 버퍼 */
static RingBuffer_t rxRingBuffer;

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
 * Ring Buffer 사용하여 패킷 조립
 * HW 레지스터 직접 접근: U2STAbits.OERR, UART2_Drv_Read()
 *===========================================================================*/
void UART2_RxCompleteCallback(void)
{
    static uint8_t rxAssemblyBuf[COMM_RX_ASSEMBLY_SIZE];  /* rx = Receive, Buf = Buffer */
    static uint8_t rxIndex = 0;        /* rx = Receive */
    uint8_t rxByte;                    /* rx = Receive */

    /* 오버런 에러 클리어 (HW 레지스터 직접 접근) */
    if (U2STAbits.OERR)
    {
        U2STAbits.OERR = 0;
    }

    if (rxIndex >= COMM_RX_ASSEMBLY_SIZE) rxIndex = 0;

    rxByte = UART2_Drv_Read();

    /* Ring Buffer에도 원시 데이터 저장 (디버그/로그용) */
    RingBuffer_Put(&rxRingBuffer, rxByte);

    /* 패킷 조립 */
    rxAssemblyBuf[rxIndex++] = rxByte;
    rxAssemblyBuf[rxIndex] = 0;

    /* STX 검증 */
    if ((rxAssemblyBuf[0] & 0xff) != COMM_STX)
    {
        rxIndex = 0;
    }

    /* ETX 감지 → 패킷 완성 */
    if (rxIndex > 3 && (rxAssemblyBuf[rxIndex - 3] & 0xff) == COMM_ETX)
    {
        memcpy(command_rx_buffer, rxAssemblyBuf, rxIndex);
        g_uart2_rx_flag = 1;
        g_uart2_tx_flag = 1;
        rxIndex = 0;
    }

    g_u16UartRXCounter++;
}
