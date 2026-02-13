/*******************************************************************************
 * timer2.h - SCCP1 타이머 드라이버 (50us 속도램프 전용)
 *
 * 기능:
 *   - SCCP1 모듈을 16비트 타이머로 사용 (50us 주기)
 *   - SpeedRamp_50us_Callback() 호출 전용 타이머
 *   - FreeRTOS 도입으로 Timer1이 RTOS Tick에 사용되어
 *     기존 Timer1의 50us 속도램프 콜백을 SCCP1 타이머로 이전
 *
 * 하드웨어:
 *   dsPIC33CK256MP508에는 전통적 Timer2(T2CON)가 없음
 *   SCCP1 모듈을 타이머 모드로 사용
 *
 * 타이머 계산:
 *   Fcy = 100MHz, 프리스케일러 1:4 (TMRPS=0b01)
 *   50us = (1/100,000,000) * 4 * (1249+1) = 50us
 *
 * 인터럽트:
 *   벡터: _CCT1Interrupt
 *   우선순위: IPL 5 (RTOS 외부, configMAX_SYSCALL_INTERRUPT_PRIORITY 이상)
 *   → FreeRTOS API 호출 불가, 최소 지연시간 보장
 ******************************************************************************/
#ifndef TIMER2_H
#define TIMER2_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/* 콜백 함수 포인터 타입 (cb = 외부 등록 콜백) */
typedef void (*Timer2_cb)(void);

/* 함수 프로토타입 */
void Timer2_Init(void);
void Timer2_RegisterCallback(Timer2_cb cb);

#ifdef __cplusplus
}
#endif

#endif /* TIMER2_H */
