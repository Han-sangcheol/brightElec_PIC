/*******************************************************************************
 * pmsm.c - 메인 진입점, RTOS 태스크, ADC/PWM ISR
 *
 * 기능:
 *   - main(): 시스템 초기화 + FreeRTOS 태스크 생성 + 스케줄러 시작
 *   - vMotorTask(): 모터 상태머신 + 속도 업데이트 (1ms 주기, vTaskDelayUntil)
 *   - vCommTask(): UART 통신 처리 (10ms 주기, vTaskDelay)
 *   - vUITask(): LED 업데이트 + 진단 (10ms 주기, vTaskDelay)
 *   - _ADCInterrupt(): ADC ISR - 전류 샘플링, 과전류/스톨 사전검사, FOC 제어 실행
 *   - _PWMInterrupt(): PWM 폴트 ISR (변경 없음)
 *   - vApplicationSetupTickTimerInterrupt(): Timer1 RTOS Tick 설정 (timer1.c)
 *
 * FreeRTOS 태스크 구조:
 *   - Motor Task (Priority 3): 상태머신, 속도업데이트, 보드서비스
 *   - Comm Task  (Priority 2): UART 통신 처리
 *   - UI Task    (Priority 1): LED 업데이트, 진단
 *
 * ISR (변경 없음, RTOS 외부):
 *   - ADC ISR (IPL 7): FOC 벡터 제어 20kHz
 *   - PWM ISR (IPL 6): PWM 폴트 처리
 *   - Timer2 ISR (IPL 5): 50us 속도램프 (timer2.c)
 *
 * Software Timer (FreeRTOS):
 *   - LED Timer (1ms): LedBlinker.TimerISR() + LedMorse.TimerISR()
 *   - Comm Timer (1ms): timer1ms_communication()
 *
 * Copyright (c) 2017 released Microchip Technology Inc.  All rights reserved.
 ******************************************************************************/
#include <xc.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <libq.h>
#include <math.h>

#include "motor_control_noinline.h"

#include "general.h"
#include "userparms.h"

#include "control.h"
#include "estim.h"
#include "fdweak.h"

#include "clock.h"
#include "pwm.h"
#include "adc.h"
#include "port_config.h"
#include "delay.h"
#include "board_service.h"
#include "diagnostics.h"
#include "singleshunt.h"
#include "measure.h"

#include "uart1.h"
#include "uart2.h"
#include "uart_interface.h"
#include "uart_types.h"

#include "interrupt.h"
#include "interrupt_types.h"

#include "Communication.h"
#include "led_blinker.h"        /* Core: LedBlinker 인스턴스 */
#include "led_blinker_cfg.h"    /* 설정: LED_STRATEGY_NORMAL 등 전략 상수 */
#include "led_blinker_drv.h"    /* 드라이버: LedBlinker_Drv_Init() */
#include "led_morse.h"          /* Morse: LedMorse 인스턴스 (선택적) */

/* 새로 분리된 모듈 */
#include "motor_control.h"
#include "motor_speed.h"
#include "motor_statemachine.h"
#include "timer1.h"
#include "timer2.h"

/* Communication 분리 모듈 */
#include "Communication_drv.h"
#include "protocol.h"
#include "command_handler.h"

/* FreeRTOS */
#include "FreeRTOS.h"
#include "task.h"
#include "timers.h"

/* 전역 변수: ADC/측정 관련 (ADC ISR에서 사용) */
volatile uint16_t adcDataBuffer;
MCAPP_MEASURE_T measureInputs;

/* 전역 변수: 모터 데이터 (Communication, 상태머신에서 참조) */
MotorData_t MotorData_cmd;
MotorData_t MotorData_now;

/* 전역 변수: 모터 방향 (ADC ISR 읽기, Task 쓰기 → volatile 필요) */
volatile unsigned int CW_CCW, CW_CCW_OLD;       /* CW = Clockwise, CCW = Counter-Clockwise */
unsigned int X2C_START_STOP;

