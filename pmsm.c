/*******************************************************************************
* Copyright (c) 2017 released Microchip Technology Inc.  All rights reserved.
*
* SOFTWARE LICENSE AGREEMENT:
* 
* Microchip Technology Incorporated ("Microchip") retains all ownership and
* intellectual property rights in the code accompanying this message and in all
* derivatives hereto.  You may use this code, and any derivatives created by
* any person or entity by or on your behalf, exclusively with Microchip's
* proprietary products.  Your acceptance and/or use of this code constitutes
* agreement to the terms and conditions of this notice.
*
* CODE ACCOMPANYING THIS MESSAGE IS SUPPLIED BY MICROCHIP "AS IS".  NO
* WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED
* TO, IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
* PARTICULAR PURPOSE APPLY TO THIS CODE, ITS INTERACTION WITH MICROCHIP'S
* PRODUCTS, COMBINATION WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION.
*
* YOU ACKNOWLEDGE AND AGREE THAT, IN NO EVENT, SHALL MICROCHIP BE LIABLE,
* WHETHER IN CONTRACT, WARRANTY, TORT (INCLUDING NEGLIGENCE OR BREACH OF
* STATUTORY DUTY),STRICT LIABILITY, INDEMNITY, CONTRIBUTION, OR OTHERWISE,
* FOR ANY INDIRECT, SPECIAL,PUNITIVE, EXEMPLARY, INCIDENTAL OR CONSEQUENTIAL
* LOSS, DAMAGE, FOR COST OR EXPENSE OF ANY KIND WHATSOEVER RELATED TO THE CODE,
* HOWSOEVER CAUSED, EVEN IF MICROCHIP HAS BEEN ADVISED OF THE POSSIBILITY OR
* THE DAMAGES ARE FORESEEABLE.  TO THE FULLEST EXTENT ALLOWABLE BY LAW,
* MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN ANY WAY RELATED TO THIS CODE,
* SHALL NOT EXCEED THE PRICE YOU PAID DIRECTLY TO MICROCHIP SPECIFICALLY TO
* HAVE THIS CODE DEVELOPED.
*
* You agree that you are solely responsible for testing the code and
* determining its suitability.  Microchip has no obligation to modify, test,
* certify, or support the code.
*
*******************************************************************************/
#include <xc.h>
#include <stdio.h> 
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <libq.h>      
#include <math.h>

#include <libq.h>      
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

#define target_speed 800

#include "uart1.h"
#include "uart2.h"
#include "uart_interface.h"
#include "uart_types.h"

#include "interrupt.h"
#include "interrupt_types.h"

#include "Communication.h"
#include "Status_LED.h"


volatile UGF_T uGF;

CTRL_PARM_T ctrlParm;
MOTOR_STARTUP_DATA_T motorStartUpData;

volatile int16_t thetaElectrical = 0,thetaElectricalOpenLoop = 0;
uint16_t pwmPeriod;

MC_ALPHABETA_T valphabeta,ialphabeta;
MC_SINCOS_T sincosTheta;
MC_DQ_T vdq,idq;
MC_DUTYCYCLEOUT_T pwmDutycycle;
MC_ABC_T   vabc,iabc;

MC_PIPARMIN_T piInputIq;
MC_PIPARMOUT_T piOutputIq;
MC_PIPARMIN_T piInputId;
MC_PIPARMOUT_T piOutputId;
MC_PIPARMIN_T piInputOmega;
MC_PIPARMOUT_T piOutputOmega;

volatile uint16_t adcDataBuffer;
MCAPP_MEASURE_T measureInputs;

int32_t X2C_targetSPD = 3000;
int32_t targetSPD;
uint16_t g_speed_delay = 0;

volatile uint16_t g_u16Timer1ms_TargetSpeed = 0;

MotorData MotorData_cmd;
MotorData MotorData_now;

/** Definitions */
/* Open loop angle scaling Constant - This corresponds to 1024(2^10)
   Scaling down motorStartUpData.startupRamp to thetaElectricalOpenLoop   */
#define STARTUPRAMP_THETA_OPENLOOP_SCALER       10 
/* Fraction of dc link voltage(expressed as a squared amplitude) to set 
 * the limit for current controllers PI Output */
#define MAX_VOLTAGE_VECTOR                      0.98


