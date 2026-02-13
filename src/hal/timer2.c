/*******************************************************************************
 * timer2.c - SCCP1 타이머 드라이버 (50us 속도램프 전용)
 *
 * 기능:
 *   - Timer2_Init(): SCCP1 모듈을 16비트 타이머로 설정 (50us 주기)
 *   - Timer2_RegisterCallback(): 콜백 함수 등록
 *   - _CCT1Interrupt(): SCCP1 Timer ISR - 등록된 콜백 호출
 *
 * 하드웨어:
 *   dsPIC33CK256MP508에는 전통적 Timer2(T2CON)가 없음
 *   SCCP1 모듈을 16비트 타이머 모드로 사용
 *
 * 타이머 계산:
 *   Fcy = 100MHz, SCCP 프리스케일러 1:4 (TMRPS=0b01)
 *   50us = (1/100,000,000) * 4 * (1249+1) = 50us
 *   CCP1PRL = (100,000,000 / 4 / 20000) - 1 = 1249
 *
 * 인터럽트:
 *   벡터: _CCT1Interrupt (SCCP1 Timer Interrupt)
 *   플래그: IFS0bits.CCT1IF
 *   활성화: IEC0bits.CCT1IE
 *   우선순위: IPC1bits.CCT1IP = 5 (RTOS 외부)
 *
 * 배경:
 *   FreeRTOS 도입으로 Timer1이 RTOS Tick(1ms)에 사용되어
 *   기존 Timer1의 50us 속도램프 콜백을 SCCP1 타이머로 이전
 ******************************************************************************/
#include <xc.h>
#include <stdint.h>
#include <stddef.h>
#include "timer2.h"

/* 콜백 함수 포인터 (하나만 등록 가능) */
static Timer2_cb timer2Callback = NULL;

/*=============================================================================
 * Timer2_Init - SCCP1 모듈을 16비트 타이머로 초기화 (50us 주기)
 * Fcy=100MHz, 프리스케일러 1:4, CCP1PRL=1249
 *===========================================================================*/
void Timer2_Init(void)
{
    timer2Callback = NULL;

    /* SCCP1 모듈 끄기 */
    CCP1CON1Lbits.CCPON = 0;

    /* SCCP1 제어 레지스터 초기화 */
    CCP1CON1L = 0;              /* 전체 초기화 */
    CCP1CON1H = 0;              /* 동기화/원샷 비활성화 */
    CCP1CON2L = 0;
    CCP1CON2H = 0;

    /* 16비트 타이머 모드 설정 */
    CCP1CON1Lbits.MOD    = 0b0000;  /* 타이머 모드 */
    CCP1CON1Lbits.CCSEL  = 0;       /* Output Compare/Timer 모드 */
    CCP1CON1Lbits.T32    = 0;       /* 16비트 모드 */
    CCP1CON1Lbits.TMRPS  = 0b01;    /* 프리스케일러 1:4 */
    CCP1CON1Lbits.CLKSEL = 0b000;   /* 클록 소스: Fcy (100MHz) */

    /* 타이머 카운터 초기화 */
    CCP1TMRL = 0;

    /* 타이머 주기 설정 (50us)
       50us = (1 / 100,000,000) * 4 * (CCP1PRL + 1)
       CCP1PRL = (100,000,000 / 4 / 20,000) - 1 = 1249 */
    CCP1PRL = 1249;

    /* 인터럽트 설정 */
    IPC1bits.CCT1IP = 5;        /* SCCP1 Timer 인터럽트 우선순위 (IPL 5, RTOS 외부) */
    IFS0bits.CCT1IF = 0;        /* SCCP1 Timer 인터럽트 플래그 초기화 */
    IEC0bits.CCT1IE = 1;        /* SCCP1 Timer 인터럽트 활성화 */

    /* SCCP1 모듈 켜기 */
    CCP1CON1Lbits.CCPON = 1;
}

/*=============================================================================
 * Timer2_RegisterCallback - 콜백 함수 등록
 * cb: 콜백 함수 포인터 (50us마다 호출됨)
 *===========================================================================*/
void Timer2_RegisterCallback(Timer2_cb cb)
{
    timer2Callback = cb;
}

/*=============================================================================
 * _CCT1Interrupt - SCCP1 Timer ISR (50us 주기)
 * 등록된 콜백 함수 호출 (SpeedRamp_50us_Callback 전용)
 *
 * 주의: IPL 5 (RTOS 외부) → FreeRTOS API 호출 불가
 *===========================================================================*/
void __attribute__((__interrupt__, no_auto_psv)) _CCT1Interrupt(void)
{
    if (timer2Callback != NULL)
    {
        timer2Callback();
    }

    IFS0bits.CCT1IF = 0;        /* SCCP1 Timer 인터럽트 플래그 초기화 */
}
