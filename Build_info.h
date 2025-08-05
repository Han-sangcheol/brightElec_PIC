/*
 * Build_info.h
 * 
 * 기능: MPLAB IDE 컴파일 시 빌드 날짜와 시간 정보를 제공하는 헤더 파일
 * 
 * 주요 기능:
 * - 컴파일 날짜와 시간 문자열 상수 정의
 * - 빌드 정보 구조체 정의
 * - 빌드 정보 접근 함수 선언
 * 
 * 사용법:
 * - GetBuildInfo() 함수를 호출하여 빌드 정보 구조체 포인터 획득
 * - BUILD_DATE, BUILD_TIME 매크로로 직접 접근 가능
 */

#ifndef BUILD_INFO_H
#define BUILD_INFO_H

// dsPIC33 컴파일러용 표준 헤더 포함
#include <stdint.h>
#include <stddef.h>

// 컴파일 시점의 날짜와 시간 매크로 (MPLAB IDE에서 자동 생성)
#define BUILD_DATE  __DATE__    // 예: "Jan 15 2024"
#define BUILD_TIME  __TIME__    // 예: "14:30:25"

// 빌드 정보 구조체
typedef struct {
    const char* compile_date;       // 컴파일 날짜 문자열
    const char* compile_time;       // 컴파일 시간 문자열
    const char* version_string;     // 버전 정보 문자열
    uint16_t    build_number;       // 빌드 번호 (수동 관리)
} BuildInfo_t;

// 함수 선언
/**
 * @brief 빌드 정보 구조체 포인터를 반환
 * @return BuildInfo_t* 빌드 정보 구조체의 포인터
 */
const BuildInfo_t* GetBuildInfo(void);

/**
 * @brief 빌드 날짜 문자열을 반환
 * @return const char* 빌드 날짜 문자열 포인터
 */
const char* GetBuildDate(void);

/**
 * @brief 빌드 시간 문자열을 반환
 * @return const char* 빌드 시간 문자열 포인터
 */
const char* GetBuildTime(void);

/**
 * @brief 전체 빌드 정보를 문자열로 반환
 * @param buffer 결과를 저장할 버퍼
 * @param buffer_size 버퍼 크기
 * @return uint16_t 복사된 문자열 길이
 */
uint16_t GetBuildInfoString(char* buffer, uint16_t buffer_size);

/**
 * @brief 빌드 정보를 UART로 출력 (디버깅용)
 * @param uart_send_func UART 전송 함수 포인터
 * @note 예시 사용법: PrintBuildInfo(UART1_SendString);
 */
void PrintBuildInfo(void (*uart_send_func)(const char*));

#endif // BUILD_INFO_H
