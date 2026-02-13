/*******************************************************************************
 * command_handler.c - 명령 디스패치 구현 (Command)
 *
 * 기능:
 *   - commandTable[] 기반 명령 디스패치 엔진
 *   - Command_MotorControl: 모터 제어 명령 핸들러
 *   - RX 이벤트 콜백 등록/실행
 *   - RegisterTarget: 대상 데이터 포인터 등록 (의존성 주입)
 *
 * 적용 패턴:
 *   09: Command  - 디스패치 테이블로 명령 ID → 핸들러 매핑
 *   04: Callback - rxCallbacks[] 배열로 RX 이벤트 다중 구독
 *   DI: 의존성 주입 - RegisterTarget으로 대상 포인터 등록
 *
 * 호출 관계:
 *   pmsm.c → CommandHandler_RegisterTarget(&MotorData_cmd)  (초기화 시 1회)
 *   Communication.c → CommandHandler_Dispatch() → Command_MotorControl()
 *   Communication.c → CommandHandler_NotifyRx() → rxCallbacks[]
 *   pmsm.c → CommandHandler_RegisterRxCallback()
 *
 * 의존:
 *   - protocol.h: Protocol_GetMotorOn/Speed 등 Getter
 *   - Communication.h: MotorData_t
 *   - command_handler.h: CommandEntry_t, CommEvent_cb
 ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <stddef.h>
#include "command_handler.h"
#include "protocol.h"

/*=============================================================================
 * Command - 모터 제어 명령 핸들러 (내부 함수)
 * Protocol Getter로 CommandData_t에서 값 읽어 MotorData_t로 변환
 *===========================================================================*/
static void Command_MotorControl(MotorData_t* motorData);

/*=============================================================================
 * Command - 명령 디스패치 테이블
 * commandId: 프로토콜 명령 바이트 (rxBuffer[1..2] → "05" = 0x05)
 *===========================================================================*/
#define COMMAND_TABLE_SIZE 1

static const CommandEntry_t commandTable[COMMAND_TABLE_SIZE] = {
    { 0x05, Command_MotorControl },     /* 모터 제어 명령 */
};

/*=============================================================================
 * Callback - RX 이벤트 콜백 배열
 *===========================================================================*/
static CommEvent_cb rxCallbacks[COMM_MAX_CALLBACKS] = { NULL, NULL, NULL };

/*=============================================================================
 * DI - 대상 데이터 포인터 (의존성 주입)
 * Application(pmsm.c)에서 RegisterTarget()으로 등록
 *===========================================================================*/
static MotorData_t* g_pMotorTarget = NULL;  /* pMotor = pointer to Motor */

/*=============================================================================
 * CommandHandler_Init - 초기화 (향후 확장용)
 *===========================================================================*/
void CommandHandler_Init(void)
{
    uint8_t i;
    for (i = 0; i < COMM_MAX_CALLBACKS; i++)
    {
        rxCallbacks[i] = NULL;
    }
    g_pMotorTarget = NULL;
}

/*=============================================================================
 * DI - 대상 데이터 포인터 등록 (의존성 주입)
 * Application(pmsm.c)에서 초기화 시 1회 호출
 * led_blinker의 SetHwOps() 패턴과 동일
 *===========================================================================*/
void CommandHandler_RegisterTarget(MotorData_t* target)
{
    g_pMotorTarget = target;
}

/*=============================================================================
 * Command - 명령 디스패치
 * commandId로 핸들러를 검색하여 실행
 * 등록된 g_pMotorTarget을 핸들러에 전달
 *===========================================================================*/
void CommandHandler_Dispatch(uint8_t cmdId)
{
    uint8_t i;

    if (g_pMotorTarget == NULL) return;  /* 대상 미등록 시 무시 */

    for (i = 0; i < COMMAND_TABLE_SIZE; i++)
    {
        if (commandTable[i].commandId == cmdId)
        {
            if (commandTable[i].handler != NULL)
            {
                commandTable[i].handler(g_pMotorTarget);
            }
            return;
        }
    }
    /* 미등록 명령: 무시 */
}

/*=============================================================================
 * Callback - RX 이벤트 콜백 등록
 *===========================================================================*/
void CommandHandler_RegisterRxCallback(CommEvent_cb cb)
{
    uint8_t i;
    for (i = 0; i < COMM_MAX_CALLBACKS; i++)
    {
        if (rxCallbacks[i] == NULL)
        {
            rxCallbacks[i] = cb;
            return;
        }
    }
}

/*=============================================================================
 * Callback - RX 콜백 실행
 *===========================================================================*/
void CommandHandler_NotifyRx(void)
{
    uint8_t i;
    for (i = 0; i < COMM_MAX_CALLBACKS; i++)
    {
        if (rxCallbacks[i] != NULL)
        {
            rxCallbacks[i]();
        }
    }
}

/*=============================================================================
 * Command - 모터 제어 명령 핸들러
 * Protocol Getter 래퍼로 CommandData_t에서 값 읽어 MotorData_t로 변환
 *===========================================================================*/
static void Command_MotorControl(MotorData_t* motorData)
{
    motorData->motor_on   = Protocol_GetMotorOn();
    motorData->direction  = Protocol_GetDirection();
    motorData->speed      = Protocol_GetSpeed();

    /* 수신된 속도값이 0이면 모터 정지 명령으로 간주 */
    if (Protocol_GetSpeed() == 0)
    {
        motorData->motor_on = 0;
    }
}
