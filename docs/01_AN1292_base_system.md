# Chapter 1: AN1292 기반 시스템 이해

## 목차

1. [Microchip AN1292 소개](#1-microchip-an1292-소개)
2. [dsPIC33CK256MP508 하드웨어 특성](#2-dspic33ck256mp508-하드웨어-특성)
3. [제공되는 드라이버와 라이브러리](#3-제공되는-드라이버와-라이브러리)
4. [FOC 기본 개념](#4-foc-기본-개념)
5. [제공된 예제의 기본 구조](#5-제공된-예제의-기본-구조)

---

## 1. Microchip AN1292 소개

### 1.1 AN1292란?

**AN1292 (Application Note 1292)**는 Microchip Technology에서 제공하는 **dsPIC33/PIC24 마이크로컨트롤러 기반의 BLDC/PMSM 모터 제어를 위한 공식 애플리케이션 노트**입니다.

**주요 특징**:
- **FOC (Field Oriented Control)** 벡터 제어 알고리즘 완전 구현
- **Single Shunt / Dual Shunt** 전류 측정 방식 모두 지원
- **센서리스 제어**: BEMF 기반 속도/각도 추정기 내장
- **최적화된 어셈블리 라이브러리**: Clarke/Park 변환, PI 제어기 등
- **LVMC 보드 지원**: Low Voltage Motor Control Development Board

### 1.2 AN1292의 구성

AN1292는 다음과 같은 구성 요소를 포함합니다:

| 구성 요소 | 설명 |
|-----------|------|
| **Application Note 문서** | FOC 이론, 시스템 설계, 튜닝 가이드 |
| **예제 프로젝트** | MPLAB X 기반 완전한 동작 예제 |
| **motor_control 라이브러리** | 어셈블리 최적화 FOC 함수 (`.a`, `.s`) |
| **HAL 드라이버** | PWM, ADC, UART 등 하드웨어 추상화 |
| **Excel 파라미터 계산기** | 모터 파라미터 → 정규화 상수 변환 |

### 1.3 왜 AN1292를 사용하는가?

AN1292를 사용하면 다음과 같은 이점이 있습니다:

✅ **검증된 FOC 알고리즘**: Microchip이 수년간 검증한 알고리즘  
✅ **빠른 개발**: 기본 제공 드라이버로 HW 제어 간소화  
✅ **최적화된 성능**: DSP 명령어를 활용한 어셈블리 코드  
✅ **폭넓은 지원**: Microchip 포럼, 문서, 예제 풍부  
✅ **상업적 사용 가능**: Microchip 라이선스 하에 제품화 가능

---

## 2. dsPIC33CK256MP508 하드웨어 특성

### 2.1 MCU 개요

**dsPIC33CK256MP508**는 Microchip의 16비트 디지털 신호 컨트롤러(DSC)로, 모터 제어에 최적화된 다음과 같은 특징을 가집니다:

| 항목 | 사양 |
|------|------|
| **코어** | dsPIC33 (Modified Harvard Architecture) |
| **클럭** | 최대 200MHz (100 MIPS) |
| **플래시** | 256KB |
| **RAM** | 32KB |
| **DSP 엔진** | 2개의 32x32 MAC, 16x16 MAC, Divide |
| **PWM** | 고해상도 PWM (High-Resolution PWM Module) |
| **ADC** | 12비트, 최대 3.25Msps, SAR ADC |
| **패키지** | 64-pin TQFP |

### 2.2 모터 제어 전용 주변장치

dsPIC33CK는 모터 제어를 위해 다음과 같은 전용 주변장치를 제공합니다:

#### 2.2.1 고해상도 PWM Generator

```
특징:
- Center-Aligned / Edge-Aligned 모드
- 독립/Complementary 출력 모드
- 프로그래머블 데드타임 (1ns 해상도)
- ADC 트리거 동기화
- 폴트 입력 (과전류 보호)
```

본 프로젝트에서는 **3개의 PWM Generator (PG1, PG2, PG4)**를 사용하여 3상 인버터를 구동합니다.

#### 2.2.2 고속 ADC

```
특징:
- 12비트 SAR ADC
- 전용 모터 제어 ADC 모듈
- PWM 트리거 동기 샘플링
- 다중 채널 동시 샘플링
```

**사용 채널**:
- AN0, AN1: 위상 전류 (Ia, Ib)
- AN4: 버스 전류 (Ibus, Single Shunt용)
- AN15: DC 버스 전압
- AN12: MOSFET 온도

#### 2.2.3 비교기 (Comparator)

- DAC 기반 과전류 보호
- 하드웨어 PWM 폴트 트리거
- 빠른 응답 시간 (수십 ns)

### 2.3 클럭 설정

본 프로젝트에서 사용하는 클럭 설정:

```
FRC (Fast RC Oscillator, 8MHz)
  ↓ PLL
200MHz (FOSC)
  ↓ /2
100MHz (FCY - 명령어 실행 클럭)
```

**소스 코드**: [`src/hal/clock.c`](../src/hal/clock.c)

```c
// 초기화 함수
void InitOscillator(void)
{
    // PLL 설정: FRC 8MHz → 200MHz
    // N1=1, M=50, N2=2, N3=2
    // FOSC = 8MHz * 50 / (1 * 2 * 2) = 200MHz
    PLLFBD = 50 - 2;        // M = 50
    CLKDIVbits.PLLPRE = 0;  // N1 = 1
    CLKDIVbits.PLLPOST = 0; // N2 = 2
    
    // PLL 활성화 및 전환 대기
    __builtin_write_OSCCONH(0x01);  // 새로운 클럭 소스 선택 (FRC+PLL)
    __builtin_write_OSCCONL(OSCCON | 0x01);  // 클럭 전환 시작
    
    while (OSCCONbits.OSWEN);  // 전환 완료 대기
    while (!OSCCONbits.LOCK);  // PLL Lock 대기
}
```

### 2.4 메모리 맵

```
프로그램 메모리 (Flash):
  0x000000 - 0x03FFFF  (256KB)
    ├── 0x000000 - 0x0001FF  : Reset/Trap Vectors
    ├── 0x000200 - 0x00xxxx  : 애플리케이션 코드
    └── 0x03FF00 - 0x03FFFF  : Configuration Bits

데이터 메모리 (RAM):
  0x000800 - 0x008FFF  (32KB)
    ├── 0x000800 - 0x00xxxx  : 전역/정적 변수
    ├── 0x00xxxx - 0x00yyyy  : 힙 (동적 할당)
    └── 0x00yyyy - 0x008FFF  : 스택 (RTOS 스택 포함)
```

---

## 3. 제공되는 드라이버와 라이브러리

### 3.1 라이브러리 구조

AN1292 프로젝트는 다음과 같은 라이브러리 구조를 가집니다:

```
lib/
├── motor_control/          # Microchip FOC 라이브러리 (핵심)
│   ├── libq-dsp.a          # Q15 고정소수점 DSP 라이브러리
│   ├── mc_clarke_dspic.s   # Clarke 변환 (어셈블리)
│   ├── mc_park_dspic.s     # Park 변환 (어셈블리)
│   ├── mc_invpark_dspic.s  # 역 Park 변환
│   ├── mc_invclarke_dspic.s # 역 Clarke 변환
│   ├── mc_piupdate_dspic.s # PI 제어기
│   ├── mc_svgen_dspic.s    # Space Vector PWM
│   ├── mc_sinetable_*.s    # sin/cos 테이블 (여러 해상도)
│   └── motor_control.h     # API 헤더
│
├── freertos/               # FreeRTOS v10.4.6 (RTOS)
│   ├── tasks.c             # 태스크 관리
│   ├── queue.c             # 큐
│   ├── timers.c            # 소프트웨어 타이머
│   ├── list.c              # 링크드 리스트
│   ├── portable/           # dsPIC33 포팅
│   │   └── MPLAB/PIC24_dsPIC/
│   │       ├── port.c      # 컨텍스트 스위칭
│   │       └── portasm_dsPIC.S
│   └── include/            # 헤더 파일
│
└── x2c_scope/              # X2CScope (실시간 디버깅, 옵션)
    └── x2cscope.h
```

### 3.2 motor_control 라이브러리 상세

#### 3.2.1 Q15 고정소수점 형식

`motor_control` 라이브러리는 **Q15 (Q1.15) 고정소수점** 형식을 사용합니다.

```
Q15 형식:
  - 16비트 부호있는 정수
  - 범위: -1.0 ~ +0.999969 (1 - 2^-15)
  - 소수점 위치: 15비트
  
예시:
  0x7FFF = +0.999969 (거의 +1.0)
  0x4000 = +0.5
  0x0000 = 0.0
  0xC000 = -0.5
  0x8000 = -1.0
```

**Q15 매크로** (`src/foc/general.h`):

```c
#define Q15(Float_Value) \
    ((Float_Value < 0.0) ? \
     (int16_t)(32768 * (Float_Value) - 0.5) : \
     (int16_t)(32767 * (Float_Value) + 0.5))

// 사용 예:
int16_t kp = Q15(0.5);  // 0x4000
int16_t ki = Q15(0.01); // 0x0147
```

#### 3.2.2 주요 어셈블리 함수

| 함수 | 파일 | 설명 |
|------|------|------|
| `MC_TransformClarke_Assembly()` | `mc_clarke_dspic.s` | ABC → αβ 변환 |
| `MC_TransformPark_Assembly()` | `mc_park_dspic.s` | αβ → dq 변환 |
| `MC_TransformParkInverse_Assembly()` | `mc_invpark_dspic.s` | dq → αβ 변환 |
| `MC_TransformClarkeInverseSwappedInput_Assembly()` | `mc_invclarke_dspic.s` | αβ → ABC 변환 (30° 이동) |
| `MC_ControllerPIUpdate_Assembly()` | `mc_piupdate_dspic.s` | PI 제어기 업데이트 |
| `MC_CalculateSpaceVectorPhaseShifted_Assembly()` | `mc_svgen_dspic.s` | SVPWM 듀티 계산 |
| `MC_CalculateSineCosine_Assembly_Ram()` | `mc_sinetable_*.s` | sin/cos 테이블 룩업 |

**성능**: 어셈블리 최적화로 대부분의 변환이 **10~30 사이클** 이내에 완료됩니다.

#### 3.2.3 사용 예시

```c
// Clarke 변환
MC_ABC_T iabc = {.a = 1000, .b = -500, .c = -500};  // 3상 전류
MC_ALPHABETA_T ialphabeta;
MC_TransformClarke_Assembly(&iabc, &ialphabeta);

// Park 변환
MC_SINCOS_T sincosTheta = {.sin = 0x4000, .cos = 0x6ED9};  // 45도
MC_DQ_T idq;
MC_TransformPark_Assembly(&ialphabeta, &sincosTheta, &idq);

// PI 제어기
MC_PIPARMIN_T piInput;
MC_PIPARMOUT_T piOutput;
piInput.piState.kp = Q15(0.05);
piInput.piState.ki = Q15(0.008);
piInput.piState.kc = Q15(0.999);
piInput.piState.outMax = 0x7F00;
piInput.piState.outMin = -0x7F00;
piInput.inReference = 5000;
piInput.inMeasure = 4800;

MC_ControllerPIUpdate_Assembly(piInput.inReference,
                                piInput.inMeasure,
                                &piInput.piState,
                                &piOutput.out);
```

### 3.3 HAL 드라이버 개요

AN1292는 다음과 같은 HAL 드라이버를 제공합니다:

| 드라이버 | 파일 | 역할 |
|----------|------|------|
| **PWM** | `src/hal/pwm.c/.h` | 3상 PWM 생성 (20kHz) |
| **ADC** | `src/hal/adc.c/.h` | 전류/전압/온도 ADC |
| **UART** | `src/hal/uart1.c/.h`, `uart2.c/.h` | 직렬 통신 |
| **Timer** | `src/hal/timer1.c/.h`, `timer2.c/.h` | 타이머 (RTOS Tick, 속도 램프) |
| **CMP** | `src/hal/cmp.c/.h` | 비교기 (과전류 보호) |
| **Clock** | `src/hal/clock.c/.h` | 클럭/PLL 설정 |
| **GPIO** | `src/hal/port_config.c/.h` | GPIO 및 PPS 핀 매핑 |
| **Measure** | `src/hal/measure.c/.h` | 전류 오프셋, 온도 측정 |
| **Board Service** | `src/hal/board_service.c/.h` | 버튼, PWM 제어 통합 |

**상세 내용**: [Chapter 2: HAL 계층 상세](02_HAL_layer.md) 참조

---

## 4. FOC 기본 개념

### 4.1 FOC란?

**FOC (Field Oriented Control)** 또는 **벡터 제어**는 AC 모터 (BLDC, PMSM)를 DC 모터처럼 제어하는 고급 제어 기법입니다.

#### 4.1.1 FOC의 장점

✅ **높은 효율**: 최적의 전류 벡터로 토크 극대화  
✅ **정밀한 속도/토크 제어**: DC 모터 수준의 응답성  
✅ **저소음**: 부드러운 전류 파형  
✅ **넓은 속도 범위**: 저속~고속 전 영역 제어  
✅ **센서리스 가능**: 홀 센서 없이 BEMF로 위치 추정

#### 4.1.2 FOC vs 6-Step (Block Commutation)

| 특징 | FOC | 6-Step |
|------|-----|--------|
| **제어 품질** | 우수 (정현파 전류) | 보통 (구형파 전류) |
| **효율** | 높음 | 낮음 |
| **토크 리플** | 낮음 | 높음 |
| **소음** | 낮음 | 높음 |
| **복잡도** | 높음 (DSP 필요) | 낮음 |
| **연산량** | 많음 (20kHz) | 적음 |

### 4.2 FOC 제어 흐름

FOC는 다음과 같은 좌표 변환 과정을 거칩니다:

```mermaid
graph LR
    ABC[3상 전류<br/>Ia, Ib, Ic] -->|Clarke| AB[고정 좌표계<br/>α, β]
    AB -->|Park| DQ[회전 좌표계<br/>Id, Iq]
    DQ -->|PI 제어| VDQ[전압 지령<br/>Vd, Vq]
    VDQ -->|역 Park| VAB[고정 좌표계<br/>Vα, Vβ]
    VAB -->|역 Clarke| VABC[3상 전압<br/>Va, Vb, Vc]
    VABC -->|SVPWM| PWM[PWM 듀티]
```

#### 4.2.1 Clarke 변환 (ABC → αβ)

3상 고정 좌표계를 2상 고정 좌표계로 변환합니다.

```
수식:
  α = Ia
  β = (Ia + 2·Ib) / √3

조건:
  Ia + Ib + Ic = 0 (3상 평형)
```

#### 4.2.2 Park 변환 (αβ → dq)

2상 고정 좌표계를 회전 좌표계로 변환합니다. 회전 좌표계에서는 정상 상태 시 **d, q가 DC 값**이 됩니다.

```
수식:
  Id = α·cos(θ) + β·sin(θ)
  Iq = -α·sin(θ) + β·cos(θ)

여기서:
  θ: 회전자 전기각
```

#### 4.2.3 dq 좌표계의 의미

- **Id (d축 전류)**: 자속 성분, PMSM에서는 보통 0으로 제어
- **Iq (q축 전류)**: 토크 성분, 토크 ∝ Iq

**DC 모터와의 유사성**:
- DC 모터: 토크 = K·Ia (전류에 비례)
- FOC: 토크 = K·Iq (q축 전류에 비례)

### 4.3 3중 캐스케이드 PI 제어기

FOC는 일반적으로 3개의 PI 제어 루프를 사용합니다:

```
┌─────────────────────────────────────────────────┐
│                 속도 루프 (가장 느림)              │
│  ω_ref → [PI] → Iq_ref                           │
│          ↑                                        │
│          └─ ω_meas (추정 속도)                    │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│               전류 루프 (빠름)                     │
│  Id_ref → [PI] → Vd                              │
│  Iq_ref → [PI] → Vq                              │
│          ↑                                        │
│          └─ Id_meas, Iq_meas                     │
└─────────────────────────────────────────────────┘
```

**제어 주기**:
- 전류 루프: 20kHz (50µs) - ADC ISR
- 속도 루프: 20kHz (50µs) - 동일 ISR 내 (또는 decimation)

### 4.4 센서리스 제어: BEMF 추정

본 프로젝트는 **홀 센서 없이** 모터를 제어합니다. 속도와 각도는 **BEMF (Back EMF, 역기전력)**를 이용하여 추정합니다.

#### 4.4.1 BEMF 원리

모터가 회전하면 코일에 역기전력이 발생합니다:

```
BEMF = Ke·ω

여기서:
  Ke: 역기전력 상수
  ω: 회전 속도
```

#### 4.4.2 BEMF 기반 추정 알고리즘

```
1. 전압 방정식:
   V = R·I + L·dI/dt + BEMF

2. BEMF 계산:
   BEMF = V - R·I - L·dI/dt

3. Park 변환:
   BEMF_d, BEMF_q 계산

4. 속도 추정:
   ω = InvKFi·(BEMF_q ± BEMF_d)

5. 각도 적분:
   θ = ∫ω·dt
```

**상세 내용**: [Chapter 3: FOC 알고리즘](03_FOC_algorithm.md#5-속도-추정estimator-알고리즘) 참조

---

## 5. 제공된 예제의 기본 구조

### 5.1 AN1292 기본 예제 구조

AN1292에서 제공하는 기본 예제는 다음과 같은 구조를 가집니다:

```
AN1292 기본 예제 (Microchip 제공):

main()
  ├── InitOscillator()          # 클럭 설정
  ├── SetupGPIOPorts()          # GPIO 설정
  ├── InitPeripherals()         # CMP, ADC, PWM 초기화
  ├── DiagnosticsInit()         # 진단 모듈
  ├── BoardServiceInit()        # 버튼, 보드 서비스
  └── while(1)                  # 메인 루프
      ├── BoardService()        # 버튼 스캔
      └── (폴링 기반 동작)

ADC ISR (20kHz):
  ├── 전류 샘플링
  ├── Clarke/Park 변환
  ├── Estim()                   # 속도/각도 추정
  ├── DoControl()               # PI 제어
  ├── CalculateParkAngle()      # 각도 계산
  ├── 역 Park/Clarke 변환
  └── SVPWM 계산 및 PWM 업데이트
```

### 5.2 본 프로젝트의 구조 (사용자 확장)

본 프로젝트는 AN1292 기본 예제에 다음을 추가하였습니다:

```
본 프로젝트 (AN1292 + 사용자 확장):

main()
  ├── InitOscillator()          # [AN1292]
  ├── SetupGPIOPorts()          # [AN1292]
  ├── InitPeripherals()         # [AN1292]
  ├── DiagnosticsInit()         # [AN1292]
  ├── BoardServiceInit()        # [AN1292]
  ├── Communication_Setup()     # [사용자] UART2 통신 초기화
  ├── LED_Setup()               # [사용자] LED 상태 표시
  ├── Timer2_Setup()            # [사용자] 속도 램프 타이머
  ├── INTERRUPT_Initialize()    # [사용자] 인터럽트 우선순위
  ├── MotorStateMachine_Init()  # [사용자] 상태머신
  ├── MotorControl.Reset()      # [AN1292]
  ├── [FreeRTOS 초기화]         # [사용자]
  │   ├── xTimerCreate (LED, Comm)
  │   ├── xTaskCreate (Motor, Comm, UI)
  │   └── vTaskStartScheduler() # RTOS 시작
  └── (여기서 리턴하지 않음)

FreeRTOS Tasks:
  ├── vMotorTask (1ms)          # [사용자] 상태머신 + 속도 업데이트
  ├── vCommTask (10ms)          # [사용자] UART 통신 처리
  └── vUITask (10ms)            # [사용자] LED + 진단

ADC ISR (20kHz):                # [AN1292 + 사용자 수정]
  ├── [사용자] Stall 검사 (과전류)
  ├── [AN1292] Clarke/Park 변환
  ├── [AN1292] Estim()
  ├── [AN1292] DoControl()
  ├── [AN1292] CalculateParkAngle()
  ├── [AN1292] 역 Park/Clarke 변환
  └── [AN1292] SVPWM

Timer2 ISR (50µs):              # [사용자]
  └── SpeedRamp_50us_Callback() # 속도 램프 제어
```

### 5.3 주요 추가 모듈

본 프로젝트에서 AN1292 기본 예제에 추가된 모듈:

| 모듈 | 디렉토리 | 설명 |
|------|----------|------|
| **통신 모듈** | `src/comm/` | UART2 기반 원격 제어 (프로토콜, 명령 처리) |
| **모터 상태머신** | `src/motor/motor_statemachine.c` | 5-State Machine (STOPPED/STARTING/RUNNING/STOPPING/FAULT) |
| **속도 램프** | `src/motor/motor_speed.c` | 50µs 주기 비대칭 가감속 |
| **LED 상태 표시** | `src/ui/` | Blinker (통신 상태) + Morse (RPM 표시) |
| **FreeRTOS 통합** | `src/pmsm.c` | 태스크, SW Timer 설정 |
| **Timer1 RTOS Tick** | `src/hal/timer1.c` | FreeRTOS RTOS Tick 전용 |
| **인터럽트 우선순위** | `src/hal/interrupt.c` | IPL 체계적 설정 |

**상세 내용**: [Chapter 5: 사용자 알고리즘 추가](05_user_algorithm.md) 참조

### 5.4 소스 코드 구조 비교

```
AN1292 기본 예제:            본 프로젝트:
src/                        src/
├── adc.c                   ├── hal/           # HAL 분리
├── pwm.c                   │   ├── adc.c
├── uart.c                  │   ├── pwm.c
├── clock.c                 │   ├── uart1.c
├── control.c               │   ├── uart2.c    # UART2 추가
├── estim.c                 │   ├── timer1.c   # RTOS Tick
├── fdweak.c                │   ├── timer2.c   # 속도 램프
├── singleshunt.c           │   └── ...
├── measure.c               ├── foc/           # FOC 분리
├── board_service.c         │   ├── control.c
├── diagnostics.c           │   ├── estim.c
├── main.c                  │   ├── fdweak.c
└── userparms.h             │   ├── singleshunt.c
                            │   └── userparms.h
                            ├── motor/         # [신규] 모터 제어
                            │   ├── motor_control.c
                            │   ├── motor_speed.c
                            │   └── motor_statemachine.c
                            ├── comm/          # [신규] 통신
                            │   ├── Communication.c
                            │   ├── Communication_drv.c
                            │   ├── protocol.c
                            │   └── command_handler.c
                            ├── ui/            # [신규] UI
                            │   ├── led_blinker.c
                            │   └── led_morse.c
                            ├── util/          # [신규] 유틸리티
                            │   └── ring_buffer.c
                            ├── config/        # [신규] RTOS 설정
                            │   └── FreeRTOSConfig.h
                            └── pmsm.c         # 메인 (FreeRTOS 통합)
```

---

## 다음 단계

AN1292의 기본 구조를 이해하셨다면, 다음 챕터에서 각 계층의 상세 구현을 확인하세요:

- **[Chapter 2: HAL 계층 상세](02_HAL_layer.md)** - 하드웨어 드라이버 API
- **[Chapter 3: FOC 알고리즘](03_FOC_algorithm.md)** - 제어 알고리즘 상세
- **[Chapter 5: 사용자 알고리즘 추가](05_user_algorithm.md)** - 사용자 확장 모듈

---

**다음**: [Chapter 2: HAL 계층 상세 →](02_HAL_layer.md)
