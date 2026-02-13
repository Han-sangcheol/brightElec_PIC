/*******************************************************************************
 * led_morse.c - LED 모르스부호 표시 (독립 모듈)
 *
 * 기능:
 *   - LedMorse.Init(): 내부 상태 초기화
 *   - LedMorse.Update(): provider 확인 + Morse 상태머신 실행 (bool 반환)
 *   - LedMorse.TimerISR(): 1ms 타이머 카운터 증가
 *   - LedMorse.RegisterProvider(): 값 제공 콜백 등록
 *   - LedMorse_SetHwOps(): HW 함수포인터 주입
 *
 * 내부 헬퍼:
 *   - Morse_LedOn/Off(): HW null 체크 포함 LED 제어
 *   - Morse_DecomposeDigits(): 숫자 → 자릿수 배열 분해 (MSD first)
 *
 * 상태머신:
 *   IDLE → START_GAP → LOAD → ELEMENT_ON → ELEMENT_GAP → ... → CHAR_GAP → WORD_GAP → IDLE
 *
 * 모르스부호 규칙:
 *   dot=1단위(150ms), dash=3단위(450ms)
 *   요소간격=1단위, 글자간격=3단위, 숫자끝간격=7단위
 *
 * 표시값 변환:
 *   provider 반환값 / 1000 (천단위 절삭, 소비자 책임)
 *
 * HW 의존성: 없음 (LED_HW_Ops_t 함수포인터로 추상화)
 ******************************************************************************/
#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include "led_morse.h"

/*=============================================================================
 * Morse 상수
 *===========================================================================*/
#define MORSE_UNIT_MS              150   /* 기본 단위 시간 (ms) */
#define MORSE_ELEMENTS_PER_DIGIT   5     /* 숫자당 모르스 요소 수 (dot/dash) */
#define MORSE_MAX_DIGITS           5     /* 최대 자릿수 */

/*=============================================================================
 * Morse 상태 정의
 *===========================================================================*/
typedef enum {
    MORSE_IDLE,         /* Morse 비활성 */
    MORSE_START_GAP,    /* 시작 전 간격 (LED OFF, blinker에서 인계 시 분리) */
    MORSE_LOAD,         /* 값 로드 + 자릿수 분해 */
    MORSE_ELEMENT_ON,   /* LED ON (dot or dash) */
    MORSE_ELEMENT_GAP,  /* 요소 간 간격 (LED OFF, 1단위) */
    MORSE_CHAR_GAP,     /* 글자 간 간격 (LED OFF, 3단위) */
    MORSE_WORD_GAP,     /* 전체 출력 후 간격 (LED OFF, 7단위) */
} MorseState_e;

/* 숫자 0-9 모르스 패턴 (bit4=첫 요소, 1=dash, 0=dot, 각 5요소) */
static const uint8_t morsePatterns[10] = {
    0x1F,  /* 0: ----- */
    0x0F,  /* 1: .---- */
    0x07,  /* 2: ..--- */
    0x03,  /* 3: ...-- */
    0x01,  /* 4: ....- */
    0x00,  /* 5: ..... */
    0x10,  /* 6: -.... */
    0x18,  /* 7: --... */
    0x1C,  /* 8: ---.. */
    0x1E,  /* 9: ----. */
};

/*=============================================================================
 * 컨텍스트 - Morse 전용 내부 상태
 *===========================================================================*/
typedef struct {
    const LED_HW_Ops_t*    hwOps;            /* HW 추상화 함수포인터 */
    MorseValueProvider_cb   provider;         /* 값 제공 콜백 */
    MorseState_e           state;            /* Morse 상태머신 상태 */
    volatile uint16_t      timer1ms;         /* 타이머 카운터 (1ms 단위) */
    int16_t                displayValue;     /* 현재 표시 중 스냅샷 값 (/1000 후) */
    uint8_t                digits[MORSE_MAX_DIGITS]; /* 자릿수 배열 (MSD first) */
    uint8_t                digitCount;       /* 총 자릿수 */
    uint8_t                digitIdx;         /* 현재 표시 중 자릿수 인덱스 */
    uint8_t                elemIdx;          /* 현재 자릿수 내 요소 인덱스 (0-4) */
} LedMorse_Context_t;

