/*******************************************************************************
 * ring_buffer.c - 범용 링 버퍼 (Ring Buffer)
 *
 * 기능:
 *   - RingBuffer_Init():    버퍼 초기화
 *   - RingBuffer_Put():     데이터 1바이트 삽입 (ISR에서 호출 가능)
 *   - RingBuffer_Get():     데이터 1바이트 추출 (메인루프에서 호출)
 *   - RingBuffer_Peek():    데이터 확인 (추출하지 않음)
 *   - RingBuffer_Count():   저장된 데이터 수 반환
 *   - RingBuffer_IsEmpty(): 빈 상태 확인
 *   - RingBuffer_IsFull():  꽉 찬 상태 확인
 *   - RingBuffer_Flush():   버퍼 비우기
 *
 * ISR 안전성:
 *   - Put은 head만 수정, Get은 tail만 수정 → 단일 생산자/소비자 안전
 *   - count는 volatile로 선언되어 ISR/메인루프 간 동기화
 ******************************************************************************/
#include "ring_buffer.h"

/*=============================================================================
 * RingBuffer_Init - 링 버퍼 초기화
 *===========================================================================*/
void RingBuffer_Init(RingBuffer_t* rb)
{
    rb->head  = 0;
    rb->tail  = 0;
    rb->count = 0;
}

/*=============================================================================
 * RingBuffer_Put - 데이터 1바이트 삽입
 * 반환: true=성공, false=버퍼 가득 참
 *===========================================================================*/
bool RingBuffer_Put(RingBuffer_t* rb, uint8_t data)
{
    if (rb->count >= RING_BUFFER_SIZE)
    {
        return false;   /* 버퍼 오버플로우 */
    }

    rb->buffer[rb->head] = data;
    rb->head++;
    if (rb->head >= RING_BUFFER_SIZE)
    {
        rb->head = 0;   /* 순환 */
    }
    rb->count++;

    return true;
}

/*=============================================================================
 * RingBuffer_Get - 데이터 1바이트 추출
 * 반환: true=성공, false=버퍼 비어있음
 *===========================================================================*/
bool RingBuffer_Get(RingBuffer_t* rb, uint8_t* data)
{
    if (rb->count == 0)
    {
        return false;   /* 버퍼 비어있음 */
    }

    *data = rb->buffer[rb->tail];
    rb->tail++;
    if (rb->tail >= RING_BUFFER_SIZE)
    {
        rb->tail = 0;   /* 순환 */
    }
    rb->count--;

    return true;
}

/*=============================================================================
 * RingBuffer_Peek - 데이터 확인 (추출하지 않음)
 * 반환: true=데이터 있음, false=비어있음
 *===========================================================================*/
bool RingBuffer_Peek(const RingBuffer_t* rb, uint8_t* data)
{
    if (rb->count == 0)
    {
        return false;
    }

    *data = rb->buffer[rb->tail];
    return true;
}

/*=============================================================================
 * RingBuffer_Count - 저장된 데이터 수 반환
 *===========================================================================*/
uint16_t RingBuffer_Count(const RingBuffer_t* rb)
{
    return rb->count;
}

/*=============================================================================
 * RingBuffer_IsEmpty - 빈 상태 확인
 *===========================================================================*/
bool RingBuffer_IsEmpty(const RingBuffer_t* rb)
{
    return (rb->count == 0);
}

/*=============================================================================
 * RingBuffer_IsFull - 꽉 찬 상태 확인
 *===========================================================================*/
bool RingBuffer_IsFull(const RingBuffer_t* rb)
{
    return (rb->count >= RING_BUFFER_SIZE);
}

/*=============================================================================
 * RingBuffer_Flush - 버퍼 비우기
 *===========================================================================*/
void RingBuffer_Flush(RingBuffer_t* rb)
{
    rb->head  = 0;
    rb->tail  = 0;
    rb->count = 0;
}
