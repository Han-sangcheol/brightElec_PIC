/*******************************************************************************
 * uart_wrapper.c - UART 전송 래퍼 구현 (Wrapper)
 *
 * 기능:
 *   - UART1/UART2 하드웨어 전송을 함수포인터 인터페이스로 래핑
 *   - UartTx1.Send() / UartTx2.Send()로 통일된 전송 인터페이스 제공
 *   - 레거시 호환: UARTSend_1() / UARTSend_2() 직접 호출도 지원
 *
 * 적용 패턴:
 *   01: Wrapper - 하드웨어 직접 접근을 래퍼 함수로 감쌈
 *
 * 의존:
 *   - uart1.h: UART1_DataWrite(), UART1_InterruptTransmitFlagClear()
 *   - uart2.h: UART2_Write()
 ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include <xc.h>
#include <stdint.h>
#include "uart1.h"
#include "uart2.h"
#include "uart_wrapper.h"

/*=============================================================================
 * UARTSend_1 - UART1 전송 (레지스터 직접 접근 래핑)
 * TX 버퍼 풀 대기 후 1바이트씩 전송
 *===========================================================================*/
void UARTSend_1(uint8_t* data, uint8_t length)
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
void UARTSend_2(uint8_t* data, uint8_t length)
{
    uint8_t i;
    for (i = 0; i < length; i++)
    {
        UART2_Write(data[i]);
    }
}

/*=============================================================================
 * Wrapper - UART_TX_WRAPPER 인스턴스
 * 함수포인터 구조체로 UART 전송을 추상화
 *===========================================================================*/
const UART_TX_WRAPPER UartTx1 = {
    .Send = UARTSend_1
};

const UART_TX_WRAPPER UartTx2 = {
    .Send = UARTSend_2
};