#define STALL_STOP

#ifdef STALL_STOP

extern MC_DQ_T bemfdq;
int32_t bemf_q_sum, bemf_d_sum;
int16_t bemf_q_flt, bemf_d_flt, STALL_CNT;
volatile uint8_t g_stall_stop_flag;
#endif

#define SPEED_STOP_LIMIT 200

void InitControlParameters(void);
void DoControl( void );
void CalculateParkAngle(void);
void ResetParmeters(void);

unsigned int X2C_START_STOP, CW_CCW, CW_CCW_OLD;
int X2C_VelRef;
int CNT_offset;

void AdjustAndMonitorCloseLoopParameters(void);


void Motor_Speed(void);
void update_driving_sequence(void);
void update_speed_command_lowlimit(void);
void update_speed_target(void);



//=================================================================================================
// 제어 동작이 되는 것이 아님_ 연동이 안되어 있음
//=================================================================================================
void SetMotorSpeed(uint16_t speed)
{
    // 모터 속도 제어 로직 구현
    // 예: PWM 듀티 사이클 설정
    MC_DUTYCYCLEOUT_T pwmDutyCycle;
    pwmDutyCycle.dutycycle1 = speed;
    pwmDutyCycle.dutycycle2 = speed;
    pwmDutyCycle.dutycycle3 = speed;
    PWMDutyCycleSet(&pwmDutyCycle);
}


//=================================================================================================
// 타이머 1 초기화 함수
//=================================================================================================
void Timer1_Init(void)
{
    T1CONbits.TON = 0;      // 타이머 1 끄기
    T1CONbits.TCS = 0;      // 내부 클록 소스 사용
    T1CONbits.TGATE = 0;    // 게이트 모드 비활성화
    T1CONbits.TCKPS = 0b11; // 프리스케일러 1:256 설정

    // 타이머 주기 계산
    // Fcy = 100 MHz (예시)
    // 타이머 주기 = (1 / Fcy) * 프리스케일러 * PR1
    // 1ms = (1 / 100,000,000) * 256 * PR1
    // PR1 = (1ms * 100,000,000) / 256
    // PR1 = 390.625 -> 391로 설정
    PR1 = 391;              // 타이머 주기 레지스터 설정

    IPC0bits.T1IP = 1;      // 타이머 1 인터럽트 우선순위 설정
    IFS0bits.T1IF = 0;      // 타이머 1 인터럽트 플래그 초기화
    IEC0bits.T1IE = 1;      // 타이머 1 인터럽트 활성화

    T1CONbits.TON = 1;      // 타이머 1 켜기
}

void __attribute__((__interrupt__, no_auto_psv)) _T1Interrupt(void)
{
	g_u16Timer1ms_TargetSpeed++;

    Interrupt_Timer1ms_Status_LED();

    timer1ms_communication();

    IFS0bits.T1IF = 0; // 타이머 1 인터럽트 플래그 초기화
}

//=================================================================================================
// uart2 초기화
//=================================================================================================
void uart2_setting(void) {
    // UART2 모듈 초기화
    UART2_Drv.Deinitialize();

    // UART2 모듈 초기화
    UART2_Drv.Initialize();

    // UART2 모듈의 보레이트 설정
    UART2_Drv.BaudRateSet(19200);

    // UART2 모듈 활성화
    UART2_Drv.TransmitEnable();

    // UART2 TX 인터럽트 활성화
    // UART2_Drv.TxInterruptEnable();

    // UART2 모듈 비활성화
    // UART2_Drv.TransmitDisable();

    // UART2 모듈 비초기화
    // UART2_Drv.Deinitialize();


}

// *****************************************************************************
/* Function:
   main()

  Summary:
    main() function

  Description:
    program entry point, calls the system initialization function group 
    containing the buttons polling loop

  Precondition:
    None.

  Parameters:
    None

  Returns:
    None.

  Remarks:
    None.
 */

