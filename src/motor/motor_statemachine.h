/*******************************************************************************
 * motor_statemachine.h - 모터 상태머신 (함수포인터 디스패치 패턴)
 *
 * 기능:
 *   - 모터 상태 관리: STOPPED → STARTING → RUNNING → STOPPING → STOPPED
 *   - FAULT 상태: 스톨 감지 시 진입, 복구 대기
 *   - 함수포인터 배열로 상태별 핸들러 디스패치
 *
 * 상태 흐름:
 *   STOPPED  → motor_on=1 → STARTING → RUNNING
 *   RUNNING  → motor_on=0 → STOPPING → (감속완료) → STOPPED
 *   (any)    → stall_flag → FAULT → motor_on=0 → STOPPED
 *
 * 함수포인터 패턴:
 *   StateHandler_t 함수포인터 배열로 상태별 핸들러 자동 디스패치
 ******************************************************************************/
#ifndef MOTOR_STATEMACHINE_H
#define MOTOR_STATEMACHINE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/* 모터 상태 정의 */
typedef enum {
    MOTOR_STATE_STOPPED,    /* 정지 상태 */
    MOTOR_STATE_STARTING,   /* 시작 (PWM 활성화, 방향 설정) */
    MOTOR_STATE_RUNNING,    /* 구동중 (속도 제어 활성) */
    MOTOR_STATE_STOPPING,   /* 감속 정지중 (램프 감속) */
    MOTOR_STATE_FAULT,      /* 스톨/폴트 상태 */
    MOTOR_STATE_COUNT       /* 상태 총 개수 */
} MotorState_e;

/* 상태 핸들러 함수포인터 타입 */
typedef void (*StateHandler_t)(void);

/* 함수 프로토타입 */
void MotorStateMachine_Init(void);
void MotorStateMachine_Execute(void);
MotorState_e MotorStateMachine_GetState(void);

#ifdef __cplusplus
}
#endif

#endif /* MOTOR_STATEMACHINE_H */
