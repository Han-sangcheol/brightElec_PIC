/*******************************************************************************
 * Status_LED.c - 상태 LED 제어 모듈 (다중 패턴 적용)
 *
 * 기능:
 *   - LED 점멸 패턴을 Strategy 패턴으로 추상화
 *   - 5단계 상태머신을 함수포인터 배열로 디스패치
 *   - 통신 상태 확인을 콜백으로 분리 (LED↔Communication 의존성 제거)
 *   - STATUS_LED_INTERFACE Singleton으로 외부 인터페이스 제공
 *
 * 적용 패턴:
 *   08: Strategy     - LED_STRATEGY_NORMAL/ERROR/FAST 점멸 전략
 *   05: State Machine- ledStateHandlers[] 함수포인터 배열 디스패치
 *   04: Callback     - statusProvider 콜백으로 외부 상태 조회
 *   03: Singleton    - StatusLED 인터페이스 구조체
 *
 * 호출 관계:
 *   StatusLED.Init()     ← pmsm.c main() 초기화
 *   StatusLED.Update()   ← 메인루프 (상태머신 실행)
 *   StatusLED.TimerISR() ← Timer1 1ms 콜백
 ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include <xc.h>
#include <stdint.h>
#include <stdbool.h>

#include "port_config.h"
#include "Status_LED.h"
#include "Communication.h"

/* LED 하드웨어 매크로 */
#define LED_HW_ON()     { LED1 = 1; }
#define LED_HW_OFF()    { LED1 = 0; }

/* 통신 상태 확인 주기 (ms) */
#define STATUS_CHECK_PERIOD_MS  1000

/*=============================================================================
 * Strategy - 사전 정의 LED 점멸 전략
 *===========================================================================*/
const LED_BlinkStrategy_t LED_STRATEGY_NORMAL = {
    .onTime      = 1000,   /* 1000ms On */
    .offTime     = 1000,   /* 1000ms Off */
    .pauseTime   = 1000,   /* 반복 간 대기 */
    .repeatCount = 0,      /* 무한 반복 */
};

const LED_BlinkStrategy_t LED_STRATEGY_ERROR = {
    .onTime      = 50,     /* 50ms On (빠른 점멸) */
    .offTime     = 50,     /* 50ms Off */
    .pauseTime   = 1000,   /* 반복 간 대기 */
    .repeatCount = 0,      /* 무한 반복 */
};

const LED_BlinkStrategy_t LED_STRATEGY_FAST = {
    .onTime      = 250,    /* 250ms On */
    .offTime     = 250,    /* 250ms Off */
    .pauseTime   = 1000,   /* 반복 간 대기 */
    .repeatCount = 0,      /* 무한 반복 */
};

/*=============================================================================
 * 정적 변수
 *===========================================================================*/
/* 현재 상태 */
static LED_State_e ledState = LED_STATE_INIT;

/* 현재 활성 전략 */
static const LED_BlinkStrategy_t* activeStrategy = &LED_STRATEGY_NORMAL;

/* 타이머 카운터 (1ms 단위) */
static volatile uint16_t ledTimer1ms = 0;

/* 반복 카운터 */
static uint8_t repeatCounter = 0;

/* Callback - 상태 제공자 */
static StatusProvider_t statusProvider = NULL;

/* 통신 상태 확인 타이머 */
static volatile uint16_t statusCheckTimer = 0;

/*=============================================================================
 * State Machine - 상태 핸들러 함수 (static)
 *===========================================================================*/
static void LedState_Init(void);
static void LedState_On(void);
static void LedState_OnWait(void);
static void LedState_OffWait(void);
static void LedState_Pause(void);

/* 상태 핸들러 함수포인터 배열 - 디스패치 테이블 */
static const LED_StateHandler_t ledStateHandlers[LED_STATE_COUNT] = {
    LedState_Init,      /* LED_STATE_INIT */
    LedState_On,        /* LED_STATE_ON */
    LedState_OnWait,    /* LED_STATE_ON_WAIT */
    LedState_OffWait,   /* LED_STATE_OFF_WAIT */
    LedState_Pause,     /* LED_STATE_PAUSE */
};

/*=============================================================================
 * State Machine 핸들러 구현
 *===========================================================================*/

/* INIT: 반복 카운터 설정 → ON 전환 */
static void LedState_Init(void)
{
    repeatCounter = (activeStrategy->repeatCount > 0)
                  ? activeStrategy->repeatCount
                  : 1;
    ledState = LED_STATE_ON;
}

/* ON: LED 켜기, 타이머 리셋 → ON_WAIT 전환 */
static void LedState_On(void)
{
    LED_HW_ON();
    ledTimer1ms = 0;
    ledState = LED_STATE_ON_WAIT;
}

