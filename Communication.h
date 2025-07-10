/*
 * communication.h
 *
 *  Created on: Apr 27, 2023
 *      Author: ninjax
 */

#ifndef INC_USER_Communication_H_
#define INC_USER_Communication_H_


/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <xc.h>

/* Private define ------------------------------------------------------------*/
#define DIRECTION_FORWARD 0
#define DIRECTION_REVERSE 1

#define MOTOR_STOP 0
#define MOTOR_RUN 1



/* Private typedef -----------------------------------------------------------*/
typedef struct {
    bool motor_on;
    bool motor_on_command;
    bool motor_on_old;
    bool direction;
    int32_t speed;          
    int32_t speed_command;
    int32_t speed_command_old;
    int32_t speed_target;
    uint16_t torque;
} MotorData;
/* Private macro -------------------------------------------------------------*/


/* Private variables ---------------------------------------------------------*/


/* Private function prototypes -----------------------------------------------*/
void communication(MotorData* motorData_cmd, MotorData* motorData_now);

void timer1ms_communication(void);
uint16_t Get_Rx_Ccount(void);


#endif /* INC_USER_Communication_H_ */
