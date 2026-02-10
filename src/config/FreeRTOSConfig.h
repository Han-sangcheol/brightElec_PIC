/*******************************************************************************
 * FreeRTOSConfig.h - FreeRTOS 커널 설정 파일
 *
 * 기능:
 *   - dsPIC33CK256MP508 (FCY=100MHz) 기준 FreeRTOS 커널 설정
 *   - Tick 주기: 1ms (configTICK_RATE_HZ = 1000)
 *   - 선점형 스케줄링 (configUSE_PREEMPTION = 1)
 *   - Software Timer 활성화 (LED, 통신 1ms 콜백용)
 *   - 힙 크기: 8192 bytes (heap_4.c 사용)
 *   - 인터럽트 우선순위 경계: IPL 4 (configMAX_SYSCALL_INTERRUPT_PRIORITY)
 *     - IPL 5~7: RTOS 외부 (ADC, PWM, Timer2) - RTOS API 호출 불가
 *     - IPL 1~3: RTOS 내부 (Timer1 Tick, UART) - RTOS API 호출 가능
 *
 * 대상 MCU:
 *   dsPIC33CK256MP508, FCY = 100MHz, XC16 v2.10
 ******************************************************************************/
#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

#ifdef __cplusplus
extern "C" {
#endif

/* XC16 컴파일러 헤더 (SET_CPU_IPL 매크로 등 제공) */
#include <xc.h>

/*=============================================================================
 * 기본 커널 설정
 *===========================================================================*/
#define configUSE_PREEMPTION                    1
#define configUSE_IDLE_HOOK                     0
#define configUSE_TICK_HOOK                     0
#define configCPU_CLOCK_HZ                      ((unsigned long)100000000UL)  /* FCY = 100MHz */
#define configTICK_RATE_HZ                      ((TickType_t)1000)           /* 1ms tick */
#define configMAX_PRIORITIES                    4
#define configMINIMAL_STACK_SIZE                256    /* words (512 bytes) */
#define configTOTAL_HEAP_SIZE                   ((size_t)8192)  /* bytes */
#define configMAX_TASK_NAME_LEN                 8
#define configUSE_TRACE_FACILITY                0
#define configIDLE_SHOULD_YIELD                 1
#define configUSE_MUTEXES                       1
#define configUSE_RECURSIVE_MUTEXES             0
#define configUSE_COUNTING_SEMAPHORES           0
#define configQUEUE_REGISTRY_SIZE               0
#define configUSE_QUEUE_SETS                    0
#define configUSE_NEWLIB_REENTRANT              0

/*=============================================================================
 * Tick 타입 설정 (16-bit tick on 16-bit MCU)
 *===========================================================================*/
#define configTICK_TYPE_WIDTH_IN_BITS           TICK_TYPE_WIDTH_16_BITS

/*=============================================================================
 * Software Timer 설정 (LED 1ms, 통신 1ms 콜백용)
 *===========================================================================*/
#define configUSE_TIMERS                        1
#define configTIMER_TASK_PRIORITY               3      /* 최고 우선순위 */
#define configTIMER_QUEUE_LENGTH                5
#define configTIMER_TASK_STACK_DEPTH            256    /* words */

/*=============================================================================
 * 인터럽트 우선순위 설정 (dsPIC33CK IPL 0~7)
 *
 * configKERNEL_INTERRUPT_PRIORITY = 1
 *   → Timer1 (RTOS Tick) IPL = 1
 *
 * configMAX_SYSCALL_INTERRUPT_PRIORITY = 4
 *   → IPL 4 이상의 ISR에서는 FreeRTOS API (FromISR 포함) 호출 불가
 *   → ADC ISR (IPL 7), PWM ISR (IPL 6), Timer2 ISR (IPL 5) 는 RTOS 위에서 동작
 *   → UART ISR (IPL 3) 는 RTOS API 호출 가능
 *===========================================================================*/
#define configKERNEL_INTERRUPT_PRIORITY         1
#define configMAX_SYSCALL_INTERRUPT_PRIORITY    4

/*=============================================================================
 * 메모리 할당 설정
 *===========================================================================*/
#define configSUPPORT_STATIC_ALLOCATION         0
#define configSUPPORT_DYNAMIC_ALLOCATION        1

/*=============================================================================
 * Hook 함수 설정
 *===========================================================================*/
#define configCHECK_FOR_STACK_OVERFLOW          0
#define configUSE_MALLOC_FAILED_HOOK            0

/*=============================================================================
 * Co-routine 설정 (미사용)
 *===========================================================================*/
#define configUSE_CO_ROUTINES                   0
#define configMAX_CO_ROUTINE_PRIORITIES         2

/*=============================================================================
 * FreeRTOS API 포함 설정
 *===========================================================================*/
#define INCLUDE_vTaskPrioritySet                0
#define INCLUDE_uxTaskPriorityGet               0
#define INCLUDE_vTaskDelete                     0
#define INCLUDE_vTaskCleanUpResources           0
#define INCLUDE_vTaskSuspend                    1
#define INCLUDE_vTaskDelayUntil                 1
#define INCLUDE_vTaskDelay                      1
#define INCLUDE_xTaskGetSchedulerState          0
#define INCLUDE_xTimerPendFunctionCall          0

/*=============================================================================
 * Assert 설정 (디버그용)
 *===========================================================================*/
#define configASSERT(x) if((x) == 0) { taskDISABLE_INTERRUPTS(); while(1); }

#ifdef __cplusplus
}
#endif

#endif /* FREERTOS_CONFIG_H */
