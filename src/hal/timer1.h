/*******************************************************************************
 * timer1.h - Timer1 드라이버 (콜백 등록 + 상태머신)
 *
 * 기능:
 *   - Timer1 50us 주기 초기화
 *   - 콜백 자동 등록/해제 (슬롯 자동 할당, 중복 방지)
 *   - 상태머신으로 초기화/등록/실행/에러 상태 관리
 *   - ISR에서 등록된 콜백을 주기적으로 호출
 *
 * 상태 전이:
 *   UNINIT ──Init()──→ READY ──RegisterTask()──→ READY
 *                         │                        │
 *                         └──등록실패──→ ERROR     └──등록실패──→ ERROR
 *                                        │
 *                                        └──GetState()로 조회
 *
 * 사용 예:
 *   Timer1_Init();
 *   Timer1_RegisterTask(callback, 1);
 *   if (Timer1_GetState() == TIMER1_ERROR) { 에러 처리 }
 ******************************************************************************/
#ifndef TIMER1_H
#define TIMER1_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/* 콜백 함수 포인터 타입 */
typedef void (*TimerCallback_t)(void);

/* 타이머 태스크 구조체 */
typedef struct {
    TimerCallback_t callback;     /* 콜백 함수 포인터 */
    uint16_t        period;       /* 호출 주기 (50us 단위, 1=50us, 20=1ms) */
    uint16_t        counter;      /* 내부 카운터 */
} TimerTask_t;

/* 상태머신 상태 정의 */
typedef enum {
    TIMER1_UNINIT,      /* 미초기화 - Init() 호출 전 */
    TIMER1_READY,       /* 준비완료 - 등록 가능, ISR 동작 중 */
    TIMER1_ERROR,       /* 에러     - 등록 실패 발생 */
    TIMER1_STATE_COUNT
} Timer1_State_e;

/* 에러 코드 정의 */
typedef enum {
    TIMER1_ERR_NONE,           /* 에러 없음 */
    TIMER1_ERR_NOT_INIT,       /* 초기화 전 등록 시도 */
    TIMER1_ERR_NULL_CALLBACK,  /* NULL 콜백 */
    TIMER1_ERR_ZERO_PERIOD,    /* period=0 */
    TIMER1_ERR_DUPLICATE,      /* 중복 등록 */
    TIMER1_ERR_SLOT_FULL,      /* 슬롯 부족 */
    TIMER1_ERR_INVALID_ID,     /* 잘못된 태스크 ID */
} Timer1_Error_e;

/* 최대 등록 가능 태스크 수 */
#define TIMER1_MAX_TASKS  4

/* 함수 프로토타입 */
void            Timer1_Init(void);
int8_t          Timer1_RegisterTask(TimerCallback_t cb, uint16_t period);  /* cb = Callback */
bool            Timer1_UnregisterTask(int8_t taskId);
Timer1_State_e  Timer1_GetState(void);
Timer1_Error_e  Timer1_GetLastError(void);

#ifdef __cplusplus
}
#endif

#endif /* TIMER1_H */
