/*******************************************************************************
 * motor_control.h - FOC 모터 제어 모듈 (인터페이스 패턴)
 *
 * 기능:
 *   - DoControl(): PI 제어 루프 (Open/Closed Loop)
 *   - InitControlParameters(): PI 계수 초기화
 *   - CalculateParkAngle(): Park 변환 각도 계산
 *   - ResetParmeters(): 모터 파라미터 리셋
 *
 * 함수포인터 패턴:
 *   MOTOR_CONTROL_INTERFACE - UART_INTERFACE와 동일 스타일
 *   MotorControl.Init / .Reset / .Execute / .CalcAngle 으로 호출
 ******************************************************************************/
#ifndef MOTOR_CONTROL_H
#define MOTOR_CONTROL_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include "motor_control_noinline.h"
#include "control.h"

/* 모터 제어 인터페이스 - 함수포인터 패턴 (UART_INTERFACE 스타일) */
typedef struct {
    void (*Init)(void);           /* InitControlParameters */
    void (*Reset)(void);          /* ResetParmeters */
    void (*Execute)(void);        /* DoControl */
    void (*CalcAngle)(void);      /* CalculateParkAngle */
} MOTOR_CONTROL_INTERFACE;

extern const MOTOR_CONTROL_INTERFACE MotorControl;

/* 전역 변수 extern (motor_control.c에서 정의) */
extern volatile UGF_T uGF;

extern volatile int16_t thetaElectrical;
extern volatile int16_t thetaElectricalOpenLoop;
extern uint16_t pwmPeriod;

extern MC_PIPARMIN_T piInputIq;
extern MC_PIPARMOUT_T piOutputIq;
extern MC_PIPARMIN_T piInputId;
extern MC_PIPARMOUT_T piOutputId;
extern MC_PIPARMIN_T piInputOmega;
extern MC_PIPARMOUT_T piOutputOmega;

extern int CNT_offset;

/* 함수 프로토타입 */
void InitControlParameters(void);
void DoControl(void);
void CalculateParkAngle(void);
void ResetParmeters(void);

#ifdef __cplusplus
}
#endif

#endif /* MOTOR_CONTROL_H */
