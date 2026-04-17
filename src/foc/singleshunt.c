
/*******************************************************************************
 * Copyright (c) 2017 released Microchip Technology Inc.  All rights reserved.
 *
 * SOFTWARE LICENSE AGREEMENT:
 *
 * Microchip Technology Incorporated ("Microchip") retains all ownership and
 * intellectual property rights in the code accompanying this message and in all
 * derivatives hereto.  You may use this code, and any derivatives created by
 * any person or entity by or on your behalf, exclusively with Microchip's
 * proprietary products.  Your acceptance and/or use of this code constitutes
 * agreement to the terms and conditions of this notice.
 *
 * CODE ACCOMPANYING THIS MESSAGE IS SUPPLIED BY MICROCHIP "AS IS".  NO
 * WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED
 * TO, IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE APPLY TO THIS CODE, ITS INTERACTION WITH MICROCHIP'S
 * PRODUCTS, COMBINATION WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION.
 *
 * YOU ACKNOWLEDGE AND AGREE THAT, IN NO EVENT, SHALL MICROCHIP BE LIABLE,
 * WHETHER IN CONTRACT, WARRANTY, TORT (INCLUDING NEGLIGENCE OR BREACH OF
 * STATUTORY DUTY),STRICT LIABILITY, INDEMNITY, CONTRIBUTION, OR OTHERWISE,
 * FOR ANY INDIRECT, SPECIAL,PUNITIVE, EXEMPLARY, INCIDENTAL OR CONSEQUENTIAL
 * LOSS, DAMAGE, FOR COST OR EXPENSE OF ANY KIND WHATSOEVER RELATED TO THE CODE,
 * HOWSOEVER CAUSED, EVEN IF MICROCHIP HAS BEEN ADVISED OF THE POSSIBILITY OR
 * THE DAMAGES ARE FORESEEABLE.  TO THE FULLEST EXTENT ALLOWABLE BY LAW,
 * MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN ANY WAY RELATED TO THIS CODE,
 * SHALL NOT EXCEED THE PRICE YOU PAID DIRECTLY TO MICROCHIP SPECIFICALLY TO
 * HAVE THIS CODE DEVELOPED.
 *
 * You agree that you are solely responsible for testing the code and
 * determining its suitability.  Microchip has no obligation to modify, test,
 * certify, or support the code.
 *
 *******************************************************************************/
#include <libq.h>
#include "userparms.h"
#include "singleshunt.h"


SINGLE_SHUNT_PARM_T singleShuntParam;
inline static void SingleShunt_CalculateSwitchingTime(SINGLE_SHUNT_PARM_T *,uint16_t );

// *****************************************************************************

// ============================================================================
// 함수명: SingleShunt_InitializeParameters
// ============================================================================
// 목적:
//   Single Shunt 전류 샘플링 시스템의 초기 매개변수를 설정합니다.
//   이 함수는 모터 제어 시작 전에 한 번 호출되어 PWM 샘플링 타이밍과
//   ADC 트리거 값을 초기화합니다.
//
// 원리:
//   - 모터의 3상 전류를 정확히 측정하기 위해 PWM 기간 중 최적의 시점에서만 샘플링
//   - 불릿 기간(dead time)과 AD 컨버터 변환 시간을 고려한 지연 시간 설정
//   - 각 섹터(360도를 6등분)에서 다른 상의 전류를 측정하여 3상 재구성
//
// 입력 매개변수:
//   pSingleShunt: Single Shunt 구조체 포인터 (초기화될 구조체)
//
// 반환값: 없음 (void)
// ============================================================================
void SingleShunt_InitializeParameters(SINGLE_SHUNT_PARM_T *pSingleShunt)
{    
    // ========== 1단계: PWM 기간 내 최소 측정 윈도우 시간 설정 ==========
    // tcrit = 임계 시간 (최소한 이 시간 이상의 윈도우가 있어야 정확한 전류 측정 가능)
    // SSTCRIT는 userparms.h에 정의된 상수 (보통 수십 마이크로초)
	pSingleShunt->tcrit = SSTCRIT;
    
    // ========== 2단계: ADC 샘플링 지연시간 설정 ==========
    // tDelaySample = PWM 에지에서 실제 ADC 샘플링까지의 지연 시간
    // 원인: 게이트 드라이버 응답 시간, MOSFET 스위칭 시간, 센싱 회로 슬루율
    // 이를 고려하지 않으면 노이즈가 섞인 부정확한 측정
    // SS_SAMPLE_DELAY는 하드웨어 특성에 따라 칼리브레이션된 값
	pSingleShunt->tDelaySample = SS_SAMPLE_DELAY;	
    
    // ========== 3단계: 첫 번째 ADC 트리거 값 초기화 ==========
    // trigger1 = PWM 기간 내에서 첫 번째 전류 샘플링 시점 (클록 카운트)
    // 초기값 0으로 설정 (첫 PWM 기간에서 계산될 때까지 대기)
    pSingleShunt->trigger1 = 0;
    
    // ========== 4단계: 두 번째 ADC 트리거 값 초기화 ==========
    // trigger2 = PWM 기간 내에서 두 번째 전류 샘플링 시점 (클록 카운트)
    // 두 점에서 샘플링하면 3상 전류 모두 재구성 가능
    pSingleShunt->trigger2 = 0;
    
    // ========== 5단계: 첫 번째 버스 전류 샘플값 초기화 ==========
    // Ibus1 = "I bus" = 첫 번째 타이밍에서 Shunt 저항을 통해 ADC로 측정된 버스 전류 (raw 값)
    // 
    // 원리:
    //   ┌─ 상 A (MOSFET 상단)
    //   ├─ 상 B (MOSFET 상단)  ─┐
    //   ├─ 상 C (MOSFET 상단)  ─┼─ 공통 버스 ─ [Shunt 저항(RShunt)] ─ GND
    //   └─────────────────────┘
    //
    // Shunt 저항은 인버터 출력 버스에 연결되어 있으므로,
    // 3상 중 어느 상(들)이 ON인지에 따라 버스를 통해 흐르는 전류가 달라짐
    // 
    // 예시 (Trigger1 시점):
    //   - 상 A, B가 ON (상 C OFF)
    //   - Ibus1 = Ia + Ib (상 C는 OFF이므로 버스를 통해 흐르지 않음)
    //
    // 이 값은 ADC ISR에서 실제 측정값으로 업데이트되고,
    // 나중에 SingleShunt_PhaseCurrentReconstruction()에서 
    // MOSFET 스위칭 상태(섹터)와 조합되어 각 상 전류로 재구성됨
    pSingleShunt->Ibus1 = 0;
    
    // ========== 6단계: 두 번째 버스 전류 샘플값 초기화 ==========
    // Ibus2 = "I bus" = 두 번째 타이밍에서 Shunt 저항을 통해 ADC로 측정된 버스 전류 (raw 값)
    //
    // 예시 (Trigger2 시점):
    //   - 상 B, C가 ON (상 A OFF)
    //   - Ibus2 = Ib + Ic (상 A는 OFF이므로 버스를 통해 흐르지 않음)
    //
    // ★ 핵심: 같은 1개의 Shunt 저항으로 2개의 시점에서 샘플링!
    //   - Ibus1: 상 A, B 포함 (상 C 제외)
    //   - Ibus2: 상 B, C 포함 (상 A 제외)
    //   → 2개 샘플 + 기르호프 법칙(Ia+Ib+Ic=0) = 3상 전류 모두 계산 가능
    //
    // Ibus1과 Ibus2를 조합하면 3상 전류 Ia, Ib, Ic 모두 재구성 가능
    pSingleShunt->Ibus2 = 0;
    
    // ========== 7단계: ADC 샘플 포인트 초기화 ==========
    // adcSamplePoint = 진단/디버깅용 샘플링 포인트 인덱스
    // X2C Scope 같은 진단 도구로 샘플링 타이밍을 확인할 때 사용
    pSingleShunt->adcSamplePoint = 0;
}
// *****************************************************************************