int main ( void )
{
    InitOscillator();
    SetupGPIOPorts();
    /* Turn on LED2 to indicate the device is programmed */
    LED2 = 1;
    /* Initialize Peripherals */
    InitPeripherals();
    DiagnosticsInit();
    
    BoardServiceInit();
    CORCONbits.SATA = 0;

    uart2_setting();

    // 타이머 1 초기화
    Timer1_Init();

    //인터럽트 
    INTERRUPT_Initialize();

	/* Reset parameters used for running motor through Inverter A*/
	ResetParmeters();

    while(1)
    {        
        /* Reset parameters used for running motor through Inverter A*/
        ResetParmeters();
        
        while(1)
        {
            DiagnosticsStepMain();
            BoardService();

		    communication(&MotorData_cmd, &MotorData_now);

            #ifdef STALL_STOP
            if(g_stall_stop_flag == 0)  // 모터 정상
            {
                MotorData_cmd.motor_on_command = MotorData_cmd.motor_on;
            }
            else
            {
                MotorData_cmd.motor_on_command = 0;
                if(MotorData_cmd.motor_on == 0)
                {
                    g_stall_stop_flag = 0;
                }
            }
            #else
            MotorData_cmd.motor_on_command = MotorData_cmd.motor_on; 
            #endif

            //================================================================
            if (MotorData_cmd.motor_on_command == 1) // 구동 명령 = 1
            {
                if(uGF.bits.RunMotor == 0) // 모터가 정지중이면 
                {
                    // 모터 정역 반영
                    if(MotorData_cmd.direction == DIRECTION_FORWARD)
                    {
                        // ctrlParm.rotationSign = 1;
                        CW_CCW = 0;
                        //estimator.qRhoOffset = estimator.qRhoOffset;                
                    }
                    else
                    {
                        // ctrlParm.rotationSign = -1;
                        CW_CCW = 1;
                        //estimator.qRhoOffset = -estimator.qRhoOffset;                
                    }
                    
                    EnablePWMOutputsInverterA();
                    uGF.bits.RunMotor = 1;
                }
                Motor_Speed();
                
            }
            else
            {
                if(uGF.bits.RunMotor == 1) 
                {
                    uGF.bits.RunMotor = 0;
                    ResetParmeters();
                }              

            }

            

            MotorData_now.speed = (int32_t)estimator.qVelEstim * 2;

            Status_LED();




            // if(X2C_START_STOP)
            // {
            //     if  (uGF.bits.RunMotor == 1)
            //     {
            //         ResetParmeters();
            //     }
            //     else
            //     {
            //         EnablePWMOutputsInverterA();
            //         uGF.bits.RunMotor = 1;
            //         LED1 = 0;
            //     }
            //     X2C_START_STOP=0;

            // }
            // // Monitoring for Button 2 press in LVMC
            // if (IsPressed_Button2())
            // {
            //     if ((uGF.bits.RunMotor == 1) && (uGF.bits.OpenLoop == 0))
            //     {
            //         uGF.bits.ChangeSpeed = !uGF.bits.ChangeSpeed;
            //     }
            // }

        }

    } // End of Main loop
    // should never get here
    while(1){}
}


void Motor_Speed(void)
{
	MotorData_cmd.speed_command = MotorData_cmd.speed / 2;

	if (g_u16Timer1ms_TargetSpeed >= 1)
	{
	 	g_u16Timer1ms_TargetSpeed = 0;

        update_speed_command_lowlimit();

		// 속도 목표 업데이트
		update_speed_target();

		// 목표 속도 전달
		// ctrlParm.inputSpeed = MotorData_cmd.speed_target;	
        X2C_VelRef = MotorData_cmd.speed_target;
	}
}

// 속도 명령 업데이트 함수(현재 모터 드라이버는 300rpm도 가능하여 사용하지 않음)
void update_speed_command_lowlimit(void)
{
	// 속도 명령이 0이 아니고, 이전 속도 명령이 0이고, 속도 명령이 3000 이하일 때
	if (MotorData_cmd.speed_command != 0 && MotorData_cmd.speed_command <= 1000)
	{
		MotorData_cmd.speed_command = 1000;
	}
}

