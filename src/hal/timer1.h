/*******************************************************************************
 * timer1.h - Timer1 드라이버 (FreeRTOS RTOS Tick 전용)
 *
 * 기능:
 *   - FreeRTOS 도입 후 Timer1은 RTOS Tick(1ms)에 사용됨
 *   - Timer1 하드웨어 설정은 FreeRTOS port.c의
 *     vApplicationSetupTickTimerInterrupt()가 담당
 *   - _T1Interrupt ISR은 FreeRTOS port.c의 configTICK_INTERRUPT_HANDLER가 담당
 *   - 기존 Timer1 콜백 시스템은 제거됨:
 *     - 속도램프(50us) → Timer2로 이전 (timer2.c)
 *     - LED(1ms)       → FreeRTOS Software Timer로 이전
 *     - 통신(1ms)      → FreeRTOS Software Timer로 이전
 *
 * 이 파일은 vApplicationSetupTickTimerInterrupt() 함수만 제공합니다.
 * (port.c의 weak 정의를 오버라이드하여 dsPIC33CK 레지스터에 맞게 설정)
 ******************************************************************************/
#ifndef TIMER1_H
#define TIMER1_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

/* FreeRTOS Timer1 Tick 설정 함수 (port.c weak 오버라이드) */
void vApplicationSetupTickTimerInterrupt(void);

#ifdef __cplusplus
}
#endif

#endif /* TIMER1_H */