/* Stall 감지 관련 */
#define STALL_STOP

#ifdef STALL_STOP
extern MC_DQ_T bemfdq;                 /* bemf = Back EMF (역기전력) */
int32_t bemf_q_sum, bemf_d_sum;
int16_t bemf_q_flt, bemf_d_flt, STALL_CNT;  /* flt = Filtered, CNT = Count */
volatile uint8_t g_stall_stop_flag;
#endif

/*=============================================================================
 * Communication_Setup - 통신 초기화 (수평 분리 패턴)
 * 1) UART2 HW 초기화 (drv)
 * 2) CommandHandler 대상 포인터 등록 (DI: 의존성 주입)
 *===========================================================================*/
static void Communication_Setup(void)
{
    /* UART2 HW 초기화 (drv) */
    UART2_Drv.Deinitialize();
    UART2_Drv.Initialize();
    UART2_Drv.BaudRateSet(19200);
    UART2_Drv.TransmitEnable();

    /* CommandHandler 대상 포인터 등록 (DI) */
    CommandHandler_RegisterTarget(&MotorData_cmd);
}

/*=============================================================================
 * LED_Setup - LED 초기화 (수평 분리 패턴)
 * 1) HW ops 주입 (GetHwOps → SetHwOps 패턴으로 통일)
 * 2) 전략: 정상/에러 자동 전환 설정
 * 3) Core: Singleton 초기화
 * 4) 통신 건강 상태 콜백 등록 (Communication 모듈 자체 API 사용)
 * 5) Morse 모듈 초기화 (선택적 - 모터 구동 시 RPM 모르스부호 표시)
 *===========================================================================*/
static void LED_Setup(void)
{
    /* LedBlinker 초기화 (보드 상태 표시) */
    LedBlinker_SetHwOps(LedBlinker_Drv_GetHwOps());
    LedBlinker_SetAutoStrategies(&LED_STRATEGY_NORMAL, &LED_STRATEGY_ERROR);
    LedBlinker.Init();
    LedBlinker.RegisterProvider(Communication_IsHealthy);
    /* Morse 초기화 (모터 구동시 수신된 rpm 표시)*/
    LedMorse_SetHwOps(LedBlinker_Drv_GetHwOps());
    LedMorse.Init();
    LedMorse.RegisterProvider(MotorStateMachine_GetSetRPM);
}

/*=============================================================================
 * Timer2_Setup - Timer2 초기화 (50us 속도램프 전용)
 * Timer1은 FreeRTOS RTOS Tick(1ms)에 사용됨
 * LED/통신 1ms 콜백은 FreeRTOS Software Timer로 전환
 *===========================================================================*/
static void Timer2_Setup(void)
{
    Timer2_Init();
    Timer2_RegisterCallback(SpeedRamp_50us_Callback);
}

/*=============================================================================
 * FreeRTOS Software Timer 콜백 함수
 * 기존 Timer1 1ms 콜백을 FreeRTOS Software Timer로 이전
 *===========================================================================*/

/* LED 1ms Software Timer 콜백 */
static void vLedTimerCallback(TimerHandle_t xTimer)
{
    (void)xTimer;
    LedBlinker.TimerISR();
    LedMorse.TimerISR();
}

/* 통신 1ms Software Timer 콜백 */
static void vCommTimerCallback(TimerHandle_t xTimer)
{
    (void)xTimer;
    timer1ms_communication();
}

/*=============================================================================
 * FreeRTOS 태스크 함수
 *===========================================================================*/

/*--- Motor Task (Priority 3): 상태머신 + 속도업데이트 + 보드서비스 ---*/
static void vMotorTask(void *pvParameters)
{
    (void)pvParameters;
    TickType_t xLastWakeTime = xTaskGetTickCount();

    for (;;)
    {
        BoardService();

        /* 상태머신 실행 (함수포인터 디스패치 패턴) */
        MotorStateMachine_Execute();

        /* 현재 속도 업데이트 */
        MotorData_now.speed = (int32_t)estimator.qVelEstim * 2;

        /* TX 응답 데이터 업데이트 (protocol Setter) */
        Protocol_SetPresentRpm((uint16_t)abs(MotorData_now.speed));

        vTaskDelayUntil(&xLastWakeTime, pdMS_TO_TICKS(1));  /* 정확한 1ms 주기 */
    }
}

