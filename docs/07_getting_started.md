# Chapter 7: 처음 적용 시 시작 가이드

## 목차

본 문서는 AN1292 기반 프로젝트를 처음 적용할 때 **Step 1~7**로 진행하는 시작 가이드입니다.

1. [Step 1: 하드웨어 준비](#step-1-하드웨어-준비)
2. [Step 2: 개발 환경 구축](#step-2-개발-환경-구축)
3. [Step 3: 프로젝트 빌드 및 다운로드](#step-3-프로젝트-빌드-및-다운로드)
4. [Step 4: 모터 파라미터 설정](#step-4-모터-파라미터-설정)
5. [Step 5: 통신 프로토콜 확인](#step-5-통신-프로토콜-확인)
6. [Step 6: 기본 동작 검증](#step-6-기본-동작-검증)
7. [Step 7: 사용자 기능 추가](#step-7-사용자-기능-추가)

---

## Step 1: 하드웨어 준비

### 1.1 필수 구성

| 항목 | 설명 |
|------|------|
| **MCU** | dsPIC33CK256MP508 |
| **보드** | LVMC (Low Voltage Motor Control) 또는 호환 보드 |
| **모터** | BLDC/PMSM (센서리스) |
| **인버터** | 3상 인버터 (6 MOSFET) |
| **전원** | DC 버스 (모터 정격에 맞춤) |

### 1.2 핀 연결

```
┌─────────────────────────────────────────────────────────────────┐
│                    주요 핀 연결                                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PWM (3상)     PG1/2/4 → 인버터 게이트 드라이버                  │
│  ADC           AN0(Ia), AN1(Ib), AN4(Ibus), AN15(Vbus)           │
│  UART2         RB10(TX), RB11(RX) → PC/통신 모듈                │
│  LED           RA7 (상태 표시)                                    │
│  CMP           과전류 보호 (PWM Fault 입력)                       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 1.3 점검 사항

- [ ] 전원 전압/전류 정격 확인
- [ ] 모터 위상(U, V, W) 연결 확인
- [ ] 접지 공통 연결
- [ ] 데드타임 설정 (1µs 권장)

---

## Step 2: 개발 환경 구축

### 2.1 필수 도구

| 도구 | 버전 | 용도 |
|------|------|------|
| **MPLAB X IDE** | 6.x 이상 | 통합 개발 환경 |
| **XC16 컴파일러** | 2.10 이상 | dsPIC33 C 컴파일러 |
| **MPLAB ICD4 / PICkit4** | - | 디버거/프로그래머 |

### 2.2 프로젝트 구조 확인

```
AN1292_dsPIC33CK256MP508_ElecLow/
├── src/
│   ├── hal/           # HAL 드라이버
│   ├── foc/           # FOC 제어 (control, estim, userparms)
│   ├── motor/         # 상태머신, 속도 램프
│   ├── comm/          # 통신 (Communication, protocol, command_handler)
│   ├── ui/            # LED (Blinker, Morse)
│   ├── config/        # FreeRTOSConfig.h
│   └── pmsm.c         # main, ISR, Task
├── lib/
│   ├── motor_control/ # Microchip FOC 어셈블리 라이브러리
│   └── freertos/      # FreeRTOS v10.4.6
└── docs/              # 문서
```

### 2.3 MPLAB X 프로젝트 열기

1. MPLAB X IDE 실행
2. File → Open Project → `AN1292_dsPIC33CK256MP508_ElecLow` 선택
3. 프로젝트 속성에서 XC16 경로 확인

---

## Step 3: 프로젝트 빌드 및 다운로드

### 3.1 빌드

```
메뉴: Run → Build Project (F11)
```

- 경고 없이 빌드되는지 확인
- `dist/default/production/*.hex` 생성 확인

### 3.2 다운로드

1. ICD4/PICkit4 연결
2. Run → Make and Program Device (F6)
3. Configuration Bits 확인 (device_config.c)

### 3.3 첫 실행

- 전원 인가 후 LED 점멸 확인 (통신 정상: 정상 패턴, 비정상: 에러 패턴)
- UART2 19200 baud로 터미널 연결

---

## Step 4: 모터 파라미터 설정

### 4.1 userparms.h 수정

**파일**: `src/foc/userparms.h`

| 상수 | 설명 | 수정 방법 |
|------|------|-----------|
| `NOPOLESPAIRS` | 극对数 | 모터 명plate 확인 |
| `NOMINAL_SPEED_RPM` | 정격 속도 | 모터 사양 |
| `MAXIMUM_SPEED_RPM` | 최대 속도 | 모터 사양 |
| `NORM_RS`, `NORM_LSDTBASE`, `NORM_INVKFIBASE` | 정규화 상수 | Excel 계산기 사용 |

### 4.2 Microchip Excel 계산기

AN1292 애플리케이션 노트에 포함된 Excel 파일을 사용하여:
- Rs, Ls, Ke 등 모터 상수 입력
- NORM_* 값 산출
- userparms.h에 반영

### 4.3 PI 계수 (초기값 유지 권장)

- D/Q 전류: 0.045 / 0.003
- Speed: 0.4 / 0.003
- 튜닝 필요 시 [Chapter 3: FOC 알고리즘](03_FOC_algorithm.md#8-제어-파라미터-튜닝-가이드-userparmsh) 참조

---

## Step 5: 통신 프로토콜 확인

### 5.1 패킷 형식

**RX (PC → MCU)**:
```
STX(0x40) + CMD(2자리 ASCII-hex) + KEY(4) + SPEED(4) + TORQUE(4) + ETX(0x2A) + ...
```

**TX (MCU → PC)**:
```
STX + "40" + status(4) + present_rpm(4) + torque(4) + version(5)
```

### 5.2 모터 제어 명령 (0x05)

- **motor_on**: KEY 필드 비트
- **direction**: KEY 필드 비트
- **speed**: SPEED 필드 (0~65535)

### 5.3 터미널 테스트

- 19200 8N1
- 패킷 예: `@05xxxx1000xxxx*` (motor_on, speed=1000)

---

## Step 6: 기본 동작 검증

### 6.1 검증 순서

1. **통신**: 패킷 수신 시 LED 정상 패턴
2. **모터 기동**: motor_on=1, speed>0 전송 → 모터 회전
3. **정지**: motor_on=0 또는 speed=0 → 감속 정지
4. **RX 타임아웃**: 1초간 패킷 미전송 → 자동 정지

### 6.2 LED 상태

| LED 패턴 | 의미 |
|----------|------|
| 정상 점멸 | Communication_IsHealthy = true |
| 에러 점멸 | 1초 이상 수신 없음 |
| Morse | 모터 구동 중 RPM 표시 (천단위) |

### 6.3 문제 발생 시

- [Chapter 6: 구현 중 발생한 문제와 해결](06_problems_solutions.md) 참조
- Stall 감지 시 FAULT → motor_on=0 후 STOPPED

---

## Step 7: 사용자 기능 추가

### 7.1 추가 모듈 배치

```
src/
├── my_module/
│   ├── my_module.c
│   └── my_module.h
```

### 7.2 통합 예시

**1) 초기화 (main)**:
```c
// pmsm.c main() 내
MyModule_Init();
```

**2) 주기 호출 (Task)**:
```c
// vMotorTask 또는 별도 Task
MyModule_Update();
```

**3) 통신 연동**:
- `CommandHandler_RegisterTarget()` 또는 `CommandHandler_RegisterRxCallback()` 활용
- `Protocol_GetXxx()` / `Protocol_SetXxx()` 확장

### 7.3 주의사항

- **ADC ISR (IPL 7)**: FreeRTOS API 호출 금지
- **Timer2 ISR (IPL 5)**: FreeRTOS API 호출 금지
- **공유 변수**: ISR-Task 간 사용 시 `volatile` 고려
- **Critical Section**: Reset 등 중요 구간 보호

### 7.4 참고 문서

| 문서 | 용도 |
|------|------|
| [02_HAL_layer.md](02_HAL_layer.md) | HAL API |
| [05_user_algorithm.md](05_user_algorithm.md) | 통신, 상태머신, 속도 램프 |
| [08_API_reference.md](08_API_reference.md) | API 레퍼런스 |

---

## 체크리스트 요약

```
□ Step 1: HW 연결, 전원/모터 확인
□ Step 2: MPLAB X, XC16 설치
□ Step 3: 빌드, 다운로드, 첫 실행
□ Step 4: userparms.h 모터 파라미터
□ Step 5: 통신 프로토콜, 터미널 테스트
□ Step 6: 기동/정지/타임아웃 검증
□ Step 7: 사용자 모듈 추가 (필요 시)
```

---

**이전**: [← Chapter 6: 구현 중 발생한 문제와 해결](06_problems_solutions.md)  
**다음**: [Chapter 8: API 레퍼런스 →](08_API_reference.md)
