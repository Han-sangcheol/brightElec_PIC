/*******************************************************************************
 * timer1.h - Timer1 드라이버 (콜백 등록 패턴)
 *
 * 기능:
 *   - Timer1 50us 주기 초기화
 *   - 콜백 등록 패턴: 주기별 콜백 함수 등록/실행
 *   - ISR에서 등록된 콜백을 주기적으로 호출
 *
 * 콜백 등록 예:
 *   Timer1_RegisterTask(0, SpeedRamp_50us_Callback, 1);   // 50us
 *   Timer1_RegisterTask(1, Interrupt_Timer1ms_Status_LED, 20); // 1ms
 *   Timer1_RegisterTask(2, timer1ms_communication, 20);   // 1ms
 *
 * 함수포인터 패턴:
 *   TimerCallback_t - 콜백 함수 포인터
 *   TimerTask_t     - 콜백 + 주기 + 카운터 구조체
 ******************************************************************************/
#ifndef TIMER1_H
#define TIMER1_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

/* 콜백 함수 포인터 타입 */
typedef void (*TimerCallback_t)(void);

/* 타이머 태스크 구조체 - 콜백 등록 패턴 */
typedef struct {
    TimerCallback_t callback;     /* 콜백 함수 포인터 */
    uint16_t        period;       /* 호출 주기 (50us 단위, 1=50us, 20=1ms) */
    uint16_t        counter;      /* 내부 카운터 */
} TimerTask_t;

/* 최대 등록 가능 태스크 수 */
#define TIMER1_MAX_TASKS  4

/* 함수 프로토타입 */
void Timer1_Init(void);
void Timer1_RegisterTask(uint8_t idx, TimerCallback_t cb, uint16_t period);

#ifdef __cplusplus
}
#endif

#endif /* TIMER1_H */
