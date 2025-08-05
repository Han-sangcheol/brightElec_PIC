/*
 * Build_info.c
 * 
 * 기능: MPLAB IDE 컴파일 시 빌드 날짜와 시간 정보를 저장하고 제공하는 구현 파일
 * 
 * 주요 기능:
 * - 컴파일 시점의 날짜와 시간을 정적 변수로 저장
 * - 빌드 정보 구조체 인스턴스 관리
 * - 빌드 정보 접근 함수들 구현
 * - 문자열 조작 및 포맷팅 기능
 * - UART 출력 기능
 * 
 * 동작원리:
 * - __DATE__, __TIME__ 매크로는 컴파일 시점에 실제 날짜/시간 문자열로 치환됨
 * - 정적 구조체를 통해 빌드 정보를 ROM에 저장
 * - 각종 접근 함수를 통해 안전하게 빌드 정보 제공
 * 
 * 사용 예시:
 * 
 * 1. 메인 함수에서 초기화 시 빌드 정보 출력:
 *    #include "Build_info.h"
 *    int main(void) {
 *        // 초기화 코드...
 *        PrintBuildInfo(UART1_SendString);  // UART1으로 빌드 정보 출력
 *        // 나머지 코드...
 *    }
 * 
 * 2. 통신 프로토콜에서 버전 정보 전송:
 *    const BuildInfo_t* build_info = GetBuildInfo();
 *    // build_info->compile_date, build_info->compile_time 사용
 * 
 * 3. 직접 문자열로 빌드 정보 획득:
 *    char buffer[100];
 *    GetBuildInfoString(buffer, sizeof(buffer));
 *    // buffer에 전체 빌드 정보 문자열 저장됨
 */

#include "Build_info.h"

// 버전 정보 (수동으로 관리)
#define SOFTWARE_VERSION    "1.0.0.0"
#define BUILD_NUMBER        1

// 빌드 정보를 저장하는 정적 구조체 (ROM에 저장됨)
static const BuildInfo_t g_buildInfo = {
    .compile_date = BUILD_DATE,         // __DATE__ 매크로 값
    .compile_time = BUILD_TIME,         // __TIME__ 매크로 값  
    .version_string = SOFTWARE_VERSION,
    .build_number = BUILD_NUMBER
};

/**
 * @brief 빌드 정보 구조체 포인터를 반환
 * @return const BuildInfo_t* 빌드 정보 구조체의 포인터
 */
const BuildInfo_t* GetBuildInfo(void)
{
    return &g_buildInfo;
}

/**
 * @brief 빌드 날짜 문자열을 반환
 * @return const char* 빌드 날짜 문자열 포인터 (예: "Jan 15 2024")
 */
const char* GetBuildDate(void)
{
    return g_buildInfo.compile_date;
}

/**
 * @brief 빌드 시간 문자열을 반환  
 * @return const char* 빌드 시간 문자열 포인터 (예: "14:30:25")
 */
const char* GetBuildTime(void)
{
    return g_buildInfo.compile_time;
}

// 간단한 문자열 길이 계산 함수 (임베디드 환경용)
static uint16_t simple_strlen(const char* str)
{
    uint16_t len = 0;
    if (str != 0) {
        while (str[len] != '\0') {
            len++;
        }
    }
    return len;
}

// 간단한 문자열 복사 함수 (임베디드 환경용)
static void simple_strcpy(char* dest, const char* src)
{
    uint16_t i = 0;
    if (dest != 0 && src != 0) {
        while (src[i] != '\0') {
            dest[i] = src[i];
            i++;
        }
        dest[i] = '\0';
    }
}

// 간단한 문자열 연결 함수 (임베디드 환경용)
static void simple_strcat(char* dest, const char* src)
{
    if (dest != 0 && src != 0) {
        uint16_t dest_len = simple_strlen(dest);
        uint16_t i = 0;
        while (src[i] != '\0') {
            dest[dest_len + i] = src[i];
            i++;
        }
        dest[dest_len + i] = '\0';
    }
}

// 숫자를 문자열로 변환하는 간단한 함수 (임베디드 환경용)
static void simple_itoa(uint16_t num, char* str)
{
    uint16_t i = 0;
    uint16_t temp = num;
    
    if (num == 0) {
        str[0] = '0';
        str[1] = '\0';
        return;
    }
    
    // 자릿수 계산
    uint16_t digits = 0;
    while (temp > 0) {
        temp /= 10;
        digits++;
    }
    
    // 문자열 변환 (역순으로)
    str[digits] = '\0';
    for (i = digits - 1; num > 0; i--) {
        str[i] = '0' + (num % 10);
        num /= 10;
    }
}

/**
 * @brief 전체 빌드 정보를 포맷된 문자열로 반환
 * @param buffer 결과를 저장할 버퍼
 * @param buffer_size 버퍼 크기
 * @return uint16_t 복사된 문자열 길이 (null terminator 제외)
 * 
 * 출력 포맷: "SW_VER v1.0.0 Build#1 Compiled: Jan 15 2024 14:30:25"
 */
uint16_t GetBuildInfoString(char* buffer, uint16_t buffer_size)
{
    if (buffer == 0 || buffer_size < 50) { // 최소 버퍼 크기 확인
        return 0;
    }
    
    // 빌드 번호를 문자열로 변환
    char build_num_str[10];
    simple_itoa(g_buildInfo.build_number, build_num_str);
    
    // 전체 문자열 조합
    simple_strcpy(buffer, "SW_VER ");
    simple_strcat(buffer, g_buildInfo.version_string);
    simple_strcat(buffer, " Build#");
    simple_strcat(buffer, build_num_str);
    simple_strcat(buffer, " Compiled: ");
    simple_strcat(buffer, g_buildInfo.compile_date);
    simple_strcat(buffer, " ");
    simple_strcat(buffer, g_buildInfo.compile_time);
    
    return simple_strlen(buffer);
}

/**
 * @brief 빌드 정보를 UART로 출력 (디버깅용)
 * @param uart_send_func UART 전송 함수 포인터
 * @note 시스템 초기화 시 빌드 정보를 출력하여 펌웨어 버전 확인 가능
 */
void PrintBuildInfo(void (*uart_send_func)(const char*))
{
    if (uart_send_func == 0) {
        return;
    }
    
    char build_info_buffer[100];
    
    // 빌드 정보 문자열 생성
    uint16_t len = GetBuildInfoString(build_info_buffer, sizeof(build_info_buffer));
    
    if (len > 0) {
        // UART로 전송
        uart_send_func("\r\n=== BUILD INFORMATION ===\r\n");
        uart_send_func(build_info_buffer);
        uart_send_func("\r\n=========================\r\n");
    }
}
