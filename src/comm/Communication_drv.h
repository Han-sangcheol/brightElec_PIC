/*******************************************************************************
 * Communication_drv.h - 통신 드라이버 (프로젝트별 HW 바인딩)
 *
 * 기능:
 *   - UART TX 전송 래퍼 인터페이스 (UartTx1, UartTx2)
 *   - UART2 RX ISR 콜백 (패킷 조립 + HW 레지스터 접근)
 *   - ISR → Core 공유 변수 선언 (플래그, 수신 버퍼, 카운터)
 *
 * 계층 구조 (수평 분리):
 *   Application(pmsm.c) → Driver(이 파일) + Core(Communication)
 *   Core(Communication.c)에서 공유 변수/TX래퍼 접근
 *
 * 프로젝트 이식 시 수정 포인트:
 *   이 파일은 수정 불필요 (Communication_drv.c만 수정)
 *
 * HW 의존:
 *   - uart1.h: UART1_DataWrite(), UART1_InterruptTransmitFlagClear()
 *   - uart2.h: UART2_Write(), UART2_Drv_Read()
 *   - xc.h:    U2STAbits, U1STAHbits (HW 레지스터)
 ******************************************************************************/
#ifndef COMMUNICATION_DRV_H
#define COMMUNICATION_DRV_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include "Communication_cfg.h"

/*=============================================================================
 * UART TX 전송 인터페이스 (Wrapper + 함수포인터)
 *===========================================================================*/
typedef struct {
    void (*Send)(uint8_t* data, uint8_t length);
} COMM_TxOps_t;                                     /* Ops = Operations */

extern const COMM_TxOps_t UartTx1;   /* UART1 전송 인터페이스 */
extern const COMM_TxOps_t UartTx2;   /* UART2 전송 인터페이스 */

/*=============================================================================
 * ISR → Core 공유 변수 (Communication_drv.c에서 정의)
 * ISR에서 쓰기, Core(Communication.c)에서 읽기
 *===========================================================================*/
extern volatile uint8_t  g_uart2_rx_flag;       /* 패킷 수신 완료 플래그 */
extern uint8_t           command_rx_buffer[];    /* 수신 완료된 패킷 데이터 */
extern volatile uint8_t  g_uart2_tx_flag;       /* TX 전송 플래그 */
extern volatile uint16_t g_u16UartRXCounter;    /* RX 바이트 카운터 */

#ifdef __cplusplus
}
#endif

#endif /* COMMUNICATION_DRV_H */