static LedMorse_Context_t mctx = {
    .hwOps        = NULL,
    .provider     = NULL,
    .state        = MORSE_IDLE,
    .timer1ms     = 0,
    .displayValue = 0,
    .digits       = {0},
    .digitCount   = 0,
    .digitIdx     = 0,
    .elemIdx      = 0,
};

/*=============================================================================
 * HW 헬퍼 - LED On/Off (null 체크 포함)
 *===========================================================================*/
static void Morse_LedOn(void)
{
    if (mctx.hwOps != NULL && mctx.hwOps->On != NULL)
    {
        mctx.hwOps->On();
    }
}

static void Morse_LedOff(void)
{
    if (mctx.hwOps != NULL && mctx.hwOps->Off != NULL)
    {
        mctx.hwOps->Off();
    }
}

/*=============================================================================
 * Morse_DecomposeDigits - 숫자를 자릿수 배열로 분해 (MSD first)
 * value: 표시할 숫자 (0 이상)
 * mctx.digits[], mctx.digitCount에 결과 저장
 *===========================================================================*/
static void Morse_DecomposeDigits(int16_t value)
{
    if (value == 0)
    {
        mctx.digits[0] = 0;
        mctx.digitCount = 1;
        return;
    }

    int16_t temp = value;
    uint8_t count = 0;
    uint8_t buf[MORSE_MAX_DIGITS];

    while (temp > 0 && count < MORSE_MAX_DIGITS)
    {
        buf[count++] = (uint8_t)(temp % 10);
        temp /= 10;
    }

    mctx.digitCount = count;
    /* 역순 배치 (MSD first) */
    uint8_t i;
    for (i = 0; i < count; i++)
    {
        mctx.digits[i] = buf[count - 1u - i];
    }
}

/*=============================================================================
 * LedMorse_SetHwOps - HW 함수포인터 주입
 *===========================================================================*/
void LedMorse_SetHwOps(const LED_HW_Ops_t* hwOps)
{
    mctx.hwOps = hwOps;
}

/*=============================================================================
 * LedMorse_Init - 내부 상태 초기화
 *===========================================================================*/
static void LedMorse_Init(void)
{
    mctx.state        = MORSE_IDLE;
    mctx.timer1ms     = 0;
    mctx.displayValue = 0;
    mctx.digitCount   = 0;
    mctx.digitIdx     = 0;
    mctx.elemIdx      = 0;
}

/*=============================================================================
 * LedMorse_Update - Morse 상태머신 실행
 * 반환값: true=Morse 활성(LED 점유), false=idle(LED 미사용)
 *===========================================================================*/