// ============================================================================
// 함수명: SingleShunt_CalculateSpaceVectorPhaseShifted
// ============================================================================
// 
// 🎯 **함수의 목적 (일반인 설명)**
// ─────────────────────────────────────────────────────────────────────────
// 3상 모터를 정확하게 회전시키기 위해, 어느 시점에 어느 상(A, B, C)에
// 전압을 얼마나 오래 인가해야 하는지를 계산합니다.
// 동시에 ADC로 전류를 정확히 측정할 수 있는 타이밍(trigger)도 결정합니다.
//
// 💡 **핵심 개념: SVM(Space Vector Modulation)이란?**
// ─────────────────────────────────────────────────────────────────────────
// 
// 📌 간단한 비유:
// 3상 모터의 전압을 "화살표(벡터)"로 생각해봅시다.
// 
//   상 A              상 C
//      ╲            ╱
//       ╲          ╱
//        ╲        ╱      ← 360도를 3등분
//         ╲      ╱
//          ╱───╲
//         ╱  M  ╲        M = 모터 (회전)
//        ╱───────╲
//       ╱          ╲
//      ╱            ╲
//   상 B
//
// 3상 전압을 적절히 섞으면 원하는 방향과 크기의 "합성 벡터"를 만들 수 있습니다.
// 이 합성 벡터가 시간에 따라 회전하면 → 모터가 매끄럽게 회전합니다.
//
// 📌 360도를 6개 섹터로 나누는 이유:
// ┌──────────────────────────────────────────────────────────────┐
// │                                                              │
// │              회전자 각도 (회전자가 바라보는 방향)            │
// │                                                              │
// │     Sector 1      Sector 2      Sector 3      Sector 4      │
// │    (60-120°)    (0°-60°)      (300-360°)   (180-240°)      │
// │                                                              │
// │  ┌─────────────────────────────────────────┐                │
// │  │    ★ 각 섹터마다 다른 상이 ON/OFF!     │                │
// │  │    ★ 이렇게 하면 부드러운 회전 가능   │                │
// │  └─────────────────────────────────────────┘                │
// │                                                              │
// │     Sector 6      Sector 5      Sector 4                   │
// │    (240-300°)   (120-180°)    (180-240°)                   │
// └──────────────────────────────────────────────────────────────┘
//
// 🔴 **"상 A가 양수"는 무엇인가? (초보자용 설명)**
// ─────────────────────────────────────────────────────────────────────────
//
// 📊 SVM의 입력: abc 구조체의 3개 값
//   - abc.a = 상 A에 인가할 전압 (0.0 ~ 1.0 정규화된 값)
//   - abc.b = 상 B에 인가할 전압
//   - abc.c = 상 C에 인가할 전압
//
// 이 3개 값의 "부호" (양수/음수)를 보면 현재 회전자가 어느 섹터에 있는지 판별 가능!
//
// 📌 **"상 A가 양수"의 물리적 의미:**
//
//   상황 1) 상 A = +0.3 (양수)
//   ─────────────────────────────────────────────────────────────
//   PWM Duty Cycle = 30% ON, 70% OFF
//   ┌─────────────────────────────────────────────────┐
//   │ PWM 파형:                                       │
//   │                                                │
//   │ ┌─────┐         ┌─────┐         ┌─────┐       │
//   │ │ ON  │ OFF OFF │ ON  │ OFF OFF │ ON  │ OFF   │
//   │ │(30%)│ (70%)   │(30%)│ (70%)   │(30%)│ (70%) │
//   │ └─────┘         └─────┘         └─────┘       │
//   │ ├─────────────────┤ ← PWM 주기 100%           │
//   │                                                │
//   │ 의미: MOSFET이 30%는 전도(ON), 70%는 차단(OFF)│
//   │ 결과: 평균 전압 = 최대 전압 × 0.3             │
//   │ 예시: 최대 100V라면 평균 30V가 상 A에 인가    │
//   └─────────────────────────────────────────────────┘
//   → "상 A에 최대의 30%를 인가"라는 의미
//
//   상황 2) 상 A = -0.2 (음수) ← 📌 부호의 의미!
//   ─────────────────────────────────────────────────────────────
//   PWM이 반전됨!
//   ┌─────────────────────────────────────────────────┐
//   │ PWM 파형 (반전됨):                              │
//   │                                                │
//   │  ┬─────────────────────┐  ON: PWM 신호 반전   │
//   │  │                     │                       │
//   │ ─┴────────┬────────────┴─ OFF: GND            │
//   │      20%ON  80%OFF                            │
//   │                                                │
//   │ 의미: MOSFET PWM이 +0.3과 정반대로 작동      │
//   │ 결과: 평균 전압 = 최대 전압 × (-0.2)         │
//   │ 결과: "반대 극성"으로 20%만큼 인가            │
//   │ 예시: 최대 100V라면 -20V (반대 방향)          │
//   └─────────────────────────────────────────────────┘
//   → "상 A에 반대 극성으로 20%를 인가"라는 의미
//
//   📊 **정리: 값의 크기와 부호의 의미**
//   ┌──────────────────────────────────────────────────┐
//   │ abc.a = +0.5                                     │
//   │ ├─ 크기: 0.5 = 50% Duty Cycle                   │
//   │ ├─ 부호: +    = 정상 극성                       │
//   │ └─ 의미: 최대 전압의 50%를 정상 극성으로 인가   │
//   │                                                 │
//   │ abc.a = -0.5                                    │
//   │ ├─ 크기: 0.5 = 50% Duty Cycle                   │
//   │ ├─ 부호: -    = 반전 극성 (180° 위상차)        │
//   │ └─ 의미: 최대 전압의 50%를 반대 극성으로 인가   │
//   │                                                 │
//   │ → 같은 크기이지만 부호로 "방향"을 결정!        │
//   └──────────────────────────────────────────────────┘
//
//   🎯 **3상 모터에서의 의미 (SVM 벡터 공간에서)**
//   ┌──────────────────────────────────────────────────┐
//   │                                                 │
//   │  양수 조합 (A+, B+, C-):                        │
//   │  → 벡터가 특정 방향 (예: 0°-60°)을 가리킴      │
//   │                                                 │
//   │  음수 조합 (A-, B+, C+):                        │
//   │  → 벡터가 반대쪽 방향을 가리킴                  │
//   │  → 모터가 다른 섹터에서 회전                    │
//   │                                                 │
//   │  → 6개 섹터를 모두 커버하기 위해 양수/음수 필요│
//   └──────────────────────────────────────────────────┘
//
// 📌 **"양수/음수 조합"으로 섹터 판별 원리:**
//
//   섹터 1: A(+), B(+), C(-) = (1, 1, 0)
//   ─────────────────────────────────────
//   상 A와 상 B를 강하게 활성화, 상 C는 약함
//   → 이 조합은 회전자가 60°~120° 구간에 있을 때!
//
//   섹터 3: A(+), B(+), C(-) = (0, 1, 1)
//   ─────────────────────────────────────
//   상 B와 상 C를 강하게 활성화, 상 A는 약함
//   → 이 조합은 회전자가 0°~60° 구간에 있을 때!
//
//   이런 식으로 6개 섹터를 모두 커버합니다!
//
// 🔧 **함수의 역할 단계별:**
// ─────────────────────────────────────────────────────────────────────────
// 
// Step 1️⃣: 3상 전압값의 부호 읽기 (abc.a, abc.b, abc.c 부호 확인)
//           ↓
// Step 2️⃣: 회전자가 어느 섹터에 있는지 판별 (6개 중 1개 선택)
//           ↓
// Step 3️⃣: 그 섹터에 맞는 T1, T2 값 저장 (활성벡터 지속시간)
//           ↓
// Step 4️⃣: SingleShunt_CalculateSwitchingTime() 호출
//           → 정확한 PWM duty cycle 계산
//           → ADC 샘플링 조건 체크 및 조정
//           ↓
// Step 5️⃣: ADC 트리거 타이밍 계산 (trigger1, trigger2)
//           → Ibus1, Ibus2를 정확한 시점에 샘플링하도록 설정
//           ↓
// Step 6️⃣: PWM 하드웨어 레지스터에 값 적용
//           → 실제 PWM 신호 생성 시작!
//
// 📈 **실제 동작 예시 (회전자가 섹터 3에 있는 경우):**
// ─────────────────────────────────────────────────────────────────────────
//
// 입력:
//   abc.a = 0.6 (양수)  ← 상 A 활성화
//   abc.b = 0.4 (양수)  ← 상 B 활성화
//   abc.c = -0.1 (음수) ← 상 C 약함
//
// 판정:
//   if (abc.a >= 0 && abc.b >= 0)
//       → Sector 3 확정! (회전자는 0°~60° 사이)
//
// 동작:
//   ┌─────────────────────────────────┐
//   │ PWM 한 주기 (5000 클록)        │
//   ├─────────────────────────────────┤
//   │                                 │
//   │  [영벡터] [활성벡터1] [활성벡터2] │
//   │  Ta1동안  Tb1동안    Tc1동안    │
//   │  상A ON   상B ON     상C ON     │
//   │                                 │
//   │  Trigger1 ← Ibus1 샘플링        │
//   │    (상A, B 동시 ON)            │
//   │                                 │
//   │  Trigger2 ← Ibus2 샘플링        │
//   │    (상B, C 동시 ON)            │
//   │                                 │
//   └─────────────────────────────────┘
//
// 입력 매개변수:
//   abc: 목표 전압 벡터 (α-β 좌표계 → a-b-c로 변환된 값)
//        abc.a, abc.b, abc.c의 부호로 섹터 판별
//   iPwmPeriod: PWM 주기 (클록 사이클, 보통 5000)
//   pSingleShunt: Single Shunt 구조체 (계산 결과 저장)
//
// 반환값: 1 (성공)
//
// ============================================================================
uint16_t SingleShunt_CalculateSpaceVectorPhaseShifted(MC_ABC_T *abc,
                                    uint16_t iPwmPeriod,
                                    SINGLE_SHUNT_PARM_T *pSingleShunt)
{ 
    // ========== 단계 1: DSP 제어 레지스터 관리 ==========
    // DSP (Digital Signal Processor) 칩의 곱셈 방식을 최적화하기 위해
    // CORCON 레지스터를 임시로 변경했다가 함수 끝에 복원
    // DSP 컨트롤 레지스터(CORCON) 현재값 저장 (함수 실행 후 복원용)
    uint16_t mcCorconSave = CORCON;
    // CORCON 설정: 0x00E2 = 고속 곱셈 모드, 반올림 모드, 바이어스 설정
    // 이렇게 하면 Q15 고정소수점 곱셈이 빠르고 정확해짐
    CORCON = 0x00E2;
    
    // ========== 단계 2: PWM duty cycle 포인터 준비 ==========
    // 같은 PWM 주기에 2개의 duty cycle 세트를 사용
    // pdcout1 = 기본 duty cycle (Ta1, Tb1, Tc1)
    // pdcout2 = ADC 샘플링 최적화 duty cycle (Ta2, Tb2, Tc2)
    // 첫 번째 PWM duty cycle 구조체 포인터 (T1, T2 기반 스위칭 시간)
    MC_DUTYCYCLEOUT_T *pdcout1 = &pSingleShunt->pwmDutycycle1;
    // 두 번째 PWM duty cycle 구조체 포인터 (ADC 샘플링 타이밍 최적화용)
    MC_DUTYCYCLEOUT_T *pdcout2 = &pSingleShunt->pwmDutycycle2;   
    
    // ============================================================================
    // 🎯 **핵심 부분: 6개 섹터 판별 및 처리**
    // ============================================================================
    // 
    // 📌 부호 조합 판별 원리:
    // ┌──────────────────────────────────────────────────────────────┐
    // │  섹터별 부호 패턴 (양수=1, 음수=0)                          │
    // ├──────────────────────────────────────────────────────────────┤
    // │  if (A >= 0) {                                               │
    // │      if (B >= 0) {                                           │
    // │          if (C >= 0) → Sector 7 (금지됨)                   │
    // │          else        → Sector 3 (허용)  ← (1, 1, 0)        │
    // │      } else {                                                │
    // │          if (C >= 0) → Sector 5  ← (1, 0, 1)               │
    // │          else        → Sector 1  ← (1, 0, 0)               │
    // │      }                                                       │
    // │  } else {                                                    │
    // │      ... (음수 조합들) ...                                   │
    // │  }                                                           │
    // └──────────────────────────────────────────────────────────────┘
    //
    // ✅ 6개 섹터만 사용 (Sector 0, 7 금지)
    //    → 정확한 제어와 전류 측정 가능
    //
    // ===== SVM 섹터 판정: 3상 전압 a, b, c의 부호 조합으로 6개 섹터 결정 =====
    if (abc->a >= 0)  // 상 A가 양수인 경우 ← 회전자가 위쪽 반원에 있는 상태
    {
        // 상 A가 양수 = 상 A에 양의 전압을 인가 = 상 A가 "강하게 활성화"
        // 예: abc.a = +0.5면 상 A에 최대의 50%를 인가
        
        // (xx1)
        if (abc->b >= 0)  // 상 B도 양수인 경우 ← 상 A, B가 모두 활성화
        {
            // (x11) - 섹터 3
            // 이 상황:
            //   ┌─ 상 A: 양수 (활성화)
            //   ├─ 상 B: 양수 (활성화)
            //   └─ 상 C: 음수 (비활성)
            // → SVM 벡터 공간 상에서 0°~60° 구간 (Sector 3)
            // → 상 A와 상 B의 합성 벡터가 지배적
            
            // Sector 3은 SVM 6섹터 중 하나 (Sector 7은 금지됨)
            // Sector 3: (0,1,1)  회전자 각도 0-60도
            pSingleShunt->sectorSVM  = 3;  // 현재 섹터 번호 저장
            // T1 = 첫 번째 활성벡터 지속시간 = abc.a 값
            // abc.a가 크면 (예: 0.8) → 상 A를 오래 활성화
            // abc.a가 작으면 (예: 0.1) → 상 A를 짧게만 활성화
            pSingleShunt->T1 = abc->a;     // 첫 번째 활성 벡터 지속시간 (정규화된 값)
            // T2 = 두 번째 활성벡터 지속시간 = abc.b 값
            pSingleShunt->T2 = abc->b;     // 두 번째 활성 벡터 지속시간 (정규화된 값)
            // T1, T2로부터 실제 PWM duty cycle 계산
            // 이 함수가 다음 단계를 처리:
            // - T1, T2를 PWM 클록 단위로 변환
            // - T7 (영벡터 시간) 계산
            // - Single Shunt 샘플링 조건 체크
            // - 필요시 Ta1, Tb1, Tc1 조정
            SingleShunt_CalculateSwitchingTime(&singleShuntParam,iPwmPeriod);
            // 첫 번째 PWM 세트에 계산된 duty cycle 할당
            pdcout1->dutycycle1 = pSingleShunt->Ta1;
            pdcout1->dutycycle2 = pSingleShunt->Tb1;
            pdcout1->dutycycle3 = pSingleShunt->Tc1;
            // 두 번째 PWM 세트에 계산된 duty cycle 할당 (ADC 트리거 최적화)
            pdcout2->dutycycle1 = pSingleShunt->Ta2;
            pdcout2->dutycycle2 = pSingleShunt->Tb2;
            pdcout2->dutycycle3 = pSingleShunt->Tc2;
        }
        else  // 상 A는 양수, 상 B는 음수 ← 상 A 활성, 상 B 비활성
        {
            // (x01)
            if (abc->c >= 0)  // 상 C가 양수인 경우 ← 상 A, C 활성화
            {
                // Sector 5: (1,0,1)  회전자 각도 120-180도
                // 상황: A(+), B(-), C(+)
                // → 상 A와 상 C가 활성화
                // → SVM 벡터 공간 상에서 120°~180° 구간 (Sector 5)
                pSingleShunt->sectorSVM  = 5;  // 현재 섹터 번호 저장
                pSingleShunt->T1 = abc->c;     // 첫 번째 활성 벡터 지속시간
                pSingleShunt->T2 = abc->a;     // 두 번째 활성 벡터 지속시간
                // T1, T2로부터 실제 PWM duty cycle 계산
                SingleShunt_CalculateSwitchingTime(&singleShuntParam,iPwmPeriod);
                // 첫 번째 PWM 세트 (상 순서: C-A-B)
                pdcout1->dutycycle1 = pSingleShunt->Tc1;
                pdcout1->dutycycle2 = pSingleShunt->Ta1;
                pdcout1->dutycycle3 = pSingleShunt->Tb1;
                // 두 번째 PWM 세트
                pdcout2->dutycycle1 = pSingleShunt->Tc2;
                pdcout2->dutycycle2 = pSingleShunt->Ta2;
                pdcout2->dutycycle3 = pSingleShunt->Tb2;
            }
            else  // 상 A 양수, 상 B 음수, 상 C 음수 ← 상 A만 활성화
            {
                // Sector 1: (0,0,1)  회전자 각도 60-120도
                // 상황: A(+), B(-), C(-)
                // → 상 A만 활성화, 상 B, C 비활성
                // → SVM 벡터 공간 상에서 60°~120° 구간 (Sector 1)
                pSingleShunt->sectorSVM  = 1;  // 현재 섹터 번호 저장
                // 음수 값 사용: SVM 계산상 상 B, C를 다르게 처리하기 위함
                // 부호를 반전시켜 SVM 공식에 맞춤
                pSingleShunt->T1 = -abc->c;    // 첫 번째 활성 벡터 지속시간 (부호 반전)
                pSingleShunt->T2 = -abc->b;    // 두 번째 활성 벡터 지속시간 (부호 반전)
                // T1, T2로부터 실제 PWM duty cycle 계산
                SingleShunt_CalculateSwitchingTime(&singleShuntParam,iPwmPeriod);
                // 첫 번째 PWM 세트 (상 순서: B-A-C)
                pdcout1->dutycycle1 = pSingleShunt->Tb1;
                pdcout1->dutycycle2 = pSingleShunt->Ta1;
                pdcout1->dutycycle3 = pSingleShunt->Tc1;
                // 두 번째 PWM 세트
                pdcout2->dutycycle1 = pSingleShunt->Tb2;
                pdcout2->dutycycle2 = pSingleShunt->Ta2;
                pdcout2->dutycycle3 = pSingleShunt->Tc2;
            }
        }
    }
    else  // 상 A가 음수인 경우 ← 회전자가 아래쪽 반원에 있는 상태
    {
        // (xx0)
        if (abc->b >= 0)  // 상 A 음수, 상 B 양수
        {
            // (x10)
            if (abc->c >= 0)  // 상 C도 양수인 경우
            {
                // Sector 6: (1,1,0)  회전자 각도 240-300도
                pSingleShunt->sectorSVM  = 6;  // 현재 섹터 번호 저장
                pSingleShunt->T1 = abc->b;     // 첫 번째 활성 벡터 지속시간
                pSingleShunt->T2 = abc->c;     // 두 번째 활성 벡터 지속시간
                // T1, T2로부터 실제 PWM duty cycle 계산
                SingleShunt_CalculateSwitchingTime(&singleShuntParam,iPwmPeriod);
                // 첫 번째 PWM 세트 (상 순서: B-C-A)
                pdcout1->dutycycle1 = pSingleShunt->Tb1;
                pdcout1->dutycycle2 = pSingleShunt->Tc1;
                pdcout1->dutycycle3 = pSingleShunt->Ta1;
                // 두 번째 PWM 세트
                pdcout2->dutycycle1 = pSingleShunt->Tb2;
                pdcout2->dutycycle2 = pSingleShunt->Tc2;
                pdcout2->dutycycle3 = pSingleShunt->Ta2;
            }
            else  // 상 A 음수, 상 B 양수, 상 C 음수
            {
                // Sector 2: (0,1,0)  회전자 각도 300-0도 (0도 근처)
                pSingleShunt->sectorSVM  = 2;  // 현재 섹터 번호 저장
                pSingleShunt->T1 = -abc->a;    // 첫 번째 활성 벡터 지속시간 (부호 반전)
                pSingleShunt->T2 = -abc->c;    // 두 번째 활성 벡터 지속시간 (부호 반전)
                // T1, T2로부터 실제 PWM duty cycle 계산
                SingleShunt_CalculateSwitchingTime(&singleShuntParam,iPwmPeriod);
                // 첫 번째 PWM 세트 (상 순서: A-C-B)
                pdcout1->dutycycle1 = pSingleShunt->Ta1;
                pdcout1->dutycycle2 = pSingleShunt->Tc1;
                pdcout1->dutycycle3 = pSingleShunt->Tb1;
                // 두 번째 PWM 세트
                pdcout2->dutycycle1 = pSingleShunt->Ta2;
                pdcout2->dutycycle2 = pSingleShunt->Tc2;
                pdcout2->dutycycle3 = pSingleShunt->Tb2;
            }
        }
        else  // 상 A 음수, 상 B 음수
        {
            // (x00)
            // Sector 4는 유효하고, Sector 0은 금지됨
            // Sector 4: (1,0,0)  회전자 각도 180-240도
            pSingleShunt->sectorSVM  = 4;  // 현재 섹터 번호 저장
            pSingleShunt->T1 = -abc->b;    // 첫 번째 활성 벡터 지속시간 (부호 반전)
            pSingleShunt->T2 = -abc->a;    // 두 번째 활성 벡터 지속시간 (부호 반전)
            // T1, T2로부터 실제 PWM duty cycle 계산
            SingleShunt_CalculateSwitchingTime(&singleShuntParam,iPwmPeriod);
            // 첫 번째 PWM 세트 (상 순서: C-B-A)
            pdcout1->dutycycle1 = pSingleShunt->Tc1;
            pdcout1->dutycycle2 = pSingleShunt->Tb1;
            pdcout1->dutycycle3 = pSingleShunt->Ta1;
            // 두 번째 PWM 세트
            pdcout2->dutycycle1 = pSingleShunt->Tc2;
            pdcout2->dutycycle2 = pSingleShunt->Tb2;
            pdcout2->dutycycle3 = pSingleShunt->Ta2;
        }
    }
    
    /* ===== ADC 트리거 시점 계산 (Single Shunt 전류 샘플링) =====
       두 개의 ADC 트리거를 PWM 중간에 배치하여 정확한 전류 측정 수행
       - tDelaySample: 데드타임과 슬루율 지연 고려 (에러 측정 방지)
       - trigger1, trigger2: PWM 기간 내에서 전류 샘플링 최적 시점 */
	
    // 첫 번째 ADC 트리거: PWM 기간 + 샘플 지연 - Ta1과 Tb1 중간값
    // (Ta1 + Tb1) >> 1: Ta1과 Tb1의 평균 (2로 나눔)
    pSingleShunt->trigger1 = (iPwmPeriod + pSingleShunt->tDelaySample);
    pSingleShunt->trigger1 = pSingleShunt->trigger1 - ((pSingleShunt->Ta1 + pSingleShunt->Tb1) >> 1);
    
    // 두 번째 ADC 트리거: PWM 기간 + 샘플 지연 - Tb1과 Tc1 중간값
    // (Tb1 + Tc1) >> 1: Tb1과 Tc1의 평균 (2로 나눔)
    pSingleShunt->trigger2 = (iPwmPeriod +  pSingleShunt->tDelaySample);
    pSingleShunt->trigger2 = pSingleShunt->trigger2 - ((pSingleShunt->Tb1 + pSingleShunt->Tc1) >> 1);
    
    // 계산된 첫 번째 ADC 트리거 값을 PWM 레지스터에 설정
	INVERTERA_PWM_TRIGB = singleShuntParam.trigger1;
    // 계산된 두 번째 ADC 트리거 값을 PWM 레지스터에 설정
    INVERTERA_PWM_TRIGC = singleShuntParam.trigger2;
    
    // 저장된 CORCON 값 복원 (함수 진입 전 상태로 복구)
    CORCON = mcCorconSave;
    
    // 함수 성공 완료 반환 (1 = 성공)
    return(1);
}
// *****************************************************************************

