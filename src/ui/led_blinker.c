/*******************************************************************************
 * led_blinker.c - LED 점멸 (HW 독립 - 재사용 가능)
 *
 * 기능:
 *   - LedBlinker.Init(): Singleton 초기화 (사전 주입된 HW ops 사용)
 *   - LedBlinker.Update(): 상태 제공자 확인 + 상태머신 디스패치
 *   - LedBlinker.SetStrategy(): 점멸 전략 변경
 *   - LedBlinker.TimerISR(): 1ms 타이머 카운터 증가
 *   - LedBlinker.RegisterProvider(): 상태 제공자 콜백 등록
 *   - LedBlinker_SetHwOps(): drv에서 HW 함수포인터 주입
 *   - LedBlinker_SetAutoStrategies(): 자동 전략 전환용 정상/에러 전략 설정
 *
 * 계층 구조:
 *   Application(pmsm.c) → Core(이 파일) ← Driver(led_blinker_drv.c)
 *   drv가 SetHwOps로 HW 주입, App이 SetAutoStrategies + LedBlinker.xxx()로 호출
 *
 * 상태머신:
 *   INIT → ON → ON_WAIT → OFF_WAIT → (반복 or PAUSE → INIT)
 *
 * HW 의존성: 없음 (LED_HW_Ops_t 함수포인터로 추상화)
 ******************************************************************************/
#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include "led_blinker.h"

/* 통신 상태 확인 주기 (ms) */
#define STATUS_CHECK_PERIOD_MS  1000    /* MS = Milliseconds */

/*=============================================================================
 * Singleton 컨텍스트 - 모든 내부 상태를 단일 인스턴스로 관리
 *===========================================================================*/
typedef struct {
    bool                          initialized;       /* 초기화 보호 플래그 */
    const LED_HW_Ops_t*           hwOps;             /* HW 추상화 함수포인터 */
    LED_State_e                   ledState;          /* 현재 상태머신 상태 */
    const LED_BlinkStrategy_t*    activeStrategy;    /* 현재 활성 점멸 패턴 */
    const LED_BlinkStrategy_t*    normalStrategy;    /* 자동전환: 정상 패턴 */
    const LED_BlinkStrategy_t*    errorStrategy;     /* 자동전환: 에러 패턴 */
    volatile uint16_t             ledTimer1ms;       /* 타이머 카운터 (1ms 단위) */
    uint8_t                       repeatCounter;     /* 반복 카운터 */
    StatusProvider_cb              statusProvider;    /* 상태 제공자 콜백 */
    volatile uint16_t             statusCheckTimer;  /* 상태 확인 타이머 */
} LedBlinker_Context_t;

static LedBlinker_Context_t ctx = {     /* ctx = Context */
    .initialized      = false,              /* LED_Setup 후 초기화 : .initialized =true */
    .hwOps            = NULL,               /* LedBlinker_SetHwOps() 후 초기화 : .hwOps = ledHwOps */
    .ledState         = LED_STATE_INIT,    
    .activeStrategy   = NULL,               /* LedBlinker_SetAutoStrategies() 후 초기화 : .activeStrategy = LED_STRATEGY_NORMAL */
    .normalStrategy   = NULL,
    .errorStrategy    = NULL,
    .ledTimer1ms      = 0,
    .repeatCounter    = 0,
    .statusProvider   = NULL,
    .statusCheckTimer = 0,
};

/*=============================================================================
 * State Machine - 상태 핸들러 함수 (static)
 *===========================================================================*/
static void LedState_Init(void);
static void LedState_On(void);
static void LedState_OnWait(void);
static void LedState_OffWait(void);
static void LedState_Pause(void);

/* 상태 핸들러 함수포인터 배열 - 디스패치 테이블 */
static const LED_StateHandler_fn ledStateHandlers[LED_STATE_COUNT] = {
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
    ctx.repeatCounter = (ctx.activeStrategy->repeatCount > 0)
                      ? ctx.activeStrategy->repeatCount
                      : 1;
    ctx.ledState = LED_STATE_ON;
}

/* ON: LED 켜기, 타이머 리셋 → ON_WAIT 전환 */
static void LedState_On(void)
{
    if (ctx.hwOps != NULL && ctx.hwOps->On != NULL)
    {
        ctx.hwOps->On();
    }
    ctx.ledTimer1ms = 0;
    ctx.ledState = LED_STATE_ON_WAIT;
}

/* ON_WAIT: On 시간 대기 → Off 전환 */
static void LedState_OnWait(void)
{
    if (ctx.ledTimer1ms >= ctx.activeStrategy->onTime)
    {
        if (ctx.hwOps != NULL && ctx.hwOps->Off != NULL)
        {
            ctx.hwOps->Off();
        }
        ctx.ledTimer1ms = 0;
        ctx.ledState = LED_STATE_OFF_WAIT;
    }
}

/* OFF_WAIT: Off 시간 대기 → 반복 확인 */
static void LedState_OffWait(void)
{
    if (ctx.ledTimer1ms >= ctx.activeStrategy->offTime)
    {
        ctx.ledTimer1ms = 0;

        if (ctx.activeStrategy->repeatCount == 0)
        {
            /* 무한 반복: 바로 ON으로 */
            ctx.ledState = LED_STATE_ON;
        }
        else
        {
            ctx.repeatCounter--;
            if (ctx.repeatCounter > 0)
            {
                ctx.ledState = LED_STATE_ON;
            }
            else
            {
                ctx.ledState = LED_STATE_PAUSE;
            }
        }
    }
}

