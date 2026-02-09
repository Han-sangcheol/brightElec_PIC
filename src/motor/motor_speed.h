/*******************************************************************************
 * motor_speed.h - 속도 램프 제어 모듈
 *
 * 기능:
 *   - 50us 주기 속도 램프 제어 (가속 +2rpm, 감속 -10rpm)
 *   - 속도 명령 변환 및 하한 제한
 *   - 속도 목표 업데이트 (4-상태: 정지/감속/구동/재기동)
 *
 * 호출 관계:
 *   - Motor_Speed()              ← 메인루프 (속도 명령 변환)
 *   - update_speed_target()      ← Timer1 ISR (50us 주기 램프)
 *   - SpeedRamp_50us_Callback()  ← Timer1 콜백 (램프 + VelRef 설정)
 ******************************************************************************/
#ifndef MOTOR_SPEED_H
#define MOTOR_SPEED_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include "Communication.h"

/* 속도 램프 설정값 */
#define SPEED_RAMP_ACCEL    2       /* 가속: +2rpm / 50us (감속의 1/5) */
#define SPEED_RAMP_DECEL    10      /* 감속: -10rpm / 50us (가속의 5배) */
#define SPEED_STOP_LIMIT    200     /* 정지 판정 속도 한계값 */

/* 전역 변수 (motor_speed.c에서 정의) */
extern int X2C_VelRef;

/* 전역 변수 (pmsm.c에서 정의, 여기서 참조) */
extern MotorData MotorData_cmd;
extern MotorData MotorData_now;

/* 함수 프로토타입 */
void Motor_Speed(void);
void update_speed_target(void);
void update_speed_command_lowlimit(void);
void SpeedRamp_50us_Callback(void);

#ifdef __cplusplus
}
#endif

#endif /* MOTOR_SPEED_H */
