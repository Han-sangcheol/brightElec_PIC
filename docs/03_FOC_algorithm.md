# Chapter 3: FOC 제어 알고리즘 상세

## 목차

1. [FOC 전체 제어 흐름 (20kHz ADC ISR)](#1-foc-전체-제어-흐름-20khz-adc-isr)
2. [Clarke/Park 변환 (어셈블리 최적화)](#2-clarkepark-변환-어셈블리-최적화)
3. [3중 PI 제어기 (Id, Iq, Speed)](#3-3중-pi-제어기-id-iq-speed)
4. [BEMF 기반 속도/각도 추정 알고리즘](#4-bemf-기반-속도각도-추정-알고리즘)
5. [Open Loop → Closed Loop 전환 메커니즘](#5-open-loop--closed-loop-전환-메커니즘)
6. [Single Shunt vs Dual Shunt 구현 차이](#6-single-shunt-vs-dual-shunt-구현-차이)
7. [Field Weakening (구현되었으나 미사용)](#7-field-weakening-구현되었으나-미사용)
8. [제어 파라미터 튜닝 가이드 (userparms.h)](#8-제어-파라미터-튜닝-가이드-userparmsh)

---

## 1. FOC 전체 제어 흐름 (20kHz ADC ISR)

### 1.1 ADC ISR 트리거 구조

FOC 제어 루프는 **20kHz (50µs)** 주기로 실행됩니다. PWM이 Center-Aligned 모드에서 중앙 시점에 ADC를 트리거하고, ADC 변환 완료 시 인터럽트가 발생합니다.

```
PWM 주기 (50µs):
    0µs                    25µs                    50µs
    ├──────────────────────┼──────────────────────┤
    │   상승 엣지           │   하강 엣지           │
    │                      ↑                      │
    │                 ADC 트리거                   │
    │                 (PG1TRIGA)                   │
    │                      │                      │
    │                      └──→ ADC 변환 완료      │
    │                           → _ADCInterrupt()  │
```

**소스 코드**: `src/pmsm.c` 306~376행

```c
void __attribute__((__interrupt__, no_auto_psv)) _ADCInterrupt()
{
    // ... (Single Shunt 분기)
    
    if (uGF.bits.RunMotor)
    {
        if (singleShuntParam.adcSamplePoint == 0)
        {
            // 1) 전류 샘플링
            measureInputs.current.Ia = ADCBUF_INV_A_IPHASE1;
            measureInputs.current.Ib = ADCBUF_INV_A_IPHASE2;
            
            // 2) Clarke/Park 변환
            MC_TransformClarke_Assembly(&iabc, &ialphabeta);
            MC_TransformPark_Assembly(&ialphabeta, &sincosTheta, &idq);
            
            // 3) 속도/각도 추정
            Estim();
            
            // 4) FOC PI 제어
            MotorControl.Execute();   // DoControl()
            
            // 5) Park 각도 계산 (Open/Closed Loop 전환)
            MotorControl.CalcAngle(); // CalculateParkAngle()
            
            // 6) 역 Park/Clarke + SVPWM
            MC_TransformParkInverse_Assembly(&vdq, &sincosTheta, &valphabeta);
            MC_TransformClarkeInverseSwappedInput_Assembly(&valphabeta, &vabc);
            MC_CalculateSpaceVectorPhaseShifted_Assembly(...);
            PWMDutyCycleSet(&pwmDutycycle);
        }
    }
    // ...
}
```

### 1.2 전체 제어 흐름 다이어그램

```mermaid
flowchart TB
    subgraph ADC["ADC ISR (20kHz)"]
        A1[전류 샘플링 Ia, Ib]
        A2[오프셋 보정]
        A3[Clarke 변환]
        A4[Park 변환]
        A5[Estim - BEMF 추정]
        A6[DoControl - PI 제어]
        A7[CalcAngle - 각도 계산]
        A8[역 Park 변환]
        A9[역 Clarke 변환]
        A10[SVPWM]
        A11[PWM 듀티 출력]
    end
    
    A1 --> A2 --> A3 --> A4 --> A5 --> A6 --> A7 --> A8 --> A9 --> A10 --> A11
```

### 1.3 ASCII 아트: 데이터 흐름

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        FOC 제어 루프 (50µs 주기)                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  [ADC] Ia, Ib ──→ [Clarke] ──→ α, β ──→ [Park] ──→ Id, Iq                   │
│       ↑                                    ↑                                 │
│       │                                    │                                 │
│  오프셋 보정                          θ (추정 각도)                          │
│                                                                             │
│  Id, Iq ──→ [PI Id] ──→ Vd                                                  │
│  Id, Iq ──→ [PI Iq] ──→ Vq  ←── [PI Speed] ←── ω_ref (X2C_VelRef)          │
│                                                                             │
│  Vd, Vq ──→ [역 Park] ──→ Vα, Vβ ──→ [역 Clarke] ──→ Va, Vb, Vc             │
│                                                                             │
│  Va, Vb, Vc ──→ [SVPWM] ──→ PWM1, PWM2, PWM4 듀티                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Clarke/Park 변환 (어셈블리 최적화)

### 2.1 Clarke 변환 (ABC → αβ)

3상 고정 좌표계를 2상 고정 좌표계로 변환합니다. 3상 평형 조건 (Ia + Ib + Ic = 0)을 이용하여 Ic를 생략합니다.

**수식**:
```
α = Ia
β = (Ia + 2·Ib) / √3
```

**어셈블리 함수**: `MC_TransformClarke_Assembly()`  
**파일**: `lib/motor_control/mc_clarke_dspic.s`

**호출 위치**: `src/pmsm.c` 396행

```c
MC_TransformClarke_Assembly(&iabc, &ialphabeta);
```

### 2.2 Park 변환 (αβ → dq)

2상 고정 좌표계를 회전자 기준 dq 좌표계로 변환합니다. 회전 좌표계에서는 정상 상태 시 **Id, Iq가 DC 값**이 됩니다.

**수식**:
```
Id =  α·cos(θ) + β·sin(θ)
Iq = -α·sin(θ) + β·cos(θ)
```

**어셈블리 함수**: `MC_TransformPark_Assembly()`  
**파일**: `lib/motor_control/mc_park_dspic.s`

**호출 위치**: `src/pmsm.c` 397행

```c
MC_TransformPark_Assembly(&ialphabeta, &sincosTheta, &idq);
```

### 2.3 역 Park 변환 (dq → αβ)

**수식**:
```
Vα = Vd·cos(θ) - Vq·sin(θ)
Vβ = Vd·sin(θ) + Vq·cos(θ)
```

**어셈블리 함수**: `MC_TransformParkInverse_Assembly()`  
**파일**: `lib/motor_control/mc_invpark_dspic.s`

### 2.4 역 Clarke 변환 (αβ → ABC)

**어셈블리 함수**: `MC_TransformClarkeInverseSwappedInput_Assembly()`  
**파일**: `lib/motor_control/mc_invclarke_dspic.s`

30° 위상 이동이 적용된 변환을 사용합니다.

### 2.5 sin/cos 테이블

**함수**: `MC_CalculateSineCosine_Assembly_Ram()`  
**파일**: `lib/motor_control/mc_sinetable_*.s`

Q15 형식의 sin/cos 값을 룩업 테이블에서 조회합니다.

---

## 3. 3중 PI 제어기 (Id, Iq, Speed)

### 3.1 캐스케이드 구조

```
┌─────────────────────────────────────────────────┐
│           속도 루프 (가장 느림)                    │
│  ω_ref → [PI Speed] → Iq_ref                    │
│          ↑                                       │
│          └─ ω_meas (estimator.qVelEstim)         │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│           전류 루프 (빠름)                        │
│  Id_ref → [PI Id] → Vd                          │
│  Iq_ref → [PI Iq] → Vq                          │
│          ↑                                       │
│          └─ Id_meas, Iq_meas (idq.d, idq.q)     │
└─────────────────────────────────────────────────┘
```

### 3.2 DoControl() 구현

**파일**: `src/motor/motor_control.c` 133~246행

#### Open Loop 모드

```c
if (uGF.bits.OpenLoop)
{
    // D축: VdRef=0 유지
    piInputId.inReference = ctrlParm.qVdRef;  // 0
    MC_ControllerPIUpdate_Assembly(...);
    vdq.d = piOutputId.out;
    
    // Q축: 고정 Iq (Q_CURRENT_REF_OPENLOOP)
    ctrlParm.qVelRef = Q_CURRENT_REF_OPENLOOP;
    piInputIq.inReference = ctrlParm.qVqRef;
    MC_ControllerPIUpdate_Assembly(...);
    vdq.q = piOutputIq.out;
}
```

#### Closed Loop 모드

```c
else
{
    // 속도 루프: ω_ref → Iq_ref
    ctrlParm.targetSpeed = X2C_VelRef;  // Timer2 ISR에서 설정
    ctrlParm.qVelRef = ctrlParm.targetSpeed;
    
    piInputOmega.inMeasure = estimator.qVelEstim + (ctrlParm.qVqRef >> 4);
    piInputOmega.inReference = ctrlParm.qVelRef;
    MC_ControllerPIUpdate_Assembly(piInputOmega.inReference,
                                   piInputOmega.inMeasure,
                                   &piInputOmega.piState,
                                   &piOutputOmega.out);
    ctrlParm.qVqRef = piOutputOmega.out;
    
    // D축: Id_ref = 0 (Field Weakening 미사용)
    ctrlParm.qVdRef = 0;
    
    // D/Q 전류 루프
    MC_ControllerPIUpdate_Assembly(...);  // Id
    MC_ControllerPIUpdate_Assembly(...);  // Iq
}
```

### 3.3 PI 제어기 어셈블리

**함수**: `MC_ControllerPIUpdate_Assembly()`  
**파일**: `lib/motor_control/mc_piupdate_dspic.s`

**Anti-windup**: `kc` (클램핑 계수)로 적분기 포화 시 누적값 감쇠

---

## 4. BEMF 기반 속도/각도 추정 알고리즘

### 4.1 BEMF 원리

모터 전압 방정식:
```
V = R·I + L·dI/dt + BEMF
BEMF = V - R·I - L·dI/dt
```

BEMF는 회전 속도에 비례: `BEMF ∝ ω`

### 4.2 Estim() 알고리즘 흐름

**파일**: `src/foc/estim.c` 76~254행

```mermaid
flowchart TB
    subgraph Input["입력"]
        I1[ialphabeta α, β]
        I2[valphabeta α, β]
        I3[이전 샘플 LastIalpha, LastIbeta]
    end
    
    subgraph Calc["계산"]
        C1[dIα, dIβ = 현재 - 이전]
        C2[VInd = Ls·dI/dt]
        C3[BEMF_α = Vα - Rs·Iα - VInd_α]
        C4[BEMF_β = Vβ - Rs·Iβ - VInd_β]
        C5[Park 변환: BEMF_dq]
        C6[필터: Esdf, Esqf]
        C7[ω = InvKfi·(Esqf ± Esdf)]
        C8[θ = ∫ω·dt]
    end
    
    I1 --> C1
    I2 --> C3
    I3 --> C1
    C1 --> C2
    C2 --> C3
    C3 --> C4 --> C5 --> C6 --> C7 --> C8
```

### 4.3 저속/고속 분기

- **저속** (|ω| < NOMINAL_ELECTRICAL_SPEED): 8 ADC 사이클 간격으로 dI 계산 (해상도 향상)
- **고속**: 1 ADC 사이클 간격으로 dI 계산

```c
// estim.c 84~98행
if (_Q15abs(estimator.qVelEstim) < NOMINAL_ELECTRICAL_SPEED)
{
    // 저속: 8샘플 간격
    uint16_t index = (estimator.qDiCounter - 7) & 0x0007;
    estimator.qDIalpha = (ialphabeta.alpha - estimator.qLastIalphaHS[index]);
    // ...
}
else
{
    // 고속: 1샘플 간격
    estimator.qDIalpha = (ialphabeta.alpha - estimator.qLastIalphaHS[estimator.qDiCounter]);
    // ...
}
```

### 4.4 속도 추정 공식

```
Ω = InvKfi · (Esqf - sgn(Esqf)·Esdf)
```

- Esqf > 0: `Ω = InvKfi·(Esqf - Esdf)`
- Esqf < 0: `Ω = InvKfi·(Esqf + Esdf)`

---

## 5. Open Loop → Closed Loop 전환 메커니즘

### 5.1 CalculateParkAngle() 동작

**파일**: `src/motor/motor_control.c` 253~287행

```c
void CalculateParkAngle(void)
{
    if (uGF.bits.OpenLoop)
    {
        if (motorStartUpData.startupLock < LOCK_TIME)
        {
            motorStartUpData.startupLock += 1;  // 극 정렬
        }
        else if (motorStartUpData.startupRamp < END_SPEED)
        {
            motorStartUpData.startupRamp += OPENLOOP_RAMPSPEED_INCREASERATE;  // 가속
        }
        else
        {
            uGF.bits.ChangeMode = 1;
            uGF.bits.OpenLoop = 0;  // Closed Loop 전환
        }
        thetaElectricalOpenLoop += (motorStartUpData.startupRamp >> 10);
    }
    else
    {
        // Closed Loop: 추정기 오프셋 미세 조정
        CNT_offset++;
        if (CNT_offset > 20)
        {
            if (estimator.qRhoOffset > 8500)
                estimator.qRhoOffset--;
            CNT_offset = 0;
        }
    }
}
```

### 5.2 전환 시퀀스

```
┌──────────────┐    LOCK_TIME     ┌──────────────┐   END_SPEED    ┌──────────────┐
│   Lock       │ ──────────────→  │   Ramp       │ ───────────→  │  Closed Loop │
│ (극 정렬)    │   (1000 샘플)    │ (가속)       │  (400 RPM)   │  (BEMF 추정) │
└──────────────┘                  └──────────────┘              └──────────────┘
```

**userparms.h 상수**:
- `LOCK_TIME`: 1000 (1초 @ 20kHz)
- `END_SPEED_RPM`: 400
- `OPENLOOP_RAMPSPEED_INCREASERATE`: 10

---

## 6. Single Shunt vs Dual Shunt 구현 차이

### 6.1 전류 측정 방식 비교

| 항목 | Dual Shunt | Single Shunt |
|------|------------|--------------|
| **ADC 채널** | AN0(Ia), AN1(Ib) | AN4(Ibus) |
| **샘플 시점** | PWM 중앙 1회 | 2회 (Phase Shifted) |
| **PWM 설정** | 단일 엣지 | 듀얼 엣지 (PHASE 레지스터) |
| **전류 복원** | 직접 측정 | 버스 전류 + 섹터별 복원 |

### 6.2 Single Shunt 전류 복원

**파일**: `src/foc/singleshunt.c` 331~366행

```c
void SingleShunt_PhaseCurrentReconstruction(SINGLE_SHUNT_PARM_T *pSingleShunt)
{
    switch(pSingleShunt->sectorSVM)
    {
        case 1:
            pSingleShunt->Ib = pSingleShunt->Ibus1;
            pSingleShunt->Ic = -pSingleShunt->Ibus2;
            pSingleShunt->Ia = -pSingleShunt->Ic - pSingleShunt->Ib;
            break;
        case 2:
            // ...
        // Sector 1~6 각각 다른 복원 공식
    }
}
```

### 6.3 PWM 듀티 설정 차이

**Dual Shunt** (`src/hal/pwm.c`):
```c
void PWMDutyCycleSet(MC_DUTYCYCLEOUT_T *pPwmDutycycle)
{
    PG1DC = pPwmDutycycle->dutycycle1 >> 1;
    PG2DC = pPwmDutycycle->dutycycle2 >> 1;
    PG4DC = pPwmDutycycle->dutycycle3 >> 1;
}
```

**Single Shunt**:
```c
void PWMDutyCycleSetDualEdge(MC_DUTYCYCLEOUT_T *p1, MC_DUTYCYCLEOUT_T *p2)
{
    PG1DC = p1->dutycycle1 >> 1;
    PG1PHASE = p2->dutycycle1 >> 1;  // 두 번째 샘플 시점
    // ...
}
```

### 6.4 userparms.h 설정

```c
// Dual Shunt (기본)
#undef SINGLE_SHUNT

// Single Shunt
#define SINGLE_SHUNT
```

---

## 7. Field Weakening (구현되었으나 미사용)

### 7.1 Field Weakening 개념

정격 속도 이상에서 자속을 약화시켜 고속 구동을 가능하게 하는 기법입니다. Id에 음의 전류를 인가하여 d축 자속을 감소시킵니다.

### 7.2 구현 상태

**파일**: `src/foc/fdweak.c`

- `InitFWParams()`: 초기화 (MotorControl.Reset()에서 호출)
- `FieldWeakening(qMotorSpeed)`: Id_ref, InvKfi, LsDt 계산

**현재 DoControl()**: Closed Loop에서 `ctrlParm.qVdRef = 0`으로 고정되어 **FieldWeakening() 호출 없음**

### 7.3 userparms.h Field Weakening 상수

```c
#define IDREF_BASESPEED         NORM_CURRENT(0.0)   // 정격 이하: Id=0

// 속도별 Id 참조 (음수 = 자속 약화)
#define IDREF_SPEED0   NORM_CURRENT(0)     /* ~2800 RPM */
#define IDREF_SPEED1   NORM_CURRENT(-0.7)  /* ~2950 RPM */
// ...
#define IDREF_SPEED17  NORM_CURRENT(-2.5)  /* ~5500 RPM */
```

**주의**: userparms.h 주석에 명시된 대로, 고속에서 FOC 이탈 시 인버터 손상 위험이 있으므로 활성화 시 주의가 필요합니다.

---

## 8. 제어 파라미터 튜닝 가이드 (userparms.h)

### 8.1 모터 기본 파라미터

| 상수 | 설명 | 예시 값 |
|------|------|---------|
| `NOPOLESPAIRS` | 극对数 | 1 |
| `NOMINAL_SPEED_RPM` | 정격 속도 | 20000 |
| `MAXIMUM_SPEED_RPM` | 최대 속도 | 21000 |
| `NORM_RS` | 정규화 Rs | 1694 |
| `NORM_LSDTBASE` | 정규화 Ls/dt | 93 |
| `NORM_INVKFIBASE` | 정규화 InvKfi | 10868 |

### 8.2 PI 제어기 계수

| 루프 | Kp | Ki | Kc | outMax |
|------|-----|-----|-----|--------|
| **D (Id)** | 0.045 | 0.003 | 0.999 | 0x7FFF |
| **Q (Iq)** | 0.045 | 0.003 | 0.999 | 0x7FFF |
| **Speed** | 0.4 | 0.003 | 0.999 | Q15_PI_SPEED_OUTPUT_LIMIT |

```c
// userparms.h 215~230행
#define D_CURRCNTR_PTERM       Q15(0.045)
#define D_CURRCNTR_ITERM       Q15(0.003)
#define D_CURRCNTR_CTERM       Q15(0.999)

#define Q_CURRCNTR_PTERM       Q15(0.045)
#define Q_CURRCNTR_ITERM       Q15(0.003)

#define SPEEDCNTR_PTERM        Q15(0.4)
#define SPEEDCNTR_ITERM        Q15(0.003)
```

### 8.3 Open Loop 파라미터

| 상수 | 설명 | 값 |
|------|------|-----|
| `LOCK_TIME` | 극 정렬 시간 (20,000=1초) | 1000 |
| `END_SPEED_RPM` | Closed Loop 전환 속도 | 400 |
| `OPENLOOP_RAMPSPEED_INCREASERATE` | 가속률 | 10 |
| `Q_CURRENT_REF_OPENLOOP` | Open Loop Iq | NORM_CURRENT(2.0) |

### 8.4 BEMF 필터 상수

| 상수 | 용도 | 값 |
|------|------|-----|
| `KFILTER_ESDQ` | BEMF dq 필터 (저속) | 600 |
| `KFILTER_ESDQ_FW` | BEMF dq 필터 (FW) | 164 |
| `KFILTER_VELESTIM` | 속도 추정 필터 | 2*374 |

### 8.5 튜닝 순서 권장

1. **전류 루프 (Id, Iq)**: Kp 먼저, Ki는 나중에
2. **속도 루프**: 전류 루프 안정화 후
3. **Open Loop 전환**: END_SPEED_RPM, INITOFFSET_TRANS_OPEN_CLSD
4. **모터 상수**: Excel 계산기로 NORM_* 값 산출

---

**이전**: [← Chapter 2: HAL 계층 상세](02_HAL_layer.md)  
**다음**: [Chapter 4: FreeRTOS 실시간 시스템 →](04_FreeRTOS_structure.md)