// ============================================================================
// 함수명: SingleShunt_CalculateSwitchingTime
// ============================================================================
// 목적:
//   SVM(Space Vector Modulation) 계산 결과인 T1, T2 시간으로부터
//   실제 PWM duty cycle을 계산합니다. Single Shunt 전류 샘플링 조건을 
//   만족하도록 PWM 타이밍을 조정합니다.
//
// 원리 (SVM 기본 개념):
//   - 3상 모터 전압을 제어하기 위해 6개의 기본 벡터 상태를 사용
//   - 각 벡터는 특정 시간 동안 적용되어 목표 전압 벡터를 합성
//   - T1, T2 = 두 개의 활성 벡터 지속시간
//   - T7 = 영벡터(모든 상이 오프) 지속시간
//   - Ta1, Tb1, Tc1 = 한 PWM 주기에 각 상이 ON 상태인 시간
//   - Ta2, Tb2, Tc2 = ADC 샘플링 조건을 만족하도록 조정된 타이밍
//
// 입력 매개변수:
//   pSingleShunt: Single Shunt 구조체 포인터 (T1, T2 포함)
//   iPwmPeriod: PWM 주기 (클록 사이클 단위, 보통 5000)
//
// 반환값: 없음 (void)
//         → 대신 pSingleShunt 내의 Ta1, Tb1, Tc1, Ta2, Tb2, Tc2 업데이트
// ============================================================================
inline static void SingleShunt_CalculateSwitchingTime(SINGLE_SHUNT_PARM_T *pSingleShunt,
        uint16_t iPwmPeriod)
{
	
    // ========== 1단계: 정규화된 T1, T2를 PWM 클록 사이클 단위로 변환 ==========
    // T1, T2는 처음에 0~1 범위의 정규화된 값 (Q15 고정소수점)
    // __builtin_mulss = DSP 하드웨어의 고속 곱셈 명령어 사용
    // iPwmPeriod * T1 계산 → >> 15 = Q15 형식을 정수로 변환 (2^15로 나눔)
    // 결과: T1, T2가 실제 PWM 클록 사이클 단위 시간으로 변환
    // 예시: iPwmPeriod=5000, T1(정규화)=0.5 → T1(클록)=2500
    pSingleShunt->T1 = (int16_t) (__builtin_mulss(iPwmPeriod,pSingleShunt->T1) >> 15);
    pSingleShunt->T2 = (int16_t) (__builtin_mulss(iPwmPeriod,pSingleShunt->T2) >> 15);
    
    // ========== 2단계: 영벡터(Zero Vector) 지속시간 계산 ==========
    // SVM 공식: T0 + T1 + T2 + T7 = PWM 주기
    // T0 = T7 (대칭성), 따라서: T7 = (PWM주기 - T1 - T2) / 2
    // >> 1 = 2로 나누는 것과 동일 (빠른 시프트 연산)
    // T7 = 모든 상이 오프되는 시간 (인버터 영벡터 상태)
    pSingleShunt->T7 = (iPwmPeriod-pSingleShunt->T1-pSingleShunt->T2)>>1;

	// ========== 3단계: 상 C의 Duty Cycle 계산 (T1 기반) ==========
    // Single Shunt 샘플링 조건:
    //   - 정확한 전류 측정을 위해 최소 tcrit 시간 동안 안정적이어야 함
    //   - 만약 T1 < tcrit이면 측정 윈도우가 너무 작아 노이즈 증가
    //
    // 경우 1: T1이 충분히 크면 (T1 > tcrit)
    //   → 문제없음, 기본 T7 사용
    //   → Tc1 = Tc2 = T7 (ADC 샘플링 타이밍 최적화 불필요)
    //
    // 경우 2: T1이 작으면 (T1 <= tcrit)
    //   → PWM 기간 내 T1 구간을 강제로 tcrit까지 확대
    //   → 대신 다음 PWM 주기에서 T1 값을 감소시켜 평균 출력 전압 유지
    //   → Tc1: 현재 주기 감소, Tc2: 다음 주기에서 보상
    
    if (pSingleShunt->T1 > pSingleShunt->tcrit)  // T1이 충분한 경우
    {
        // 상 C는 영벡터 기간만 ON (기본 타이밍)
        pSingleShunt->Tc1 = pSingleShunt->T7;  // 첫 번째 PWM 세트: C의 ON 시간
        pSingleShunt->Tc2 = pSingleShunt->T7;  // 두 번째 PWM 세트: C의 ON 시간 (동일)
    }
    else  // T1이 작은 경우 (측정 윈도우 확대 필요)
    {
        // 부족한 시간: tcrit - T1
        // Tc1을 줄여서 상 C의 ON 시간을 크게 → 상 A의 시간 확대
        // → Single Shunt로 상 A 전류 측정 시간 확대
        pSingleShunt->Tc1 = pSingleShunt->T7 - (pSingleShunt->tcrit - pSingleShunt->T1);
        // Tc2를 늘려서 다음 주기에서 보상 → 평균 출력 유지
        pSingleShunt->Tc2 = pSingleShunt->T7 + (pSingleShunt->tcrit - pSingleShunt->T1);
    }
    
    // ========== 4단계: 상 B의 Duty Cycle 계산 ==========
    // T7 + T1 = 영벡터와 첫 활성벡터의 합
    // 이 시간동안 상 B는 ON 상태 유지
    pSingleShunt->Tb1 = pSingleShunt->T7 + pSingleShunt->T1;  // 첫 번째 PWM 세트
    pSingleShunt->Tb2 = pSingleShunt->Tb1;  // 두 번째 PWM 세트 (T1 조정 전이므로 동일)
    
    // ========== 5단계: 상 A의 Duty Cycle 계산 (T2 기반) ==========
    // 상 A는 T7 + T1 + T2 시간 동안 ON (모든 활성벡터 기간)
    // T1과 유사하게, T2가 너무 작으면 측정 윈도우 확대 필요
    
    if (pSingleShunt->T2 > pSingleShunt->tcrit)  // T2가 충분한 경우
    {
        // 기본 계산: T7 + T1 + T2
        pSingleShunt->Ta1 = pSingleShunt->Tb1 + pSingleShunt->T2;  // 첫 번째 세트
        pSingleShunt->Ta2 = pSingleShunt->Tb2 + pSingleShunt->T2;  // 두 번째 세트
    }
    else  // T2가 작은 경우 (측정 윈도우 확대 필요)
    {
        // 현재 주기: T2를 tcrit까지 강제로 확대
        // → 상 B 전류 측정 윈도우 확대
        pSingleShunt->Ta1 = pSingleShunt->Tb1 + pSingleShunt->tcrit;
        
        // 다음 주기: T2 축소로 보상 (평균 출력 유지)
        // Ta2 = Tb2 + (T2*2 - tcrit)
        // = Tb2 + 2*T2 - tcrit (축소된 T2 값)
        pSingleShunt->Ta2 = pSingleShunt->Tb2 + pSingleShunt->T2 + pSingleShunt->T2 - pSingleShunt->tcrit;
    }
	
}    
// *****************************************************************************

