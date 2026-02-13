/*******************************************************************************
 * Communication.h - 통신 모듈 공용 타입 및 오케스트레이션 인터페이스
 *
 * 기능:
 *   - MotorData_t 구조체 (모터 명령/상태 데이터)
 *   - ProtocolAdapter_t typedef (프로토콜 어댑터 인터페이스)
 *   - CommandEntry_t typedef (명령 디스패치 테이블)
 *   - CommEvent_cb typedef (RX 이벤트 콜백)
 *   - communication() 오케스트레이션 함수
 *   - Communication_IsHealthy() 통신 건강 상태 판단
 *
 * 분리된 모듈:
 *   - uart_wrapper.h/c:      UART 전송 래퍼 (Wrapper)
 *   - protocol_adapter.h/c:  프로토콜 어댑터 (Adapter)
 *   - command_handler.h/c:   명령 디스패치 (Command) + RX 콜백 (Callback)
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
 * Assertion - 패킷 유효성 검증 결과
 *===========================================================================*/
typedef enum {
    PACKET_OK,              /* 패킷 정상 */
    PACKET_ERR_STX,         /* STX 오류 */
    PACKET_ERR_ETX,         /* ETX 오류 */
    PACKET_ERR_LENGTH,      /* 길이 오류 */
    PACKET_ERR_CHECKSUM     /* 체크섬 오류 */
} PacketValidation_e;

/*=============================================================================
 * Adapter - 프로토콜 어댑터 인터페이스 (함수포인터)
 * ASCII-hex 프로토콜 파싱/포맷팅을 추상화
 *===========================================================================*/
typedef struct {
    bool    (*ParsePacket)(const uint8_t* raw, uint8_t len);
    uint8_t (*FormatResponse)(uint8_t* outBuf);
    uint8_t (*AsciiToHex)(uint8_t ascii);
    uint8_t (*CalcChecksum)(const uint8_t* data, uint8_t len);
    PacketValidation_e (*ValidatePacket)(const uint8_t* data, uint8_t len);
} ProtocolAdapter_t;

extern const ProtocolAdapter_t Protocol;

/*=============================================================================
 * Command - 명령 핸들러 함수포인터 (fn = 내부 디스패치용)
 *===========================================================================*/
typedef void (*CommandHandler_fn)(MotorData_t* motorData);

typedef struct {
    uint8_t           commandId;   /* 명령 ID (프로토콜의 command 바이트) */
    CommandHandler_fn handler;     /* 핸들러 함수 포인터 */
} CommandEntry_t;

/*=============================================================================
 * Callback - RX 이벤트 콜백 (cb = 외부 등록 콜백)
 *===========================================================================*/
typedef void (*CommEvent_cb)(void);

#define COMM_MAX_CALLBACKS 3

/*=============================================================================
 * 오케스트레이션 함수 (Communication.c)
 *===========================================================================*/
void communication(MotorData_t* motorData_cmd, MotorData_t* motorData_now);
void timer1ms_communication(void);
uint16_t Get_Rx_Ccount(void);
bool Communication_IsHealthy(void);

#ifdef __cplusplus
}
#endif

#endif /* INC_USER_Communication_H_ */
