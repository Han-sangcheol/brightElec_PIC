/*******************************************************************************
 * str_util.c - 문자열 유틸리티 함수
 *
 * 기능:
 *   - reverse(): 문자열 반전
 *   - long_to_str(): long → 문자열 변환
 *
 * 위치: src/util/ (범용 유틸리티)
 * 원본: protocol.c에서 분리
 ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>
#include "str_util.h"

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
