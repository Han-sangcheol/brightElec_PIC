/*******************************************************************************
 * led_blinker_cfg.h - LED 점멸 설정 (프로젝트별 타이밍 전략)
 *
 * 기능:
 *   - 프로젝트별 점멸 전략 상수 extern 선언
 *   - HW와 무관한 순수 SW 타이밍 설정
 *
 * 계층 구조:
 *   Application(pmsm.c) → Config(이 파일) + Core(led_blinker)
 *   Application이 Config의 전략 상수를 선택하여 Core에 전달
 *
 * 프로젝트 이식 시:
 *   이 파일은 수정 불필요 (led_blinker_cfg.c만 수정)
 ******************************************************************************/
#ifndef LED_BLINKER_CFG_H
#define LED_BLINKER_CFG_H

#ifdef __cplusplus
extern "C" {
#endif

#include "led_blinker.h"

/* 프로젝트별 전략 상수 */
extern const LED_BlinkStrategy_t LED_STRATEGY_NORMAL;   /* 1000ms 주기 정상 점멸 */
extern const LED_BlinkStrategy_t LED_STRATEGY_ERROR;    /* 50ms 빠른 점멸 (에러) */
extern const LED_BlinkStrategy_t LED_STRATEGY_FAST;     /* 250ms 중간 점멸 */

#ifdef __cplusplus
}
#endif

#endif /* LED_BLINKER_CFG_H */
