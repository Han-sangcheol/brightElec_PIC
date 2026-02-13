/*******************************************************************************
 * Communication.h - 통신 모듈 공용 타입 및 오케스트레이션 인터페이스
 *
 * 기능:
 *   - MotorData_t 구조체 (모터 명령/상태 데이터)
 *   - communication() 오케스트레이션 함수
 *   - Communication_IsHealthy() 통신 건강 상태 판단
 *
 * 타입 소속 (각 모듈 헤더로 분리됨):
 *   - ProtocolOps_t, PacketValidation_e → protocol.h
 *   - CommandEntry_t, CommEvent_cb      → command_handler.h
 *
 * 분리된 모듈:
 *   - Communication_drv.h/c:  UART ISR + TX 전송 + COMM_Drv API (Driver)
 *   - Communication_cfg.h:    프로토콜 상수/설정값 (Config)
 *   - protocol.h/c:           프로토콜 파싱/포맷팅/검증
 *   - command_handler.h/c:    명령 디스패치 + RX 콜백
 ******************************************************************************/
#ifndef INC_USER_Communication_H_
#define INC_USER_Communication_H_

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>

/* 방향 정의 */
#define DIRECTION_FORWARD 0
#define DIRECTION_REVERSE 1

#define MOTOR_STOP 0
#define MOTOR_RUN 1

/*=============================================================================
 * 모터 데이터 구조체
 *===========================================================================*/
typedef struct {
    bool motor_on;
    bool motor_on_command;
    bool motor_on_old;
    bool direction;
    int32_t speed;
    int32_t speed_command;
    int32_t speed_command_old;
    int32_t speed_target;
    uint16_t torque;
} MotorData_t;

/*=============================================================================
 * 오케스트레이션 함수 (Communication.c)
 *===========================================================================*/
void communication(void);
void timer1ms_communication(void);
bool Communication_IsHealthy(void);

#ifdef __cplusplus
}
#endif

#endif /* INC_USER_Communication_H_ */