/*--- Comm Task (Priority 2): UART 통신 처리 ---*/
static void vCommTask(void *pvParameters)
{
    (void)pvParameters;

    for (;;)
    {
        communication();

        vTaskDelay(pdMS_TO_TICKS(10));  /* 약 10ms 주기 (정밀 주기 불필요) */
    }
}

/*--- UI Task (Priority 1): LED 업데이트 + 진단 ---*/
static void vUITask(void *pvParameters)
{
    (void)pvParameters;

    for (;;)
    {
        DiagnosticsStepMain();

        /* LED 상태 업데이트: Morse 우선, idle이면 Strategy */
        if (!LedMorse.Update())
        {
            LedBlinker.Update();
        }

        vTaskDelay(pdMS_TO_TICKS(10)); /* 약 10ms 주기 (정밀 주기 불필요) */
    }
}

/*=============================================================================
 * main - 시스템 초기화 + FreeRTOS 태스크 생성 + 스케줄러 시작
 *
 * 초기화 순서:
 *   1) 클록, GPIO, 주변장치
 *   2) Communication (drv + DI)
 *   3) LED (drv + cfg + Core + Callback)
 *   4) Timer2 (50us 속도램프 전용, Timer1은 RTOS Tick)
 *   5) 인터럽트 우선순위 설정
 *   6) 상태머신 + 모터 파라미터 리셋
 *   7) FreeRTOS Software Timer 생성 (LED 1ms, 통신 1ms)
 *   8) FreeRTOS 태스크 생성 (Motor, Comm, UI)
 *   9) vTaskStartScheduler() → Timer1 RTOS Tick 시작
 *
 * 태스크 구조:
 *   Motor Task (P3): 상태머신 + 속도업데이트 + 보드서비스 (1ms, vTaskDelayUntil)
 *   Comm Task  (P2): UART 통신 처리 (10ms, vTaskDelay)
 *   UI Task    (P1): LED + 진단 (10ms, vTaskDelay)
 *===========================================================================*/
int main(void)
{
    InitOscillator();
    SetupGPIOPorts();
    InitPeripherals();
    DiagnosticsInit();
    BoardServiceInit();
    CORCONbits.SATA = 0;

    /* Communication 초기화 (drv + DI) */
    Communication_Setup();

    /* LED 초기화 (drv + cfg + Core + Callback) */
    LED_Setup();

    /* Timer2 초기화 (50us 속도램프 전용) */
    Timer2_Setup();

    /* 인터럽트 초기화 */
    INTERRUPT_Initialize();

    /* 상태머신 초기화 */
    MotorStateMachine_Init();

    /* 모터 파라미터 리셋 */
    MotorControl.Reset();

    /* FreeRTOS Software Timer 생성 + 시작 (기존 Timer1 1ms 콜백 대체) */
    {
        TimerHandle_t xLedTimer  = xTimerCreate("LED",  pdMS_TO_TICKS(1), pdTRUE, NULL, vLedTimerCallback);
        TimerHandle_t xCommTimer = xTimerCreate("Comm", pdMS_TO_TICKS(1), pdTRUE, NULL, vCommTimerCallback);

        if (xLedTimer != NULL)  { xTimerStart(xLedTimer,  0); }
        if (xCommTimer != NULL) { xTimerStart(xCommTimer, 0); }
    }

    /* FreeRTOS 태스크 생성 */
    xTaskCreate(vMotorTask, "Motor", 512, NULL, 3, NULL);
    xTaskCreate(vCommTask,  "Comm",  512, NULL, 2, NULL);
    xTaskCreate(vUITask,    "UI",    256, NULL, 1, NULL);

    /* 스케줄러 시작 (Timer1 RTOS Tick 자동 설정, 여기서 리턴하지 않음) */
    vTaskStartScheduler();

    /* 도달 불가 */
    while (1);
}

