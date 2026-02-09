/*******************************************************************************
 * motor_control.c - FOC 모터 제어 모듈 (인터페이스 패턴)
 *
 * 기능:
 *   - DoControl(): Open/Closed Loop PI 제어 루프 (Id, Iq, Speed)
 *   - InitControlParameters(): PI 계수 초기화 (D/Q/Speed)
 *   - CalculateParkAngle(): Open Loop 각도 계산, Closed Loop 전환
 *   - ResetParmeters(): 모터 파라미터 리셋 (PWM, PI, Estimator 등)
 *
 * 함수포인터 패턴:
 *   MOTOR_CONTROL_INTERFACE 구조체로 함수 포인터 제공
 *   MotorControl.Init()      → InitControlParameters()
 *   MotorControl.Reset()     → ResetParmeters()
 *   MotorControl.Execute()   → DoControl()
 *   MotorControl.CalcAngle() → CalculateParkAngle()
 *
 * 호출 관계:
 *   - DoControl(), CalculateParkAngle() ← ADC ISR (pmsm.c)
 *   - ResetParmeters() ← 상태머신/ADC ISR
 *   - InitControlParameters() ← ResetParmeters() 내부
 ******************************************************************************/
#include <xc.h>
#include <stdint.h>
#include <stdbool.h>
#include <libq.h>

#include "motor_control_noinline.h"
#include "general.h"
#include "userparms.h"
#include "motor_control.h"
#include "motor_speed.h"
#include "estim.h"
#include "fdweak.h"
#include "pwm.h"
#include "adc.h"
#include "board_service.h"
#include "singleshunt.h"
#include "measure.h"

/** Definitions */
#define STARTUPRAMP_THETA_OPENLOOP_SCALER       10
#define MAX_VOLTAGE_VECTOR                      0.98

/* 전역 변수 정의 */
volatile UGF_T uGF;

CTRL_PARM_T ctrlParm;
MOTOR_STARTUP_DATA_T motorStartUpData;

volatile int16_t thetaElectrical = 0;
volatile int16_t thetaElectricalOpenLoop = 0;
uint16_t pwmPeriod;

MC_ALPHABETA_T valphabeta, ialphabeta;
MC_SINCOS_T sincosTheta;
MC_DQ_T vdq, idq;
MC_DUTYCYCLEOUT_T pwmDutycycle;
MC_ABC_T vabc, iabc;

MC_PIPARMIN_T piInputIq;
MC_PIPARMOUT_T piOutputIq;
MC_PIPARMIN_T piInputId;
MC_PIPARMOUT_T piOutputId;
MC_PIPARMIN_T piInputOmega;
MC_PIPARMOUT_T piOutputOmega;

int CNT_offset;

/* 외부 참조 (pmsm.c) */
extern volatile uint16_t adcDataBuffer;
extern MCAPP_MEASURE_T measureInputs;

/*=============================================================================
 * MOTOR_CONTROL_INTERFACE 인스턴스 - 함수포인터 패턴
 * 사용예: MotorControl.Reset(), MotorControl.Execute() 등
 *===========================================================================*/
const MOTOR_CONTROL_INTERFACE MotorControl = {
    .Init      = InitControlParameters,
    .Reset     = ResetParmeters,
    .Execute   = DoControl,
    .CalcAngle = CalculateParkAngle,
};

/*=============================================================================
 * ResetParmeters - 모터 파라미터 리셋
 * PWM 비활성화, PI 초기화, Estimator/FW/측정 초기화
 *===========================================================================*/
void ResetParmeters(void)
{
    DisableADCInterrupt();

#ifdef SINGLE_SHUNT
    SingleShunt_InitializeParameters(&singleShuntParam);
    INVERTERA_PWM_TRIGA = ADC_SAMPLING_POINT;
    INVERTERA_PWM_TRIGB = LOOPTIME_TCY >> 1;
    INVERTERA_PWM_TRIGC = LOOPTIME_TCY - 1;
    INVERTERA_PWM_PHASE3 = MIN_DUTY;
    INVERTERA_PWM_PHASE2 = MIN_DUTY;
    INVERTERA_PWM_PHASE1 = MIN_DUTY;
#else
    INVERTERA_PWM_TRIGA = ADC_SAMPLING_POINT;
#endif

    INVERTERA_PWM_PDC3 = MIN_DUTY;
    INVERTERA_PWM_PDC2 = MIN_DUTY;
    INVERTERA_PWM_PDC1 = MIN_DUTY;

    DisablePWMOutputsInverterA();

    uGF.bits.RunMotor = 0;
    ctrlParm.qVelRef = 0;
    uGF.bits.OpenLoop = 1;
    uGF.bits.ChangeSpeed = 0;
    uGF.bits.ChangeMode = 1;

    InitControlParameters();
    InitEstimParm();
    InitFWParams();
    MCAPP_MeasureCurrentInit(&measureInputs);

    MCAPP_MeasureAvgInit(&measureInputs.MOSFETTemperature,
            MOSFET_TEMP_AVG_FILTER_SCALE);

    ClearADCIF();
    adcDataBuffer = ClearADCIF_ReadADCBUF();
    EnableADCInterrupt();
}

