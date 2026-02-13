/*******************************************************************************
 * command_handler.h - 명령 디스패치 (Command)
 *
 * 기능:
 *   - CommandEntry_t: 명령 디스패치 테이블 항목 구조체
 *   - CommEvent_cb: RX 이벤트 콜백 타입
 *   - 명령 디스패치 테이블로 핸들러 자동 호출
 *   - RX 콜백 등록/실행 (Callback)
 *   - RegisterTarget: 대상 데이터 포인터 의존성 주입
 *
 * 적용 패턴:
 *   09: Command  - commandTable[] 디스패치 테이블
 *   04: Callback - RX 이벤트 콜백 등록/실행
 *   DI: 의존성 주입 - RegisterTarget으로 대상 포인터 등록
 ******************************************************************************/
#ifndef COMMAND_HANDLER_H
#define COMMAND_HANDLER_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include "Communication.h"     /* MotorData_t */

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
 * 명령 디스패치 인터페이스
 *===========================================================================*/
void CommandHandler_Init(void);
void CommandHandler_RegisterTarget(MotorData_t* target);  /* DI: 대상 포인터 등록 */
void CommandHandler_Dispatch(uint8_t cmdId);               /* cmd = Command */

/*=============================================================================
 * Callback - RX 이벤트 콜백 등록/실행
 *===========================================================================*/
void CommandHandler_RegisterRxCallback(CommEvent_cb cb);  /* cb = Callback */
void CommandHandler_NotifyRx(void);

#ifdef __cplusplus
}
#endif

#endif /* COMMAND_HANDLER_H */
