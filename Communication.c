/*
 * (C) COPYRIGHT 2014 HSC
 *
 * File Name : Communication.c
 * Author    :
 * Version   : V1.0
 * Date      : 06/20/2023
 */

/* Private Include -----------------------------------------------------------*/
/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <xc.h>
#include "uart1.h"
#include "uart2.h"
#include <string.h>
#include "Communication.h"
#include "port_config.h"


#include <stdio.h> 
#include <string.h> 
/* Private typedef -----------------------------------------------------------*/

/* Private define ------------------------------------------------------------*/
#define dVersion_FW 1004


#define dSTX 0x40
#define dETX 0x2A

/* Private typedef -----------------------------------------------------------*/
typedef struct {
    uint16_t motor_on : 1;
    uint16_t direction : 1;
    uint16_t led_level_down : 1;
    uint16_t led_level_up : 1;
    uint16_t reserved : 1;
    uint16_t auto_reverse_mode : 1;
    uint16_t auto_reverse_forward : 1;
    uint16_t reserved2 : 2;
    uint16_t ab_side_selection : 1;
    uint16_t led_on_off : 1;
    uint16_t reserved3 : 5;
} CommandKeyBits;

typedef union {
    uint16_t value;
    CommandKeyBits bits;
} CommandKey;

typedef struct {
    // uint8_t command_rx_buffer[20];
    CommandKey key;
    int32_t speed;
    uint16_t torque;

    uint16_t status_data;
    uint16_t present_bldc_rpm;
    uint16_t bldc_torque;
    uint16_t version_fw;
    uint8_t command_tx_buffer[20];

} CommandData;

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

CommandData stCommandData;

uint8_t g_uart2_rx_flag; 
uint8_t command_rx_buffer[20];
uint8_t checksum_buffer[30];

uint8_t g_uart2_tx_flag; 
uint8_t g_checksum_rx;
uint16_t g_checksum;
uint16_t g_timer1ms_comm;

uint16_t g_u16UartRXCounter; // 통신 들어온 갯수 카운트
/* Private function prototypes -----------------------------------------------*/
void data_change_print(MotorData* motorData);
void now_rpm(MotorData* motorData_now, MotorData* motorData_cmd);

void rx_data_process(CommandData* pcommandData);
void tx_data_process(CommandData* pCommandData);
void UARTSend_2(uint8_t* data, uint8_t length);
/* Private functions ---------------------------------------------------------*/


/**
 * @brief 통신 처리 함수
 * @param motorData 모터 데이터 구조체 포인터
 * @return 없음
 */
void communication(MotorData* motorData_cmd, MotorData* motorData_now)
{
    // char message[20]; // message 변수를 함수 내에 선언

	if(g_uart2_rx_flag)
	{
		g_uart2_rx_flag = 0;

        rx_data_process(&stCommandData); // Pass the address of stCommandData

        // motor_on, direction, speed, torque 값을 구조체에 저장
        motorData_cmd->motor_on = stCommandData.key.bits.motor_on;
        motorData_cmd->direction = stCommandData.key.bits.direction;
        motorData_cmd->speed = stCommandData.speed;
        motorData_cmd->torque = stCommandData.torque;

        // 필요한 로직 추가
    }

    // if(g_uart2_tx_flag == 1)
    // {
    //     g_uart2_tx_flag = 0;
    //     // UARTSend_2((uint8_t*)command_rx_buffer, 18);
    //     data_change_print(motorData_cmd);

    //     // UARTSend_2((uint8_t*)&g_checksum_rx, 1); // g_checksum의 주소를 전달
    //     // UARTSend_2((uint8_t*)&g_checksum, 1); // g_checksum의 주소를 전달


    // }
    // else if(g_uart2_tx_flag == 2)
    // {
    //     g_uart2_tx_flag = 0;
    //     // UARTSend_2((uint8_t*)command_rx_buffer, 18);        
    //     // UARTSend_2((uint8_t*)"Checksum error\n", 15);

    //     UARTSend_2((uint8_t*)&g_checksum_rx, 1); // g_checksum의 주소를 전달
    //     UARTSend_2((uint8_t*)&g_checksum, 1); // g_checksum의 주소를 전달

    //     // sprintf(message, "=========\r\n");
    //     // UARTSend_2((uint8_t*)message, 10);

    //     // for(uint8_t i = 0; i < 20; i++)
    //     // {
    //     //     UARTSend_2(&checksum_buffer[i], 1); // checksum_buffer의 주소를 전달
    //     // }
    //     // sprintf(message, "========\r\n");
    //     // UARTSend_2((uint8_t*)message, 10);
    // }
    // else if(g_uart2_tx_flag == 3)
    // {
    //     g_uart2_tx_flag = 0;
    //     UARTSend_2((uint8_t*)"Invalid packet start\n", 21);
    // }
    
    // now_rpm(motorData_now, motorData_cmd);
}