/*=============================================================================
 * DoControl - PI 제어 루프 (Open Loop / Closed Loop)
 * Id, Iq, Speed 3개 루프 PI 연산 실행
 *===========================================================================*/
void DoControl(void)
{
    volatile int16_t temp_qref_pow_q15;

    if (uGF.bits.OpenLoop)
    {
        /* OPENLOOP: 회전 각도, Vd, Vq 강제 설정 */
        if (uGF.bits.ChangeMode)
        {
            uGF.bits.ChangeMode = 0;
            ctrlParm.qVqRef = 0;
            ctrlParm.qVdRef = 0;
            motorStartUpData.startupLock = 0;
            motorStartUpData.startupRamp = 0;
            #ifdef TUNING
                motorStartUpData.tuningAddRampup = 0;
                motorStartUpData.tuningDelayRampup = 0;
            #endif
        }

        /* PI control for D */
        piInputId.inMeasure = idq.d;
        piInputId.inReference = ctrlParm.qVdRef;
        MC_ControllerPIUpdate_Assembly(piInputId.inReference,
                                       piInputId.inMeasure,
                                       &piInputId.piState,
                                       &piOutputId.out);
        vdq.d = piOutputId.out;

        temp_qref_pow_q15 = (int16_t)(__builtin_mulss(piOutputId.out,
                                                      piOutputId.out) >> 15);
        temp_qref_pow_q15 = Q15(MAX_VOLTAGE_VECTOR) - temp_qref_pow_q15;
        piInputIq.piState.outMax = _Q15sqrt(temp_qref_pow_q15);
        piInputIq.piState.outMin = -piInputIq.piState.outMax;

        /* PI control for Q */
        ctrlParm.qVelRef = Q_CURRENT_REF_OPENLOOP;
        ctrlParm.qVqRef = ctrlParm.qVelRef;
        piInputIq.inMeasure = idq.q;
        piInputIq.inReference = ctrlParm.qVqRef;
        MC_ControllerPIUpdate_Assembly(piInputIq.inReference,
                                       piInputIq.inMeasure,
                                       &piInputIq.piState,
                                       &piOutputIq.out);
        vdq.q = piOutputIq.out;
    }
    else
    /* Closed Loop Vector Control */
    {
        /* 외부 50us 램프(Timer1 ISR)에서 이미 부드러운 가감속 처리 완료
           내부 2차 램프 바이패스 - targetSpeed를 qVelRef에 직접 반영 */
        ctrlParm.targetSpeed = X2C_VelRef;
        ctrlParm.qVelRef = ctrlParm.targetSpeed;

        #ifdef TUNING
            if (motorStartUpData.tuningDelayRampup > TUNING_DELAY_RAMPUP)
            {
                motorStartUpData.tuningDelayRampup = 0;
            }
            if ((motorStartUpData.tuningAddRampup < (MAXIMUMSPEED_ELECTR - ENDSPEED_ELECTR)) &&
                                                  (motorStartUpData.tuningDelayRampup == 0))
            {
                motorStartUpData.tuningAddRampup++;
            }
            motorStartUpData.tuningDelayRampup++;
            ctrlParm.qVelRef = ENDSPEED_ELECTR + motorStartUpData.tuningAddRampup;
        #endif

        if (uGF.bits.ChangeMode)
        {
            uGF.bits.ChangeMode = 0;
            piInputOmega.piState.integrator = (int32_t)ctrlParm.qVqRef << 13;
            ctrlParm.qVelRef = ENDSPEED_ELECTR;
        }

        #ifndef TORQUE_MODE
            piInputOmega.inMeasure = estimator.qVelEstim + (ctrlParm.qVqRef >> 4);
            piInputOmega.inReference = ctrlParm.qVelRef;
            MC_ControllerPIUpdate_Assembly(piInputOmega.inReference,
                                           piInputOmega.inMeasure,
                                           &piInputOmega.piState,
                                           &piOutputOmega.out);
            ctrlParm.qVqRef = piOutputOmega.out;
        #else
            ctrlParm.qVqRef = ctrlParm.qVelRef;
        #endif

        ctrlParm.qVdRef = 0;

        /* PI control for D */
        piInputId.inMeasure = idq.d + (vdq.d >> 4);
        piInputId.inReference = ctrlParm.qVdRef;
        MC_ControllerPIUpdate_Assembly(piInputId.inReference,
                                       piInputId.inMeasure,
                                       &piInputId.piState,
                                       &piOutputId.out);
        vdq.d = piOutputId.out;

        temp_qref_pow_q15 = (int16_t)(__builtin_mulss(piOutputId.out,
                                                      piOutputId.out) >> 15);
        temp_qref_pow_q15 = Q15(MAX_VOLTAGE_VECTOR) - temp_qref_pow_q15;
        piInputIq.piState.outMax = _Q15sqrt(temp_qref_pow_q15);
        piInputIq.piState.outMin = -piInputIq.piState.outMax;

        /* PI control for Q */
        piInputIq.inMeasure = idq.q + (vdq.q >> 4);
        piInputIq.inReference = ctrlParm.qVqRef;
        MC_ControllerPIUpdate_Assembly(piInputIq.inReference,
                                       piInputIq.inMeasure,
                                       &piInputIq.piState,
                                       &piOutputIq.out);
        vdq.q = piOutputIq.out;
    }
}

