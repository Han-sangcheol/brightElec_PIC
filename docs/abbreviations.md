# 프로젝트 줄임말 사전 (Abbreviations)

프로젝트 코드에서 사용되는 줄임말과 원래 단어 목록.
선언부에 인라인 주석으로도 표기되어 있음.

---

## 공통

| 줄임말 | 원래 단어 | 설명 |
|--------|-----------|------|
| ctx | Context | 모듈 내부 상태를 담는 구조체 인스턴스 |
| Ops | Operations | 함수포인터 묶음 (동작 집합) |
| HW | Hardware | 하드웨어 관련 |
| SW | Software | 소프트웨어 관련 |
| Drv / drv | Driver | 하드웨어 드라이버 |
| cfg | Configuration | 설정/구성 |
| cb | Callback | 콜백 함수포인터 |
| Impl | Implementation | 내부 구현 함수 (외부 인터페이스와 구분) |
| ISR | Interrupt Service Routine | 인터럽트 서비스 루틴 |
| err | Error | 에러 |

## 통신 (Communication)

| 줄임말 | 원래 단어 | 설명 |
|--------|-----------|------|
| rx | Receive | 수신 |
| tx | Transmit | 송신 |
| cmd | Command | 명령 |
| buf | Buffer | 버퍼 (데이터 임시 저장) |
| len | Length | 길이 |
| idx | Index | 인덱스 (배열 위치) |
| rb | Ring Buffer | 링 버퍼 (순환 큐) |
| STX | Start of Text | 패킷 시작 문자 (0x40) |
| ETX | End of Text | 패킷 종료 문자 (0x2A) |
| FW | Firmware | 펌웨어 |
| st | Static (prefix) | 정적 변수 접두사 |

## 모터 제어 (Motor Control)

| 줄임말 | 원래 단어 | 설명 |
|--------|-----------|------|
| bemf | Back EMF | 역기전력 (Back Electromotive Force) |
| flt | Filtered | 필터링된 값 |
| CNT | Count | 카운터 |
| CW | Clockwise | 시계 방향 |
| CCW | Counter-Clockwise | 반시계 방향 |
| Id | d-axis current | d축 전류 (FOC) |
| Iq | q-axis current | q축 전류 (FOC) |
| DQ | Direct-Quadrature | 직교 좌표계 (FOC) |

## 단위

| 줄임말 | 원래 단어 | 설명 |
|--------|-----------|------|
| MS / ms | Milliseconds | 밀리초 |

## typedef 접미사 규칙 (Barr Group 기반)

이름만으로 타입 종류를 유추할 수 있도록 접미사를 구분한다.

| 접미사 | 의미 | 용도 | 예시 |
|--------|------|------|------|
| `_t` | type (struct/union) | 구조체, 공용체 타입 | `LED_HW_Ops_t`, `MotorData_t`, `LED_BlinkerInterface_t` |
| `_e` | enum | 열거형 타입 | `LED_State_e`, `MorseState_e`, `MotorState_e` |
| `_fn` | function pointer | 내부 디스패치용 함수포인터 (모듈이 소유) | `LED_StateHandler_fn`, `StateHandler_fn`, `CommandHandler_fn` |
| `_cb` | callback | 외부 등록 콜백 함수포인터 (호출자가 제공) | `StatusProvider_cb`, `CommEvent_cb`, `Timer2_cb` |

### `_fn` vs `_cb` 구분 기준: 누가 함수를 제공하는가?

- `_fn`: 모듈 자신이 내부에서 배열/테이블로 관리 (상태머신 핸들러, 명령 디스패치 테이블)
- `_cb`: 외부 Application이 `Register()` / `Set()`으로 등록 (이벤트 콜백, 값 제공자)

### 기타 접두사

| 접두사 | 의미 | 설명 |
|--------|------|------|
| g_ | global | 전역 변수 접두사 |
| st | static | 정적 변수 접두사 |

## 파일 접미사

| 접미사 | 의미 | 예시 |
|--------|------|------|
| _drv | Driver (하드웨어) | led_blinker_drv.c |
| _cfg | Configuration (설정) | led_blinker_cfg.c |
| (없음) | Core (핵심 로직) | led_blinker.c |