/**
 * @brief 모터 속도 출력
 * @param motorData_now 모터 데이터 구조체 포인터
 * @return 없음
 */
void now_rpm(MotorData* motorData_now, MotorData* motorData_cmd)
{
    char message[20];
    static uint32_t old_speed = 0;

    if(motorData_cmd->speed != old_speed && motorData_cmd->motor_on == 1)
    {
        old_speed = motorData_cmd->speed;
        g_timer1ms_comm = 1000;
    }
    else if(motorData_cmd->motor_on == 0)
    {
        old_speed = 0;
    }

    if(g_timer1ms_comm >= 1000)
    {
        g_timer1ms_comm = 0;
        sprintf(message, "rpm: %ld\r", motorData_now->speed); 
        UARTSend_2((uint8_t*)message, strlen(message)); // 캐스팅 추가    
    }
}

/**
 * @brief 모터 데이터 변경 사항을 UART로 출력
 * @param motorData 모터 데이터 구조체 포인터
 * @return 없음
 */
void data_change_print(MotorData* motorData)
{
    static uint8_t runMotor_old = 0;
    static uint8_t motorDirection_old = 0;
    static uint32_t motorSpeed_old = 3000;
    char message[20]; // message 배열을 char 타입으로 변경

    if(runMotor_old != motorData->motor_on)
    {
        runMotor_old = motorData->motor_on;
        sprintf(message, "run: %d\r\n", motorData->motor_on); // runMotor 변수 수정
        UARTSend_2((uint8_t*)message, strlen(message)); // 캐스팅 추가
    }
    else if(motorDirection_old != motorData->direction)
    {
        motorDirection_old = motorData->direction;
        sprintf(message, "Dir: %d\r\n", motorData->direction);
        UARTSend_2((uint8_t*)message, strlen(message)); // 캐스팅 추가
    }
    else if(motorSpeed_old != motorData->speed)
    {
        motorSpeed_old = motorData->speed;
        sprintf(message, "Spd: %ld\r\n", motorData->speed);
        UARTSend_2((uint8_t*)message, strlen(message)); // 캐스팅 추가


// g_checksum

        // X2C_targetSPD = motorSpeed;
    }
}


/**
 * @brief ASCII 문자를 16진수로 변환
 * @param ascii_char 변환할 ASCII 문자
 * @return 변환된 16진수 값
 */
uint8_t ascii_to_hex(uint8_t ascii_char) // ASCII to hex function
{
	uint8_t temp;

	if (ascii_char < 0x3a)
	{
		temp = ascii_char - 0x30;
		return temp;
	}
	else
	{
		temp = ascii_char - 0x37;
		return temp;
	}
}

/**
 * @brief 수신된 데이터를 처리하여 CommandData 구조체에 저장
 * @param pcommandData 명령 데이터 구조체 포인터
 * @return 없음
 */
