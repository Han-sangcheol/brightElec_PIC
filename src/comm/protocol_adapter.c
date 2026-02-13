/*******************************************************************************
 * protocol_adapter.c - ASCII-hex 프로토콜 어댑터 구현 (Adapter)
 *
 * 기능:
 *   - ASCII-hex ↔ 바이너리 변환 (프로토콜 파싱/포맷팅)
 *   - 패킷 유효성 검증 (STX/ETX/길이)
 *   - 체크섬 계산 (XOR)
 *   - CommandData_t 내부 소유 및 Getter/Setter 래퍼 제공
 *   - 유틸리티: reverse(), long_to_str()
 *
 * 적용 패턴:
 *   02: Adapter   - ProtocolAdapter_t 함수포인터 구조체
 *   01: Wrapper   - CommandData_t Getter/Setter 래퍼
 *   30: Assertion - Protocol_ValidatePacket_Impl()
 *
 * 호출 관계:
 *   Communication.c → Protocol.ParsePacket()   → 이 파일
 *   Communication.c → Protocol.FormatResponse() → 이 파일
 *   command_handler.c → Protocol_GetSpeed() 등  → 이 파일
 ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdint.h>
#include "protocol_adapter.h"

/* 프로토콜 상수 -----------------------------------------------------------*/
#define dVersion_FW     105     /* FW = Firmware */
#define dSTX            0x40    /* STX = Start of Text */
#define dETX            0x2A    /* ETX = End of Text */
#define PACKET_MIN_LEN  4       /* 최소 패킷 길이 (STX + cmd + ETX + checksum) */

/*=============================================================================
 * 내부 명령 키 비트필드 (프로토콜 어댑터 내부 사용)
 *===========================================================================*/
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
} CommandKeyBits_t;

typedef union {
    uint16_t value;
    CommandKeyBits_t bits;
} CommandKey_t;

typedef struct {
    CommandKey_t key;
    int32_t speed;
    uint16_t torque;

    uint16_t status_data;
    uint16_t present_bldc_rpm;
    uint16_t bldc_torque;
    uint16_t version_fw;
    uint8_t command_tx_buffer[20];
} CommandData_t;

/*=============================================================================
 * 정적 변수 - CommandData_t (이 모듈이 소유)
 *===========================================================================*/
static CommandData_t stCommandData;       /* st = Static (prefix) */

/*=============================================================================
 * 내부 함수 프로토타입 (Adapter 구현)
 *===========================================================================*/
static bool    Protocol_ParsePacket_Impl(const uint8_t* raw, uint8_t len);  /* Impl = Implementation, len = Length */
static uint8_t Protocol_FormatResponse_Impl(uint8_t* outBuf);              /* Buf = Buffer */
static uint8_t Protocol_AsciiToHex_Impl(uint8_t ascii);
static uint8_t Protocol_CalcChecksum_Impl(const uint8_t* data, uint8_t len);
static PacketValidation_e Protocol_ValidatePacket_Impl(const uint8_t* data, uint8_t len);

/*=============================================================================
 * Adapter - ProtocolAdapter_t 인스턴스
 * 프로토콜 파싱/포맷팅 함수포인터 구조체
 *===========================================================================*/
const ProtocolAdapter_t Protocol = {
    .ParsePacket     = Protocol_ParsePacket_Impl,
    .FormatResponse  = Protocol_FormatResponse_Impl,
    .AsciiToHex      = Protocol_AsciiToHex_Impl,
    .CalcChecksum    = Protocol_CalcChecksum_Impl,
    .ValidatePacket  = Protocol_ValidatePacket_Impl,
};

/*=============================================================================
 * Assertion - 패킷 유효성 검증
 * STX, ETX, 최소 길이 확인
 *===========================================================================*/
static PacketValidation_e Protocol_ValidatePacket_Impl(const uint8_t* data, uint8_t len)
{
    /* 길이 검증 */
    if (len < PACKET_MIN_LEN)
    {
        return PACKET_ERR_LENGTH;
    }

    /* STX 검증 */
    if (data[0] != dSTX)
    {
        return PACKET_ERR_STX;
    }

    /* ETX 검증 (ETX 위치: data[len-3]) */
    if (data[len - 3] != dETX)
    {
        return PACKET_ERR_ETX;
    }

    return PACKET_OK;
}

/*=============================================================================
 * Adapter - ASCII-hex 문자를 16진수로 변환
 *===========================================================================*/
static uint8_t Protocol_AsciiToHex_Impl(uint8_t ascii_char)
{
    if (ascii_char < 0x3a)
    {
        return ascii_char - 0x30;
    }
    else
    {
        return ascii_char - 0x37;
    }
}

/*=============================================================================
 * Adapter - 수신 패킷 파싱
 * ASCII-hex 데이터를 CommandData_t 구조체로 변환
 *===========================================================================*/
