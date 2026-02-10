/*******************************************************************************
 * ring_buffer.h - 범용 링 버퍼 (Ring Buffer)
 *
 * 기능:
 *   - ISR-safe 순환 버퍼 구현
 *   - Put/Get/Peek/Count/Flush 인터페이스
 *   - UART RX 등 인터럽트 환경에서 안전한 데이터 큐잉
 *
 * 사용 패턴:
 *   RingBuffer_t rb;
 *   RingBuffer_Init(&rb);
 *   RingBuffer_Put(&rb, data);     // ISR에서 호출
 *   RingBuffer_Get(&rb, &data);    // 메인루프에서 호출
 ******************************************************************************/
#ifndef RING_BUFFER_H
#define RING_BUFFER_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/* 링 버퍼 크기 (2의 거듭제곱 권장) */
#define RING_BUFFER_SIZE    256

/* 링 버퍼 구조체 */
typedef struct {
    uint8_t  buffer[RING_BUFFER_SIZE];  /* 데이터 저장 배열 */
    volatile uint16_t head;              /* 쓰기 위치 (ISR에서 증가) */
    volatile uint16_t tail;              /* 읽기 위치 (메인루프에서 증가) */
    volatile uint16_t count;             /* 현재 저장된 데이터 수 */
} RingBuffer_t;

/* 함수 프로토타입 */
void     RingBuffer_Init(RingBuffer_t* rb);                     /* rb = Ring Buffer */
bool     RingBuffer_Put(RingBuffer_t* rb, uint8_t data);
bool     RingBuffer_Get(RingBuffer_t* rb, uint8_t* data);
bool     RingBuffer_Peek(const RingBuffer_t* rb, uint8_t* data);
uint16_t RingBuffer_Count(const RingBuffer_t* rb);
bool     RingBuffer_IsEmpty(const RingBuffer_t* rb);
bool     RingBuffer_IsFull(const RingBuffer_t* rb);
void     RingBuffer_Flush(RingBuffer_t* rb);

#ifdef __cplusplus
}
#endif

#endif /* RING_BUFFER_H */