/*=============================================================================
 * _ADCInterrupt - ADC ISR
 * PWM 주기마다 트리거, 전류 샘플링 + FOC 벡터 제어 실행
 * motor_control 모듈의 함수포인터 인터페이스 사용
 *===========================================================================*/
void __attribute__((__interrupt__, no_auto_psv)) _ADCInterrupt()
{
#ifdef SINGLE_SHUNT
    if (IFS4bits.PWM1IF == 1)
    {
        singleShuntParam.adcSamplePoint = 0;
        IFS4bits.PWM1IF = 0;
    }

    switch (singleShuntParam.adcSamplePoint)
    {
        case SS_SAMPLE_BUS1:
            singleShuntParam.adcSamplePoint = 1;
            singleShuntParam.Ibus1 = (int16_t)(ADCBUF_INV_A_IBUS) -
                                            measureInputs.current.offsetIbus;
        break;

        case SS_SAMPLE_BUS2:
            INVERTERA_PWM_TRIGA = ADC_SAMPLING_POINT;
            singleShuntParam.adcSamplePoint = 0;
            singleShuntParam.Ibus2 = (int16_t)(ADCBUF_INV_A_IBUS) -
                                            measureInputs.current.offsetIbus;
            ADCON3Lbits.SWCTRG = 1;
        break;

        default:
        break;
    }
#endif

    if (uGF.bits.RunMotor)
    {
        if (singleShuntParam.adcSamplePoint == 0)
        {
            measureInputs.current.Ia = ADCBUF_INV_A_IPHASE1;
            measureInputs.current.Ib = ADCBUF_INV_A_IPHASE2;

#ifdef SINGLE_SHUNT
            SingleShunt_PhaseCurrentReconstruction(&singleShuntParam);
            MCAPP_MeasureCurrentCalibrate(&measureInputs);
            iabc.a = singleShuntParam.Ia;
            iabc.b = singleShuntParam.Ib;
#else
            MCAPP_MeasureCurrentCalibrate(&measureInputs);

            if (CW_CCW)
            {
                iabc.a = measureInputs.current.Ib;
                iabc.b = measureInputs.current.Ia;
            }
            else
            {
                iabc.a = measureInputs.current.Ia;
                iabc.b = measureInputs.current.Ib;
            }
#endif

#ifdef STALL_STOP
            /* 과전류/스톨 감지 (FOC 실행 전 선행 검사) */
            if (measureInputs.current.Ia > 10000
             || measureInputs.current.Ib > 10000)
            {
                MotorControl.Reset();
                g_stall_stop_flag = 1;
                STALL_CNT = 0;
                goto adc_isr_tail;
            }

            if (measureInputs.current.Ia > 8000
             || measureInputs.current.Ib > 8000)
            {
                STALL_CNT++;
            }
            else if (measureInputs.current.Ia < 7500
                  && measureInputs.current.Ib < 7500)
            {
                STALL_CNT = 0;
            }

            if (STALL_CNT > 130)
            {
                MotorControl.Reset();
                g_stall_stop_flag = 1;
                STALL_CNT = 0;
                goto adc_isr_tail;
            }
#endif
            /* Clarke/Park 변환 */
            MC_TransformClarke_Assembly(&iabc, &ialphabeta);
            MC_TransformPark_Assembly(&ialphabeta, &sincosTheta, &idq);

            /* 속도/각도 추정 */
            Estim();

            /* FOC PI 제어 (함수포인터 인터페이스) */
            MotorControl.Execute();

            /* Park 각도 계산 (함수포인터 인터페이스) */
            MotorControl.CalcAngle();

            /* 각도 소스 선택 */
            if (uGF.bits.OpenLoop == 1)
            {
                thetaElectrical = thetaElectricalOpenLoop;
            }
            else
            {
                thetaElectrical = estimator.qRho;
            }

            MC_CalculateSineCosine_Assembly_Ram(thetaElectrical, &sincosTheta);
            MC_TransformParkInverse_Assembly(&vdq, &sincosTheta, &valphabeta);
            MC_TransformClarkeInverseSwappedInput_Assembly(&valphabeta, &vabc);

#ifdef SINGLE_SHUNT
            SingleShunt_CalculateSpaceVectorPhaseShifted(&vabc, pwmPeriod, &singleShuntParam);
            PWMDutyCycleSetDualEdge(&singleShuntParam.pwmDutycycle1, &singleShuntParam.pwmDutycycle2);
#else
            MC_CalculateSpaceVectorPhaseShifted_Assembly(&vabc, pwmPeriod,
                                                        &pwmDutycycle);
            PWMDutyCycleSet(&pwmDutycycle);
#endif
        }
    }
    else
    {
        INVERTERA_PWM_TRIGA = ADC_SAMPLING_POINT;
#ifdef SINGLE_SHUNT
        INVERTERA_PWM_TRIGB = LOOPTIME_TCY >> 1;
        INVERTERA_PWM_TRIGC = LOOPTIME_TCY - 1;
        singleShuntParam.pwmDutycycle1.dutycycle3 = MIN_DUTY;
        singleShuntParam.pwmDutycycle1.dutycycle2 = MIN_DUTY;
        singleShuntParam.pwmDutycycle1.dutycycle1 = MIN_DUTY;
        singleShuntParam.pwmDutycycle2.dutycycle3 = MIN_DUTY;
        singleShuntParam.pwmDutycycle2.dutycycle2 = MIN_DUTY;
        singleShuntParam.pwmDutycycle2.dutycycle1 = MIN_DUTY;
        PWMDutyCycleSetDualEdge(&singleShuntParam.pwmDutycycle1,
                &singleShuntParam.pwmDutycycle2);
#else
        pwmDutycycle.dutycycle3 = MIN_DUTY;
        pwmDutycycle.dutycycle2 = MIN_DUTY;
        pwmDutycycle.dutycycle1 = MIN_DUTY;
        PWMDutyCycleSet(&pwmDutycycle);
#endif
    }

adc_isr_tail:
    if (singleShuntParam.adcSamplePoint == 0)
    {
        if (uGF.bits.RunMotor == 0)
        {
            measureInputs.current.Ia = ADCBUF_INV_A_IPHASE1;
            measureInputs.current.Ib = ADCBUF_INV_A_IPHASE2;
            measureInputs.current.Ibus = ADCBUF_INV_A_IBUS;
        }
        if (MCAPP_MeasureCurrentOffsetStatus(&measureInputs) == 0)
        {
            MCAPP_MeasureCurrentOffset(&measureInputs);
        }
        else
        {
            BoardServiceStepIsr();
        }
        measureInputs.potValue = (int16_t)(ADCBUF_SPEED_REF_A >> 1);
        measureInputs.dcBusVoltage = (int16_t)(ADCBUF_VBUS_A >> 1);

        MCAPP_MeasureTemperature(&measureInputs, (int16_t)(ADCBUF_MOSFET_TEMP_A >> 1));

        DiagnosticsStepIsr();
    }

    /* Read ADC Buffer to Clear Flag */
    adcDataBuffer = ClearADCIF_ReadADCBUF();
    ClearADCIF();
}

/*=============================================================================
 * _PWMInterrupt - PWM 폴트 ISR
 * 모터 파라미터 리셋 (함수포인터 인터페이스)
 *===========================================================================*/
void __attribute__((__interrupt__, no_auto_psv)) _PWMInterrupt()
{
    MotorControl.Reset();
    ClearPWMPCIFaultInverterA();
    ClearPWMIF();
}
