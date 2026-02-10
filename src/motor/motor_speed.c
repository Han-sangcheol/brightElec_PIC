/*******************************************************************************
 * motor_speed.c - 속도 램프 제어 모듈
 *
 * 기능:
 *   - Motor_Speed(): 속도 명령 변환 (speed/2) 및 하한 제한
 *   - update_speed_target(): 50us 주기 속도 램프 제어
 *     - 가속: +2rpm/50us (느리게)
 *     - 감속: -10rpm/50us (빠르게, 가속의 5배)
 *   - 4-상태 머신: 완전정지(0), 정지명령(1), 구동중(2), 재기동(3)
 *   - SpeedRamp_50us_Callback(): Timer2 콜백용 래퍼 함수
 *
 * 호출 관계:
 *   - Motor_Speed()              ← Motor Task (속도 명령 변환)
 *   - update_speed_target()      ← Timer2 ISR (50us 주기 램프)
 *   - SpeedRamp_50us_Callback()  ← Timer2 콜백 등록 (램프 + VelRef 설정)
 ******************************************************************************/
#include <stdlib.h>
#include <stdint.h>
#include "motor_speed.h"

/* X2C_VelRef: 모터 속도 기준값 (Timer2 ISR에서 설정, ADC ISR DoControl에서 참조) */
volatile int X2C_VelRef;

/*=============================================================================
 * SpeedRamp_50us_Callback - Timer2 콜백용 래퍼 함수
 * 50us 마다 속도 램프 실행 + X2C_VelRef 설정
 *===========================================================================*/
void SpeedRamp_50us_Callback(void)
{
    update_speed_target();
    X2C_VelRef = MotorData_cmd.speed_target;
}

/*=============================================================================
 * Motor_Speed - 속도 명령 변환 함수 (Motor Task에서 호출)
 * 타겟속도 램프는 Timer2 ISR(50us)에서 직접 처리
 *===========================================================================*/
void Motor_Speed(void)
{
    MotorData_cmd.speed_command = MotorData_cmd.speed / 2;
    update_speed_command_lowlimit();
}

/*=============================================================================
 * update_speed_command_lowlimit - 속도 명령 하한 제한
 * (현재 모터 드라이버는 300rpm도 가능하여 사용하지 않음)
 *===========================================================================*/
void update_speed_command_lowlimit(void)
{
    if (MotorData_cmd.speed_command != 0 && MotorData_cmd.speed_command <= 1000)
    {
        MotorData_cmd.speed_command = 1000;
    }
}

/*=============================================================================
 * update_speed_target - 속도 목표 업데이트 함수 (50us 주기 호출)
 * 가속: +2rpm/50us (느리게), 감속: -10rpm/50us (빠르게, 가속의 5배)
 *
 * 상태:
 *   0: 완전 정지 - 타겟 0 유지
 *   1: 정지 명령 - 빠른 감속 (-10rpm/50us)
 *   2: 구동중    - 목표속도와 비교하여 가감속
 *   3: 재기동    - 가속 시작 (+2rpm/50us)
 *===========================================================================*/
void update_speed_target(void)
{
    static uint8_t control_step = 0;

    int32_t now_speed = abs(MotorData_now.speed);

    /* 상태 판정 */
    if( (MotorData_cmd.speed_command == 0)
    && (now_speed <= SPEED_STOP_LIMIT) )
    {
        control_step = 0;
    }
    else if( (MotorData_cmd.speed_command == 0)
    && (now_speed > SPEED_STOP_LIMIT) )
    {
        control_step = 1;
    }
    else if( (MotorData_cmd.speed_command != 0)
    && (now_speed > SPEED_STOP_LIMIT) )
    {
        control_step = 2;
    }
    else if( (MotorData_cmd.speed_command != 0)
     && (now_speed <= SPEED_STOP_LIMIT) )
    {
        control_step = 3;
    }

    /* 상태별 처리 */
    if(control_step == 0)
    {
        MotorData_cmd.speed_target = 0;
    }
    else if(control_step == 1)
    {
        if(MotorData_cmd.speed_target > SPEED_RAMP_DECEL)
        {
            MotorData_cmd.speed_target -= SPEED_RAMP_DECEL;
        }
        else
        {
            MotorData_cmd.speed_target = 0;
        }
    }
    else if(control_step == 2)
    {
        if(MotorData_cmd.speed_command > MotorData_cmd.speed_target)
        {
            MotorData_cmd.speed_target += SPEED_RAMP_ACCEL;
            if(MotorData_cmd.speed_target > MotorData_cmd.speed_command)
            {
                MotorData_cmd.speed_target = MotorData_cmd.speed_command;
            }
        }
        else if(MotorData_cmd.speed_command < MotorData_cmd.speed_target)
        {
            if((MotorData_cmd.speed_target - MotorData_cmd.speed_command) >= SPEED_RAMP_DECEL)
            {
                MotorData_cmd.speed_target -= SPEED_RAMP_DECEL;
            }
            else
            {
                MotorData_cmd.speed_target = MotorData_cmd.speed_command;
            }
        }
    }
    else if(control_step == 3 && now_speed <= SPEED_STOP_LIMIT)
    {
        MotorData_cmd.speed_target += SPEED_RAMP_ACCEL;
        if(MotorData_cmd.speed_target > MotorData_cmd.speed_command)
        {
            MotorData_cmd.speed_target = MotorData_cmd.speed_command;
        }
    }
}