// 속도 목표 업데이트 함수
void update_speed_target(void)
{
	static uint8_t control_step = 0; // 0: 완전 정지, 1: 정지 명령, 2: 구동중, 3: 재기동 준비 상태

    int32_t now_speed = abs(MotorData_now.speed);

	// 완전 정지 상태 
	if( (MotorData_cmd.speed_command == 0)
	&& (now_speed <= SPEED_STOP_LIMIT) )
	{
		control_step = 0;
	}
	// 정지 명령 상태
	else if( (MotorData_cmd.speed_command == 0)
	&& (now_speed > SPEED_STOP_LIMIT) )
	{
		control_step = 1;
	}
	// 구동중 상태
	else if( (MotorData_cmd.speed_command != 0)
	&& (now_speed > SPEED_STOP_LIMIT) )
	{
		control_step = 2;
	}
	// 재기동 준비 상태
	else if( (MotorData_cmd.speed_command != 0)
 	&& (now_speed <= SPEED_STOP_LIMIT) )
	// && (control_step == 0) )
	{
		control_step = 3;
	}

	if(control_step == 1)
	{
		MotorData_cmd.speed_target = 0;
	}
	else if(control_step == 2)
	{
		MotorData_cmd.speed_target = MotorData_cmd.speed_command;
	}
	else if(control_step == 3 && now_speed <= SPEED_STOP_LIMIT)
	{
		MotorData_cmd.speed_target = MotorData_cmd.speed_command;
	}
}

// *****************************************************************************
/* Function:
    ResetParmsA()

  Summary:
    This routine resets all the parameters required for Motor through Inv-A

  Description:
    Reinitializes the duty cycle,resets all the counters when restarting motor

  Precondition:
    None.

  Parameters:
    None

  Returns:
    None.

  Remarks:
    None.
 */
void ResetParmeters(void)
{
    /* Make sure ADC does not generate interrupt while initializing parameters*/
	DisableADCInterrupt();
    
#ifdef SINGLE_SHUNT
    /* Initialize Single Shunt Related parameters */
    SingleShunt_InitializeParameters(&singleShuntParam);
    INVERTERA_PWM_TRIGA = ADC_SAMPLING_POINT;
    INVERTERA_PWM_TRIGB = LOOPTIME_TCY>>1;
    INVERTERA_PWM_TRIGC = LOOPTIME_TCY-1;
    INVERTERA_PWM_PHASE3 = MIN_DUTY;
    INVERTERA_PWM_PHASE2 = MIN_DUTY;
    INVERTERA_PWM_PHASE1 = MIN_DUTY;
#else
    INVERTERA_PWM_TRIGA = ADC_SAMPLING_POINT;
#endif
    /* Re initialize the duty cycle to minimum value */
    INVERTERA_PWM_PDC3 = MIN_DUTY;
    INVERTERA_PWM_PDC2 = MIN_DUTY;
    INVERTERA_PWM_PDC1 = MIN_DUTY;
    
    DisablePWMOutputsInverterA();

    /* Stop the motor   */
    uGF.bits.RunMotor = 0;        
    /* Set the reference speed value to 0 */
    ctrlParm.qVelRef = 0;
    /* Restart in open loop */
    uGF.bits.OpenLoop = 1;
    /* Change speed */
    uGF.bits.ChangeSpeed = 0;
    /* Change mode */
    uGF.bits.ChangeMode = 1;
    
    /* Initialize PI control parameters */
    InitControlParameters();        
    /* Initialize estimator parameters */
    InitEstimParm();
    /* Initialize flux weakening parameters */
    InitFWParams();
    /* Initialize measurement parameters */
    MCAPP_MeasureCurrentInit(&measureInputs);

    MCAPP_MeasureAvgInit(&measureInputs.MOSFETTemperature,
            MOSFET_TEMP_AVG_FILTER_SCALE);
    /* Enable ADC interrupt and begin main loop timing */
    ClearADCIF();
    adcDataBuffer = ClearADCIF_ReadADCBUF();
    EnableADCInterrupt();
}
// *****************************************************************************
/* Function:
    DoControl()

  Summary:
    Executes one PI iteration for each of the three loops Id,Iq,Speed

  Description:
    This routine executes one PI iteration for each of the three loops
    Id,Iq,Speed

  Precondition:
    None.

  Parameters:
    None

  Returns:
    None.

  Remarks:
    None.
 */
