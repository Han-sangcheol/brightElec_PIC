/*******************************************************************************
 * led_blinker_drv.c - LED 점멸 드라이버 (프로젝트별 HW 바인딩)
 *
 * 기능:
 *   - LedBlinker_Drv_GetHwOps(): HW ops 포인터 반환
 *     Application(pmsm.c)에서 GetHwOps → SetHwOps 패턴으로 각 모듈에 주입
 *   - HW 핀 매핑: LED1 (RE6) On/Off 함수 (Active-Low: 0=ON, 1=OFF)
 *
 * 계층 구조:
 *   Application(pmsm.c) → Driver(이 파일): GetHwOps()로 HW ops 획득
 *   Application(pmsm.c) → Core(led_blinker/led_morse): SetHwOps()로 주입
 *
 * 프로젝트 이식 시 수정 포인트 (2곳):
 *   1. HW_LED_On() / HW_LED_Off() → 새 MCU의 LED 핀
 *   2. #include "port_config.h" → 새 프로젝트의 핀 헤더
 ******************************************************************************/
#include <xc.h>
#include "port_config.h"
#include "led_blinker_drv.h"

/*=============================================================================
 * HW 핀 매핑 (프로젝트별 수정 포인트)
 * LED1 = LATEbits.LATE6 (port_config.h에서 정의)
 * Active-Low 회로: VCC → R27(560R) → LED → RE6 (핀=0: LED ON, 핀=1: LED OFF)
 *===========================================================================*/
static void HW_LED_On(void)  { LED1 = 0; }  /* Active-Low: 0 = LED ON */
static void HW_LED_Off(void) { LED1 = 1; }  /* Active-Low: 1 = LED OFF */

static const LED_HW_Ops_t ledHwOps = {      /* HwOps = Hardware Operations */
    .On  = HW_LED_On,
    .Off = HW_LED_Off,
};

/*=============================================================================
 * LedBlinker_Drv_GetHwOps - HW ops 포인터 반환
 * Application(pmsm.c)에서 각 LED 모듈에 SetHwOps()로 주입
 *===========================================================================*/
const LED_HW_Ops_t* LedBlinker_Drv_GetHwOps(void)
{
    return &ledHwOps;
}
