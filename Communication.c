/*
 * (C) COPYRIGHT 2014 HSC
 *
 * File Name : Communication.c
 * Author    :
 * Version   : V1.0
 * Date      : 06/20/2023
 * 
 * 주요 개선사항:
 * - 정지 명령 시에도 실제 RPM이 200 RPM 이하로 떨어질 때까지 RPM 측정 및 출력 지속
 * - 자연스러운 감속 과정 모니터링 가능
 * - 완전 정지 시점 정확한 판단 가능
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
#include <libq.h>
#include <stdio.h>
#include <stdlib.h>

/* Private typedef -----------------------------------------------------------*/

/* Private define ------------------------------------------------------------*/
#define dVersion_FW 100


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
// void data_change_print(MotorData* motorData);
void rx_data_process(CommandData* pcommandData);
void tx_data_process(CommandData* pCommandData);
void UARTSend_2(uint8_t* data, uint8_t length);
static void reverse(char str[], int length);
static int long_to_str(long num, char* str);

/* Private functions ---------------------------------------------------------*/

/**
 * @brief  Reverses a string 'str' of length 'len'.
 * @param  str: The string to be reversed.
 * @param  length: The length of the string.
 * @return None
 */
static void reverse(char str[], int length) {
    int start = 0;
    int end = length - 1;
    while (start < end) {
        char temp = str[start];
        str[start] = str[end];
        str[end] = temp;
        end--;
        start++;
    }
}

/**
 * @brief  Converts a long integer to a null-terminated string.
 * @param  num: The long integer to be converted.
 * @param  str: The buffer to store the resulting string.
 * @return The length of the generated string (excluding null terminator).
 */
static int long_to_str(long num, char* str) {
    int i = 0;
    bool isNegative = false;

    if (num == 0) {
        str[i++] = '0';
        str[i] = '\0';
        return 1;
    }

    if (num < 0) {
        isNegative = true;
        num = -num;
    }

    while (num != 0) {
        int rem = num % 10;
        str[i++] = rem + '0';
        num = num / 10;
    }

    if (isNegative) {
        str[i++] = '-';
    }

    reverse(str, i);
    str[i] = '\0';

    return i;
}

/**
 * @brief 통신 처리 함수
 * @param motorData_cmd 모터 데이터 구조체 포인터
 * @param motorData_now 모터 데이터 구조체 포인터
 * @return 없음
 */
void communication(MotorData* motorData_cmd, MotorData* motorData_now)
{
	if(g_uart2_rx_flag)
	{
		g_uart2_rx_flag = 0;

        rx_data_process(&stCommandData);

        motorData_cmd->motor_on = stCommandData.key.bits.motor_on;
        motorData_cmd->direction = stCommandData.key.bits.direction;
        motorData_cmd->speed = stCommandData.speed;
        
        // 수신된 속도값이 0이면 모터 정지 명령으로 간주
        if (stCommandData.speed == 0)
        {
            motorData_cmd->motor_on = 0;
        }
    }
    
    // 주기적인 로그 전송 로직 제거
    // now_rpm(motorData_now, motorData_cmd);
    LogMotorStatus(motorData_now, motorData_cmd);
}

/**
 * @brief 모터 속도 및 디버그 정보 출력 (이벤트 기반)
 * @param now_data: 현재 모터 데이터
 * @param cmd_data: 명령 데이터
 * @return 없음
 */
void LogMotorStatus(MotorData* now_data, MotorData* cmd_data)
{
    char message[90]; // 버퍼 크기 확장
    char* ptr = message;
    int len;
    static bool was_running = false;
    bool is_running = cmd_data->motor_on || (now_data->speed != 0);


    // 로그 전송 주기를 100ms로 변경하여 부하 감소
    if (g_timer1ms_comm >= 100) 
    {
        g_timer1ms_comm = 0;
        
        // 모터가 돌고 있거나, 방금 멈췄을 경우에만 로그 전송
        if (is_running || was_running)
        {
            // 표시용 속도 값만 보정 계수(20412)를 적용하여 스케일링
            int32_t display_speed = ((int32_t)now_data->speed * 20412) >> 15;

            // 수신된 원본 목표 속도를 맨 앞에 추가
            len = long_to_str((long)cmd_data->speed, ptr); ptr += len;
            *ptr++ = ',';


            // 라벨을 제거하고 쉼표로 구분된 데이터만 전송하여 메시지 크기 최소화
            len = long_to_str((long)cmd_data->speed_target, ptr); ptr += len;
            *ptr++ = ',';
            len = long_to_str((long)display_speed, ptr); ptr += len;
            *ptr++ = ',';
            // len = long_to_str((long)now_data->iq_measure, ptr); ptr += len;
            // *ptr++ = ',';
            // len = long_to_str((long)now_data->vq_ref, ptr); ptr += len;
            // *ptr++ = ',';
            // len = long_to_str((long)now_data->angle, ptr); ptr += len;
            // *ptr++ = ',';
            // len = long_to_str((long)now_data->hall_state, ptr); ptr += len;
            // *ptr++ = ',';
            // *ptr++ = now_data->loop_status;

            // "\r\n"
            *ptr++ = '\r'; *ptr++ = '\n';
            *ptr = '\0'; // Null-terminate
                
            UARTSend_2((uint8_t*)message, ptr - message);
        }
    }
    was_running = is_running;
}

/**
 * @brief 모터 데이터 변경 사항을 UART로 출력
 * @param motorData 모터 데이터 구조체 포인터
 * @return 없음
 */
// void data_change_print(MotorData* motorData)
// {
//     char message[50];
    
//     sprintf(message, "on:%d,dir:%d,speed:%u\r\n", // torque removed for now
//             motorData->motor_on,
//             motorData->direction,
//             motorData->speed);

//     UARTSend_2((uint8_t*)message, strlen(message));
// }


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