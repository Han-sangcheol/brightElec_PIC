/*******************************************************************************
 * protocol_adapter.h - ASCII-hex 프로토콜 어댑터 (Adapter)
 *
 * 기능:
 *   - ASCII-hex 프로토콜 파싱/포맷팅/검증 구현
 *   - ProtocolAdapter_t 함수포인터 인스턴스 제공
 *   - CommandData_t 내부 소유, Getter 래퍼로 외부 접근
 *   - 유틸리티: reverse(), long_to_str()
 *
 * 적용 패턴:
 *   02: Adapter   - 프로토콜 인터페이스 변환
 *   01: Wrapper   - CommandData Getter 래퍼
 *   30: Assertion - 패킷 유효성 검증
 ******************************************************************************/
#ifndef PROTOCOL_ADAPTER_H
#define PROTOCOL_ADAPTER_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include "Communication.h"     /* ProtocolAdapter_t, PacketValidation_e typedef */

/*=============================================================================
 * Protocol 인스턴스 (Communication.h에서 extern 선언됨)
 * 실제 정의는 protocol_adapter.c에 위치
 *===========================================================================*/
/* extern const ProtocolAdapter_t Protocol;  -- Communication.h에서 선언 */

/*=============================================================================
 * CommandData_t Getter 래퍼 (Wrapper)
 * CommandData_t는 protocol_adapter.c 내부 소유, 외부에서 Getter로 접근
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

/*=============================================================================
 * 유틸리티 함수
 *===========================================================================*/
void reverse(char str[], int length);
int  long_to_str(long num, char* str);

#ifdef __cplusplus
}
#endif

#endif /* PROTOCOL_ADAPTER_H */
