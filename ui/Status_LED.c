/*
 * (C) COPYRIGHT 2014 HSC
 *
 * File Name : VCNL3040_PS.c
 * Author    :
 * Version   : V1.0
 * Date      : 06/20/2023
 */

/* Private Include -----------------------------------------------------------*/
/* Includes ------------------------------------------------------------------*/
#include <xc.h>
#include <stdio.h> 
#include <stdint.h>
#include <stdbool.h>

#include <libq.h>      
#include "motor_control_noinline.h"

#include "general.h"   
#include "userparms.h"

#include "control.h"   
#include "estim.h"
#include "fdweak.h"

#include "clock.h"
#include "pwm.h"
#include "adc.h"
#include "port_config.h"
#include "delay.h"
#include "board_service.h"
#include "diagnostics.h"
#include "singleshunt.h"
#include "measure.h"

#include "Status_LED.h"
#include "Communication.h"
/* Private typedef -----------------------------------------------------------*/

/* Private define ------------------------------------------------------------*/


#define dStatusLED_On 	    {LED1 = 1;}
#define dStatusLED_Off      {LED1 = 0;}

#define dStatusLED_Status_Time					25
#define dStatusLED_Step_Time					1000
#define dStatusLED_Error_Communication_Time		50

#define dStatusCount    stStatus.u8Repeat_Count
#define dTimer1ms_LED   stStatus.u16Timer1ms_Status_LED

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
struct_StatusLED stStatus;

uint16_t g_u16Timer1ms_Com;
uint8_t g_u8RX_Error_Flag;

/* Private function prototypes -----------------------------------------------*/
void Status_LED_Control(uint8_t u8Repeat, uint16_t u16Timer_Step, uint16_t u16Timer_Next);
uint8_t Communication_Check(void);
/* Private functions ---------------------------------------------------------*/

//==================================================================================================
//	* Function : Status_LED
//	* 설    명 :
//	* 전달인자 :
//	* Return : 
//==================================================================================================
void Status_LED(void)
{
    static uint8_t u8Com_status;

	if(g_u16Timer1ms_Com > 1000)
	{
		g_u16Timer1ms_Com = 0;

		u8Com_status = Communication_Check();  // 정상
    }


    if(u8Com_status)
        Status_LED_Control(0, dStatusLED_Step_Time, dStatusLED_Step_Time);
	else	
		Status_LED_Control(0, dStatusLED_Error_Communication_Time, dStatusLED_Step_Time);
}

void Status_LED_Control(uint8_t u8Repeat, uint16_t u16Timer_Step, uint16_t u16Timer_Next)
{
	static uint8_t u8Step = 0;

	static uint8_t u8Repeat_Old;
	static uint16_t u16Timer_Step_Old;
	static uint16_t u16Timer_Next_Old;

	if( (u8Repeat_Old != u8Repeat
	  || u16Timer_Step_Old != u16Timer_Step
	  || u16Timer_Next_Old != u16Timer_Next)
	&& u8Step >= 3)
	{
		u8Repeat_Old = u8Repeat;
	  	u16Timer_Step_Old = u16Timer_Step;
	  	u16Timer_Next_Old = u16Timer_Next;

		u8Step = 0;
	}

    switch(u8Step)
    {
    case 0 : 
        dStatusCount = u8Repeat + 1;
        u8Step++;
        break;
    case 1 :
        dStatusLED_On;

        dTimer1ms_LED = 0;
        u8Step++;
        break;
    case 2 : // On Time		
        if(dTimer1ms_LED > u16Timer_Step)
        {
            dStatusLED_Off;

            dTimer1ms_LED = 0;
            u8Step++;			
        }
        break;
    case 3 : // Off Time		
        if(dTimer1ms_LED > u16Timer_Step)
        {
            if(u8Repeat == 0)
                 u8Step = 1;
            else
            {
                dStatusCount++;
                if(dStatusCount >= u8Repeat)
                {
                    dStatusCount = 0;

                    u8Step++;	
                }
                else
                    u8Step = 1;
            }

            dTimer1ms_LED = 0;
        }
        break;
    case 4 :			
        if(dTimer1ms_LED > (u16Timer_Next - u16Timer_Step) )
        {
            u8Step = 1;

            dTimer1ms_LED = 0;
        }
        break;
    default :
    	break;
	}
}



//==================================================================================================
//	* 함 수 명 : MainLoop_Count
//	* 설    명 : 메인루프 횟수 카운트
//	* 전달인자 : 
//	* 반 환 값 : 
//==================================================================================================
// COUNT_LoopTypeDef sLoop_Main;
// void MainLoop_Count(uint8_t Call)
// {
//     sLoop_Main.u16Loop_Count++;

//     if(HAL_GetTick() > sLoop_Main.u16Timer1ms_OldTime + 1000)
//     {
//         sLoop_Main.u16Timer1ms_OldTime = HAL_GetTick();

//         sLoop_Main.u16Loop = sLoop_Main.u16Loop_Count;
//         sLoop_Main.u16Loop_Count = 0;

//         sLoop_Main.u16Timer1us_Loop = (uint16_t)(1000000 / sLoop_Main.u16Loop);
//     }

// }


//==================================================================================================
//	* 함 수 명 : Communication_Check
//	* 설    명 : 통신 검사, 1동안 통신 들어온 갯수 카운트와 비교
//	* 전달인자 : 없음
//	* 반 환 값 : 없음
//==================================================================================================
uint8_t Communication_Check(void)
{
    static uint16_t u16Com_old;
	uint16_t u16Com;

    uint8_t u8result = 0;

    u16Com = Get_Rx_Ccount();

    if (u16Com_old != u16Com)
        u8result = 1;
    else
        u8result = 0;

    u16Com_old = u16Com;

    return u8result;
}

//==================================================================================================
// Interrupt
//==================================================================================================

//==================================================================================================
//	* 함 수 명 : Interrupt_Timer1ms_Status_LED
//	* 설    명 : 타이머 인터럽트에서 호출
//	* 전달인자 : 없음
//	* 반 환 값 : 없음
//==================================================================================================
void Interrupt_Timer1ms_Status_LED(void)
{
	dTimer1ms_LED++;




    g_u16Timer1ms_Com++;


}
