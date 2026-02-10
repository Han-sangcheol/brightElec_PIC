/*******************************************************************************
 * timer1.c - Timer1 RTOS Tick 설정 (dsPIC33CK256MP508 전용)
 *
 * 기능:
 *   - vApplicationSetupTickTimerInterrupt(): FreeRTOS port.c의 weak 함수 오버라이드
 *     dsPIC33CK 레지스터 형식(T1CONbits.TCKPS)에 맞게 Timer1을 설정
 *
 * 타이머 계산 (RTOS Tick 1ms):
 *   Fcy = 100MHz, 프리스케일러 1:8
 *   1ms = (1/100,000,000) * 8 * (PR1+1)
 *   PR1 = (100,000,000 / 8 / 1000) - 1 = 12499
 *
 * 배경:
 *   FreeRTOS port.c의 기본 vApplicationSetupTickTimerInterrupt()는
 *   T1CONbits.TCKPS0/TCKPS1 개별 비트를 사용하지만,
 *   dsPIC33CK는 T1CONbits.TCKPS를 2비트 필드로 사용하므로 오버라이드 필요
 *
 * 이전 기능 (제거됨):
 *   - Timer1_Init(): 50us 주기 → FreeRTOS port.c가 1ms로 재설정
 *   - Timer1_RegisterTask(): 콜백 등록 → Timer2 및 SW Timer로 이전
 *   - _T1Interrupt(): ISR → FreeRTOS port.c의 configTICK_INTERRUPT_HANDLER로 대체
 ******************************************************************************/
#include <xc.h>
#include <stdint.h>
#include "timer1.h"
#include "FreeRTOS.h"

/*=============================================================================
 * vApplicationSetupTickTimerInterrupt - FreeRTOS Timer1 Tick 설정
 * port.c의 weak 정의를 오버라이드 (dsPIC33CK 레지스터 호환)
 *
 * 계산:
 *   ulCompareMatch = (configCPU_CLOCK_HZ / 8 / configTICK_RATE_HZ) - 1
 *                  = (100,000,000 / 8 / 1000) - 1 = 12499
 *===========================================================================*/
void vApplicationSetupTickTimerInterrupt(void)
{
    const uint32_t ulCompareMatch =
        (configCPU_CLOCK_HZ / 8UL / configTICK_RATE_HZ) - 1UL;

    T1CON = 0;              /* Timer1 초기화 */
    TMR1 = 0;               /* 카운터 초기화 */

    PR1 = (uint16_t)ulCompareMatch;   /* PR1 = 12499 (1ms) */

    /* dsPIC33CK: TCKPS는 2비트 필드 (0b01 = 1:8 프리스케일러) */
    T1CONbits.TCKPS = 0b01;

    /* 인터럽트 설정 */
    IPC0bits.T1IP = configKERNEL_INTERRUPT_PRIORITY;  /* IPL 1 (RTOS Tick) */
    IFS0bits.T1IF = 0;      /* 인터럽트 플래그 초기화 */
    IEC0bits.T1IE = 1;      /* 인터럽트 활성화 */

    T1CONbits.TON = 1;      /* Timer1 시작 */
}