void DoControl( void )
{
    /* Temporary variables for sqrt calculation of q reference */
    volatile int16_t temp_qref_pow_q15;
    
    if  (uGF.bits.OpenLoop)
    {
        /* OPENLOOP:  force rotating angle,Vd and Vq */
        if  (uGF.bits.ChangeMode)
        {
            /* Just changed to open loop */
            uGF.bits.ChangeMode = 0;

            /* Synchronize angles */
            /* VqRef & VdRef not used */
            ctrlParm.qVqRef = 0;
            ctrlParm.qVdRef = 0;

            /* Reinitialize variables for initial speed ramp */
            motorStartUpData.startupLock = 0;
            motorStartUpData.startupRamp = 0;
            #ifdef TUNING
                motorStartUpData.tuningAddRampup = 0;
                motorStartUpData.tuningDelayRampup = 0;
            #endif
        }

        /* PI control for D */
        piInputId.inMeasure = idq.d;
        piInputId.inReference  = ctrlParm.qVdRef;
        MC_ControllerPIUpdate_Assembly(piInputId.inReference,
                                       piInputId.inMeasure,
                                       &piInputId.piState,
                                       &piOutputId.out);
        vdq.d = piOutputId.out;
         /* Dynamic d-q adjustment
         with d component priority 
         vq=sqrt (vs^2 - vd^2) 
        limit vq maximum to the one resulting from the calculation above */
        temp_qref_pow_q15 = (int16_t)(__builtin_mulss(piOutputId.out ,
                                                      piOutputId.out) >> 15);
        temp_qref_pow_q15 = Q15(MAX_VOLTAGE_VECTOR) - temp_qref_pow_q15;
        piInputIq.piState.outMax = _Q15sqrt (temp_qref_pow_q15);
        piInputIq.piState.outMin = - piInputIq.piState.outMax;    
        /* PI control for Q */
        /* Speed reference */
        ctrlParm.qVelRef = Q_CURRENT_REF_OPENLOOP;
        /* q current reference is equal to the velocity reference 
         while d current reference is equal to 0
        for maximum startup torque, set the q current to maximum acceptable 
        value represents the maximum peak value */
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
        /* if change speed indication, double the speed */
//        if (uGF.bits.ChangeSpeed)
//        {
//            
//            /* Potentiometer value is scaled between NOMINALSPEED_ELECTR and 
//             * MAXIMUMSPEED_ELECTR to set the speed reference*/
//            ctrlParm.targetSpeed = (__builtin_mulss(measureInputs.potValue,
//                    MAXIMUMSPEED_ELECTR-NOMINALSPEED_ELECTR)>>15)+
//                    NOMINALSPEED_ELECTR;  
//
//        }
//        else
//        {
//
//            /* Potentiometer value is scaled between ENDSPEED_ELECTR 
//             * and NOMINALSPEED_ELECTR to set the speed reference*/
//            
//            ctrlParm.targetSpeed = (__builtin_mulss(measureInputs.potValue,
//                    NOMINALSPEED_ELECTR-ENDSPEED_ELECTR)>>15) +
//                    ENDSPEED_ELECTR;  
//            
//        }
        
        ctrlParm.targetSpeed = X2C_VelRef;
        if  (ctrlParm.speedRampCount < SPEEDREFRAMP_COUNT)
        {
           ctrlParm.speedRampCount++; 
        }
        else
        {
            /* Ramp generator to limit the change of the speed reference
              the rate of change is defined by CtrlParm.qRefRamp */
            ctrlParm.qDiff = ctrlParm.qVelRef - ctrlParm.targetSpeed;
            /* Speed Ref Ramp */
            if (ctrlParm.qDiff < 0)
            {
                /* Set this cycle reference as the sum of
                previously calculated one plus the reference ramp value */
                ctrlParm.qVelRef = ctrlParm.qVelRef+ctrlParm.qRefRamp;
            }
            else
            {
                /* Same as above for speed decrease */
                ctrlParm.qVelRef = ctrlParm.qVelRef-ctrlParm.qRefRamp;
            }
            /* If difference less than half of ref ramp, set reference
            directly from the pot */
            if (_Q15abs(ctrlParm.qDiff) < (ctrlParm.qRefRamp << 1))
            {
                ctrlParm.qVelRef = ctrlParm.targetSpeed;
            }
            ctrlParm.speedRampCount = 0;
        }
        /* Tuning is generating a software ramp
        with sufficiently slow ramp defined by 
        TUNING_DELAY_RAMPUP constant */
        #ifdef TUNING
            /* if delay is not completed */
            if (motorStartUpData.tuningDelayRampup > TUNING_DELAY_RAMPUP)
            {
                motorStartUpData.tuningDelayRampup = 0;
            }
            /* While speed less than maximum and delay is complete */
            if ((motorStartUpData.tuningAddRampup < (MAXIMUMSPEED_ELECTR - ENDSPEED_ELECTR)) &&
                                                  (motorStartUpData.tuningDelayRampup == 0) )
            {
                /* Increment ramp add */
                motorStartUpData.tuningAddRampup++;
            }
            motorStartUpData.tuningDelayRampup++;
            /* The reference is continued from the open loop speed up ramp */
            ctrlParm.qVelRef = ENDSPEED_ELECTR +  motorStartUpData.tuningAddRampup;
        #endif

        if (uGF.bits.ChangeMode)
        {
            /* Just changed from open loop */
            uGF.bits.ChangeMode = 0;
            piInputOmega.piState.integrator = (int32_t)ctrlParm.qVqRef << 13;
            ctrlParm.qVelRef = ENDSPEED_ELECTR;
        }

        /* If TORQUE MODE skip the speed controller */
        #ifndef	TORQUE_MODE
            /* Execute the velocity control loop */
            piInputOmega.inMeasure = estimator.qVelEstim + (ctrlParm.qVqRef>>4);
            piInputOmega.inReference = ctrlParm.qVelRef;
            MC_ControllerPIUpdate_Assembly(piInputOmega.inReference,
                                           piInputOmega.inMeasure,
                                           &piInputOmega.piState,
                                           &piOutputOmega.out);
            ctrlParm.qVqRef = piOutputOmega.out;
        #else
            ctrlParm.qVqRef = ctrlParm.qVelRef;
        #endif
        
        /* Flux weakening control - the actual speed is replaced 
        with the reference speed for stability 
        reference for d current component 
        adapt the estimator parameters in concordance with the speed */
        ctrlParm.qVdRef=0;//FieldWeakening(_Q15abs(ctrlParm.qVelRef));

        /* PI control for D */
        piInputId.inMeasure = idq.d +  (vdq.d>>4);
        piInputId.inReference  = ctrlParm.qVdRef;
        MC_ControllerPIUpdate_Assembly(piInputId.inReference,
                                       piInputId.inMeasure,
                                       &piInputId.piState,
                                       &piOutputId.out);
        vdq.d    = piOutputId.out;

        /* Dynamic d-q adjustment
         with d component priority 
         vq=sqrt (vs^2 - vd^2) 
        limit vq maximum to the one resulting from the calculation above */
        temp_qref_pow_q15 = (int16_t)(__builtin_mulss(piOutputId.out ,
                                                      piOutputId.out) >> 15);
        temp_qref_pow_q15 = Q15(MAX_VOLTAGE_VECTOR) - temp_qref_pow_q15;
        piInputIq.piState.outMax = _Q15sqrt (temp_qref_pow_q15);
        piInputIq.piState.outMin = - piInputIq.piState.outMax;
        /* PI control for Q */
        piInputIq.inMeasure  = idq.q + (vdq.q>>4);
        piInputIq.inReference  = ctrlParm.qVqRef;
        MC_ControllerPIUpdate_Assembly(piInputIq.inReference,
                                       piInputIq.inMeasure,
                                       &piInputIq.piState,
                                       &piOutputIq.out);
        vdq.q = piOutputIq.out;
    }
      
}
// *****************************************************************************
/* Function:
   _ADCInterrupt()

  Summary:
   _ADCInterrupt() ISR routine

  Description:
    Does speed calculation and executes the vector update loop
    The ADC sample and conversion is triggered by the PWM period.
    The speed calculation assumes a fixed time interval between calculations.

  Precondition:
    None.

  Parameters:
    None

  Returns:
    None.

  Remarks:
    None.
 */
