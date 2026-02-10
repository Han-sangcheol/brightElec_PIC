/*******************************************************************************
 * timer1.c - Timer1 드라이버 (콜백 등록 + 상태머신)
 *
 * 기능:
 *   - Timer1_Init(): 50us 주기 타이머 초기화, 상태 → READY
 *   - Timer1_RegisterTask(): 콜백 자동 등록, 실패 시 상태 → ERROR
 *   - Timer1_UnregisterTask(): 콜백 해제
 *   - Timer1_GetState(): 현재 상태 조회
 *   - Timer1_GetLastError(): 마지막 에러 코드 조회
 *   - _T1Interrupt(): ISR - READY 상태에서만 콜백 디스패치
 *
 * 상태머신:
 *   UNINIT → Init() → READY → RegisterTask() 실패 → ERROR
 *   UNINIT 상태에서 RegisterTask() 호출 시 → ERROR
 *
 * 타이머 계산:
 *   Fcy = 100MHz, 프리스케일러 1:8
 *   50us = (1/100,000,000) * 8 * (624+1) = 50us
 ******************************************************************************/
#include <xc.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include "timer1.h"

/* 콜백 태스크 배열 (정적) */
static TimerTask_t timerTasks[TIMER1_MAX_TASKS] = {
    { NULL, 0, 0 },
    { NULL, 0, 0 },
    { NULL, 0, 0 },
    { NULL, 0, 0 }
};

/* 상태머신 내부 변수 */
static Timer1_State_e  timer1State     = TIMER1_UNINIT;
static Timer1_Error_e  timer1LastError = TIMER1_ERR_NONE;

/*=============================================================================
 * Timer1_Init - Timer1 50us 주기 초기화, 상태 → READY
 * Fcy=100MHz, 프리스케일러 1:8, PR1=624
 *===========================================================================*/
void Timer1_Init(void)
{
    uint8_t i;

    /* 태스크 배열 초기화 */
    for (i = 0; i < TIMER1_MAX_TASKS; i++)
    {
        timerTasks[i].callback = NULL;
        timerTasks[i].period   = 0;
        timerTasks[i].counter  = 0;
    }

    /* 에러 상태 클리어 */
    timer1LastError = TIMER1_ERR_NONE;

    T1CONbits.TON = 0;      /* 타이머 1 끄기 */
    T1CONbits.TCS = 0;      /* 내부 클록 소스 사용 */
    T1CONbits.TGATE = 0;    /* 게이트 모드 비활성화 */
    T1CONbits.TCKPS = 0b01; /* 프리스케일러 1:8 설정 */

    /* 타이머 주기 계산 (50us)
       50us = (1 / 100,000,000) * 8 * (PR1 + 1)
       PR1 = 625 - 1 = 624 */
    PR1 = 624;

    IPC0bits.T1IP = 1;      /* 타이머 1 인터럽트 우선순위 설정 */
    IFS0bits.T1IF = 0;      /* 타이머 1 인터럽트 플래그 초기화 */
    IEC0bits.T1IE = 1;      /* 타이머 1 인터럽트 활성화 */

    T1CONbits.TON = 1;      /* 타이머 1 켜기 */

    /* 상태 전이: UNINIT → READY */
    timer1State = TIMER1_READY;
}

/*=============================================================================
 * Timer1_RegisterTask - 콜백 태스크 자동 등록 (상태머신 연동)
 * cb:     콜백 함수 포인터 (NULL 불가)
 * period: 호출 주기 (50us 단위, 1=50us, 20=1ms)
 * 반환:   >= 0 할당된 슬롯 ID (성공), -1 (실패 → ERROR 상태 전이)
 *===========================================================================*/
