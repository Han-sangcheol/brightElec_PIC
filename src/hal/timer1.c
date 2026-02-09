/*******************************************************************************
 * timer1.c - Timer1 드라이버 (콜백 등록 패턴)
 *
 * 기능:
 *   - Timer1_Init(): 50us 주기 타이머 초기화 (Fcy=100MHz, 1:8, PR1=624)
 *   - Timer1_RegisterTask(): 콜백 함수 등록 (인덱스, 콜백, 주기)
 *   - _T1Interrupt(): ISR - 등록된 콜백을 주기별로 호출
 *
 * 타이머 계산:
 *   Fcy = 100MHz, 프리스케일러 1:8
 *   50us = (1/100,000,000) * 8 * (624+1) = 50us
 *
 * 콜백 패턴:
 *   timerTasks[] 배열에 등록된 콜백을 ISR에서 주기적으로 디스패치
 *   period=1 → 50us마다, period=20 → 1ms마다 호출
 ******************************************************************************/
#include <xc.h>
#include <stdint.h>
#include <stddef.h>
#include "timer1.h"

/* 콜백 태스크 배열 (정적) */
static TimerTask_t timerTasks[TIMER1_MAX_TASKS] = {
    { NULL, 0, 0 },
    { NULL, 0, 0 },
    { NULL, 0, 0 },
    { NULL, 0, 0 }
};

/*=============================================================================
 * Timer1_Init - Timer1 50us 주기 초기화
 * Fcy=100MHz, 프리스케일러 1:8, PR1=624
 *===========================================================================*/
void Timer1_Init(void)
{
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
}

/*=============================================================================
 * Timer1_RegisterTask - 콜백 태스크 등록
 * idx:    태스크 인덱스 (0 ~ TIMER1_MAX_TASKS-1)
 * cb:     콜백 함수 포인터
 * period: 호출 주기 (50us 단위, 1=50us, 20=1ms)
 *===========================================================================*/
void Timer1_RegisterTask(uint8_t idx, TimerCallback_t cb, uint16_t period)
{
    if (idx < TIMER1_MAX_TASKS)
    {
        timerTasks[idx].callback = cb;
        timerTasks[idx].period   = period;
        timerTasks[idx].counter  = 0;
    }
}

/*=============================================================================
 * _T1Interrupt - Timer1 ISR (50us 주기)
 * 등록된 콜백 태스크를 주기별로 디스패치
 *===========================================================================*/
void __attribute__((__interrupt__, no_auto_psv)) _T1Interrupt(void)
{
    uint8_t i;

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