void __attribute__((__interrupt__,no_auto_psv)) _ADCInterrupt()
{
#ifdef SINGLE_SHUNT 
    if (IFS4bits.PWM1IF ==1)
    {
        singleShuntParam.adcSamplePoint = 0;
        IFS4bits.PWM1IF = 0;
    }    
    /* If single shunt algorithm is enabled, two ADC interrupts will be
     serviced every PWM period in order to sample current twice and
     be able to reconstruct the three phases */

    switch(singleShuntParam.adcSamplePoint)
    {
        case SS_SAMPLE_BUS1:
            /*Set Trigger to measure BusCurrent Second sample during PWM 
              Timer is counting up*/
            singleShuntParam.adcSamplePoint = 1;  
            /* Ibus is measured and offset removed from measurement*/
            singleShuntParam.Ibus1 = (int16_t)(ADCBUF_INV_A_IBUS) - 
                                            measureInputs.current.offsetIbus;                        
        break;

        case SS_SAMPLE_BUS2:
            /*Set Trigger to measure BusCurrent first sample during PWM 
              Timer is counting up*/
            INVERTERA_PWM_TRIGA = ADC_SAMPLING_POINT;
            singleShuntParam.adcSamplePoint = 0;
            /* this interrupt corresponds to the second trigger and 
                save second current measured*/
            /* Ibus is measured and offset removed from measurement*/
            singleShuntParam.Ibus2 = (int16_t)(ADCBUF_INV_A_IBUS) - 
                                            measureInputs.current.offsetIbus;
            ADCON3Lbits.SWCTRG = 1;
        break;

        default:
        break;  
    }
#endif
    
    // if(CW_CCW!=CW_CCW_OLD){
    //     uGF.bits.RunMotor = 0;
    // }
    // CW_CCW_OLD = CW_CCW;
    
    if (uGF.bits.RunMotor)
    {

        if (singleShuntParam.adcSamplePoint == 0)
        {
            measureInputs.current.Ia = ADCBUF_INV_A_IPHASE1;
            measureInputs.current.Ib = ADCBUF_INV_A_IPHASE2; 

#ifdef SINGLE_SHUNT
                
            /* Reconstruct Phase currents from Bus Current*/                
            SingleShunt_PhaseCurrentReconstruction(&singleShuntParam);
            MCAPP_MeasureCurrentCalibrate(&measureInputs);
            iabc.a = singleShuntParam.Ia;
            iabc.b = singleShuntParam.Ib;
#else
            MCAPP_MeasureCurrentCalibrate(&measureInputs);
//            iabc.a = measureInputs.current.Ia;
//            iabc.b = measureInputs.current.Ib;
            
            if(CW_CCW){
                iabc.a = measureInputs.current.Ib;      // CW
                iabc.b = measureInputs.current.Ia;      // CW
                
            }else{
                iabc.a = measureInputs.current.Ia;      // CCW
                iabc.b = measureInputs.current.Ib;      // CCW
            }
            
#endif
            /* Calculate qId,qIq from qSin,qCos,qIa,qIb */
            MC_TransformClarke_Assembly(&iabc,&ialphabeta);
            MC_TransformPark_Assembly(&ialphabeta,&sincosTheta,&idq);

            /* Speed and field angle estimation */
            Estim();
            /* Calculate control values */
            DoControl();
            /* Calculate qAngle */
            CalculateParkAngle();
            /* if open loop */
            if (uGF.bits.OpenLoop == 1)
            {
                /* the angle is given by park parameter */
                thetaElectrical = thetaElectricalOpenLoop;
            }
            else
            {
                /* if closed loop, angle generated by estimator */
                thetaElectrical = estimator.qRho;
            }
            MC_CalculateSineCosine_Assembly_Ram(thetaElectrical,&sincosTheta);
            MC_TransformParkInverse_Assembly(&vdq,&sincosTheta,&valphabeta);

            MC_TransformClarkeInverseSwappedInput_Assembly(&valphabeta,&vabc);
                
#ifdef  SINGLE_SHUNT
            SingleShunt_CalculateSpaceVectorPhaseShifted(&vabc,pwmPeriod,&singleShuntParam);

            PWMDutyCycleSetDualEdge(&singleShuntParam.pwmDutycycle1,&singleShuntParam.pwmDutycycle2);
#else
            MC_CalculateSpaceVectorPhaseShifted_Assembly(&vabc,pwmPeriod,
                                                        &pwmDutycycle);
            PWMDutyCycleSet(&pwmDutycycle);
#endif
                
        }
    }
    else
    {
        INVERTERA_PWM_TRIGA = ADC_SAMPLING_POINT;
#ifdef SINGLE_SHUNT
        INVERTERA_PWM_TRIGB = LOOPTIME_TCY>>1;
        INVERTERA_PWM_TRIGC = LOOPTIME_TCY-1;
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

  #ifdef STALL_STOP
    //  if (!uGF.bits.OpenLoop) {
    //   bemf_d_sum += bemfdq.d;
    //   bemf_d_sum -= bemf_d_flt;
    //   bemf_d_flt = (bemf_d_sum >> 8);

    //   bemf_q_sum += bemfdq.q;
    //   bemf_q_sum -= bemf_q_flt;
    //   bemf_q_flt = (bemf_q_sum >> 8);

    //   if (bemf_d_flt < 0) {
    //     STALL_CNT++;
    //   } else {
    //     STALL_CNT = 0;
    //   }

    //   if (STALL_CNT > 2) {
    //     ResetParmeters();
    //     g_stall_stop_flag = 1;
    //   }
    // }

    if(measureInputs.current.Ia > 8000
     || measureInputs.current.Ib > 8000)
    {
      STALL_CNT++;
    } else if(measureInputs.current.Ia < 7500
     || measureInputs.current.Ib < 7500){
      STALL_CNT = 0;
    }

    if(STALL_CNT > 130)
    {
      ResetParmeters();
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
        measureInputs.potValue = (int16_t)( ADCBUF_SPEED_REF_A>>1);
        measureInputs.dcBusVoltage = (int16_t)( ADCBUF_VBUS_A>>1);
        
        MCAPP_MeasureTemperature(&measureInputs,(int16_t)(ADCBUF_MOSFET_TEMP_A>>1));
        
        DiagnosticsStepIsr();
    }
    /* Read ADC Buffet to Clear Flag */
	adcDataBuffer = ClearADCIF_ReadADCBUF();
    ClearADCIF();   
}
// *****************************************************************************
/* Function:
    CalculateParkAngle ()

  Summary:
    Function calculates the angle for open loop control

  Description:
    Generate the start sine waves feeding the motor terminals
    Open loop control, forcing the motor to align and to start speeding up .
 
  Precondition:
    None.

  Parameters:
    None

  Returns:
    None.

  Remarks:
    None.
 */
void CalculateParkAngle(void)
{
    /* if open loop */
    if (uGF.bits.OpenLoop)
    {
        /* begin with the lock sequence, for field alignment */
        if (motorStartUpData.startupLock < LOCK_TIME)
        {
            motorStartUpData.startupLock += 1;
        }
        /* Then ramp up till the end speed */
        else if (motorStartUpData.startupRamp < END_SPEED)
        {
            motorStartUpData.startupRamp += OPENLOOP_RAMPSPEED_INCREASERATE;
        }
        /* Switch to closed loop */
        else 
        {
            #ifndef OPEN_LOOP_FUNCTIONING
                uGF.bits.ChangeMode = 1;
                uGF.bits.OpenLoop = 0;
            #endif
        }
        /* The angle set depends on startup ramp */
        thetaElectricalOpenLoop += (int16_t)(motorStartUpData.startupRamp >> 
                                            STARTUPRAMP_THETA_OPENLOOP_SCALER);

    }
    /* Switched to closed loop */
    else 
    {
        /* In closed loop slowly decrease the offset add to the estimated angle */
        CNT_offset++;
        if(CNT_offset>20){
            if (estimator.qRhoOffset > 8500)
            {
                estimator.qRhoOffset--;
            }
            CNT_offset = 0;
        }
    }
}
// *****************************************************************************
/* Function:
    InitControlParameters()

  Summary:
    Function initializes control parameters

  Description:
    Initialize control parameters: PI coefficients, scaling constants etc.

  Precondition:
    None.

  Parameters:
    None

  Returns:
    None.

  Remarks:
    None.
 */
void InitControlParameters(void)
{
    
    ctrlParm.qRefRamp = SPEEDREFRAMP;
    ctrlParm.speedRampCount = SPEEDREFRAMP_COUNT;
    /* Set PWM period to Loop Time */
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

void __attribute__((__interrupt__,no_auto_psv)) _PWMInterrupt()
{
    ResetParmeters();
    ClearPWMPCIFaultInverterA();
    LED1 = 1; 
    ClearPWMIF(); 
}