void rx_data_process(CommandData* pcommandData)
{
    pcommandData->key.value = (uint16_t)(ascii_to_hex(command_rx_buffer[3])) * 4096 +
						(uint16_t)(ascii_to_hex(command_rx_buffer[4])) * 256 +
						(uint16_t)(ascii_to_hex(command_rx_buffer[5])) * 16 +
						(uint16_t)(ascii_to_hex(command_rx_buffer[6]));

	pcommandData->speed = (int32_t)(ascii_to_hex(command_rx_buffer[7])) * 4096 +
						(int32_t)(ascii_to_hex(command_rx_buffer[8])) * 256 +
						(int32_t)(ascii_to_hex(command_rx_buffer[9])) * 16 +
						(int32_t)(ascii_to_hex(command_rx_buffer[10]));

	pcommandData->torque = ((uint16_t)(ascii_to_hex(command_rx_buffer[11])) * 4096 +
						(uint16_t)(ascii_to_hex(command_rx_buffer[12])) * 256 +
						(uint16_t)(ascii_to_hex(command_rx_buffer[13])) * 16 +
						(uint16_t)(ascii_to_hex(command_rx_buffer[14])));
}

/**
 * @brief CommandData 구조체의 데이터를 전송 버퍼에 저장
 * @param pCommandData 명령 데이터 구조체 포인터
 * @return 없음
 */
void tx_data_process(CommandData* pCommandData)
{
    pCommandData->command_tx_buffer[3] = (pCommandData->status_data >> 8) / 16 + '0';
    pCommandData->command_tx_buffer[4] = (pCommandData->status_data >> 8) % 16 + '0';
    pCommandData->command_tx_buffer[5] = (pCommandData->status_data & 0x00ff) / 16 + '0';
    pCommandData->command_tx_buffer[6] = (pCommandData->status_data & 0x00ff) % 16 + '0';

    pCommandData->command_tx_buffer[7] = (pCommandData->present_bldc_rpm >> 8) / 16 + '0';
    pCommandData->command_tx_buffer[8] = (pCommandData->present_bldc_rpm >> 8) % 16 + '0';
    pCommandData->command_tx_buffer[9] = (pCommandData->present_bldc_rpm & 0x00ff) / 16 + '0';
    pCommandData->command_tx_buffer[10] = (pCommandData->present_bldc_rpm & 0x00ff) % 16 + '0';

    pCommandData->command_tx_buffer[11] = (pCommandData->bldc_torque >> 8) / 16 + '0';
    pCommandData->command_tx_buffer[12] = (pCommandData->bldc_torque >> 8) % 16 + '0';
    pCommandData->command_tx_buffer[13] = (pCommandData->bldc_torque & 0x00ff) / 16 + '0';
    pCommandData->command_tx_buffer[14] = (pCommandData->bldc_torque & 0x00ff) % 16 + '0';

    pCommandData->command_tx_buffer[15] = '[';
    pCommandData->command_tx_buffer[16] = (pCommandData->version_fw / 100) + '0';
    pCommandData->command_tx_buffer[17] = ((pCommandData->version_fw % 100) / 10) + '0';
    pCommandData->command_tx_buffer[18] = ((pCommandData->version_fw % 100) % 10) + '0';
    pCommandData->command_tx_buffer[19] = ']';

    UARTSend_2(pCommandData->command_tx_buffer, 20);
}

/**
 * @brief UART1로 데이터를 전송
 * @param data 전송할 데이터 포인터
 * @param length 데이터 길이
 * @return 없음
 */
void UARTSend_1(uint8_t* data, uint8_t length)
{
    for (uint8_t i = 0; i < length; i++)
    {
        while (U1STAHbits.UTXBF); // Wait if the buffer is full
        UART1_InterruptTransmitFlagClear();
        UART1_DataWrite(data[i]);
    }
}

/**
 * @brief UART2로 데이터를 전송
 * @param data 전송할 데이터 포인터
 * @param length 데이터 길이
 * @return 없음
 */
