/*******************************************************************************
 * uart_wrapper.h - UART 전송 래퍼 (Wrapper)
 *
 * 기능:
 *   - UART1/UART2 전송을 함수포인터 인터페이스로 추상화
 *   - 하드웨어 직접 접근을 래퍼로 감싸 교체 가능한 구조
 *
 * 사용예:
 *   UartTx2.Send(data, length);   // UART2로 전송
 *   UartTx1.Send(data, length);   // UART1로 전송
 ******************************************************************************/
#ifndef UART_WRAPPER_H
#define UART_WRAPPER_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

/* UART 전송 래퍼 인터페이스 (Wrapper + 함수포인터) */
typedef struct {
    void (*Send)(uint8_t* data, uint8_t length);
} UART_TX_WRAPPER;

extern const UART_TX_WRAPPER UartTx1;   /* UART1 전송 래퍼 */
extern const UART_TX_WRAPPER UartTx2;   /* UART2 전송 래퍼 */

/* 레거시 호환 함수 프로토타입 */
void UARTSend_1(uint8_t* data, uint8_t length);
void UARTSend_2(uint8_t* data, uint8_t length);

#ifdef __cplusplus
}
#endif

#endif /* UART_WRAPPER_H */