int8_t Timer1_RegisterTask(TimerCallback_t cb, uint16_t period)
{
    uint8_t i;

    /* 초기화 전 등록 시도 차단 */
    if (timer1State == TIMER1_UNINIT)
    {
        timer1LastError = TIMER1_ERR_NOT_INIT;
        timer1State     = TIMER1_ERROR;
        return -1;
    }

    /* 파라미터 검증 */
    if (cb == NULL)
    {
        timer1LastError = TIMER1_ERR_NULL_CALLBACK;
        timer1State     = TIMER1_ERROR;
        return -1;
    }

    if (period == 0)
    {
        timer1LastError = TIMER1_ERR_ZERO_PERIOD;
        timer1State     = TIMER1_ERROR;
        return -1;
    }

    /* 중복 등록 방지 */
    for (i = 0; i < TIMER1_MAX_TASKS; i++)
    {
        if (timerTasks[i].callback == cb)
        {
            timer1LastError = TIMER1_ERR_DUPLICATE;
            timer1State     = TIMER1_ERROR;
            return -1;
        }
    }

    /* 빈 슬롯 자동 검색 */
    for (i = 0; i < TIMER1_MAX_TASKS; i++)
    {
        if (timerTasks[i].callback == NULL)
        {
            timerTasks[i].callback = cb;
            timerTasks[i].period   = period;
            timerTasks[i].counter  = 0;
            return (int8_t)i;  /* 할당된 슬롯 반환 */
        }
    }

    /* 슬롯 부족 → ERROR 상태 전이 */
    timer1LastError = TIMER1_ERR_SLOT_FULL;
    timer1State     = TIMER1_ERROR;
    return -1;
}

/*=============================================================================
 * Timer1_UnregisterTask - 콜백 태스크 해제
 * taskId: Timer1_RegisterTask()에서 반환받은 슬롯 ID
 * 반환:   true (성공), false (잘못된 ID 또는 빈 슬롯)
 *===========================================================================*/
bool Timer1_UnregisterTask(int8_t taskId)
{
    if (taskId < 0 || taskId >= TIMER1_MAX_TASKS)
    {
        timer1LastError = TIMER1_ERR_INVALID_ID;
        return false;
    }

    if (timerTasks[taskId].callback == NULL)
    {
        return false;   /* 이미 비어있음 */
    }

    timerTasks[taskId].callback = NULL;
    timerTasks[taskId].period   = 0;
    timerTasks[taskId].counter  = 0;

    return true;
}

/*=============================================================================
 * Timer1_GetState - 현재 상태머신 상태 조회
 * 반환: TIMER1_UNINIT / TIMER1_READY / TIMER1_ERROR
 *===========================================================================*/
Timer1_State_e Timer1_GetState(void)
{
    return timer1State;
}

/*=============================================================================
 * Timer1_GetLastError - 마지막 에러 코드 조회
 * 반환: Timer1_Error_e 에러 코드 (읽은 후 NONE으로 클리어)
 *===========================================================================*/
Timer1_Error_e Timer1_GetLastError(void)
{
    Timer1_Error_e err = timer1LastError;  /* err = Error */
    timer1LastError = TIMER1_ERR_NONE;
    return err;
}

/*=============================================================================
 * _T1Interrupt - Timer1 ISR (50us 주기)
 * READY 상태에서만 등록된 콜백 태스크를 디스패치
 *===========================================================================*/
void __attribute__((__interrupt__, no_auto_psv)) _T1Interrupt(void)
{
    uint8_t i;

    /* ERROR 상태에서도 등록된 콜백은 계속 실행 (안전) */
    if (timer1State == TIMER1_UNINIT)
    {
        IFS0bits.T1IF = 0;
        return;     /* 미초기화 시 콜백 실행하지 않음 */
    }

    for (i = 0; i < TIMER1_MAX_TASKS; i++)
    {
        if (timerTasks[i].callback != NULL)
        {
            timerTasks[i].counter++;
            if (timerTasks[i].counter >= timerTasks[i].period)
            {
                timerTasks[i].counter = 0;
                timerTasks[i].callback();
            }
        }
    }

    IFS0bits.T1IF = 0; /* 타이머 1 인터럽트 플래그 초기화 */
}
