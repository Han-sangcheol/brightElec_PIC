/*******************************************************************************
 * command_handler.h - 명령 디스패치 (Command)
 *
 * 기능:
 *   - 명령 디스패치 테이블로 핸들러 자동 호출
 *   - RX 콜백 등록/실행 (Callback)
 *   - 모터 제어 명령 핸들러 (Command_MotorControl)
 *
 * 적용 패턴:
 *   09: Command  - commandTable[] 디스패치 테이블
 *   04: Callback - RX 이벤트 콜백 등록/실행
 ******************************************************************************/
#ifndef COMMAND_HANDLER_H
#define COMMAND_HANDLER_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include "Communication.h"     /* MotorData, CommandEntry_t, CommEventCallback_t */

/*=============================================================================
 * 명령 디스패치 인터페이스
 *===========================================================================*/
void CommandHandler_Init(void);
void CommandHandler_Dispatch(uint8_t cmdId, MotorData* motorData);  /* cmd = Command */

/*=============================================================================
 * Callback - RX 이벤트 콜백 등록/실행
 *===========================================================================*/
void CommandHandler_RegisterRxCallback(CommEventCallback_t cb);  /* cb = Callback */
void CommandHandler_NotifyRx(void);

#ifdef __cplusplus
}
#endif

#endif /* COMMAND_HANDLER_H */
