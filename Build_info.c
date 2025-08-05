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
 * - ISO 8601 형식 날짜/시간 변환 기능 ("YYYY-MM-DD HH:MM")
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
 *    char buffer[50];
 *    GetBuildInfoString(buffer, sizeof(buffer));
 *    // buffer에 "1.0.0.0,2025-08-05 18:19" 형식 문자열 저장됨
 * 
 * 4. ISO 8601 형식 날짜/시간 획득:
 *    char datetime_buffer[20];
 *    uint16_t len = GetFormattedBuildDateTime(datetime_buffer, sizeof(datetime_buffer));
 *    // datetime_buffer에 "2025-08-05 18:19" 형식 문자열 저장됨
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
 * @brief 전체 빌드 정보를 포맷된 문자열로 반환 (ISO 8601 형식 적용)
 * @param buffer 결과를 저장할 버퍼
 * @param buffer_size 버퍼 크기
 * @return uint16_t 복사된 문자열 길이 (null terminator 제외)
 * 
 * 출력 포맷: "1.0.0.0,2025-08-05 18:19"
 */
uint16_t GetBuildInfoString(char* buffer, uint16_t buffer_size)
{
    if (buffer == 0 || buffer_size < 30) { // 최소 버퍼 크기 확인
        return 0;
    }
    
    // ISO 8601 형식 날짜/시간을 위한 임시 버퍼
    char formatted_datetime[20];
    uint16_t datetime_len = GetFormattedBuildDateTime(formatted_datetime, sizeof(formatted_datetime));
    
    if (datetime_len == 0) {
        // ISO 8601 변환 실패 시 기존 방식 사용
        buffer[0] = '\0';
        simple_strcpy(buffer, g_buildInfo.version_string);
        simple_strcat(buffer, g_buildInfo.compile_date);
        simple_strcat(buffer, g_buildInfo.compile_time);
        return simple_strlen(buffer);
    }
    
    // 새로운 형식으로 문자열 조합: "1.0.0.0,2025-08-05 18:19"
    buffer[0] = '\0'; // 초기화
    simple_strcpy(buffer, g_buildInfo.version_string);
    simple_strcat(buffer, ",");
    simple_strcat(buffer, formatted_datetime);
    
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

// 월 이름을 숫자로 변환하는 도우미 함수
static uint16_t month_name_to_number(const char* month_str)
{
    // 3글자 월 이름 배열
    const char* months[] = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    };
    
    uint16_t i;
    for (i = 0; i < 12; i++) {
        // 3글자씩 비교
        if (month_str[0] == months[i][0] && 
            month_str[1] == months[i][1] && 
            month_str[2] == months[i][2]) {
            return i + 1; // 1-12 반환
        }
    }
    return 1; // 기본값 (January)
}

// 2자리 숫자를 문자열로 변환 (앞에 0 패딩)
static void format_two_digits(uint16_t num, char* str)
{
    if (num < 10) {
        str[0] = '0';
        str[1] = '0' + num;
    } else {
        str[0] = '0' + (num / 10);
        str[1] = '0' + (num % 10);
    }
    str[2] = '\0';
}

/**
 * @brief 빌드 날짜와 시간을 ISO 8601 형식으로 변환하여 반환
 * @param buffer 결과를 저장할 버퍼 (최소 17바이트 필요)
 * @param buffer_size 버퍼 크기
 * @return uint16_t 변환된 문자열 길이 (성공 시 16, 실패 시 0)
 * 
 * 입력 형식: BUILD_DATE = "Aug  5 2025", BUILD_TIME = "18:19:22"
 * 출력 형식: "2025-08-05 18:19"
 */
uint16_t GetFormattedBuildDateTime(char* buffer, uint16_t buffer_size)
{
    if (buffer == 0 || buffer_size < 17) { // "YYYY-MM-DD HH:MM" + null = 17 bytes
        return 0;
    }
    
    const char* date_str = g_buildInfo.compile_date;  // 예: "Aug  5 2025"
    const char* time_str = g_buildInfo.compile_time;  // 예: "18:19:22"
    
    if (date_str == 0 || time_str == 0) {
        return 0;
    }
    
    // 날짜 파싱: "Aug  5 2025" 형식
    char month_name[4] = {0};
    uint16_t day = 0;
    uint16_t year = 0;
    
    // 월 이름 추출 (첫 3글자)
    month_name[0] = date_str[0];
    month_name[1] = date_str[1];
    month_name[2] = date_str[2];
    month_name[3] = '\0';
    
    // 일 추출 (4번째부터, 공백 건너뛰기)
    uint16_t i = 3;
    while (date_str[i] == ' ') i++;  // 공백 건너뛰기
    
    // 일 파싱
    while (date_str[i] >= '0' && date_str[i] <= '9') {
        day = day * 10 + (date_str[i] - '0');
        i++;
    }
    
    // 년도 추출 (공백 건너뛰고)
    while (date_str[i] == ' ') i++;
    while (date_str[i] >= '0' && date_str[i] <= '9') {
        year = year * 10 + (date_str[i] - '0');
        i++;
    }
    
    // 시간 파싱: "18:19:22" 형식에서 시와 분만 추출
    uint16_t hour = 0;
    uint16_t minute = 0;
    
    // 시 추출
    i = 0;
    while (time_str[i] >= '0' && time_str[i] <= '9') {
        hour = hour * 10 + (time_str[i] - '0');
        i++;
    }
    
    // ':' 건너뛰기
    if (time_str[i] == ':') i++;
    
    // 분 추출
    while (time_str[i] >= '0' && time_str[i] <= '9') {
        minute = minute * 10 + (time_str[i] - '0');
        i++;
    }
    
    // 월 이름을 숫자로 변환
    uint16_t month = month_name_to_number(month_name);
    
    // 임시 버퍼들
    char year_str[5];
    char month_str[3];
    char day_str[3];
    char hour_str[3];
    char minute_str[3];
    
    // 각 숫자를 문자열로 변환
    simple_itoa(year, year_str);
    format_two_digits(month, month_str);
    format_two_digits(day, day_str);
    format_two_digits(hour, hour_str);
    format_two_digits(minute, minute_str);
    
    // 최종 문자열 조합: "YYYY-MM-DD HH:MM"
    buffer[0] = '\0'; // 초기화
    simple_strcpy(buffer, year_str);
    simple_strcat(buffer, "-");
    simple_strcat(buffer, month_str);
    simple_strcat(buffer, "-");
    simple_strcat(buffer, day_str);
    simple_strcat(buffer, " ");
    simple_strcat(buffer, hour_str);
    simple_strcat(buffer, ":");
    simple_strcat(buffer, minute_str);
    
    return simple_strlen(buffer);
}
