/*******************************************************************************
 * led_morse.h - LED 모르스부호 표시 (독립 모듈)
 *
 * 기능:
 *   - 숫자 값을 모르스부호로 LED 표시 (독립 상태머신)
 *   - Pull 모델 - MorseValueProvider 콜백으로 표시할 값 조회
 *   - led_blinker와 독립 동작, 같은 LED HW를 공유
 *
 * 사용 순서:
 *   1. LedMorse_SetHwOps()            ← HW ops 주입 (LedBlinker_Drv_GetHwOps)
 *   2. LedMorse.Init()                ← 내부 상태 초기화
 *   3. LedMorse.RegisterProvider()    ← 값 제공 콜백 등록
 *   4. LedMorse.Update()              ← 메인루프 호출 (true=활성, false=idle)
 *
 * 적용 패턴:
 *   State Machine - Morse 상태별 함수포인터 디스패치
 *   Callback      - MorseValueProvider_t 값 제공자 콜백
 ******************************************************************************/
#ifndef LED_MORSE_H
#define LED_MORSE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include "led_blinker.h"    /* LED_HW_Ops_t 재사용 */

/*=============================================================================
 * Callback - Morse 값 제공자 (Pull 모델)
 * 반환값 >= 0: 원본 RPM 값 (Morse 모듈에서 표시 형식 결정)
 * 반환값 <  0: Morse 모드 비활성 (idle)
 *===========================================================================*/
typedef int32_t (*MorseValueProvider_t)(void);

/*=============================================================================
 * 인터페이스 구조체 - 인스턴스 (LedMorse)
 * Application에서 LedMorse.Init(), LedMorse.Update() 등으로 호출
 *===========================================================================*/
typedef struct {
    void (*Init)(void);                              /* 내부 상태 초기화 */
    bool (*Update)(void);                            /* true=활성(LED 점유), false=idle */
    void (*TimerISR)(void);                          /* 1ms 타이머 카운터 증가 */
    void (*RegisterProvider)(MorseValueProvider_t);  /* 값 제공 콜백 등록 */
} LED_MORSE_INTERFACE;

/*=============================================================================
 * 인스턴스 - Application에서 직접 사용
 *===========================================================================*/
extern const LED_MORSE_INTERFACE LedMorse;

/*=============================================================================
 * HW ops 주입 - pmsm.c에서 LedBlinker_Drv_GetHwOps()로 전달
 *===========================================================================*/
void LedMorse_SetHwOps(const LED_HW_Ops_t* hwOps);

#ifdef __cplusplus
}
#endif

#endif /* LED_MORSE_H */
