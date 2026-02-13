/*******************************************************************************
 * led_blinker.h - LED 점멸 (HW 독립 - 재사용 가능)
 *
 * 기능:
 *   - LED 점멸 패턴을 Strategy 패턴으로 추상화
 *   - 5단계 상태머신 (INIT → ON → ON_WAIT → OFF_WAIT → PAUSE)
 *   - 외부 상태 제공자 콜백으로 자동 전략 전환
 *   - Singleton 컨텍스트 (초기화 보호)
 *   - HW 추상화: LED_HW_Ops_t 함수포인터로 하드웨어 분리
 *
 * 계층 구조 (수평 분리):
 *   Application(pmsm.c) → Core(led_blinker) → Driver(led_blinker_drv)
 *   Application이 drv와 Core를 각각 직접 호출
 *
 * 사용 순서:
 *   1. LedBlinker_Drv_Init()    ← drv: HW ops + 전략 주입
 *   2. LedBlinker.Init()        ← Core: Singleton 초기화
 *   3. LedBlinker.Update()      ← Core: 메인루프 호출
 *
 * 적용 패턴:
 *   Strategy     - LED_BlinkStrategy_t 점멸 패턴 전략
 *   State Machine- LED_StateHandler_fn 상태별 함수포인터 디스패치
 *   Callback     - StatusProvider_cb 상태 제공자 콜백
 *   Singleton    - 초기화 보호 (1회만 실행)
 ******************************************************************************/
#ifndef LED_BLINKER_H
#define LED_BLINKER_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/*=============================================================================
 * HW 추상화 - 프로젝트별 LED 핀 동작을 함수포인터로 주입
 *===========================================================================*/
typedef struct {
    void (*On)(void);       /* LED 켜기 */
    void (*Off)(void);      /* LED 끄기 */
} LED_HW_Ops_t;             /* HW = Hardware, Ops = Operations */

/*=============================================================================
 * Strategy - LED 점멸 패턴 전략
 *===========================================================================*/
typedef struct {
    uint16_t onTime;       /* LED On 시간 (ms) */
    uint16_t offTime;      /* LED Off 시간 (ms) */
    uint16_t pauseTime;    /* 반복 간 대기 시간 (ms) */
    uint8_t  repeatCount;  /* 반복 횟수 (0=무한 반복) */
} LED_BlinkStrategy_t;

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

/* 상태 핸들러 함수포인터 타입 (fn = 내부 디스패치용) */
typedef void (*LED_StateHandler_fn)(void);

/*=============================================================================
 * Callback - 상태 제공자
 * true=정상, false=이상 (통신 끊김 등)
 *===========================================================================*/
typedef bool (*StatusProvider_cb)(void);

/*=============================================================================
 * 인터페이스 구조체 - 인스턴스 (LedBlinker)
 * Application에서 LedBlinker.Init(), LedBlinker.Update() 등으로 호출
 *===========================================================================*/
typedef struct {
    void (*Init)(void);                                 /* Singleton 초기화 */
    void (*Update)(void);                               /* 메인루프 호출 */
    void (*SetStrategy)(const LED_BlinkStrategy_t*);    /* 점멸 패턴 변경 */
    void (*TimerISR)(void);                             /* 1ms 타이머 ISR */
    void (*RegisterProvider)(StatusProvider_cb);          /* 상태 제공자 등록 */
} LED_BlinkerInterface_t;

/*=============================================================================
 * 인스턴스 - Application에서 직접 사용
 *===========================================================================*/
extern const LED_BlinkerInterface_t LedBlinker;

/*=============================================================================
 * 함수 프로토타입 - drv 계층에서 HW 주입 시 사용
 *===========================================================================*/
void LedBlinker_SetHwOps(const LED_HW_Ops_t* hwOps);
void LedBlinker_SetAutoStrategies(const LED_BlinkStrategy_t* normal,
                                   const LED_BlinkStrategy_t* error);

#ifdef __cplusplus
}
#endif

#endif /* LED_BLINKER_H */
