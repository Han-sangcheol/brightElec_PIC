/*******************************************************************************
 * motor_statemachine.c - 모터 상태머신 (함수포인터 디스패치 패턴)
 *
 * 기능:
 *   - MotorStateMachine_Execute(): 메인루프에서 호출, 상태별 핸들러 디스패치
 *   - State_Stopped():  정지 대기, motor_on 시 STARTING 전환
 *   - State_Starting(): PWM 활성화, CW/CCW 설정, RunMotor=1 → RUNNING
 *   - State_Running():  Motor_Speed() 호출, motor_on=0 시 STOPPING 전환
 *   - State_Stopping(): speed_command=0, 감속 완료 시 ResetParmeters → STOPPED
 *   - State_Fault():    스톨 감지, motor_on=0 입력 대기 후 STOPPED 전환
 *   - MotorStateMachine_GetSetRPM(): 모터 구동 시 설정 RPM 반환, 정지 시 -1
 *
 * 함수포인터 패턴:
 *   stateHandlers[] 배열에 상태별 핸들러 등록
 *   MotorStateMachine_Execute()에서 현재 상태의 핸들러를 자동 디스패치
 *
 * 호출 관계:
 *   MotorStateMachine_Execute() ← 메인루프 (pmsm.c)
 ******************************************************************************/
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include "motor_statemachine.h"
#include "motor_control.h"
#include "motor_speed.h"
#include "Communication.h"
#include "board_service.h"
#include "FreeRTOS.h"
#include "task.h"

/* STALL_STOP 기능 (pmsm.c의 ADC ISR에서 g_stall_stop_flag 설정) */
#define STALL_STOP

#ifdef STALL_STOP
extern volatile uint8_t g_stall_stop_flag;
#endif

/* 외부 변수 (pmsm.c에서 정의, volatile - Task 쓰기, ADC ISR 읽기) */
extern volatile unsigned int CW_CCW;

/* 현재 상태 */
static MotorState_e currentState = MOTOR_STATE_STOPPED;

/* 상태 핸들러 함수 선언 (static) */
static void State_Stopped(void);
static void State_Starting(void);
static void State_Running(void);
static void State_Stopping(void);
static void State_Fault(void);

/* 함수포인터 배열 - 상태별 핸들러 디스패치 테이블 */
static const StateHandler_fn stateHandlers[MOTOR_STATE_COUNT] = {
    State_Stopped,      /* MOTOR_STATE_STOPPED */
    State_Starting,     /* MOTOR_STATE_STARTING */
    State_Running,      /* MOTOR_STATE_RUNNING */
    State_Stopping,     /* MOTOR_STATE_STOPPING */
    State_Fault,        /* MOTOR_STATE_FAULT */
};

/*=============================================================================
 * MotorStateMachine_Init - 상태머신 초기화
 *===========================================================================*/
void MotorStateMachine_Init(void)
{
    currentState = MOTOR_STATE_STOPPED;
}

/*=============================================================================
 * MotorStateMachine_GetState - 현재 상태 반환
 *===========================================================================*/
MotorState_e MotorStateMachine_GetState(void)
{
    return currentState;
}

/*=============================================================================
 * MotorStateMachine_Execute - 상태머신 실행 (메인루프에서 호출)
 * 1) Stall 검사 및 motor_on_command 결정
 * 2) 현재 상태의 핸들러 함수포인터 디스패치
 *===========================================================================*/
void MotorStateMachine_Execute(void)
{
    /* Stall 검사 및 motor_on_command 결정 */
    #ifdef STALL_STOP
    if (g_stall_stop_flag != 0)
    {
        MotorData_cmd.motor_on_command = 0;
        /* 구동중이었다면 FAULT 상태로 전환 */
        if (currentState != MOTOR_STATE_FAULT
         && currentState != MOTOR_STATE_STOPPED)
        {
            currentState = MOTOR_STATE_FAULT;
        }
        /* motor_on이 0이 되면 stall 플래그 해제 */
        if (MotorData_cmd.motor_on == 0)
        {
            g_stall_stop_flag = 0;
        }
    }
    else
    {
        MotorData_cmd.motor_on_command = MotorData_cmd.motor_on;
    }
    #else
    MotorData_cmd.motor_on_command = MotorData_cmd.motor_on;
    #endif

    /* 상태 핸들러 디스패치 (함수포인터 배열) */
    if (currentState < MOTOR_STATE_COUNT && stateHandlers[currentState] != NULL)
    {
        stateHandlers[currentState]();
    }
}

/*=============================================================================
 * State_Stopped - 정지 상태 핸들러
 * motor_on_command=1 이면 STARTING 전환
 *===========================================================================*/
static void State_Stopped(void)
{
    if (MotorData_cmd.motor_on_command == 1)
    {
        currentState = MOTOR_STATE_STARTING;
    }
}

/*=============================================================================
 * State_Starting - 시작 상태 핸들러
 * PWM 활성화, CW/CCW 방향 설정, RunMotor=1 → 즉시 RUNNING 전환
 *===========================================================================*/
static void State_Starting(void)
{
    /* 모터 정역 반영 */
    if (MotorData_cmd.direction == DIRECTION_FORWARD)
    {
        CW_CCW = 0;
    }
    else
    {
        CW_CCW = 1;
    }

    EnablePWMOutputsInverterA();
    uGF.bits.RunMotor = 1;

    currentState = MOTOR_STATE_RUNNING;
}

/*=============================================================================
 * State_Running - 구동중 상태 핸들러
 * Motor_Speed() 호출, motor_on_command=0 이면 STOPPING 전환
 *===========================================================================*/
static void State_Running(void)
{
    Motor_Speed();

    if (MotorData_cmd.motor_on_command == 0)
    {
        currentState = MOTOR_STATE_STOPPING;
    }
}

/*=============================================================================
 * State_Stopping - 감속 정지 상태 핸들러
 * speed_command=0 설정 → 램프 감속 → 속도 충분히 낮으면 PWM OFF
 *===========================================================================*/
static void State_Stopping(void)
{
    /* 감속 제어: speed_command = 0으로 설정하여 램프 감속 동작 */
    MotorData_cmd.speed_command = 0;

    /* 속도가 충분히 낮아지면 PWM OFF */
    if (abs(MotorData_now.speed) <= SPEED_STOP_LIMIT
     && MotorData_cmd.speed_target == 0)
    {
        uGF.bits.RunMotor = 0;
        /* Critical Section: ResetParmeters()는 ADC ISR enable/disable을 포함
           RTOS 태스크 컨텍스트에서 호출 시 선점 방지 필요 */
        taskENTER_CRITICAL();
        MotorControl.Reset();
        taskEXIT_CRITICAL();
        currentState = MOTOR_STATE_STOPPED;
    }
}

/*=============================================================================
 * MotorStateMachine_GetSetRPM - 설정 RPM 반환 (범용 getter)
 * 모터 구동중: MotorData_cmd.speed (원본 값 그대로)
 * 모터 정지  : -1 반환
 *===========================================================================*/
int32_t MotorStateMachine_GetSetRPM(void)
{
    if (!uGF.bits.RunMotor) return -1;
    return MotorData_cmd.speed;
}

/*=============================================================================
 * State_Fault - 폴트 상태 핸들러
 * ADC ISR에서 이미 ResetParmeters() 호출됨
 * g_stall_stop_flag 해제 대기 (MotorStateMachine_Execute에서 처리)
 *===========================================================================*/
static void State_Fault(void)
{
    #ifdef STALL_STOP
    if (g_stall_stop_flag == 0)
    {
        currentState = MOTOR_STATE_STOPPED;
    }
    #endif
}