static bool Protocol_ParsePacket_Impl(const uint8_t* raw, uint8_t len)
{
    /* key (4 hex chars at positions 3-6) */
    stCommandData.key.value =
        (uint16_t)(Protocol_AsciiToHex_Impl(raw[3])) * 4096 +
        (uint16_t)(Protocol_AsciiToHex_Impl(raw[4])) * 256 +
        (uint16_t)(Protocol_AsciiToHex_Impl(raw[5])) * 16 +
        (uint16_t)(Protocol_AsciiToHex_Impl(raw[6]));

    /* speed (4 hex chars at positions 7-10) */
    stCommandData.speed =
        (int32_t)(Protocol_AsciiToHex_Impl(raw[7])) * 4096 +
        (int32_t)(Protocol_AsciiToHex_Impl(raw[8])) * 256 +
        (int32_t)(Protocol_AsciiToHex_Impl(raw[9])) * 16 +
        (int32_t)(Protocol_AsciiToHex_Impl(raw[10]));

    /* torque (4 hex chars at positions 11-14) */
    stCommandData.torque =
        (uint16_t)(Protocol_AsciiToHex_Impl(raw[11])) * 4096 +
        (uint16_t)(Protocol_AsciiToHex_Impl(raw[12])) * 256 +
        (uint16_t)(Protocol_AsciiToHex_Impl(raw[13])) * 16 +
        (uint16_t)(Protocol_AsciiToHex_Impl(raw[14]));

    return true;
}

/*=============================================================================
 * Adapter - 응답 데이터 포맷팅
 * CommandData_t → ASCII-hex TX 버퍼 변환
 * 반환: 전송 바이트 수
 *===========================================================================*/
static uint8_t Protocol_FormatResponse_Impl(uint8_t* outBuf)
{
    stCommandData.version_fw = dVersion_FW;

    outBuf[0] = 0x40;
    outBuf[1] = '4';
    outBuf[2] = '0';

    outBuf[3] = (stCommandData.status_data >> 8) / 16 + '0';
    outBuf[4] = (stCommandData.status_data >> 8) % 16 + '0';
    outBuf[5] = (stCommandData.status_data & 0x00ff) / 16 + '0';
    outBuf[6] = (stCommandData.status_data & 0x00ff) % 16 + '0';

    outBuf[7]  = (stCommandData.present_bldc_rpm >> 8) / 16 + '0';
    outBuf[8]  = (stCommandData.present_bldc_rpm >> 8) % 16 + '0';
    outBuf[9]  = (stCommandData.present_bldc_rpm & 0x00ff) / 16 + '0';
    outBuf[10] = (stCommandData.present_bldc_rpm & 0x00ff) % 16 + '0';

    outBuf[11] = (stCommandData.bldc_torque >> 8) / 16 + '0';
    outBuf[12] = (stCommandData.bldc_torque >> 8) % 16 + '0';
    outBuf[13] = (stCommandData.bldc_torque & 0x00ff) / 16 + '0';
    outBuf[14] = (stCommandData.bldc_torque & 0x00ff) % 16 + '0';

    outBuf[15] = '[';
    outBuf[16] = (stCommandData.version_fw / 100) + '0';
    outBuf[17] = ((stCommandData.version_fw % 100) / 10) + '0';
    outBuf[18] = ((stCommandData.version_fw % 100) % 10) + '0';
    outBuf[19] = ']';

    return 20;
}

/*=============================================================================
 * Adapter - 체크섬 계산 (XOR)
 *===========================================================================*/
static uint8_t Protocol_CalcChecksum_Impl(const uint8_t* data, uint8_t len)
{
    uint16_t checksum = data[0];
    uint8_t i;

    for (i = 1; i < len; i++)
    {
        checksum ^= data[i];
    }
    return (uint8_t)checksum;
}

/*=============================================================================
 * Wrapper - CommandData_t Getter 래퍼
 * CommandData_t는 이 모듈 내부 소유, 외부에서 Getter로 접근
 *===========================================================================*/
bool Protocol_GetMotorOn(void)
{
    return (bool)stCommandData.key.bits.motor_on;
}

bool Protocol_GetDirection(void)
{
    return (bool)stCommandData.key.bits.direction;
}

int32_t Protocol_GetSpeed(void)
{
    return stCommandData.speed;
}

uint16_t Protocol_GetTorque(void)
{
    return stCommandData.torque;
}

/*=============================================================================
 * CommandData_t Setter (TX 응답용 - 현재 모터 상태 업데이트)
 *===========================================================================*/
void Protocol_SetStatusData(uint16_t status)
{
    stCommandData.status_data = status;
}

void Protocol_SetPresentRpm(uint16_t rpm)
{
    stCommandData.present_bldc_rpm = rpm;
}

void Protocol_SetBldcTorque(uint16_t torque)
{
    stCommandData.bldc_torque = torque;
}

/*=============================================================================
 * 유틸리티: 문자열 반전
 *===========================================================================*/
void reverse(char str[], int length)
{
    int start = 0;
    int end = length - 1;
    while (start < end)
    {
        char temp = str[start];
        str[start] = str[end];
        str[end] = temp;
        end--;
        start++;
    }
}

/*=============================================================================
 * 유틸리티: long → 문자열 변환
 *===========================================================================*/
int long_to_str(long num, char* str)
{
    int i = 0;
    bool isNegative = false;

    if (num == 0)
    {
        str[i++] = '0';
        str[i] = '\0';
        return 1;
    }

    if (num < 0)
    {
        isNegative = true;
        num = -num;
    }

    while (num != 0)
    {
        int rem = num % 10;
        str[i++] = rem + '0';
        num = num / 10;
    }

    if (isNegative)
    {
        str[i++] = '-';
    }

    reverse(str, i);
    str[i] = '\0';

    return i;
}