/*=============================================================================
 * CalculateParkAngle - Park 변환 각도 계산
 * Open Loop: Lock → Ramp → Closed Loop 전환
 * Closed Loop: 추정기 오프셋 보정
 *===========================================================================*/
void CalculateParkAngle(void)
{
    if (uGF.bits.OpenLoop)
    {
        if (motorStartUpData.startupLock < LOCK_TIME)
        {
            motorStartUpData.startupLock += 1;
        }
        else if (motorStartUpData.startupRamp < END_SPEED)
        {
            motorStartUpData.startupRamp += OPENLOOP_RAMPSPEED_INCREASERATE;
        }
        else
        {
            #ifndef OPEN_LOOP_FUNCTIONING
                uGF.bits.ChangeMode = 1;
                uGF.bits.OpenLoop = 0;
            #endif
        }
        thetaElectricalOpenLoop += (int16_t)(motorStartUpData.startupRamp >>
                                            STARTUPRAMP_THETA_OPENLOOP_SCALER);
    }
    else
    {
        CNT_offset++;
        if (CNT_offset > 20)
        {
            if (estimator.qRhoOffset > 8500)
            {
                estimator.qRhoOffset--;
            }
            CNT_offset = 0;
        }
    }
}

/*=============================================================================
 * InitControlParameters - PI 제어 파라미터 초기화
 * D/Q 전류 제어기, 속도 제어기 계수 설정
 *===========================================================================*/
void InitControlParameters(void)
{
    ctrlParm.qRefRamp = SPEEDREFRAMP;
    ctrlParm.speedRampCount = SPEEDREFRAMP_COUNT;
    pwmPeriod = LOOPTIME_TCY;

    /* PI - Id Current Control */
    piInputId.piState.kp = D_CURRCNTR_PTERM;
    piInputId.piState.ki = D_CURRCNTR_ITERM;
    piInputId.piState.kc = D_CURRCNTR_CTERM;
    piInputId.piState.outMax = D_CURRCNTR_OUTMAX;
    piInputId.piState.outMin = -piInputId.piState.outMax;
    piInputId.piState.integrator = 0;
    piOutputId.out = 0;

    /* PI - Iq Current Control */
    piInputIq.piState.kp = Q_CURRCNTR_PTERM;
    piInputIq.piState.ki = Q_CURRCNTR_ITERM;
    piInputIq.piState.kc = Q_CURRCNTR_CTERM;
    piInputIq.piState.outMax = Q_CURRCNTR_OUTMAX;
    piInputIq.piState.outMin = -piInputIq.piState.outMax;
    piInputIq.piState.integrator = 0;
    piOutputIq.out = 0;

    /* PI - Speed Control */
    piInputOmega.piState.kp = SPEEDCNTR_PTERM;
    piInputOmega.piState.ki = SPEEDCNTR_ITERM;
    piInputOmega.piState.kc = SPEEDCNTR_CTERM;
    piInputOmega.piState.outMax = SPEEDCNTR_OUTMAX;
    piInputOmega.piState.outMin = -piInputOmega.piState.outMax;
    piInputOmega.piState.integrator = 0;
    piOutputOmega.out = 0;
}
