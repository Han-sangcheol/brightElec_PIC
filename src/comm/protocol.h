/*******************************************************************************
 * protocol.h - ASCII-hex 프로토콜 (Adapter 패턴 적용)
 *
 * 기능:
 *   - ASCII-hex 프로토콜 파싱/포맷팅/검증 구현
 *   - ProtocolOps_t 함수포인터 인스턴스 제공
 *   - CommandData_t 내부 소유, Getter 래퍼로 외부 접근
 *
 * 적용 패턴:
 *   02: Adapter   - 프로토콜 인터페이스 변환
 *   01: Wrapper   - CommandData Getter 래퍼
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
#include "Communication.h"     /* ProtocolOps_t, PacketValidation_e typedef */

/*=============================================================================
 * Protocol 인스턴스 (Communication.h에서 extern 선언됨)
 * 실제 정의는 protocol.c에 위치
 *===========================================================================*/
/* extern const ProtocolOps_t Protocol;  -- Communication.h에서 선언 */

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

/* 유틸리티 함수 reverse(), long_to_str()은 src/util/str_util.h로 이동됨 */

#ifdef __cplusplus
}
#endif

#endif /* PROTOCOL_H */
