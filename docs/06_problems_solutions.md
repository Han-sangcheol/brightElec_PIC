# Chapter 6: 구현 중 발생한 문제와 해결

## 목차

본 문서는 AN1292 기본 예제에 FreeRTOS, 통신, 상태머신 등을 통합하는 과정에서 발생한 7가지 주요 문제와 해결 방법을 상세히 기록합니다.

1. [FreeRTOS와 고우선순위 ISR 간 API 호출 불가](#1-freertos와-고우선순위-isr-간-api-호출-불가)
2. [Timer1 1ms 콜백과 RTOS Tick 충돌](#2-timer1-1ms-콜백과-rtos-tick-충돌)
3. [통신 단절 시 모터 무한 구동](#3-통신-단절-시-모터-무한-구동)
4. [Stall(과전류) 미감지로 인한 손상 위험](#4-stall과전류-미감지로-인한-손상-위험)
5. [MotorControl.Reset() 호출 시 경쟁 조건](#5-motorcontrolreset-호출-시-경쟁-조건)
6. [ISR-Task 간 공유 변수 동기화](#6-isr-task-간-공유-변수-동기화)
7. [Open Loop → Closed Loop 전환 실패](#7-open-loop--closed-loop-전환-실패)

---

## 1. FreeRTOS와 고우선순위 ISR 간 API 호출 불가

### 1.1 문제

ADC ISR (IPL 7), Timer2 ISR (IPL 5)에서 `xQueueSendFromISR`, `xSemaphoreGiveFromISR` 등 FreeRTOS API를 호출하면 **커널 손상** 또는 **예측 불가 동작**이 발생합니다.

### 1.2 원인

FreeRTOS는 `configMAX_SYSCALL_INTERRUPT_PRIORITY = 4`로 설정되어 있어, **IPL 4 초과**인 ISR에서는 RTOS API 호출이 금지됩니다. dsPIC33CK의 IPL 5~7은 이 경계 위에 있습니다.

### 1.3 해결

- **ADC ISR, Timer2 ISR**: FreeRTOS API 사용 금지, **공유 변수만** 사용
- **UART ISR (IPL 3)**: `xQueueSendFromISR` 등 FromISR API 사용 가능 (현재는 미사용, 패킷 조립만 수행)

**설정**: `src/config/FreeRTOSConfig.h` 74행

```c
#define configMAX_SYSCALL_INTERRUPT_PRIORITY    4
```

**인터럽트 우선순위**: `src/hal/interrupt.c`

```c
_ADCAN0IP = 7;   // ADC - RTOS 외부
_CCP1IP = 5;    // Timer2 - RTOS 외부
_U2RXIP = 3;    // UART - RTOS 내부 (FromISR 가능)
_T1IP = 1;      // Timer1 - RTOS Tick
```

---

## 2. Timer1 1ms 콜백과 RTOS Tick 충돌

### 2.1 문제

기존 AN1292 예제에서는 Timer1이 **RTOS Tick**과 **LED/통신 1ms 카운터**를 동시에 담당하려 했습니다. FreeRTOS 포팅에서는 Timer1이 **RTOS Tick 전용**으로 예약되어 있어, LED/통신 1ms 콜백을 Timer1에 추가할 수 없습니다.

### 2.2 원인

- `vApplicationSetupTickTimerInterrupt()`에서 Timer1을 RTOS Tick으로 설정
- `port.c`의 `_T1Interrupt`에서 `xTaskIncrementTick()` 호출
- Timer1 ISR에 사용자 콜백을 추가하면 RTOS 동작에 영향

### 2.3 해결

**FreeRTOS Software Timer**로 LED/통신 1ms 콜백을 분리했습니다.

**변경 전**:
```
Timer1 ISR → xTaskIncrementTick() + LED_TimerISR() + timer1ms_communication()
```

**변경 후**:
```
Timer1 ISR → xTaskIncrementTick()  (RTOS Tick 전용)
SW Timer LED (1ms)  → LedBlinker.TimerISR(), LedMorse.TimerISR()
SW Timer Comm (1ms) → timer1ms_communication()
```

**구현**: `src/pmsm.c` 282~289행

```c
TimerHandle_t xLedTimer  = xTimerCreate("LED",  pdMS_TO_TICKS(1), pdTRUE, NULL, vLedTimerCallback);
TimerHandle_t xCommTimer = xTimerCreate("Comm", pdMS_TO_TICKS(1), pdTRUE, NULL, vCommTimerCallback);
xTimerStart(xLedTimer,  0);
xTimerStart(xCommTimer, 0);
```

---

## 3. 통신 단절 시 모터 무한 구동

### 3.1 문제

UART 통신이 끊어져도 마지막 수신된 `motor_on=1` 명령이 그대로 유지되어, **모터가 계속 구동**되는 위험이 있습니다. 원격 제어 환경에서는 통신 단절 시 즉시 정지해야 합니다.

### 3.2 원인

- `MotorData_cmd.motor_on`은 통신 패킷 수신 시에만 갱신됨
- 통신이 끊기면 갱신이 없어 이전 값 유지

### 3.3 해결

**1초 주기 RX 타임아웃**을 도입했습니다.

1. `g_rxPacketCount`: 패킷 수신 시마다 증가 (Communication_drv.c)
2. 1초마다 `g_commHealthy = (count != lastCount)` 판단
3. `Communication_IsHealthy() == false`이면 `motor_on_command = 0` 강제

**구현**: `src/comm/Communication.c` 98~104행

```c
if (g_healthCheckTimer >= COMM_HEALTH_PERIOD_MS)  // 1000
{
    g_healthCheckTimer = 0;
    g_commHealthy = (COMM_Drv_GetRxPacketCount() != g_lastRxCount);
    g_lastRxCount = COMM_Drv_GetRxPacketCount();
}
```

**적용**: `src/motor/motor_statemachine.c` 113~117행

```c
if (!Communication_IsHealthy())
{
    MotorData_cmd.motor_on_command = 0;
}
```

---

## 4. Stall(과전류) 미감지로 인한 손상 위험

### 4.1 문제

모터 정체(Stall) 시 전류가 급증하지만, CMP(비교기) 하드웨어 보호만으로는 **연속적인 과전류**를 감지하기 어렵습니다. 소프트웨어에서 추가 감지가 필요합니다.

### 4.2 원인

- CMP: 순간 과전류 시 PWM 폴트 → Reset
- Stall: 구속으로 인한 **지속적 과전류** → CMP 임계를 넘지 않을 수도 있음

### 4.3 해결

**ADC ISR 내 선행 검사**를 추가했습니다. FOC 실행 직전에 전류를 확인합니다.

**임계값**:
- **즉시 정지**: Ia 또는 Ib > 10000
- **카운트**: Ia 또는 Ib > 8000 → STALL_CNT++
- **리셋**: Ia, Ib < 7500 → STALL_CNT=0
- **정지**: STALL_CNT > 130 (약 6.5ms 지속)

**구현**: `src/pmsm.c` 366~396행

```c
#ifdef STALL_STOP
if (measureInputs.current.Ia > 10000 || measureInputs.current.Ib > 10000)
{
    MotorControl.Reset();
    g_stall_stop_flag = 1;
    goto adc_isr_tail;
}
// ... STALL_CNT 로직 ...
if (STALL_CNT > 130)
{
    MotorControl.Reset();
    g_stall_stop_flag = 1;
    goto adc_isr_tail;
}
#endif
```

**상태머신 연동**: `g_stall_stop_flag` 설정 시 FAULT 상태로 전환, `motor_on=0` 대기 후 STOPPED로 복귀

---

## 5. MotorControl.Reset() 호출 시 경쟁 조건

### 5.1 문제

`MotorControl.Reset()`은 `DisableADCInterrupt()` ~ `EnableADCInterrupt()` 사이에서 PI, Estimator, PWM 등을 초기화합니다. 이 동안 **Motor Task가 선점**되면, ADC ISR이 비활성화된 상태에서 다른 태스크가 공유 자원을 건드릴 수 있습니다. 또한 Reset 중에 ADC ISR이 끼어들면 **일관성 없는 상태**가 됩니다.

### 5.2 원인

- Reset은 ADC 비활성화로 ISR 진입은 막지만, **다른 태스크**는 계속 실행됨
- `uGF`, `estimator` 등은 Task와 ISR 양쪽에서 접근 가능

### 5.3 해결

**taskENTER_CRITICAL() / taskEXIT_CRITICAL()**로 Reset 호출 구간을 감쌌습니다. Critical Section 동안 **Motor Task 선점 방지**로, Reset이 원자적으로 완료되도록 합니다.

**구현**: `src/motor/motor_statemachine.c` 189~193행

```c
if (abs(MotorData_now.speed) <= SPEED_STOP_LIMIT && MotorData_cmd.speed_target == 0)
{
    uGF.bits.RunMotor = 0;
    taskENTER_CRITICAL();
    MotorControl.Reset();
    taskEXIT_CRITICAL();
    currentState = MOTOR_STATE_STOPPED;
}
```

**참고**: Critical Section은 IPL 1~4만 비활성화하므로, ADC ISR(IPL 7)은 여전히 실행될 수 있습니다. 다만 Reset 내부에서 `DisableADCInterrupt()`를 먼저 호출하므로, 실질적으로 ADC ISR은 진입하지 않습니다.

---

## 6. ISR-Task 간 공유 변수 동기화

### 6.1 문제

- `X2C_VelRef`: Timer2 ISR에서 쓰기, ADC ISR에서 읽기
- `CW_CCW`: Motor Task에서 쓰기, ADC ISR에서 읽기
- `g_stall_stop_flag`: ADC ISR에서 쓰기, Motor Task에서 읽기

컴파일러 최적화로 인해 **캐시/레지스터**에 값이 머물러, 다른 컨텍스트에서 최신 값을 보지 못하는 문제가 발생할 수 있습니다.

### 6.2 원인

- `volatile` 미선언 시 컴파일러가 메모리 접근을 생략할 수 있음
- 다중 컨텍스트에서 접근하는 변수는 `volatile`로 선언해야 함

### 6.3 해결

**volatile 선언**을 적용했습니다.

**파일**: `src/motor/motor_speed.c` 22행

```c
volatile int X2C_VelRef;
```

**파일**: `src/pmsm.c` 95~106행

```c
volatile unsigned int CW_CCW, CW_CCW_OLD;
volatile uint8_t g_stall_stop_flag;
```

**Lock-free 패턴**: 대부분 단일 쓰기/다중 읽기이므로, 뮤텍스 없이 volatile만으로 충분합니다. 다만 `MotorData_cmd`처럼 여러 필드를 한 번에 갱신하는 경우, 프로토콜 파싱 시점과 Motor Task 읽기 시점이 10ms 이상 떨어져 있어 실질적 경쟁은 적습니다.

---

## 7. Open Loop → Closed Loop 전환 실패

### 7.1 문제

Open Loop 가속 후 Closed Loop로 전환할 때 **각도 오차**나 **속도 불일치**로 인해 모터가 흔들리거나 역전하는 현상이 발생할 수 있습니다.

### 7.2 원인

- Open Loop 각도 `thetaElectricalOpenLoop`와 BEMF 추정 각도 `estimator.qRho`의 **초기 오프셋** 불일치
- 전환 시점의 속도가 END_SPEED_RPM과 맞지 않음
- `INITOFFSET_TRANS_OPEN_CLSD` 값이 모터/부하에 맞지 않음

### 7.3 해결

**userparms.h 튜닝**:

1. **INITOFFSET_TRANS_OPEN_CLSD**: 45°(0x2000) 근처에서 미세 조정. 현재 0x2040 사용
2. **END_SPEED_RPM**: 전환 속도. 너무 높으면 BEMF 신호가 약해 추정 불안정. 400 RPM 사용
3. **LOCK_TIME**: 극 정렬 시간. 부하/관성에 따라 조정

**CalculateParkAngle() 오프셋 보정** (`src/motor/motor_control.c` 276~285행):

```c
else  // Closed Loop
{
    CNT_offset++;
    if (CNT_offset > 20)
    {
        if (estimator.qRhoOffset > 8500)
            estimator.qRhoOffset--;
        CNT_offset = 0;
    }
}
```

전환 후 일정 주기로 `qRhoOffset`을 서서히 감소시켜, 추정기 각도를 실제와 맞춥니다.

**권장 튜닝 순서**:
1. Open Loop만으로 END_SPEED_RPM까지 안정 가속 확인
2. INITOFFSET_TRANS_OPEN_CLSD를 ±0x100 단위로 조정
3. 전환 직후 토크 리플/흔들림 관찰 후 qRhoOffset 보정 주기(20) 조정

---

## 요약 표

| # | 문제 | 해결 |
|---|------|------|
| 1 | FreeRTOS API ISR 호출 불가 | IPL 5~7 ISR에서 API 미사용, 공유 변수만 사용 |
| 2 | Timer1 콜백 충돌 | SW Timer로 LED/통신 1ms 분리 |
| 3 | 통신 단절 시 무한 구동 | 1초 RX 타임아웃, motor_on_command=0 강제 |
| 4 | Stall 미감지 | ADC ISR 선행 검사, STALL_CNT, g_stall_stop_flag |
| 5 | Reset 경쟁 조건 | taskENTER/EXIT_CRITICAL로 Reset 구간 보호 |
| 6 | 공유 변수 동기화 | volatile 선언 (X2C_VelRef, CW_CCW, g_stall_stop_flag) |
| 7 | Open/Closed 전환 실패 | INITOFFSET, END_SPEED_RPM, qRhoOffset 보정 튜닝 |

---

**이전**: [← Chapter 5: 사용자 알고리즘 추가](05_user_algorithm.md)  
**다음**: [Chapter 7: 처음 적용 시 시작 가이드 →](07_getting_started.md)