/* ON_WAIT: On 시간 대기 → Off 전환 */
static void LedState_OnWait(void)
{
    if (ledTimer1ms >= activeStrategy->onTime)
    {
        LED_HW_OFF();
        ledTimer1ms = 0;
        ledState = LED_STATE_OFF_WAIT;
    }
}

/* OFF_WAIT: Off 시간 대기 → 반복 확인 */
static void LedState_OffWait(void)
{
    if (ledTimer1ms >= activeStrategy->offTime)
    {
        ledTimer1ms = 0;

        if (activeStrategy->repeatCount == 0)
        {
            /* 무한 반복: 바로 ON으로 */
            ledState = LED_STATE_ON;
        }
        else
        {
            repeatCounter--;
            if (repeatCounter > 0)
            {
                ledState = LED_STATE_ON;
            }
            else
            {
                ledState = LED_STATE_PAUSE;
            }
        }
    }
}

/* PAUSE: 반복 간 대기 → INIT로 복귀 */
static void LedState_Pause(void)
{
    if (ledTimer1ms >= (activeStrategy->pauseTime - activeStrategy->offTime))
    {
        ledTimer1ms = 0;
        ledState = LED_STATE_INIT;
    }
}

/*=============================================================================
 * StatusLED_Init_Impl - 초기화
 *===========================================================================*/
static void StatusLED_Init_Impl(void)
{
    ledState = LED_STATE_INIT;
    activeStrategy = &LED_STRATEGY_NORMAL;
    ledTimer1ms = 0;
    repeatCounter = 0;
    statusProvider = NULL;
    statusCheckTimer = 0;
    LED_HW_OFF();
}

/*=============================================================================
 * StatusLED_Update_Impl - 메인루프 업데이트
 * 1) 주기적으로 상태 제공자 콜백 호출 → 전략 자동 변경
 * 2) 상태머신 핸들러 디스패치
 *===========================================================================*/
static void StatusLED_Update_Impl(void)
{
    /* Callback - 상태 제공자로 전략 자동 변경 */
    if (statusCheckTimer >= STATUS_CHECK_PERIOD_MS)
    {
        statusCheckTimer = 0;

        if (statusProvider != NULL)
        {
            bool isHealthy = statusProvider();

            if (isHealthy)
            {
                activeStrategy = &LED_STRATEGY_NORMAL;
            }
            else
            {
                activeStrategy = &LED_STRATEGY_ERROR;
            }
        }
    }

    /* State Machine - 핸들러 디스패치 */
    if (ledState < LED_STATE_COUNT && ledStateHandlers[ledState] != NULL)
    {
        ledStateHandlers[ledState]();
    }
}

/*=============================================================================
 * StatusLED_SetStrategy_Impl - Strategy 변경
 *===========================================================================*/
static void StatusLED_SetStrategy_Impl(const LED_BlinkStrategy_t* strategy)
{
    if (strategy != NULL)
    {
        activeStrategy = strategy;
        ledState = LED_STATE_INIT;   /* 전략 변경 시 상태머신 리셋 */
    }
}

/*=============================================================================
 * StatusLED_TimerISR_Impl - 1ms 타이머 ISR
 * Timer1 콜백으로 등록되어 1ms마다 호출
 *===========================================================================*/
static void StatusLED_TimerISR_Impl(void)
{
    ledTimer1ms++;
    statusCheckTimer++;
}

/*=============================================================================
 * StatusLED_RegisterProvider_Impl - 상태 제공자 콜백 등록
 *===========================================================================*/
static void StatusLED_RegisterProvider_Impl(StatusProvider_t provider)
{
    statusProvider = provider;
}

/*=============================================================================
 * Singleton - STATUS_LED_INTERFACE 인스턴스
 * 사용예: StatusLED.Init(), StatusLED.Update(), StatusLED.SetStrategy()
 *===========================================================================*/
const STATUS_LED_INTERFACE StatusLED = {
    .Init             = StatusLED_Init_Impl,
    .Update           = StatusLED_Update_Impl,
    .SetStrategy      = StatusLED_SetStrategy_Impl,
    .TimerISR         = StatusLED_TimerISR_Impl,
    .RegisterProvider = StatusLED_RegisterProvider_Impl,
};

/*=============================================================================
 * 레거시 호환 함수
 * 기존 코드의 Status_LED() / Interrupt_Timer1ms_Status_LED() 호출을 유지
 *===========================================================================*/
void Status_LED(void)
{
    StatusLED.Update();
}

void Interrupt_Timer1ms_Status_LED(void)
{
    StatusLED.TimerISR();
}