static bool LedMorse_Update(void)
{
    /* provider 미등록 시 항상 idle */
    if (mctx.provider == NULL)
    {
        return false;
    }

    /* idle 상태에서 provider 확인 → Morse 모드 진입 여부 결정 */
    if (mctx.state == MORSE_IDLE)
    {
        int32_t rawVal = mctx.provider();
        if (rawVal >= 0)
        {
            /* Blinker에서 인계: LED OFF + 시작 간격 삽입 (첫 신호 분리) */
            Morse_LedOff();
            mctx.timer1ms = 0;
            mctx.state = MORSE_START_GAP;
            return true;  /* 시작 간격 대기 → 다음 호출에서 처리 */
        }
        else
        {
            return false;
        }
    }

    /* Morse 상태머신 */
    switch (mctx.state)
    {
        case MORSE_START_GAP:
        {
            /* 시작 전 간격 (3단위 OFF) - blinker LED 상태와 첫 Morse 요소 분리 */
            if (mctx.timer1ms >= (3u * MORSE_UNIT_MS))
            {
                mctx.timer1ms = 0;
                mctx.state = MORSE_LOAD;
            }
            break;
        }

        case MORSE_LOAD:
        {
            /* provider 재확인 (모터 정지 시 idle 복귀) */
            int32_t rawVal = mctx.provider();
            if (rawVal < 0)
            {
                mctx.state = MORSE_IDLE;
                Morse_LedOff();
                return false;
            }

            /* 표시 형식 변환: 천단위 절삭 (1000→1, 40000→40, 500→0) */
            mctx.displayValue = (int16_t)(rawVal / 1000);
            Morse_DecomposeDigits(mctx.displayValue);

            mctx.digitIdx = 0;
            mctx.elemIdx = 0;

            /* 첫 요소 LED ON */
            Morse_LedOn();
            mctx.timer1ms = 0;
            mctx.state = MORSE_ELEMENT_ON;
            break;
        }

        case MORSE_ELEMENT_ON:
        {
            /* dot 또는 dash 지속 시간 확인 */
            uint8_t digit = mctx.digits[mctx.digitIdx];
            uint8_t pattern = morsePatterns[digit];
            uint8_t bitPos = (MORSE_ELEMENTS_PER_DIGIT - 1u) - mctx.elemIdx;
            bool isDash = ((pattern >> bitPos) & 0x01u) != 0;
            uint16_t duration = isDash ? (3u * MORSE_UNIT_MS) : MORSE_UNIT_MS;

            if (mctx.timer1ms >= duration)
            {
                /* LED OFF */
                Morse_LedOff();
                mctx.timer1ms = 0;

                mctx.elemIdx++;
                if (mctx.elemIdx >= MORSE_ELEMENTS_PER_DIGIT)
                {
                    /* 현재 글자(숫자) 완료 */
                    mctx.digitIdx++;
                    if (mctx.digitIdx >= mctx.digitCount)
                    {
                        /* 모든 글자 완료 → WORD_GAP */
                        mctx.state = MORSE_WORD_GAP;
                    }
                    else
                    {
                        /* 다음 글자로 → CHAR_GAP */
                        mctx.state = MORSE_CHAR_GAP;
                    }
                }
                else
                {
                    /* 같은 글자 내 다음 요소 → ELEMENT_GAP */
                    mctx.state = MORSE_ELEMENT_GAP;
                }
            }
            break;
        }

        case MORSE_ELEMENT_GAP:
        {
            /* 요소 간 간격 (1단위 = 150ms) */
            if (mctx.timer1ms >= MORSE_UNIT_MS)
            {
                /* 다음 요소 LED ON */
                Morse_LedOn();
                mctx.timer1ms = 0;
                mctx.state = MORSE_ELEMENT_ON;
            }
            break;
        }

        case MORSE_CHAR_GAP:
        {
            /* 글자 간 간격 (3단위 = 450ms) */
            if (mctx.timer1ms >= (3u * MORSE_UNIT_MS))
            {
                /* 다음 글자 첫 요소 LED ON */
                mctx.elemIdx = 0;
                Morse_LedOn();
                mctx.timer1ms = 0;
                mctx.state = MORSE_ELEMENT_ON;
            }
            break;
        }

        case MORSE_WORD_GAP:
        {
            /* 전체 출력 후 간격 (7단위 = 1050ms) → IDLE 복귀 */
            /* IDLE → START_GAP → LOAD 경로로 일관된 시퀀스 시작 보장 */
            if (mctx.timer1ms >= (7u * MORSE_UNIT_MS))
            {
                mctx.timer1ms = 0;
                mctx.state = MORSE_IDLE;  /* IDLE 복귀 → START_GAP 경유 후 재시작 */
            }
            break;
        }

        default:
            mctx.state = MORSE_IDLE;
            return false;
    }

    return true;  /* Morse 활성 중 */
}

/*=============================================================================
 * LedMorse_TimerISR - 1ms 타이머 카운터 증가
 *===========================================================================*/
static void LedMorse_TimerISR(void)
{
    mctx.timer1ms++;
}

/*=============================================================================
 * LedMorse_RegisterProvider - 값 제공 콜백 등록
 *===========================================================================*/
static void LedMorse_RegisterProvider(MorseValueProvider_cb provider)
{
    mctx.provider = provider;
}

/*=============================================================================
 * LedMorse 인스턴스 - Application에서 LedMorse.xxx()로 호출
 *===========================================================================*/
const LED_MorseInterface_t LedMorse = {
    .Init             = LedMorse_Init,
    .Update           = LedMorse_Update,
    .TimerISR         = LedMorse_TimerISR,
    .RegisterProvider = LedMorse_RegisterProvider,
};
