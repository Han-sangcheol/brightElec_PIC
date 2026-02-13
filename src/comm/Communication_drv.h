/*******************************************************************************
 * Communication_drv.h - 통신 드라이버 (프로젝트별 HW 바인딩)
 *
 * 기능:
 *   - UART TX 전송 래퍼 인터페이스 (UartTx1, UartTx2)
 *   - COMM_Drv API: 패킷 수신 여부/데이터/카운터 (캡슐화된 접근)
 *   - ISR 내부 변수는 Communication_drv.c에서 static 소유
 *
 * 계층 구조 (수평 분리):
 *   Application(pmsm.c) → Driver(이 파일) + Core(Communication)
 *   Core(Communication.c)에서 COMM_Drv API / TX 래퍼 접근
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
#include <stdbool.h>
#include "Communication_cfg.h"

/*=============================================================================
 * UART TX 전송 인터페이스 (함수포인터)
 *===========================================================================*/
typedef struct {
    void (*Send)(uint8_t* data, uint8_t length);
} COMM_TxOps_t;                                     /* Ops = Operations */

extern const COMM_TxOps_t UartTx1;   /* UART1 전송 인터페이스 */
extern const COMM_TxOps_t UartTx2;   /* UART2 전송 인터페이스 */

/*=============================================================================
 * COMM_Drv API - 캡슐화된 RX 접근 함수
 * ISR 내부 변수(static)를 함수로만 외부 제공
 *===========================================================================*/
bool     COMM_Drv_IsPacketReady(void);                        /* 패킷 수신 완료 여부 */
uint8_t  COMM_Drv_GetPacket(uint8_t* buf, uint8_t maxLen);    /* 패킷 복사 + 플래그 클리어 */
uint16_t COMM_Drv_GetRxPacketCount(void);                     /* 수신 패킷 카운터 (건강상태용) */

#ifdef __cplusplus
}
#endif

#endif /* COMMUNICATION_DRV_H */
