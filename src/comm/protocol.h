/*******************************************************************************
 * protocol.h - ASCII-hex 프로토콜 파싱/포맷팅/검증
 *
 * 기능:
 *   - PacketValidation_e: 패킷 유효성 검증 결과 열거형
 *   - ProtocolOps_t: 프로토콜 동작 인터페이스 (함수포인터 구조체)
 *   - Protocol 인스턴스 (extern const)
 *   - CommandData_t 내부 소유, Getter/Setter로 외부 접근
 *
 * 적용 패턴:
 *   02: Adapter   - 프로토콜 인터페이스 변환
 *   30: Assertion - 패킷 유효성 검증
 *
 * 설정값 참조:
 *   Communication_cfg.h: 프로토콜 상수 (COMM_STX, COMM_ETX 등)
 ******************************************************************************/
#ifndef PROTOCOL_H
#define PROTOCOL_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/*=============================================================================
 * 패킷 유효성 검증 결과 (Assertion)
 *===========================================================================*/
typedef enum {
    PACKET_OK,              /* 패킷 정상 */
    PACKET_ERR_STX,         /* STX 오류 */
    PACKET_ERR_ETX,         /* ETX 오류 */
    PACKET_ERR_LENGTH,      /* 길이 오류 */
    PACKET_ERR_CHECKSUM     /* 체크섬 오류 */
} PacketValidation_e;

/*=============================================================================
 * 프로토콜 동작 인터페이스 (함수포인터)
 * ASCII-hex 프로토콜 파싱/포맷팅을 추상화
 *===========================================================================*/
typedef struct {
    bool    (*ParsePacket)(const uint8_t* raw, uint8_t len);
    uint8_t (*FormatResponse)(uint8_t* outBuf);
    uint8_t (*AsciiToHex)(uint8_t ascii);
    uint8_t (*CalcChecksum)(const uint8_t* data, uint8_t len);
    PacketValidation_e (*ValidatePacket)(const uint8_t* data, uint8_t len);
} ProtocolOps_t;                        /* Ops = Operations */

extern const ProtocolOps_t Protocol;

/*=============================================================================
 * CommandData_t Getter (읽기 전용 접근)
 * CommandData_t는 protocol.c 내부 소유, 외부에서 Getter로 접근
 *===========================================================================*/
bool     Protocol_GetMotorOn(void);
bool     Protocol_GetDirection(void);
int32_t  Protocol_GetSpeed(void);
uint16_t Protocol_GetTorque(void);

/*=============================================================================
 * CommandData_t Setter (TX 응답용 - 현재 모터 상태 업데이트)
 *===========================================================================*/
void Protocol_SetStatusData(uint16_t status);
void Protocol_SetPresentRpm(uint16_t rpm);
void Protocol_SetBldcTorque(uint16_t torque);

#ifdef __cplusplus
}
#endif

#endif /* PROTOCOL_H */
