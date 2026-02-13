/*******************************************************************************
 * str_util.h - 문자열 유틸리티 함수
 *
 * 기능:
 *   - reverse(): 문자열 반전
 *   - long_to_str(): long → 문자열 변환
 *
 * 위치: src/util/ (범용 유틸리티)
 ******************************************************************************/
#ifndef STR_UTIL_H
#define STR_UTIL_H

#ifdef __cplusplus
extern "C" {
#endif

/* 문자열 반전 */
void reverse(char str[], int length);

/* long → 문자열 변환, 반환: 문자열 길이 */
int  long_to_str(long num, char* str);

#ifdef __cplusplus
}
#endif

#endif /* STR_UTIL_H */
