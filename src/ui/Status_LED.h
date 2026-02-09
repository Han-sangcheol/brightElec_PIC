/*******************************************************************************
 * Status_LED.h - 상태 LED 제어 모듈 (다중 패턴 적용)
 *
 * 기능:
 *   - LED 점멸 패턴 제어 (정상/에러/고속 등)
 *   - 외부 상태 제공자 콜백으로 통신 의존성 제거
 *   - 함수포인터 기반 상태머신 디스패치
 *
 * 적용 패턴:
 *   08: Strategy     - LED_BlinkStrategy_t 점멸 패턴 전략
 *   05: State Machine- LED_StateHandler_t 상태별 함수포인터 디스패치
 *   04: Callback     - StatusProvider_t 상태 제공자 콜백
 *   03: Singleton    - STATUS_LED_INTERFACE 인터페이스 구조체
 ******************************************************************************/
#ifndef INC_USER_Status_LED_H_
#define INC_USER_Status_LED_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/*=============================================================================
 * Strategy - LED 점멸 패턴 전략
 *===========================================================================*/
typedef struct {
    uint16_t onTime;       /* LED On 시간 (ms) */
    uint16_t offTime;      /* LED Off 시간 (ms) */
    uint16_t pauseTime;    /* 반복 간 대기 시간 (ms) */
    uint8_t  repeatCount;  /* 반복 횟수 (0=무한 반복) */
} LED_BlinkStrategy_t;

/* 사전 정의 전략 (Strategy 인스턴스) */
extern const LED_BlinkStrategy_t LED_STRATEGY_NORMAL;   /* 1000ms 주기 정상 점멸 */
extern const LED_BlinkStrategy_t LED_STRATEGY_ERROR;    /* 50ms 빠른 점멸 (에러) */
extern const LED_BlinkStrategy_t LED_STRATEGY_FAST;     /* 250ms 중간 점멸 */

/*=============================================================================
 * State Machine - LED 상태 정의
 *===========================================================================*/
typedef enum {
    LED_STATE_INIT,       /* 반복 카운터 설정 */
    LED_STATE_ON,         /* LED 켜기 */
    LED_STATE_ON_WAIT,    /* On 시간 대기 */
    LED_STATE_OFF_WAIT,   /* Off 시간 대기 */
    LED_STATE_PAUSE,      /* 반복 간 대기 */
    LED_STATE_COUNT       /* 상태 총 개수 */
} LED_State_e;

/* 상태 핸들러 함수포인터 타입 */
typedef void (*LED_StateHandler_t)(void);

/*=============================================================================
 * Callback - 상태 제공자
 * true=정상, false=이상 (통신 끊김 등)
 *===========================================================================*/
typedef bool (*StatusProvider_t)(void);

/*=============================================================================
 * Singleton - STATUS_LED_INTERFACE
 * MOTOR_CONTROL_INTERFACE와 동일 스타일
 *===========================================================================*/
typedef struct {
    void (*Init)(void);                                 /* 초기화 */
    void (*Update)(void);                               /* 메인루프 호출 */
    void (*SetStrategy)(const LED_BlinkStrategy_t*);    /* 점멸 패턴 변경 */
    void (*TimerISR)(void);                             /* 1ms 타이머 ISR */
    void (*RegisterProvider)(StatusProvider_t);          /* 상태 제공자 등록 */
} STATUS_LED_INTERFACE;

extern const STATUS_LED_INTERFACE StatusLED;

/*=============================================================================
 * 레거시 호환 함수 (기존 코드와의 호환성 유지)
 *===========================================================================*/
void Status_LED(void);
void Interrupt_Timer1ms_Status_LED(void);

#ifdef __cplusplus
}
#endif

#endif /* INC_USER_Status_LED_H_ */
