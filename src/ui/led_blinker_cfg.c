/*******************************************************************************
 * led_blinker_cfg.c - LED 점멸 설정 (프로젝트별 타이밍 전략)
 *
 * 기능:
 *   - 프로젝트별 점멸 전략 상수 정의
 *   - NORMAL: 1000ms On/Off (정상 동작)
 *   - ERROR:  50ms On/Off (빠른 점멸, 에러 표시)
 *   - FAST:   250ms On/Off (중간 속도 점멸)
 *
 * 프로젝트 이식 시 수정 포인트:
 *   - 각 전략의 onTime/offTime/pauseTime/repeatCount 값 조정
 ******************************************************************************/
#include "led_blinker_cfg.h"

/*=============================================================================
 * Strategy - 프로젝트별 점멸 전략 상수 (타이밍 수정 포인트)
 *===========================================================================*/
const LED_BlinkStrategy_t LED_STRATEGY_NORMAL = {
    .onTime      = 1000,   /* 1000ms On */
    .offTime     = 1000,   /* 1000ms Off */
    .pauseTime   = 1000,   /* 반복 간 대기 */
    .repeatCount = 0,      /* 무한 반복 */
};

const LED_BlinkStrategy_t LED_STRATEGY_ERROR = {
    .onTime      = 50,     /* 50ms On (빠른 점멸) */
    .offTime     = 50,     /* 50ms Off */
    .pauseTime   = 1000,   /* 반복 간 대기 */
    .repeatCount = 0,      /* 무한 반복 */
};

const LED_BlinkStrategy_t LED_STRATEGY_FAST = {
    .onTime      = 250,    /* 250ms On */
    .offTime     = 250,    /* 250ms Off */
    .pauseTime   = 1000,   /* 반복 간 대기 */
    .repeatCount = 0,      /* 무한 반복 */
};