/* PAUSE: 반복 간 대기 → INIT로 복귀 */
static void LedState_Pause(void)
{
    if (ctx.ledTimer1ms >= (ctx.activeStrategy->pauseTime - ctx.activeStrategy->offTime))
    {
        ctx.ledTimer1ms = 0;
        ctx.ledState = LED_STATE_INIT;
    }
}

/*=============================================================================
 * LedBlinker_SetHwOps - HW 함수포인터 주입 (drv에서 호출)
 * Init() 전에 호출하여 HW 바인딩 설정
 *===========================================================================*/
void LedBlinker_SetHwOps(const LED_HW_Ops_t* hwOps)
{
    ctx.hwOps = hwOps;
}

/*=============================================================================
 * LedBlinker_Init - Singleton 초기화
 * 최초 1회만 실행, 재호출 시 무시 (등록된 콜백/전략 보호)
 * 사전에 LedBlinker_SetHwOps()와 LedBlinker_SetAutoStrategies()를 호출해야 함
 *===========================================================================*/
static void LedBlinker_Init(void)
{
    if (ctx.initialized)
    {
        return;     /* 이미 초기화됨 - 등록된 콜백/전략 보호 */
    }

    ctx.ledState         = LED_STATE_INIT;
    ctx.activeStrategy   = ctx.normalStrategy;  /* SetAutoStrategies()로 사전 설정된 전략 사용 */
    ctx.ledTimer1ms      = 0;
    ctx.repeatCounter    = 0;
    ctx.statusProvider   = NULL;
    ctx.statusCheckTimer = 0;

    /* LED 끄기 */
    if (ctx.hwOps != NULL && ctx.hwOps->Off != NULL)
    {
        ctx.hwOps->Off();
    }

    ctx.initialized = true;
}

/*=============================================================================
 * LedBlinker_Update - 메인루프 업데이트
 * 1) 주기적으로 상태 제공자 콜백 호출 → 전략 자동 변경
 * 2) 상태머신 핸들러 디스패치
 *===========================================================================*/
void LedBlinker_Update(void)
{
    /* Callback - 상태 제공자로 전략 자동 변경 */
    if (ctx.statusCheckTimer >= STATUS_CHECK_PERIOD_MS)
    {
        ctx.statusCheckTimer = 0;

        if (ctx.statusProvider != NULL &&
            ctx.normalStrategy != NULL && 
            ctx.errorStrategy != NULL)
        {
            bool isHealthy = ctx.statusProvider();

            if (isHealthy)
            {
                ctx.activeStrategy = ctx.normalStrategy;
            }
            else
            {
                ctx.activeStrategy = ctx.errorStrategy;
            }
        }
    }

    /* State Machine - 핸들러 디스패치 */
    if (ctx.activeStrategy != NULL &&
        ctx.ledState < LED_STATE_COUNT &&
        ledStateHandlers[ctx.ledState] != NULL)
    {
        ledStateHandlers[ctx.ledState]();
    }
}

/*=============================================================================
 * LedBlinker_SetStrategy - Strategy 변경
 *===========================================================================*/
void LedBlinker_SetStrategy(const LED_BlinkStrategy_t* strategy)
{
    if (strategy != NULL)
    {
        ctx.activeStrategy = strategy;
        ctx.ledState = LED_STATE_INIT;   /* 전략 변경 시 상태머신 리셋 */
    }
}

/*=============================================================================
 * LedBlinker_TimerISR - 1ms 타이머 ISR
 * FreeRTOS Software Timer 콜백으로 등록되어 1ms마다 호출
 *===========================================================================*/
void LedBlinker_TimerISR(void)
{
    ctx.ledTimer1ms++;
    ctx.statusCheckTimer++;
}

/*=============================================================================
 * LedBlinker_RegisterProvider - 상태 제공자 콜백 등록
 *===========================================================================*/
void LedBlinker_RegisterProvider(StatusProvider_cb provider)
{
    ctx.statusProvider = provider;
}

/*=============================================================================
 * LedBlinker_SetAutoStrategies - 자동 패턴 전환용 정상/에러 패턴 설정
 * Update()에서 상태 제공자 결과에 따라 자동 전환할 점멸 패턴 지정
 * Init() 전에 호출하면 Init 시 normalStrategy이 activeStrategy으로 설정됨
 *===========================================================================*/
void LedBlinker_SetAutoStrategies(const LED_BlinkStrategy_t* normal,
                                   const LED_BlinkStrategy_t* error)
{
    ctx.normalStrategy = normal;
    ctx.errorStrategy  = error;

    /* 현재 활성 패턴이 없으면 정상 패턴으로 설정 */
    if (ctx.activeStrategy == NULL &&
         normal != NULL)
    {
        ctx.activeStrategy = normal;
    }
}

/*=============================================================================
 * LedBlinker 인스턴스 - Application에서 LedBlinker.xxx()로 호출
 *===========================================================================*/
const LED_BlinkerInterface_t LedBlinker = {
    .Init             = LedBlinker_Init,
    .Update           = LedBlinker_Update,
    .SetStrategy      = LedBlinker_SetStrategy,
    .TimerISR         = LedBlinker_TimerISR,
    .RegisterProvider = LedBlinker_RegisterProvider,
};
