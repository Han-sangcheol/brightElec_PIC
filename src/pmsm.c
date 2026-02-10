/*******************************************************************************
 * pmsm.c - 메인 진입점 및 ADC/PWM ISR
 *
 * 기능:
 *   - main(): 시스템 초기화 + 메인루프
 *   - UART2_Setup(): UART2 인터페이스 초기화
 *   - Timer1_Setup(): Timer1 초기화 + 콜백 등록 (상태머신 연동)
 *   - _ADCInterrupt(): ADC ISR - 전류 샘플링, FOC 제어 실행
 *   - _PWMInterrupt(): PWM 폴트 ISR
 *
 * 분리된 모듈:
 *   - motor_control.c/h: FOC PI 제어 루프 (MOTOR_CONTROL_INTERFACE 패턴)
 *   - motor_speed.c/h:   속도 램프 제어 (+2/-10 rpm)
 *   - motor_statemachine.c/h: 상태머신 디스패치 패턴
 *   - hal/timer1.c/h:    Timer1 콜백 등록 패턴
 *   - led_blinker.c/h:   LED 점멸 제어 (HW 독립, 재사용)
 *   - led_blinker_drv.c/h: LED HW 바인딩 (프로젝트별)
 *   - uart_wrapper.c/h:  UART 전송 래퍼 (Wrapper)
 *   - protocol_adapter.c/h: 프로토콜 어댑터 (Adapter)
 *   - command_handler.c/h: 명령 디스패치 (Command)
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

/* 새로 분리된 모듈 */
#include "motor_control.h"
#include "motor_speed.h"
#include "motor_statemachine.h"
#include "timer1.h"

/* Communication 분리 모듈 */
#include "uart_wrapper.h"
#include "protocol_adapter.h"
#include "command_handler.h"

/* 전역 변수: ADC/측정 관련 (ADC ISR에서 사용) */
volatile uint16_t adcDataBuffer;
MCAPP_MEASURE_T measureInputs;

/* 전역 변수: 모터 데이터 (Communication, 상태머신에서 참조) */
MotorData MotorData_cmd;
MotorData MotorData_now;

/* 전역 변수: 모터 방향 (ADC ISR, 상태머신에서 참조) */
unsigned int CW_CCW, CW_CCW_OLD;       /* CW = Clockwise, CCW = Counter-Clockwise */
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
 * UART2_Setup - UART2 인터페이스 초기화
 * UART_INTERFACE 함수포인터 패턴 활용
 *===========================================================================*/
static void UART2_Setup(void)
{
    UART2_Drv.Deinitialize();
    UART2_Drv.Initialize();
    UART2_Drv.BaudRateSet(19200);
    UART2_Drv.TransmitEnable();
}

/*=============================================================================
 * 통신 상태 제공자 (Callback)
 * StatusLED에 등록되어 1초마다 호출됨
 * Communication 모듈의 RX 카운터 변화로 통신 상태 판단
 *===========================================================================*/
static bool CommunicationStatusProvider(void)
{
    static uint16_t lastRxCount = 0;
    uint16_t currentRxCount = Get_Rx_Ccount();
    bool isHealthy = (currentRxCount != lastRxCount);
    lastRxCount = currentRxCount;
    return isHealthy;
}

/*=============================================================================
 * LED_Setup - LED 초기화 (수평 분리 패턴)
 * 1) 드라이버: HW ops 주입
 * 2) 전략: 정상/에러 자동 전환 설정
 * 3) Core: Singleton 초기화
 * 4) 통신 상태 제공자 콜백 등록
 *===========================================================================*/
static void LED_Setup(void)
{
    LedBlinker_Drv_Init();
    LedBlinker_SetAutoStrategies(&LED_STRATEGY_NORMAL, &LED_STRATEGY_ERROR);
    LedBlinker.Init();
    LedBlinker.RegisterProvider(CommunicationStatusProvider);
}

/*=============================================================================
 * Timer1_Setup - Timer1 초기화 + 콜백 등록 (상태머신 연동)
 * 등록 실패 시 ERROR 상태 → while(1) 정지
 *===========================================================================*/
static void Timer1_Setup(void)
{
    Timer1_Init();
    Timer1_RegisterTask(SpeedRamp_50us_Callback, 1);    /* 50us: 속도 램프 */
    Timer1_RegisterTask(LedBlinker.TimerISR,     20);   /* 1ms: LED 타이머 */
    Timer1_RegisterTask(timer1ms_communication,  20);   /* 1ms: 통신 타이머 */

    /* 등록 실패 검출 → 에러 상태 시 무한루프 (디버그용) */
    if (Timer1_GetState() == TIMER1_ERROR)  { while(1); }
}

/*=============================================================================
 * main - 시스템 초기화 + 메인루프
 *
 * 초기화 순서:
 *   1) 클록, GPIO, 주변장치
 *   2) UART2 (통신)
 *   3) Timer1 (50us) + 콜백 등록
 *   4) 인터럽트
 *   5) 모터 파라미터 리셋
 *
 * 메인루프:
 *   - 진단 + 보드 서비스
 *   - 통신 처리
 *   - 상태머신 실행 (함수포인터 디스패치)
 *   - 속도 업데이트 + LED 표시
 *===========================================================================*/
int main(void)
{
    InitOscillator();
    SetupGPIOPorts();
    InitPeripherals();
    DiagnosticsInit();
    BoardServiceInit();
    CORCONbits.SATA = 0;

    /* UART2 초기화 */
    UART2_Setup();

    /* LED 초기화 (drv + cfg + Core + Callback) */
    LED_Setup();

    /* Timer1 초기화 + 콜백 등록 (상태머신 연동) */
    Timer1_Setup();

    /* 인터럽트 초기화 */
    INTERRUPT_Initialize();

    /* 상태머신 초기화 */
    MotorStateMachine_Init();

    /* 모터 파라미터 리셋 */
    MotorControl.Reset();

    /* 메인루프 */
    while (1)
    {
        DiagnosticsStepMain();
        BoardService();

        communication(&MotorData_cmd, &MotorData_now);

        /* 상태머신 실행 (함수포인터 디스패치 패턴) */
        MotorStateMachine_Execute();

        /* 현재 속도 업데이트 */
        MotorData_now.speed = (int32_t)estimator.qVelEstim * 2;

        /* LED 상태 업데이트 (Core) */
        LedBlinker.Update();
    }
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

    /* Stall 감지 */
#ifdef STALL_STOP
    if (measureInputs.current.Ia > 8000
     || measureInputs.current.Ib > 8000)
    {
        STALL_CNT++;
    }
    else if (measureInputs.current.Ia < 7500
          || measureInputs.current.Ib < 7500)
    {
        STALL_CNT = 0;
    }

    if (STALL_CNT > 130)
    {
        MotorControl.Reset();
        g_stall_stop_flag = 1;
    }
#endif

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