void UARTSend_2(uint8_t* data, uint8_t length)
{
    for (uint8_t i = 0; i < length; i++)
    {
        UART2_Write(data[i]);
    }
}

/**
 * @brief 문자열을 UART2로 전송
 * @param str 전송할 문자열 포인터
 * @return 없음
 */
void UART2_TransmitString(const char* str)
{
    while (*str != '\0')
    {
        UART2_Write((uint8_t)*str);
        str++;
    }
}

/**
 * @brief 데이터의 체크섬을 계산
 * @param data 데이터 포인터
 * @param length 데이터 길이
 * @return 계산된 체크섬 값
 */
uint8_t calculate_checksum(uint8_t* data, uint8_t length)
{
    uint16_t checksum = data[0];
    checksum_buffer[0] = checksum; // 첫 번째 값을 설정

    for (uint8_t i = 1; i < length; i++) {
        checksum ^= data[i];
        checksum_buffer[i] = checksum;
    }
    return (uint8_t)checksum;
}

/**
 * @brief UART2 수신 완료 콜백 함수
 * @return 없음
 */
void UART2_RxCompleteCallback(void)
{
    static uint8_t rxBuffer[256]; // 버퍼 크기 증가
    static uint8_t rxIndex = 0;
    if (U2STAbits.OERR) {
        U2STAbits.OERR = 0; // 오버런 에러 클리어
    }
    // LED1 = !LED1;
    if(rxIndex >= 256) rxIndex = 0; // 버퍼 크기 증가에 따른 조건 변경

    rxBuffer[rxIndex++] = UART2_Drv_Read();  	// read data
    rxBuffer[rxIndex] = 0;					    // clear

    if((rxBuffer[0] & 0xff) != dSTX) {
        rxIndex = 0;
        // g_uart2_tx_flag = 3;
    }


    // #40 30 35 30 38 31 32 30 30 30 30 30 30 30 35 2a 36 31
    // #@  0  5  0  8  1  2  0  0  0  0  0  0  5  *  6  1

    // #40    30 35    30 38 31 33    34 34 39 30    30 30 30 35    2a   31 35
    // #@     0  5     0  8  1  3     4  4  9  0     0  0  0  5     *    1  5

    // #40    30 35    30 38 31 33     39 43 34 30   30 30 30 35 2a 31 45
    // #@     0  5     0  8  1  3      9  C  4  0     0  0  0  5     *    1  5

    if(rxIndex > 3 && (rxBuffer[rxIndex-3] & 0xff) == dETX) // ETX 위치 변경
    {	
        // uint8_t checksum = (ascii_to_hex(rxBuffer[rxIndex-2]) << 4) | ascii_to_hex(rxBuffer[rxIndex-1]); // 체크섬 계산
        // uint8_t calculated_checksum = calculate_checksum(rxBuffer, rxIndex-2); // 체크섬 계산 함수 호출
        // g_checksum_rx = checksum;
        // g_checksum = calculated_checksum;   

        // // if (checksum == calculated_checksum) {
            memcpy(command_rx_buffer, rxBuffer, rxIndex-0); // 필요한 데이터만 복사
            g_uart2_rx_flag = 1; // rx 완료 표시
            g_uart2_tx_flag = 1;
            rxIndex = 0;
        // } else {
        //     g_uart2_tx_flag = 2;
        //     memcpy(command_rx_buffer, rxBuffer, rxIndex-0); 
        //     g_checksum_rx = checksum;
        //     g_checksum = calculated_checksum;
            
        // }
    }

    g_u16UartRXCounter++;
}

/**
 * @brief 1ms 타이머 통신 처리 함수
 * @return 없음
 */
void timer1ms_communication(void)
{
    g_timer1ms_comm++;
}

uint16_t Get_Rx_Ccount(void)
{
	return g_u16UartRXCounter;
}