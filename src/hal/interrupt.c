/**
 * INTERRUPT Generated Driver Source File 
 * 
 * @file      interrupt.c
 *            
 * @ingroup   interruptdriver
 *            
 * @brief     This is the generated driver source file for INTERRUPT driver
 *            
 * @skipline @version   Firmware Driver Version 1.1.2
 *
 * @skipline @version   PLIB Version 1.3.1
 *            
 * @skipline  Device : dsPIC33CK256MP508
*/

/*
? [2024] Microchip Technology Inc. and its subsidiaries.

    Subject to your compliance with these terms, you may use Microchip 
    software and any derivatives exclusively with Microchip products. 
    You are responsible for complying with 3rd party license terms  
    applicable to your use of 3rd party software (including open source  
    software) that may accompany Microchip software. SOFTWARE IS ?AS IS.? 
    NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS 
    SOFTWARE, INCLUDING ANY IMPLIED WARRANTIES OF NON-INFRINGEMENT,  
    MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT 
    WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY 
    KIND WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF 
    MICROCHIP HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE 
    FORESEEABLE. TO THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP?S 
    TOTAL LIABILITY ON ALL CLAIMS RELATED TO THE SOFTWARE WILL NOT 
    EXCEED AMOUNT OF FEES, IF ANY, YOU PAID DIRECTLY TO MICROCHIP FOR 
    THIS SOFTWARE.
*/

// Section: Includes
#include <xc.h>
#include "interrupt.h"

// Section: Driver Interface Function Definitions

void INTERRUPT_Initialize(void)
{
    /*==========================================================================
     * FreeRTOS 인터럽트 우선순위 배치
     *
     * IPL 7: ADC ISR (FOC 벡터 제어 20kHz) - pwm.c에서 설정
     * IPL 6: PWM Fault ISR - pwm.c에서 설정
     * IPL 5: SCCP1 Timer ISR (50us 속도램프) - timer2.c에서 설정
     * ------- configMAX_SYSCALL_INTERRUPT_PRIORITY = 4 (경계) -------
     * IPL 3: UART ISR (FreeRTOS API 호출 가능)
     * IPL 2: (여유)
     * IPL 1: Timer1 RTOS Tick (timer1.c/port.c에서 설정)
     *
     * 주의: IPL 4 이상의 ISR에서는 FreeRTOS API (xQueueSendFromISR 등) 호출 불가
     *========================================================================*/

    // DMT: Dead Man Timer
    IPC11bits.DMTIP = 1;

    // T1: Timer 1 - FreeRTOS RTOS Tick (timer1.c에서 설정, 여기서는 미설정)
    // IPC0bits.T1IP = 1;  // configKERNEL_INTERRUPT_PRIORITY (timer1.c에서 설정)

    // SCCP1 Timer - 50us 속도램프 (timer2.c에서 IPL 5 설정)
    // IPC1bits.CCT1IP = 5;  // timer2.c에서 설정

    // UART1 - IPL 3 (FreeRTOS API 호출 가능)
    IPC47bits.U1EVTIP = 3;  // U1EVT: UART1 Event
    IPC12bits.U1EIP = 3;    // U1E: UART1 Error
    IPC3bits.U1TXIP = 3;    // U1TX: UART1 TX
    IPC2bits.U1RXIP = 3;    // U1RX: UART1 RX

    // UART2 - IPL 3 (FreeRTOS API 호출 가능)
    IPC47bits.U2EVTIP = 3;  // U2EVT: UART2 Event
    IPC12bits.U2EIP = 3;    // U2E: UART2 Error
    IPC6bits.U2RXIP = 3;    // U2RX: UART2 RX
    IPC7bits.U2TXIP = 3;    // U2TX: UART2 TX
}

void INTERRUPT_Deinitialize(void)
{
    //POR default value of priority
    IPC11bits.DMTIP = 4;
    IPC0bits.T1IP = 4;
    IPC47bits.U1EVTIP = 4;
    IPC12bits.U1EIP = 4;
    IPC3bits.U1TXIP = 4;
    IPC2bits.U1RXIP = 4;
    IPC47bits.U2EVTIP = 4;
    IPC12bits.U2EIP = 4;
    IPC7bits.U2TXIP = 4;
    IPC6bits.U2RXIP = 4;
}