// ============================================================================
// 함수명: SingleShunt_PhaseCurrentReconstruction
// ============================================================================
// 목적:
//   Single Shunt 저항을 통해 측정한 버스 전류(Ibus1, Ibus2) 두 샘플로부터
//   3상 모터 전류(Ia, Ib, Ic)를 재구성합니다.
//
// 원리:
//   - Single Shunt: 1개의 저항으로 3상 전류를 모두 측정하는 저가형 구성
//   - 동시에 1상만 측정 가능하므로, 섹터 정보로 어느 상을 측정했는지 판별
//   - 2개의 버스 전류 샘플 Ibus1, Ibus2를 조합하면 3상 전류 복원 가능
//   - 기르호프 전류 법칙: Ia + Ib + Ic = 0 활용
//
// 측정 원리 예시 (섹터 3):
//   - Ibus1 샘플링 시점: 상 A와 상 B가 모두 ON (C는 OFF)
//   - 버스 전류 Ibus1 = Ia + Ib (Ic는 음의 값)
//   - Ibus2 샘플링 시점: 상 B와 상 C가 모두 ON (A는 OFF)
//   - 버스 전류 Ibus2 = Ib + Ic (Ia는 음의 값)
//   - Ia + Ib + Ic = 0이므로 모든 상 전류 계산 가능
//
// 입력 매개변수:
//   pSingleShunt: Single Shunt 구조체 포인터
//     - sectorSVM: 현재 SVM 섹터 (1~6)
//     - Ibus1: 첫 번째 ADC 샘플 값 (버스 전류)
//     - Ibus2: 두 번째 ADC 샘플 값 (버스 전류)
//
// 반환값: 없음 (void)
//         → pSingleShunt 내의 Ia, Ib, Ic 값이 업데이트됨
// ============================================================================
void SingleShunt_PhaseCurrentReconstruction(SINGLE_SHUNT_PARM_T *pSingleShunt)
{
    // ===== SVM 섹터 정보로 어느 상을 측정했는지 판별하여 3상 전류 재구성 =====
    // 6개 섹터는 360도를 60도씩 나눈 것
    // 각 섹터마다 PWM 상태(어느 상이 ON/OFF)가 다르므로,
    // 측정한 버스 전류가 어느 상의 조합인지가 달라짐
    
    switch(pSingleShunt->sectorSVM)  // 현재 섹터 번호 확인
    {
        // ================================================================
        // 섹터 1: (0,0,1) = 상A OFF, 상B OFF, 상C ON
        // 첫 샘플(Ibus1): 상B와 상C가 ON → Ibus1 = Ib + Ic
        // 두 번째 샘플(Ibus2): 상A와 상C가 ON → Ibus2 = Ia + Ic
        // 재구성: Ib = Ibus1, Ic = -Ibus2 (반전), Ia = -(Ib+Ic)
        // ================================================================
        case 1:
            // 상 B 전류 = 첫 번째 버스 샘플
            pSingleShunt->Ib = pSingleShunt->Ibus1;
            // 상 C 전류 = -두 번째 버스 샘플 (음수로 재구성)
            pSingleShunt->Ic = -pSingleShunt->Ibus2;
            // 상 A 전류 = -(Ib + Ic) [기르호프 법칙: Ia+Ib+Ic=0]
            pSingleShunt->Ia = -pSingleShunt->Ic - pSingleShunt->Ib;
        break;
        
        // ================================================================
        // 섹터 2: (0,1,0) = 상A OFF, 상B ON, 상C OFF
        // 첫 샘플(Ibus1): 상A와 상B가 ON → Ibus1 = Ia + Ib
        // 두 번째 샘플(Ibus2): 상A와 상C가 ON → Ibus2 = Ia + Ic
        // ================================================================
        case 2:
            // 상 A 전류 = 첫 번째 버스 샘플
            pSingleShunt->Ia = pSingleShunt->Ibus1;
            // 상 B 전류 = -두 번째 버스 샘플
            pSingleShunt->Ib = -pSingleShunt->Ibus2;
            // 상 C 전류 = -(Ia + Ib)
            pSingleShunt->Ic = -pSingleShunt->Ia - pSingleShunt->Ib;
        break;
        
        // ================================================================
        // 섹터 3: (1,1,0) = 상A ON, 상B ON, 상C OFF
        // 첫 샘플(Ibus1): 상A와 상B가 ON → Ibus1 = Ia + Ib
        // 두 번째 샘플(Ibus2): 상B와 상C가 ON → Ibus2 = Ib + Ic
        // ================================================================
        case 3:
            // 상 A 전류 = 첫 번째 버스 샘플
            pSingleShunt->Ia = pSingleShunt->Ibus1; 
            // 상 C 전류 = -두 번째 버스 샘플
            pSingleShunt->Ic = -pSingleShunt->Ibus2;
            // 상 B 전류 = -(Ia + Ic)
            pSingleShunt->Ib = -pSingleShunt->Ia - pSingleShunt->Ic;
        break;
        
        // ================================================================
        // 섹터 4: (1,0,0) = 상A ON, 상B OFF, 상C OFF
        // 첫 샘플(Ibus1): 상A와 상C가 ON → Ibus1 = Ia + Ic
        // 두 번째 샘플(Ibus2): 상A와 상B가 ON → Ibus2 = Ia + Ib
        // ================================================================
        case 4:
            // 상 C 전류 = 첫 번째 버스 샘플
            pSingleShunt->Ic = pSingleShunt->Ibus1; 
            // 상 A 전류 = -두 번째 버스 샘플
            pSingleShunt->Ia = -pSingleShunt->Ibus2; 
            // 상 B 전류 = -(Ia + Ic)
            pSingleShunt->Ib = -pSingleShunt->Ia - pSingleShunt->Ic;
        break;
        
        // ================================================================
        // 섹터 5: (1,0,1) = 상A ON, 상B OFF, 상C ON
        // 첫 샘플(Ibus1): 상A와 상B가... 아니 상A와 상C가 ON
        // 두 번째 샘플(Ibus2): 상A와 상B가 ON → Ibus2 = Ia + Ib
        // ================================================================
        case 5:
            // 상 B 전류 = 첫 번째 버스 샘플
            pSingleShunt->Ib = pSingleShunt->Ibus1; 
            // 상 A 전류 = -두 번째 버스 샘플
            pSingleShunt->Ia = -pSingleShunt->Ibus2; 
            // 상 C 전류 = -(Ia + Ib)
            pSingleShunt->Ic = -pSingleShunt->Ia - pSingleShunt->Ib;
        break;
        
        // ================================================================
        // 섹터 6: (1,1,0) → 아니 (0,1,1) = 상A OFF, 상B ON, 상C ON
        // 첫 샘플(Ibus1): 상B와 상C가 ON → Ibus1 = Ib + Ic
        // 두 번째 샘플(Ibus2): 상A와 상B가 ON → Ibus2 = Ia + Ib
        // ================================================================
        case 6:
            // 상 C 전류 = 첫 번째 버스 샘플
            pSingleShunt->Ic = pSingleShunt->Ibus1; 
            // 상 B 전류 = -두 번째 버스 샘플
            pSingleShunt->Ib = -pSingleShunt->Ibus2;
            // 상 A 전류 = -(Ic + Ib)
            pSingleShunt->Ia = -pSingleShunt->Ic - pSingleShunt->Ib;
        break;   
    }
    
    // ===== 결과: Ia, Ib, Ic (3상 전류) 계산 완료 =====
    // 이 값들이 FOC 제어 루프로 전달되어 전류 제어 수행
}