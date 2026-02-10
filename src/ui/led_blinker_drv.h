/*******************************************************************************
 * led_blinker_drv.h - LED 점멸 드라이버 (프로젝트별 HW 바인딩)
 *
 * 기능:
 *   - LedBlinker_Drv_Init(): HW ops를 Core에 주입
 *
 * 계층 구조 (수평 분리):
 *   Application(pmsm.c) → Driver(이 파일) : HW 핀 바인딩
 *   Application(pmsm.c) → Config(led_blinker_cfg) : 타이밍 전략
 *   Application(pmsm.c) → Core(led_blinker) : 점멸 로직
 *
 * 프로젝트 이식 시:
 *   이 파일은 수정 불필요 (led_blinker_drv.c만 수정)
 ******************************************************************************/
#ifndef LED_BLINKER_DRV_H
#define LED_BLINKER_DRV_H

#ifdef __cplusplus
extern "C" {
#endif

#include "led_blinker.h"

/* 드라이버 초기화 - HW ops를 Core에 주입 */
void LedBlinker_Drv_Init(void);

#ifdef __cplusplus
}
#endif

#endif /* LED_BLINKER_DRV_H */
