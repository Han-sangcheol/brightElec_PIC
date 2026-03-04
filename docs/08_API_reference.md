# Chapter 8: API 레퍼런스

## 목차

1. [HAL API](#1-hal-api)
2. [Motor Control API](#2-motor-control-api)
3. [Communication API](#3-communication-api)
4. [State Machine API](#4-state-machine-api)
5. [Speed API](#5-speed-api)
6. [LED API](#6-led-api)

---

## 1. HAL API

### 1.1 PWM

**파일**: `src/hal/pwm.h`, `src/hal/pwm.c`

| 함수/매크로 | 설명 |
|-------------|------|
| `InitPWMGenerators(void)` | 3상 PWM 초기화 (20kHz, Center-Aligned) |
| `PWMDutyCycleSet(MC_DUTYCYCLEOUT_T*)` | 듀티 설정 (Dual Shunt) |
| `PWMDutyCycleSetDualEdge(MC_DUTYCYCLEOUT_T*, MC_DUTYCYCLEOUT_T*)` | 듀티 설정 (Single Shunt) |
| `EnablePWMOutputsInverterA(void)` | PWM 출력 활성화 |
| `DisablePWMOutputsInverterA(void)` | PWM 출력 비활성화 |

**상수**:
- `LOOPTIME_TCY`: PWM 주기 (TCY)
- `ADC_SAMPLING_POINT`: ADC 트리거 시점
- `MIN_DUTY`: 최소 듀티 (0)

### 1.2 ADC

**파일**: `src/hal/adc.h`, `src/hal/adc.c`

| 매크로 | 채널 | 용도 |
|--------|------|------|
| `ADCBUF_INV_A_IPHASE1` | AN0 | 위상 전류 Ia |
| `ADCBUF_INV_A_IPHASE2` | AN1 | 위상 전류 Ib |
| `ADCBUF_INV_A_IBUS` | AN4 | 버스 전류 (Single Shunt) |
| `ADCBUF_VBUS_A` | AN15 | DC 버스 전압 |
| `ADCBUF_MOSFET_TEMP_A` | AN12 | MOSFET 온도 |
| `ADCBUF_SPEED_REF_A` | AN11 | 속도 기준 (가변저항) |

| 함수 | 설명 |
|------|------|
| `InitializeADCs(void)` | ADC 초기화 |
| `EnableADCInterrupt(void)` | ADC 인터럽트 활성화 |
| `DisableADCInterrupt(void)` | ADC 인터럽트 비활성화 |
| `ClearADCIF(void)` | ADC 인터럽트 플래그 클리어 |

### 1.3 UART2

**파일**: `src/hal/uart2.h`, `src/hal/uart_interface.h`

**UART_INTERFACE** (함수포인터 구조체):

| 멤버 | 설명 |
|------|------|
| `Initialize()` | UART 초기화 |
| `Deinitialize()` | UART 비활성화 |
| `Read()` | 1바이트 수신 |
| `Write(uint8_t)` | 1바이트 전송 |
| `IsRxReady()` | 수신 버퍼 데이터 여부 |
| `IsTxReady()` | 송신 버퍼 빈 여부 |
| `BaudRateSet(uint32_t)` | 보레이트 설정 |
| `BaudRateGet()` | 보레이트 조회 |

**인스턴스**: `UART2_Drv`

### 1.4 Timer

**파일**: `src/hal/timer1.h`, `src/hal/timer2.h`

| 함수 | 파일 | 설명 |
|------|------|------|
| `vApplicationSetupTickTimerInterrupt()` | timer1.c | FreeRTOS RTOS Tick 설정 (1ms) |
| `Timer2_Init(void)` | timer2.c | 50µs 타이머 초기화 |
| `Timer2_RegisterCallback(Timer2_cb)` | timer2.c | 50µs 콜백 등록 |

### 1.5 기타 HAL

| 모듈 | 주요 함수 |
|------|-----------|
| **clock** | `InitOscillator()` |
| **port_config** | `SetupGPIOPorts()`, `MapGPIOHWFunction()` |
| **cmp** | `CMP_Initialize()`, `CMP1_ReferenceSet()` |
| **measure** | `MCAPP_MeasureCurrentOffset()`, `MCAPP_MeasureCurrentCalibrate()` |
| **interrupt** | `INTERRUPT_Initialize()`, `INTERRUPT_GlobalEnable()` |

---

## 2. Motor Control API

### 2.1 MotorControl 인터페이스

**파일**: `src/motor/motor_control.h`

```c
typedef struct {
    void (*Init)(void);       // InitControlParameters
    void (*Reset)(void);     // ResetParmeters
    void (*Execute)(void);   // DoControl
    void (*CalcAngle)(void); // CalculateParkAngle
} MotorControlInterface_t;

extern const MotorControlInterface_t MotorControl;
```

| 멤버 | 호출 위치 | 설명 |
|------|-----------|------|
| `MotorControl.Init()` | ResetParmeters 내부 | PI 계수 초기화 |
| `MotorControl.Reset()` | 상태머신, ADC ISR, PWM ISR | PWM/ADC/PI/Estimator 리셋 |
| `MotorControl.Execute()` | ADC ISR | DoControl (PI 제어) |
| `MotorControl.CalcAngle()` | ADC ISR | CalculateParkAngle (Open/Closed 전환) |

### 2.2 직접 호출 함수

| 함수 | 설명 |
|------|------|
| `InitControlParameters(void)` | PI 초기화 (D/Q/Speed) |
| `DoControl(void)` | Id, Iq, Speed PI 제어 |
| `CalculateParkAngle(void)` | Park 각도 계산 |
| `ResetParmeters(void)` | 모터 파라미터 전체 리셋 |

### 2.3 전역 변수 (extern)

| 변수 | 타입 | 용도 |
|------|------|------|
| `uGF` | volatile UGF_T | RunMotor, OpenLoop, ChangeMode 등 |
| `thetaElectrical` | volatile int16_t | Park 변환 각도 |
| `thetaElectricalOpenLoop` | volatile int16_t | Open Loop 각도 |
| `pwmPeriod` | uint16_t | PWM 주기 |
| `piInputId`, `piOutputId` | MC_PIPARMIN_T, MC_PIPARMOUT_T | Id PI |
| `piInputIq`, `piOutputIq` | MC_PIPARMIN_T, MC_PIPARMOUT_T | Iq PI |
| `piInputOmega`, `piOutputOmega` | MC_PIPARMIN_T, MC_PIPARMOUT_T | Speed PI |

---

## 3. Communication API

### 3.1 오케스트레이션

**파일**: `src/comm/Communication.h`

| 함수 | 설명 |
|------|------|
| `communication(void)` | RX 파싱, TX 전송, 건강 상태 판단 (vCommTask에서 호출) |
| `timer1ms_communication(void)` | 1ms 카운터 증가 (SW Timer 콜백) |
| `Communication_IsHealthy(void)` | 통신 건강 상태 (true=수신 있음) |

### 3.2 MotorData_t

**파일**: `src/comm/Communication.h`

```c
typedef struct {
    bool motor_on;
    bool motor_on_command;
    bool motor_on_old;
    bool direction;
    int32_t speed;
    int32_t speed_command;
    int32_t speed_command_old;
    int32_t speed_target;
    uint16_t torque;
} MotorData_t;
```

**전역 인스턴스**: `MotorData_cmd`, `MotorData_now`

### 3.3 Communication_drv

**파일**: `src/comm/Communication_drv.h`

| 함수 | 설명 |
|------|------|
| `COMM_Drv_IsPacketReady(void)` | 패킷 수신 완료 여부 |
| `COMM_Drv_GetPacket(uint8_t* buf, uint8_t maxLen)` | 패킷 복사, 플래그 클리어 |
| `COMM_Drv_GetRxPacketCount(void)` | 수신 패킷 카운터 |

**TX 인터페이스**:
```c
extern const COMM_TxOps_t UartTx1;
extern const COMM_TxOps_t UartTx2;
// UartTx2.Send(data, length);
```

### 3.4 CommandHandler

**파일**: `src/comm/command_handler.h`

| 함수 | 설명 |
|------|------|
| `CommandHandler_RegisterTarget(MotorData_t* target)` | DI: 대상 포인터 등록 |
| `CommandHandler_Dispatch(uint8_t cmdId)` | 명령 디스패치 |
| `CommandHandler_RegisterRxCallback(CommEvent_cb cb)` | RX 콜백 등록 |
| `CommandHandler_NotifyRx(void)` | RX 콜백 실행 |

### 3.5 Protocol

**파일**: `src/comm/protocol.h`, `src/comm/protocol.c`

| 함수/멤버 | 설명 |
|-----------|------|
| `Protocol.ValidatePacket()` | STX/ETX/길이 검증 |
| `Protocol.ParsePacket()` | ASCII-hex → CommandData_t |
| `Protocol.FormatResponse()` | CommandData_t → ASCII-hex TX |
| `Protocol.AsciiToHex()` | ASCII → hex 변환 |
| `Protocol_GetMotorOn()` | motor_on 비트 |
| `Protocol_GetDirection()` | direction 비트 |
| `Protocol_GetSpeed()` | speed 값 |
| `Protocol_SetPresentRpm(uint16_t)` | 현재 RPM (TX용) |

---

## 4. State Machine API

### 4.1 모터 상태

**파일**: `src/motor/motor_statemachine.h`

```c
typedef enum {
    MOTOR_STATE_STOPPED,
    MOTOR_STATE_STARTING,
    MOTOR_STATE_RUNNING,
    MOTOR_STATE_STOPPING,
    MOTOR_STATE_FAULT,
    MOTOR_STATE_COUNT
} MotorState_e;
```

### 4.2 함수

| 함수 | 설명 |
|------|------|
| `MotorStateMachine_Init(void)` | 상태머신 초기화 |
| `MotorStateMachine_Execute(void)` | 상태 핸들러 디스패치 (vMotorTask에서 호출) |
| `MotorStateMachine_GetState(void)` | 현재 상태 반환 |
| `MotorStateMachine_GetSetRPM(void)` | 구동 시 설정 RPM, 정지 시 -1 |

---

## 5. Speed API

### 5.1 함수

**파일**: `src/motor/motor_speed.h` 38~41행

| 함수 | 호출 위치 | 설명 |
|------|-----------|------|
| `Motor_Speed(void)` | vMotorTask | speed_command 변환, 하한 제한 |
| `update_speed_target(void)` | Timer2 콜백 | 50µs 속도 램프 |
| `update_speed_command_lowlimit(void)` | Motor_Speed 내부 | 하한 제한 |
| `SpeedRamp_50us_Callback(void)` | Timer2 콜백 | 램프 + X2C_VelRef 설정 |

### 5.2 상수

```c
#define SPEED_RAMP_ACCEL    2    // 가속: +2rpm/50us
#define SPEED_RAMP_DECEL    10   // 감속: -10rpm/50us
#define SPEED_STOP_LIMIT    200  // 정지 판정 (rpm)
```

### 5.3 전역 변수

```c
extern volatile int X2C_VelRef;  // Timer2 쓰기, ADC ISR 읽기
```

---

## 6. LED API

### 6.1 LedBlinker

**파일**: `src/ui/led_blinker.h`

```c
typedef struct {
    void (*Init)(void);
    void (*Update)(void);
    void (*SetStrategy)(const LED_BlinkStrategy_t*);
    void (*TimerISR)(void);
    void (*RegisterProvider)(StatusProvider_cb);
} LED_BlinkerInterface_t;

extern const LED_BlinkerInterface_t LedBlinker;
```

| 함수 | 설명 |
|------|------|
| `LedBlinker.Init()` | Singleton 초기화 |
| `LedBlinker.Update()` | 상태머신 실행 (vUITask) |
| `LedBlinker.SetStrategy()` | 점멸 패턴 변경 |
| `LedBlinker.TimerISR()` | 1ms 타이머 (SW Timer) |
| `LedBlinker.RegisterProvider()` | 상태 제공자 콜백 등록 |
| `LedBlinker_SetHwOps()` | HW 함수포인터 주입 |
| `LedBlinker_SetAutoStrategies()` | 정상/에러 전략 설정 |

### 6.2 LedMorse

**파일**: `src/ui/led_morse.h`

```c
typedef struct {
    void (*Init)(void);
    bool (*Update)(void);   // true=Morse 활성
    void (*TimerISR)(void);
    void (*RegisterProvider)(MorseValueProvider_cb);
} LED_MorseInterface_t;

extern const LED_MorseInterface_t LedMorse;
```

| 함수 | 설명 |
|------|------|
| `LedMorse.Init()` | 내부 상태 초기화 |
| `LedMorse.Update()` | Morse 상태머신 (true=LED 점유) |
| `LedMorse.TimerISR()` | 1ms 타이머 |
| `LedMorse.RegisterProvider()` | 값 제공 콜백 (RPM 등) |
| `LedMorse_SetHwOps()` | HW 함수포인터 주입 |

### 6.3 LedBlinker_Drv

**파일**: `src/ui/led_blinker_drv.h`

| 함수 | 설명 |
|------|------|
| `LedBlinker_Drv_Init(void)` | HW ops + 전략 초기화 |
| `LedBlinker_Drv_GetHwOps()` | HW 함수포인터 반환 |

---

## API 호출 관계 요약

```
main()
  ├── Communication_Setup() → UART2_Drv, CommandHandler_RegisterTarget
  ├── LED_Setup() → LedBlinker_SetHwOps, LedBlinker.Init, LedMorse.Init
  ├── Timer2_Setup() → Timer2_RegisterCallback(SpeedRamp_50us_Callback)
  ├── MotorStateMachine_Init()
  ├── MotorControl.Reset()
  └── vTaskStartScheduler()

vMotorTask (1ms)
  ├── BoardService()
  ├── MotorStateMachine_Execute()
  ├── Protocol_SetPresentRpm()
  └── vTaskDelayUntil(1ms)

vCommTask (10ms)
  └── communication()

vUITask (10ms)
  ├── DiagnosticsStepMain()
  ├── LedMorse.Update()
  └── LedBlinker.Update()

ADC ISR (20kHz)
  ├── MotorControl.Execute()  → DoControl
  ├── MotorControl.CalcAngle()
  └── PWMDutyCycleSet()

Timer2 ISR (50µs)
  └── SpeedRamp_50us_Callback() → X2C_VelRef 설정
```

---

**이전**: [← Chapter 7: 처음 적용 시 시작 가이드](07_getting_started.md)  
**다음**: [Chapter 9: PID 튜닝 가이드 →](09_PID_tuning_guide.md)  
**목차**: [README](README.md)
