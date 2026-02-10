/*******************************************************************************
 * led_blinker_drv.c - LED 점멸 드라이버 (프로젝트별 HW 바인딩)
 *
 * 기능:
 *   - LedBlinker_Drv_Init(): HW ops를 Core에 주입
 *   - HW 핀 매핑: LED1 (RE6) On/Off 함수
 *
 * 계층 구조:
 *   Application(pmsm.c) → Driver(이 파일) → Core(led_blinker)
 *   이 파일은 Core의 SetHwOps를 호출하여 HW 핀 바인딩 주입
 *
 * 프로젝트 이식 시 수정 포인트 (2곳):
 *   1. HW_LED_On() / HW_LED_Off() → 새 MCU의 LED 핀
 *   2. #include "port_config.h" → 새 프로젝트의 핀 헤더
 ******************************************************************************/
#include <xc.h>
#include "port_config.h"
#include "led_blinker.h"
#include "led_blinker_drv.h"

/*=============================================================================
 * HW 핀 매핑 (프로젝트별 수정 포인트)
 * LED1 = LATEbits.LATE6 (port_config.h에서 정의)
 *===========================================================================*/
static void HW_LED_On(void)  { LED1 = 1; }  /* HW = Hardware */
static void HW_LED_Off(void) { LED1 = 0; }

static const LED_HW_Ops_t ledHwOps = {      /* HwOps = Hardware Operations */
    .On  = HW_LED_On,
    .Off = HW_LED_Off,
};

/*=============================================================================
 * LedBlinker_Drv_Init - HW ops를 Core에 주입
 * pmsm.c에서 LedBlinker.Init() 호출 전에 실행해야 함
 *===========================================================================*/
void LedBlinker_Drv_Init(void)
{
    LedBlinker_SetHwOps(&ledHwOps);
}
