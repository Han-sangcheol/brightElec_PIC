/*
 * LED_Contorl.h
 *
 *  Created on: Apr 27, 2023
 *      Author: ninjax
 */

#ifndef INC_USER_Status_LED_H_
#define INC_USER_Status_LED_H_



/* Includes ------------------------------------------------------------------*/


/* Private define ------------------------------------------------------------*/


/* Private typedef -----------------------------------------------------------*/

typedef struct StatusLEDTag{
    uint8_t u8Repeat_Count;
    uint16_t u16Timer1ms_Status_LED;

}struct_StatusLED;

typedef struct
{
	uint16_t u16Loop_Count;
    uint32_t u16Timer1ms_OldTime;

    uint16_t u16Loop;
    uint16_t u16Timer1us_Loop;
}COUNT_LoopTypeDef;


/* Private macro -------------------------------------------------------------*/


/* Private variables ---------------------------------------------------------*/


/* Private function prototypes -----------------------------------------------*/
void Status_LED(void);


void MainLoop_Count(uint8_t Call);

void Interrupt_Timer1ms_Status_LED(void);

#endif /* INC_USER_Status_LED_H_ */
