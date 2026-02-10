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

## 단위/타입

| 줄임말 | 원래 단어 | 설명 |
|--------|-----------|------|
| MS / ms | Milliseconds | 밀리초 |
| _t | type | typedef 접미사 (C 관용) |
| _e | enum | 열거형 접미사 |
| g_ | global | 전역 변수 접두사 |

## 파일 접미사

| 접미사 | 의미 | 예시 |
|--------|------|------|
| _drv | Driver (하드웨어) | led_blinker_drv.c |
| _cfg | Configuration (설정) | led_blinker_cfg.c |
| (없음) | Core (핵심 로직) | led_blinker.c |
