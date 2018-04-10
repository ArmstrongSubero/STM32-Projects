queue_ucPortCountLeadingZeros:
;portmacro.h,176 :: 		static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
;portmacro.h,178 :: 		asm CLZ R0, R0;
CLZ	R0, R0
;portmacro.h,179 :: 		return R0;
UXTB	R0, R0
;portmacro.h,180 :: 		}
L_end_ucPortCountLeadingZeros:
BX	LR
; end of queue_ucPortCountLeadingZeros
queue_xPortIsInsideInterrupt:
;portmacro.h,218 :: 		portFORCE_INLINE static BaseType_t xPortIsInsideInterrupt( void )
SUB	SP, SP, #8
;portmacro.h,224 :: 		ulCurrentInterrupt = CPU_REG_GET(CPU_IPSR);
MRS	R12, #5
MOV	R0, R12
STR	R0, [SP, #0]
;portmacro.h,226 :: 		if( ulCurrentInterrupt == 0 )
LDR	R0, [SP, #0]
CMP	R0, #0
IT	NE
BNE	L_queue_xPortIsInsideInterrupt0
;portmacro.h,228 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;portmacro.h,229 :: 		}
IT	AL
BAL	L_queue_xPortIsInsideInterrupt1
L_queue_xPortIsInsideInterrupt0:
;portmacro.h,232 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;portmacro.h,233 :: 		}
L_queue_xPortIsInsideInterrupt1:
;portmacro.h,235 :: 		return xReturn;
LDR	R0, [SP, #4]
;portmacro.h,236 :: 		}
L_end_xPortIsInsideInterrupt:
ADD	SP, SP, #8
BX	LR
; end of queue_xPortIsInsideInterrupt
queue_vPortRaiseBASEPRI:
;portmacro.h,239 :: 		portFORCE_INLINE static void vPortRaiseBASEPRI( void )
SUB	SP, SP, #4
;portmacro.h,243 :: 		ulNewBASEPRI = configMAX_SYSCALL_INTERRUPT_PRIORITY;
MOVS	R0, #16
STR	R0, [SP, #0]
;portmacro.h,244 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewBASEPRI);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,246 :: 		asm ISB;
ISB	#15
;portmacro.h,247 :: 		asm DSB;
DSB	#15
;portmacro.h,248 :: 		}
L_end_vPortRaiseBASEPRI:
ADD	SP, SP, #4
BX	LR
; end of queue_vPortRaiseBASEPRI
queue_ulPortRaiseBASEPRI:
;portmacro.h,251 :: 		portFORCE_INLINE static uint32_t ulPortRaiseBASEPRI( void )
SUB	SP, SP, #8
;portmacro.h,255 :: 		ulOriginalBASEPRI = CPU_REG_GET(CPU_BASEPRI);
MRS	R12, #17
MOV	R0, R12
STR	R0, [SP, #0]
;portmacro.h,256 :: 		ulNewBASEPRI = configMAX_SYSCALL_INTERRUPT_PRIORITY;
MOVS	R0, #16
STR	R0, [SP, #4]
;portmacro.h,257 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewBASEPRI);
LDR	R0, [SP, #4]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,259 :: 		asm ISB;
ISB	#15
;portmacro.h,260 :: 		asm DSB;
DSB	#15
;portmacro.h,264 :: 		return ulOriginalBASEPRI;
LDR	R0, [SP, #0]
;portmacro.h,265 :: 		}
L_end_ulPortRaiseBASEPRI:
ADD	SP, SP, #8
BX	LR
; end of queue_ulPortRaiseBASEPRI
queue_vPortSetBASEPRI:
;portmacro.h,268 :: 		portFORCE_INLINE static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
;portmacro.h,270 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,271 :: 		}
L_end_vPortSetBASEPRI:
BX	LR
; end of queue_vPortSetBASEPRI
_xQueueGenericReset:
;queue.c,279 :: 		BaseType_t xQueueGenericReset( QueueHandle_t xQueue, BaseType_t xNewQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,281 :: 		Queue_t * const pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #8]
STR	R0, [SP, #4]
;queue.c,283 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReset2
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericReset3:
IT	AL
BAL	L_xQueueGenericReset3
L_xQueueGenericReset2:
;queue.c,285 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,287 :: 		pxQueue->pcTail = pxQueue->pcHead + ( pxQueue->uxLength * pxQueue->uxItemSize );
LDR	R0, [SP, #4]
ADDS	R3, R0, #4
LDR	R0, [SP, #4]
LDR	R2, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, #60
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, #64
LDR	R0, [R0, #0]
MULS	R0, R1, R0
ADDS	R0, R2, R0
STR	R0, [R3, #0]
;queue.c,288 :: 		pxQueue->uxMessagesWaiting = ( UBaseType_t ) 0U;
LDR	R0, [SP, #4]
ADDW	R1, R0, #56
MOV	R0, #0
STR	R0, [R1, #0]
;queue.c,289 :: 		pxQueue->pcWriteTo = pxQueue->pcHead;
LDR	R0, [SP, #4]
ADDW	R1, R0, #8
LDR	R0, [SP, #4]
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;queue.c,290 :: 		pxQueue->u.pcReadFrom = pxQueue->pcHead + ( ( pxQueue->uxLength - ( UBaseType_t ) 1U ) * pxQueue->uxItemSize );
LDR	R0, [SP, #4]
ADDS	R0, #12
MOV	R3, R0
LDR	R0, [SP, #4]
LDR	R2, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, #60
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
LDR	R0, [SP, #4]
ADDS	R0, #64
LDR	R0, [R0, #0]
MULS	R0, R1, R0
ADDS	R0, R2, R0
STR	R0, [R3, #0]
;queue.c,291 :: 		pxQueue->cRxLock = queueUNLOCKED;
LDR	R0, [SP, #4]
ADDW	R1, R0, #68
MOVS	R0, #-1
SXTB	R0, R0
STRB	R0, [R1, #0]
;queue.c,292 :: 		pxQueue->cTxLock = queueUNLOCKED;
LDR	R0, [SP, #4]
ADDW	R1, R0, #69
MOVS	R0, #-1
SXTB	R0, R0
STRB	R0, [R1, #0]
;queue.c,294 :: 		if( xNewQueue == pdFALSE )
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReset5
;queue.c,301 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
LDR	R0, [SP, #4]
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericReset261
MOVS	R0, #1
L__xQueueGenericReset261:
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReset6
;queue.c,303 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
LDR	R0, [SP, #4]
ADDS	R0, #16
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericReset7
;queue.c,305 :: 		queueYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;queue.c,306 :: 		}
IT	AL
BAL	L_xQueueGenericReset8
L_xQueueGenericReset7:
;queue.c,310 :: 		}
L_xQueueGenericReset8:
;queue.c,311 :: 		}
IT	AL
BAL	L_xQueueGenericReset9
L_xQueueGenericReset6:
;queue.c,315 :: 		}
L_xQueueGenericReset9:
;queue.c,316 :: 		}
IT	AL
BAL	L_xQueueGenericReset10
L_xQueueGenericReset5:
;queue.c,320 :: 		vListInitialise( &( pxQueue->xTasksWaitingToSend ) );
LDR	R0, [SP, #4]
ADDS	R0, #16
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;queue.c,321 :: 		vListInitialise( &( pxQueue->xTasksWaitingToReceive ) );
LDR	R0, [SP, #4]
ADDS	R0, #36
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;queue.c,322 :: 		}
L_xQueueGenericReset10:
;queue.c,324 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,328 :: 		return pdPASS;
MOV	R0, #1
;queue.c,329 :: 		}
L_end_xQueueGenericReset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _xQueueGenericReset
_xQueueGenericCreate:
;queue.c,386 :: 		QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, const uint8_t ucQueueType )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;queue.c,392 :: 		configASSERT( uxQueueLength > ( UBaseType_t ) 0 );
LDR	R0, [SP, #16]
CMP	R0, #0
MOVW	R0, #0
BLS	L__xQueueGenericCreate263
MOVS	R0, #1
L__xQueueGenericCreate263:
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericCreate11
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericCreate12:
IT	AL
BAL	L_xQueueGenericCreate12
L_xQueueGenericCreate11:
;queue.c,394 :: 		if( uxItemSize == ( UBaseType_t ) 0 )
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericCreate14
;queue.c,397 :: 		xQueueSizeInBytes = ( size_t ) 0;
MOV	R0, #0
STR	R0, [SP, #8]
;queue.c,398 :: 		}
IT	AL
BAL	L_xQueueGenericCreate15
L_xQueueGenericCreate14:
;queue.c,403 :: 		xQueueSizeInBytes = ( size_t ) ( uxQueueLength * uxItemSize ); /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
LDR	R1, [SP, #20]
LDR	R0, [SP, #16]
MULS	R0, R1, R0
STR	R0, [SP, #8]
;queue.c,404 :: 		}
L_xQueueGenericCreate15:
;queue.c,406 :: 		pxNewQueue = ( Queue_t * ) pvPortMalloc( sizeof( Queue_t ) + xQueueSizeInBytes );
LDR	R0, [SP, #8]
ADDS	R0, #72
PUSH	(R0)
BL	_pvPortMalloc+0
ADD	SP, SP, #4
STR	R0, [SP, #4]
;queue.c,408 :: 		if( pxNewQueue != NULL )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericCreate16
;queue.c,412 :: 		pucQueueStorage = ( ( uint8_t * ) pxNewQueue ) + sizeof( Queue_t );
LDR	R0, [SP, #4]
ADDS	R0, #72
STR	R0, [SP, #12]
;queue.c,423 :: 		prvInitialiseNewQueue( uxQueueLength, uxItemSize, pucQueueStorage, ucQueueType, pxNewQueue );
LDR	R0, [SP, #4]
PUSH	(R0)
LDRB	R0, [SP, #28]
PUSH	(R0)
LDR	R0, [SP, #20]
PUSH	(R0)
LDR	R0, [SP, #32]
PUSH	(R0)
LDR	R0, [SP, #32]
PUSH	(R0)
BL	queue_prvInitialiseNewQueue+0
ADD	SP, SP, #20
;queue.c,424 :: 		}
L_xQueueGenericCreate16:
;queue.c,426 :: 		return pxNewQueue;
LDR	R0, [SP, #4]
;queue.c,427 :: 		}
L_end_xQueueGenericCreate:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xQueueGenericCreate
queue_prvInitialiseNewQueue:
;queue.c,432 :: 		static void prvInitialiseNewQueue( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, uint8_t *pucQueueStorage, const uint8_t ucQueueType, Queue_t *pxNewQueue )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;queue.c,438 :: 		if( uxItemSize == ( UBaseType_t ) 0 )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_queue_prvInitialiseNewQueue17
;queue.c,444 :: 		pxNewQueue->pcHead = ( int8_t * ) pxNewQueue;
LDR	R0, [SP, #20]
MOV	R1, R0
LDR	R0, [SP, #20]
STR	R0, [R1, #0]
;queue.c,445 :: 		}
IT	AL
BAL	L_queue_prvInitialiseNewQueue18
L_queue_prvInitialiseNewQueue17:
;queue.c,449 :: 		pxNewQueue->pcHead = ( int8_t * ) pucQueueStorage;
LDR	R0, [SP, #20]
MOV	R1, R0
LDR	R0, [SP, #12]
STR	R0, [R1, #0]
;queue.c,450 :: 		}
L_queue_prvInitialiseNewQueue18:
;queue.c,454 :: 		pxNewQueue->uxLength = uxQueueLength;
LDR	R0, [SP, #20]
ADDW	R1, R0, #60
LDR	R0, [SP, #4]
STR	R0, [R1, #0]
;queue.c,455 :: 		pxNewQueue->uxItemSize = uxItemSize;
LDR	R0, [SP, #20]
ADDW	R1, R0, #64
LDR	R0, [SP, #8]
STR	R0, [R1, #0]
;queue.c,456 :: 		( void ) xQueueGenericReset( pxNewQueue, pdTRUE );
MOV	R0, #1
PUSH	(R0)
LDR	R0, [SP, #24]
PUSH	(R0)
BL	_xQueueGenericReset+0
ADD	SP, SP, #8
;queue.c,471 :: 		}
L_end_prvInitialiseNewQueue:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of queue_prvInitialiseNewQueue
queue_prvInitialiseMutex:
;queue.c,476 :: 		static void prvInitialiseMutex( Queue_t *pxNewQueue )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;queue.c,478 :: 		if( pxNewQueue != NULL )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_queue_prvInitialiseMutex19
;queue.c,484 :: 		pxNewQueue->pxMutexHolder = NULL;
LDR	R0, [SP, #4]
ADDS	R1, R0, #4
MOVS	R0, #0
STR	R0, [R1, #0]
;queue.c,485 :: 		pxNewQueue->uxQueueType = queueQUEUE_IS_MUTEX;
LDR	R0, [SP, #4]
MOV	R1, R0
MOVS	R0, #0
STR	R0, [R1, #0]
;queue.c,488 :: 		pxNewQueue->u.uxRecursiveCallCount = 0;
LDR	R0, [SP, #4]
ADDS	R0, #12
MOV	R1, R0
MOVS	R0, #0
STR	R0, [R1, #0]
;queue.c,493 :: 		( void ) xQueueGenericSend( pxNewQueue, NULL, ( TickType_t ) 0U, queueSEND_TO_BACK );
MOV	R0, #0
PUSH	(R0)
MOV	R0, #0
PUSH	(R0)
MOVS	R0, #0
PUSH	(R0)
LDR	R0, [SP, #16]
PUSH	(R0)
BL	_xQueueGenericSend+0
ADD	SP, SP, #16
;queue.c,494 :: 		}
IT	AL
BAL	L_queue_prvInitialiseMutex20
L_queue_prvInitialiseMutex19:
;queue.c,498 :: 		}
L_queue_prvInitialiseMutex20:
;queue.c,499 :: 		}
L_end_prvInitialiseMutex:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of queue_prvInitialiseMutex
_xQueueCreateMutex:
;queue.c,506 :: 		QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,511 :: 		pxNewQueue = ( Queue_t * ) xQueueGenericCreate( uxMutexLength, uxMutexSize, ucQueueType );
LDRB	R0, [SP, #8]
PUSH	(R0)
MOV	R0, #0
PUSH	(R0)
MOV	R0, #1
PUSH	(R0)
BL	_xQueueGenericCreate+0
ADD	SP, SP, #12
STR	R0, [SP, #4]
;queue.c,512 :: 		prvInitialiseMutex( pxNewQueue );
LDR	R0, [SP, #4]
PUSH	(R0)
BL	queue_prvInitialiseMutex+0
ADD	SP, SP, #4
;queue.c,514 :: 		return pxNewQueue;
LDR	R0, [SP, #4]
;queue.c,515 :: 		}
L_end_xQueueCreateMutex:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _xQueueCreateMutex
_xQueueGiveMutexRecursive:
;queue.c,572 :: 		BaseType_t xQueueGiveMutexRecursive( QueueHandle_t xMutex )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;queue.c,575 :: 		Queue_t * const pxMutex = ( Queue_t * ) xMutex;
LDR	R0, [SP, #16]
STR	R0, [SP, #8]
;queue.c,577 :: 		configASSERT( pxMutex );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_xQueueGiveMutexRecursive21
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGiveMutexRecursive22:
IT	AL
BAL	L_xQueueGiveMutexRecursive22
L_xQueueGiveMutexRecursive21:
;queue.c,585 :: 		if( pxMutex->pxMutexHolder == ( void * ) xTaskGetCurrentTaskHandle() ) /*lint !e961 Not a redundant cast as TaskHandle_t is a typedef. */
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
BL	_xTaskGetCurrentTaskHandle+0
MOV	R1, R0
LDR	R0, [SP, #12]
CMP	R0, R1
IT	NE
BNE	L_xQueueGiveMutexRecursive24
;queue.c,594 :: 		( pxMutex->u.uxRecursiveCallCount )--;
LDR	R0, [SP, #8]
ADDS	R0, #12
MOV	R1, R0
LDR	R0, [R1, #0]
SUBS	R0, R0, #1
STR	R0, [R1, #0]
;queue.c,597 :: 		if( pxMutex->u.uxRecursiveCallCount == ( UBaseType_t ) 0 )
LDR	R0, [SP, #8]
ADDS	R0, #12
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xQueueGiveMutexRecursive25
;queue.c,601 :: 		( void ) xQueueGenericSend( pxMutex, NULL, queueMUTEX_GIVE_BLOCK_TIME, queueSEND_TO_BACK );
MOV	R0, #0
PUSH	(R0)
MOV	R0, #0
PUSH	(R0)
MOVS	R0, #0
PUSH	(R0)
LDR	R0, [SP, #20]
PUSH	(R0)
BL	_xQueueGenericSend+0
ADD	SP, SP, #16
;queue.c,602 :: 		}
IT	AL
BAL	L_xQueueGiveMutexRecursive26
L_xQueueGiveMutexRecursive25:
;queue.c,606 :: 		}
L_xQueueGiveMutexRecursive26:
;queue.c,608 :: 		xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #4]
;queue.c,609 :: 		}
IT	AL
BAL	L_xQueueGiveMutexRecursive27
L_xQueueGiveMutexRecursive24:
;queue.c,614 :: 		xReturn = pdFAIL;
MOV	R0, #0
STR	R0, [SP, #4]
;queue.c,617 :: 		}
L_xQueueGiveMutexRecursive27:
;queue.c,619 :: 		return xReturn;
LDR	R0, [SP, #4]
;queue.c,620 :: 		}
L_end_xQueueGiveMutexRecursive:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xQueueGiveMutexRecursive
_xQueueTakeMutexRecursive:
;queue.c,627 :: 		BaseType_t xQueueTakeMutexRecursive( QueueHandle_t xMutex, TickType_t xTicksToWait )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;queue.c,630 :: 		Queue_t * const pxMutex = ( Queue_t * ) xMutex;
LDR	R0, [SP, #16]
STR	R0, [SP, #8]
;queue.c,632 :: 		configASSERT( pxMutex );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_xQueueTakeMutexRecursive28
BL	queue_vPortRaiseBASEPRI+0
L_xQueueTakeMutexRecursive29:
IT	AL
BAL	L_xQueueTakeMutexRecursive29
L_xQueueTakeMutexRecursive28:
;queue.c,639 :: 		if( pxMutex->pxMutexHolder == ( void * ) xTaskGetCurrentTaskHandle() ) /*lint !e961 Cast is not redundant as TaskHandle_t is a typedef. */
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
BL	_xTaskGetCurrentTaskHandle+0
MOV	R1, R0
LDR	R0, [SP, #12]
CMP	R0, R1
IT	NE
BNE	L_xQueueTakeMutexRecursive31
;queue.c,641 :: 		( pxMutex->u.uxRecursiveCallCount )++;
LDR	R0, [SP, #8]
ADDS	R0, #12
MOV	R1, R0
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;queue.c,642 :: 		xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #4]
;queue.c,643 :: 		}
IT	AL
BAL	L_xQueueTakeMutexRecursive32
L_xQueueTakeMutexRecursive31:
;queue.c,646 :: 		xReturn = xQueueGenericReceive( pxMutex, NULL, xTicksToWait, pdFALSE );
MOV	R0, #0
PUSH	(R0)
LDR	R0, [SP, #24]
PUSH	(R0)
MOVS	R0, #0
PUSH	(R0)
LDR	R0, [SP, #20]
PUSH	(R0)
BL	_xQueueGenericReceive+0
ADD	SP, SP, #16
STR	R0, [SP, #4]
;queue.c,651 :: 		if( xReturn != pdFAIL )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueTakeMutexRecursive33
;queue.c,653 :: 		( pxMutex->u.uxRecursiveCallCount )++;
LDR	R0, [SP, #8]
ADDS	R0, #12
MOV	R1, R0
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;queue.c,654 :: 		}
IT	AL
BAL	L_xQueueTakeMutexRecursive34
L_xQueueTakeMutexRecursive33:
;queue.c,658 :: 		}
L_xQueueTakeMutexRecursive34:
;queue.c,659 :: 		}
L_xQueueTakeMutexRecursive32:
;queue.c,661 :: 		return xReturn;
LDR	R0, [SP, #4]
;queue.c,662 :: 		}
L_end_xQueueTakeMutexRecursive:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xQueueTakeMutexRecursive
_xQueueCreateCountingSemaphore:
;queue.c,697 :: 		QueueHandle_t xQueueCreateCountingSemaphore( const UBaseType_t uxMaxCount, const UBaseType_t uxInitialCount )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,701 :: 		configASSERT( uxMaxCount != 0 );
LDR	R0, [SP, #8]
CMP	R0, #0
MOVW	R0, #0
BEQ	L__xQueueCreateCountingSemaphore270
MOVS	R0, #1
L__xQueueCreateCountingSemaphore270:
CMP	R0, #0
IT	NE
BNE	L_xQueueCreateCountingSemaphore35
BL	queue_vPortRaiseBASEPRI+0
L_xQueueCreateCountingSemaphore36:
IT	AL
BAL	L_xQueueCreateCountingSemaphore36
L_xQueueCreateCountingSemaphore35:
;queue.c,702 :: 		configASSERT( uxInitialCount <= uxMaxCount );
LDR	R1, [SP, #8]
LDR	R0, [SP, #12]
CMP	R0, R1
MOVW	R0, #0
BHI	L__xQueueCreateCountingSemaphore271
MOVS	R0, #1
L__xQueueCreateCountingSemaphore271:
CMP	R0, #0
IT	NE
BNE	L_xQueueCreateCountingSemaphore38
BL	queue_vPortRaiseBASEPRI+0
L_xQueueCreateCountingSemaphore39:
IT	AL
BAL	L_xQueueCreateCountingSemaphore39
L_xQueueCreateCountingSemaphore38:
;queue.c,704 :: 		xHandle = xQueueGenericCreate( uxMaxCount, queueSEMAPHORE_QUEUE_ITEM_LENGTH, queueQUEUE_TYPE_COUNTING_SEMAPHORE );
MOVS	R0, #2
PUSH	(R0)
MOV	R0, #0
PUSH	(R0)
LDR	R0, [SP, #16]
PUSH	(R0)
BL	_xQueueGenericCreate+0
ADD	SP, SP, #12
STR	R0, [SP, #4]
;queue.c,706 :: 		if( xHandle != NULL )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueCreateCountingSemaphore41
;queue.c,708 :: 		( ( Queue_t * ) xHandle )->uxMessagesWaiting = uxInitialCount;
LDR	R0, [SP, #4]
ADDW	R1, R0, #56
LDR	R0, [SP, #12]
STR	R0, [R1, #0]
;queue.c,711 :: 		}
IT	AL
BAL	L_xQueueCreateCountingSemaphore42
L_xQueueCreateCountingSemaphore41:
;queue.c,715 :: 		}
L_xQueueCreateCountingSemaphore42:
;queue.c,717 :: 		return xHandle;
LDR	R0, [SP, #4]
;queue.c,718 :: 		}
L_end_xQueueCreateCountingSemaphore:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _xQueueCreateCountingSemaphore
_xQueueGenericSend:
;queue.c,723 :: 		BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void * const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition )
SUB	SP, SP, #24
STR	LR, [SP, #0]
;queue.c,725 :: 		BaseType_t xEntryTimeSet = pdFALSE, xYieldRequired;
MOV	R0, #0
STR	R0, [SP, #20]
;queue.c,727 :: 		Queue_t * const pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #24]
STR	R0, [SP, #16]
;queue.c,729 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend43
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericSend44:
IT	AL
BAL	L_xQueueGenericSend44
L_xQueueGenericSend43:
;queue.c,730 :: 		configASSERT( !( ( pvItemToQueue == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
LDR	R0, [SP, #28]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend47
LDR	R0, [SP, #16]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericSend47
MOVS	R0, #1
IT	AL
BAL	L_xQueueGenericSend46
L_xQueueGenericSend47:
MOVS	R0, #0
L_xQueueGenericSend46:
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericSend273
MOVS	R0, #1
L__xQueueGenericSend273:
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend48
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericSend49:
IT	AL
BAL	L_xQueueGenericSend49
L_xQueueGenericSend48:
;queue.c,731 :: 		configASSERT( !( ( xCopyPosition == queueOVERWRITE ) && ( pxQueue->uxLength != 1 ) ) );
LDR	R0, [SP, #36]
CMP	R0, #2
IT	NE
BNE	L_xQueueGenericSend52
LDR	R0, [SP, #16]
ADDS	R0, #60
LDR	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_xQueueGenericSend52
MOVS	R0, #1
IT	AL
BAL	L_xQueueGenericSend51
L_xQueueGenericSend52:
MOVS	R0, #0
L_xQueueGenericSend51:
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericSend274
MOVS	R0, #1
L__xQueueGenericSend274:
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend53
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericSend54:
IT	AL
BAL	L_xQueueGenericSend54
L_xQueueGenericSend53:
;queue.c,742 :: 		for( ;; )
L_xQueueGenericSend56:
;queue.c,744 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,750 :: 		if( ( pxQueue->uxMessagesWaiting < pxQueue->uxLength ) || ( xCopyPosition == queueOVERWRITE ) )
LDR	R0, [SP, #16]
ADDS	R0, #56
LDR	R1, [R0, #0]
LDR	R0, [SP, #16]
ADDS	R0, #60
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CC
BCC	L__xQueueGenericSend253
LDR	R0, [SP, #36]
CMP	R0, #2
IT	EQ
BEQ	L__xQueueGenericSend253
IT	AL
BAL	L_xQueueGenericSend61
L__xQueueGenericSend253:
;queue.c,753 :: 		xYieldRequired = prvCopyDataToQueue( pxQueue, pvItemToQueue, xCopyPosition );
LDR	R0, [SP, #36]
PUSH	(R0)
LDR	R0, [SP, #32]
PUSH	(R0)
LDR	R0, [SP, #24]
PUSH	(R0)
BL	queue_prvCopyDataToQueue+0
ADD	SP, SP, #12
STR	R0, [SP, #4]
;queue.c,808 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
LDR	R0, [SP, #16]
ADDS	R0, #36
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericSend275
MOVS	R0, #1
L__xQueueGenericSend275:
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend62
;queue.c,810 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
LDR	R0, [SP, #16]
ADDS	R0, #36
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericSend63
;queue.c,816 :: 		queueYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;queue.c,817 :: 		}
IT	AL
BAL	L_xQueueGenericSend64
L_xQueueGenericSend63:
;queue.c,821 :: 		}
L_xQueueGenericSend64:
;queue.c,822 :: 		}
IT	AL
BAL	L_xQueueGenericSend65
L_xQueueGenericSend62:
;queue.c,823 :: 		else if( xYieldRequired != pdFALSE )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericSend66
;queue.c,829 :: 		queueYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;queue.c,830 :: 		}
IT	AL
BAL	L_xQueueGenericSend67
L_xQueueGenericSend66:
;queue.c,834 :: 		}
L_xQueueGenericSend67:
L_xQueueGenericSend65:
;queue.c,838 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,839 :: 		return pdPASS;
MOV	R0, #1
IT	AL
BAL	L_end_xQueueGenericSend
;queue.c,840 :: 		}
L_xQueueGenericSend61:
;queue.c,843 :: 		if( xTicksToWait == ( TickType_t ) 0 )
LDR	R0, [SP, #32]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend69
;queue.c,847 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,852 :: 		return errQUEUE_FULL;
MOV	R0, #0
IT	AL
BAL	L_end_xQueueGenericSend
;queue.c,853 :: 		}
L_xQueueGenericSend69:
;queue.c,854 :: 		else if( xEntryTimeSet == pdFALSE )
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend71
;queue.c,858 :: 		vTaskSetTimeOutState( &xTimeOut );
ADD	R0, SP, #8
PUSH	(R0)
BL	_vTaskSetTimeOutState+0
ADD	SP, SP, #4
;queue.c,859 :: 		xEntryTimeSet = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #20]
;queue.c,860 :: 		}
IT	AL
BAL	L_xQueueGenericSend72
L_xQueueGenericSend71:
;queue.c,865 :: 		}
L_xQueueGenericSend72:
;queue.c,868 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,873 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;queue.c,874 :: 		prvLockQueue( pxQueue );
BL	_vPortEnterCritical+0
LDR	R0, [SP, #16]
ADDS	R0, #68
LDRSB	R0, [R0, #0]
CMP	R0, #-1
IT	NE
BNE	L_xQueueGenericSend73
LDR	R0, [SP, #16]
ADDW	R1, R0, #68
MOVS	R0, #0
SXTB	R0, R0
STRB	R0, [R1, #0]
L_xQueueGenericSend73:
LDR	R0, [SP, #16]
ADDS	R0, #69
LDRSB	R0, [R0, #0]
CMP	R0, #-1
IT	NE
BNE	L_xQueueGenericSend74
LDR	R0, [SP, #16]
ADDW	R1, R0, #69
MOVS	R0, #0
SXTB	R0, R0
STRB	R0, [R1, #0]
L_xQueueGenericSend74:
BL	_vPortExitCritical+0
;queue.c,877 :: 		if( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) == pdFALSE )
ADD	R0, SP, #32
PUSH	(R0)
ADD	R0, SP, #12
PUSH	(R0)
BL	_xTaskCheckForTimeOut+0
ADD	SP, SP, #8
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend75
;queue.c,879 :: 		if( prvIsQueueFull( pxQueue ) != pdFALSE )
LDR	R0, [SP, #16]
PUSH	(R0)
BL	queue_prvIsQueueFull+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericSend76
;queue.c,882 :: 		vTaskPlaceOnEventList( &( pxQueue->xTasksWaitingToSend ), xTicksToWait );
LDR	R0, [SP, #32]
PUSH	(R0)
LDR	R0, [SP, #20]
ADDS	R0, #16
PUSH	(R0)
BL	_vTaskPlaceOnEventList+0
ADD	SP, SP, #8
;queue.c,889 :: 		prvUnlockQueue( pxQueue );
LDR	R0, [SP, #16]
PUSH	(R0)
BL	queue_prvUnlockQueue+0
ADD	SP, SP, #4
;queue.c,896 :: 		if( xTaskResumeAll() == pdFALSE )
BL	_xTaskResumeAll+0
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSend77
;queue.c,898 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;queue.c,899 :: 		}
L_xQueueGenericSend77:
;queue.c,900 :: 		}
IT	AL
BAL	L_xQueueGenericSend78
L_xQueueGenericSend76:
;queue.c,904 :: 		prvUnlockQueue( pxQueue );
LDR	R0, [SP, #16]
PUSH	(R0)
BL	queue_prvUnlockQueue+0
ADD	SP, SP, #4
;queue.c,905 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;queue.c,906 :: 		}
L_xQueueGenericSend78:
;queue.c,907 :: 		}
IT	AL
BAL	L_xQueueGenericSend79
L_xQueueGenericSend75:
;queue.c,911 :: 		prvUnlockQueue( pxQueue );
LDR	R0, [SP, #16]
PUSH	(R0)
BL	queue_prvUnlockQueue+0
ADD	SP, SP, #4
;queue.c,912 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;queue.c,915 :: 		return errQUEUE_FULL;
MOV	R0, #0
IT	AL
BAL	L_end_xQueueGenericSend
;queue.c,916 :: 		}
L_xQueueGenericSend79:
;queue.c,917 :: 		}
IT	AL
BAL	L_xQueueGenericSend56
;queue.c,918 :: 		}
L_end_xQueueGenericSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _xQueueGenericSend
_xQueueGenericSendFromISR:
;queue.c,921 :: 		BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void * const pvItemToQueue, BaseType_t * const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition )
SUB	SP, SP, #20
STR	LR, [SP, #0]
;queue.c,925 :: 		Queue_t * const pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #20]
STR	R0, [SP, #16]
;queue.c,927 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSendFromISR80
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericSendFromISR81:
IT	AL
BAL	L_xQueueGenericSendFromISR81
L_xQueueGenericSendFromISR80:
;queue.c,928 :: 		configASSERT( !( ( pvItemToQueue == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
LDR	R0, [SP, #24]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSendFromISR84
LDR	R0, [SP, #16]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericSendFromISR84
MOVS	R0, #1
IT	AL
BAL	L_xQueueGenericSendFromISR83
L_xQueueGenericSendFromISR84:
MOVS	R0, #0
L_xQueueGenericSendFromISR83:
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericSendFromISR277
MOVS	R0, #1
L__xQueueGenericSendFromISR277:
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSendFromISR85
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericSendFromISR86:
IT	AL
BAL	L_xQueueGenericSendFromISR86
L_xQueueGenericSendFromISR85:
;queue.c,929 :: 		configASSERT( !( ( xCopyPosition == queueOVERWRITE ) && ( pxQueue->uxLength != 1 ) ) );
LDR	R0, [SP, #32]
CMP	R0, #2
IT	NE
BNE	L_xQueueGenericSendFromISR89
LDR	R0, [SP, #16]
ADDS	R0, #60
LDR	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_xQueueGenericSendFromISR89
MOVS	R0, #1
IT	AL
BAL	L_xQueueGenericSendFromISR88
L_xQueueGenericSendFromISR89:
MOVS	R0, #0
L_xQueueGenericSendFromISR88:
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericSendFromISR278
MOVS	R0, #1
L__xQueueGenericSendFromISR278:
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSendFromISR90
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericSendFromISR91:
IT	AL
BAL	L_xQueueGenericSendFromISR91
L_xQueueGenericSendFromISR90:
;queue.c,945 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;queue.c,952 :: 		uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
BL	queue_ulPortRaiseBASEPRI+0
STR	R0, [SP, #12]
;queue.c,954 :: 		if( ( pxQueue->uxMessagesWaiting < pxQueue->uxLength ) || ( xCopyPosition == queueOVERWRITE ) )
LDR	R0, [SP, #16]
ADDS	R0, #56
LDR	R1, [R0, #0]
LDR	R0, [SP, #16]
ADDS	R0, #60
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CC
BCC	L__xQueueGenericSendFromISR254
LDR	R0, [SP, #32]
CMP	R0, #2
IT	EQ
BEQ	L__xQueueGenericSendFromISR254
IT	AL
BAL	L_xQueueGenericSendFromISR95
L__xQueueGenericSendFromISR254:
;queue.c,956 :: 		const int8_t cTxLock = pxQueue->cTxLock;
LDR	R0, [SP, #16]
ADDS	R0, #69
LDRSB	R0, [R0, #0]
STRB	R0, [SP, #4]
;queue.c,965 :: 		( void ) prvCopyDataToQueue( pxQueue, pvItemToQueue, xCopyPosition );
LDR	R0, [SP, #32]
PUSH	(R0)
LDR	R0, [SP, #28]
PUSH	(R0)
LDR	R0, [SP, #24]
PUSH	(R0)
BL	queue_prvCopyDataToQueue+0
ADD	SP, SP, #12
;queue.c,969 :: 		if( cTxLock == queueUNLOCKED )
LDRSB	R0, [SP, #4]
CMP	R0, #-1
IT	NE
BNE	L_xQueueGenericSendFromISR96
;queue.c,1024 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
LDR	R0, [SP, #16]
ADDS	R0, #36
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericSendFromISR279
MOVS	R0, #1
L__xQueueGenericSendFromISR279:
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericSendFromISR97
;queue.c,1026 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
LDR	R0, [SP, #16]
ADDS	R0, #36
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericSendFromISR98
;queue.c,1030 :: 		if( pxHigherPriorityTaskWoken != NULL )
LDR	R0, [SP, #28]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericSendFromISR99
;queue.c,1032 :: 		*pxHigherPriorityTaskWoken = pdTRUE;
MOV	R1, #1
LDR	R0, [SP, #28]
STR	R1, [R0, #0]
;queue.c,1033 :: 		}
IT	AL
BAL	L_xQueueGenericSendFromISR100
L_xQueueGenericSendFromISR99:
;queue.c,1037 :: 		}
L_xQueueGenericSendFromISR100:
;queue.c,1038 :: 		}
IT	AL
BAL	L_xQueueGenericSendFromISR101
L_xQueueGenericSendFromISR98:
;queue.c,1042 :: 		}
L_xQueueGenericSendFromISR101:
;queue.c,1043 :: 		}
IT	AL
BAL	L_xQueueGenericSendFromISR102
L_xQueueGenericSendFromISR97:
;queue.c,1047 :: 		}
L_xQueueGenericSendFromISR102:
;queue.c,1050 :: 		}
IT	AL
BAL	L_xQueueGenericSendFromISR103
L_xQueueGenericSendFromISR96:
;queue.c,1055 :: 		pxQueue->cTxLock = ( int8_t ) ( cTxLock + 1 );
LDR	R0, [SP, #16]
ADDW	R1, R0, #69
LDRSB	R0, [SP, #4]
ADDS	R0, R0, #1
SXTB	R0, R0
STRB	R0, [R1, #0]
;queue.c,1056 :: 		}
L_xQueueGenericSendFromISR103:
;queue.c,1058 :: 		xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #8]
;queue.c,1059 :: 		}
IT	AL
BAL	L_xQueueGenericSendFromISR104
L_xQueueGenericSendFromISR95:
;queue.c,1063 :: 		xReturn = errQUEUE_FULL;
MOV	R0, #0
STR	R0, [SP, #8]
;queue.c,1064 :: 		}
L_xQueueGenericSendFromISR104:
;queue.c,1066 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
LDR	R0, [SP, #12]
PUSH	(R0)
BL	queue_vPortSetBASEPRI+0
ADD	SP, SP, #4
;queue.c,1068 :: 		return xReturn;
LDR	R0, [SP, #8]
;queue.c,1069 :: 		}
L_end_xQueueGenericSendFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _xQueueGenericSendFromISR
_xQueueGiveFromISR:
;queue.c,1072 :: 		BaseType_t xQueueGiveFromISR( QueueHandle_t xQueue, BaseType_t * const pxHigherPriorityTaskWoken )
SUB	SP, SP, #24
STR	LR, [SP, #0]
;queue.c,1076 :: 		Queue_t * const pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #24]
STR	R0, [SP, #20]
;queue.c,1084 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_xQueueGiveFromISR105
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGiveFromISR106:
IT	AL
BAL	L_xQueueGiveFromISR106
L_xQueueGiveFromISR105:
;queue.c,1088 :: 		configASSERT( pxQueue->uxItemSize == 0 );
LDR	R0, [SP, #20]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGiveFromISR281
MOVS	R0, #1
L__xQueueGiveFromISR281:
CMP	R0, #0
IT	NE
BNE	L_xQueueGiveFromISR108
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGiveFromISR109:
IT	AL
BAL	L_xQueueGiveFromISR109
L_xQueueGiveFromISR108:
;queue.c,1093 :: 		configASSERT( !( ( pxQueue->uxQueueType == queueQUEUE_IS_MUTEX ) && ( pxQueue->pxMutexHolder != NULL ) ) );
LDR	R0, [SP, #20]
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xQueueGiveFromISR112
LDR	R0, [SP, #20]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGiveFromISR112
MOVS	R0, #1
IT	AL
BAL	L_xQueueGiveFromISR111
L_xQueueGiveFromISR112:
MOVS	R0, #0
L_xQueueGiveFromISR111:
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGiveFromISR282
MOVS	R0, #1
L__xQueueGiveFromISR282:
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_xQueueGiveFromISR113
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGiveFromISR114:
IT	AL
BAL	L_xQueueGiveFromISR114
L_xQueueGiveFromISR113:
;queue.c,1109 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;queue.c,1111 :: 		uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
BL	queue_ulPortRaiseBASEPRI+0
STR	R0, [SP, #16]
;queue.c,1113 :: 		const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
LDR	R0, [SP, #20]
ADDS	R0, #56
LDR	R0, [R0, #0]
STR	R0, [SP, #8]
;queue.c,1118 :: 		if( uxMessagesWaiting < pxQueue->uxLength )
LDR	R0, [SP, #20]
ADDS	R0, #60
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	CS
BCS	L_xQueueGiveFromISR116
;queue.c,1120 :: 		const int8_t cTxLock = pxQueue->cTxLock;
LDR	R0, [SP, #20]
ADDS	R0, #69
LDRSB	R0, [R0, #0]
STRB	R0, [SP, #4]
;queue.c,1130 :: 		pxQueue->uxMessagesWaiting = uxMessagesWaiting + 1;
LDR	R0, [SP, #20]
ADDW	R1, R0, #56
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;queue.c,1134 :: 		if( cTxLock == queueUNLOCKED )
LDRSB	R0, [SP, #4]
CMP	R0, #-1
IT	NE
BNE	L_xQueueGiveFromISR117
;queue.c,1189 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
LDR	R0, [SP, #20]
ADDS	R0, #36
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGiveFromISR283
MOVS	R0, #1
L__xQueueGiveFromISR283:
CMP	R0, #0
IT	NE
BNE	L_xQueueGiveFromISR118
;queue.c,1191 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
LDR	R0, [SP, #20]
ADDS	R0, #36
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGiveFromISR119
;queue.c,1195 :: 		if( pxHigherPriorityTaskWoken != NULL )
LDR	R0, [SP, #28]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGiveFromISR120
;queue.c,1197 :: 		*pxHigherPriorityTaskWoken = pdTRUE;
MOV	R1, #1
LDR	R0, [SP, #28]
STR	R1, [R0, #0]
;queue.c,1198 :: 		}
IT	AL
BAL	L_xQueueGiveFromISR121
L_xQueueGiveFromISR120:
;queue.c,1202 :: 		}
L_xQueueGiveFromISR121:
;queue.c,1203 :: 		}
IT	AL
BAL	L_xQueueGiveFromISR122
L_xQueueGiveFromISR119:
;queue.c,1207 :: 		}
L_xQueueGiveFromISR122:
;queue.c,1208 :: 		}
IT	AL
BAL	L_xQueueGiveFromISR123
L_xQueueGiveFromISR118:
;queue.c,1212 :: 		}
L_xQueueGiveFromISR123:
;queue.c,1215 :: 		}
IT	AL
BAL	L_xQueueGiveFromISR124
L_xQueueGiveFromISR117:
;queue.c,1220 :: 		pxQueue->cTxLock = ( int8_t ) ( cTxLock + 1 );
LDR	R0, [SP, #20]
ADDW	R1, R0, #69
LDRSB	R0, [SP, #4]
ADDS	R0, R0, #1
SXTB	R0, R0
STRB	R0, [R1, #0]
;queue.c,1221 :: 		}
L_xQueueGiveFromISR124:
;queue.c,1223 :: 		xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #12]
;queue.c,1224 :: 		}
IT	AL
BAL	L_xQueueGiveFromISR125
L_xQueueGiveFromISR116:
;queue.c,1228 :: 		xReturn = errQUEUE_FULL;
MOV	R0, #0
STR	R0, [SP, #12]
;queue.c,1229 :: 		}
L_xQueueGiveFromISR125:
;queue.c,1231 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
LDR	R0, [SP, #16]
PUSH	(R0)
BL	queue_vPortSetBASEPRI+0
ADD	SP, SP, #4
;queue.c,1233 :: 		return xReturn;
LDR	R0, [SP, #12]
;queue.c,1234 :: 		}
L_end_xQueueGiveFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _xQueueGiveFromISR
_xQueueGenericReceive:
;queue.c,1237 :: 		BaseType_t xQueueGenericReceive( QueueHandle_t xQueue, void * const pvBuffer, TickType_t xTicksToWait, const BaseType_t xJustPeeking )
SUB	SP, SP, #32
STR	LR, [SP, #0]
;queue.c,1239 :: 		BaseType_t xEntryTimeSet = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #24]
;queue.c,1242 :: 		Queue_t * const pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #32]
STR	R0, [SP, #20]
;queue.c,1244 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive126
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericReceive127:
IT	AL
BAL	L_xQueueGenericReceive127
L_xQueueGenericReceive126:
;queue.c,1245 :: 		configASSERT( !( ( pvBuffer == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
LDR	R0, [SP, #36]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive130
LDR	R0, [SP, #20]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericReceive130
MOVS	R0, #1
IT	AL
BAL	L_xQueueGenericReceive129
L_xQueueGenericReceive130:
MOVS	R0, #0
L_xQueueGenericReceive129:
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericReceive285
MOVS	R0, #1
L__xQueueGenericReceive285:
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive131
BL	queue_vPortRaiseBASEPRI+0
L_xQueueGenericReceive132:
IT	AL
BAL	L_xQueueGenericReceive132
L_xQueueGenericReceive131:
;queue.c,1256 :: 		for( ;; )
L_xQueueGenericReceive134:
;queue.c,1258 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,1260 :: 		const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
LDR	R0, [SP, #20]
ADDS	R0, #56
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;queue.c,1264 :: 		if( uxMessagesWaiting > ( UBaseType_t ) 0 )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	LS
BLS	L_xQueueGenericReceive137
;queue.c,1268 :: 		pcOriginalReadPosition = pxQueue->u.pcReadFrom;
LDR	R0, [SP, #20]
ADDS	R0, #12
LDR	R0, [R0, #0]
STR	R0, [SP, #16]
;queue.c,1270 :: 		prvCopyDataFromQueue( pxQueue, pvBuffer );
LDR	R0, [SP, #36]
PUSH	(R0)
LDR	R0, [SP, #24]
PUSH	(R0)
BL	queue_prvCopyDataFromQueue+0
ADD	SP, SP, #8
;queue.c,1272 :: 		if( xJustPeeking == pdFALSE )
LDR	R0, [SP, #44]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive138
;queue.c,1277 :: 		pxQueue->uxMessagesWaiting = uxMessagesWaiting - 1;
LDR	R0, [SP, #20]
ADDW	R1, R0, #56
LDR	R0, [SP, #4]
SUBS	R0, R0, #1
STR	R0, [R1, #0]
;queue.c,1281 :: 		if( pxQueue->uxQueueType == queueQUEUE_IS_MUTEX )
LDR	R0, [SP, #20]
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive139
;queue.c,1285 :: 		pxQueue->pxMutexHolder = ( int8_t * ) pvTaskIncrementMutexHeldCount(); /*lint !e961 Cast is not redundant as TaskHandle_t is a typedef. */
LDR	R0, [SP, #20]
ADDS	R0, R0, #4
STR	R0, [SP, #28]
BL	_pvTaskIncrementMutexHeldCount+0
MOV	R1, R0
LDR	R0, [SP, #28]
STR	R1, [R0, #0]
;queue.c,1286 :: 		}
IT	AL
BAL	L_xQueueGenericReceive140
L_xQueueGenericReceive139:
;queue.c,1290 :: 		}
L_xQueueGenericReceive140:
;queue.c,1294 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
LDR	R0, [SP, #20]
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericReceive286
MOVS	R0, #1
L__xQueueGenericReceive286:
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive141
;queue.c,1296 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
LDR	R0, [SP, #20]
ADDS	R0, #16
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericReceive142
;queue.c,1298 :: 		queueYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;queue.c,1299 :: 		}
IT	AL
BAL	L_xQueueGenericReceive143
L_xQueueGenericReceive142:
;queue.c,1303 :: 		}
L_xQueueGenericReceive143:
;queue.c,1304 :: 		}
IT	AL
BAL	L_xQueueGenericReceive144
L_xQueueGenericReceive141:
;queue.c,1308 :: 		}
L_xQueueGenericReceive144:
;queue.c,1309 :: 		}
IT	AL
BAL	L_xQueueGenericReceive145
L_xQueueGenericReceive138:
;queue.c,1316 :: 		pxQueue->u.pcReadFrom = pcOriginalReadPosition;
LDR	R0, [SP, #20]
ADDS	R0, #12
MOV	R1, R0
LDR	R0, [SP, #16]
STR	R0, [R1, #0]
;queue.c,1320 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
LDR	R0, [SP, #20]
ADDS	R0, #36
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueGenericReceive287
MOVS	R0, #1
L__xQueueGenericReceive287:
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive146
;queue.c,1322 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
LDR	R0, [SP, #20]
ADDS	R0, #36
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericReceive147
;queue.c,1325 :: 		queueYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;queue.c,1326 :: 		}
IT	AL
BAL	L_xQueueGenericReceive148
L_xQueueGenericReceive147:
;queue.c,1330 :: 		}
L_xQueueGenericReceive148:
;queue.c,1331 :: 		}
IT	AL
BAL	L_xQueueGenericReceive149
L_xQueueGenericReceive146:
;queue.c,1335 :: 		}
L_xQueueGenericReceive149:
;queue.c,1336 :: 		}
L_xQueueGenericReceive145:
;queue.c,1338 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1339 :: 		return pdPASS;
MOV	R0, #1
IT	AL
BAL	L_end_xQueueGenericReceive
;queue.c,1340 :: 		}
L_xQueueGenericReceive137:
;queue.c,1343 :: 		if( xTicksToWait == ( TickType_t ) 0 )
LDR	R0, [SP, #40]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive151
;queue.c,1347 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1349 :: 		return errQUEUE_EMPTY;
MOV	R0, #0
IT	AL
BAL	L_end_xQueueGenericReceive
;queue.c,1350 :: 		}
L_xQueueGenericReceive151:
;queue.c,1351 :: 		else if( xEntryTimeSet == pdFALSE )
LDR	R0, [SP, #24]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive153
;queue.c,1355 :: 		vTaskSetTimeOutState( &xTimeOut );
ADD	R0, SP, #8
PUSH	(R0)
BL	_vTaskSetTimeOutState+0
ADD	SP, SP, #4
;queue.c,1356 :: 		xEntryTimeSet = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #24]
;queue.c,1357 :: 		}
IT	AL
BAL	L_xQueueGenericReceive154
L_xQueueGenericReceive153:
;queue.c,1362 :: 		}
L_xQueueGenericReceive154:
;queue.c,1365 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1370 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;queue.c,1371 :: 		prvLockQueue( pxQueue );
BL	_vPortEnterCritical+0
LDR	R0, [SP, #20]
ADDS	R0, #68
LDRSB	R0, [R0, #0]
CMP	R0, #-1
IT	NE
BNE	L_xQueueGenericReceive155
LDR	R0, [SP, #20]
ADDW	R1, R0, #68
MOVS	R0, #0
SXTB	R0, R0
STRB	R0, [R1, #0]
L_xQueueGenericReceive155:
LDR	R0, [SP, #20]
ADDS	R0, #69
LDRSB	R0, [R0, #0]
CMP	R0, #-1
IT	NE
BNE	L_xQueueGenericReceive156
LDR	R0, [SP, #20]
ADDW	R1, R0, #69
MOVS	R0, #0
SXTB	R0, R0
STRB	R0, [R1, #0]
L_xQueueGenericReceive156:
BL	_vPortExitCritical+0
;queue.c,1374 :: 		if( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) == pdFALSE )
ADD	R0, SP, #40
PUSH	(R0)
ADD	R0, SP, #12
PUSH	(R0)
BL	_xTaskCheckForTimeOut+0
ADD	SP, SP, #8
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive157
;queue.c,1376 :: 		if( prvIsQueueEmpty( pxQueue ) != pdFALSE )
LDR	R0, [SP, #20]
PUSH	(R0)
BL	queue_prvIsQueueEmpty+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericReceive158
;queue.c,1382 :: 		if( pxQueue->uxQueueType == queueQUEUE_IS_MUTEX )
LDR	R0, [SP, #20]
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive159
;queue.c,1384 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,1386 :: 		vTaskPriorityInherit( ( void * ) pxQueue->pxMutexHolder );
LDR	R0, [SP, #20]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
PUSH	(R0)
BL	_vTaskPriorityInherit+0
ADD	SP, SP, #4
;queue.c,1388 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1389 :: 		}
IT	AL
BAL	L_xQueueGenericReceive160
L_xQueueGenericReceive159:
;queue.c,1393 :: 		}
L_xQueueGenericReceive160:
;queue.c,1397 :: 		vTaskPlaceOnEventList( &( pxQueue->xTasksWaitingToReceive ), xTicksToWait );
LDR	R0, [SP, #40]
PUSH	(R0)
LDR	R0, [SP, #24]
ADDS	R0, #36
PUSH	(R0)
BL	_vTaskPlaceOnEventList+0
ADD	SP, SP, #8
;queue.c,1398 :: 		prvUnlockQueue( pxQueue );
LDR	R0, [SP, #20]
PUSH	(R0)
BL	queue_prvUnlockQueue+0
ADD	SP, SP, #4
;queue.c,1399 :: 		if( xTaskResumeAll() == pdFALSE )
BL	_xTaskResumeAll+0
CMP	R0, #0
IT	NE
BNE	L_xQueueGenericReceive161
;queue.c,1401 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;queue.c,1402 :: 		}
IT	AL
BAL	L_xQueueGenericReceive162
L_xQueueGenericReceive161:
;queue.c,1406 :: 		}
L_xQueueGenericReceive162:
;queue.c,1407 :: 		}
IT	AL
BAL	L_xQueueGenericReceive163
L_xQueueGenericReceive158:
;queue.c,1411 :: 		prvUnlockQueue( pxQueue );
LDR	R0, [SP, #20]
PUSH	(R0)
BL	queue_prvUnlockQueue+0
ADD	SP, SP, #4
;queue.c,1412 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;queue.c,1413 :: 		}
L_xQueueGenericReceive163:
;queue.c,1414 :: 		}
IT	AL
BAL	L_xQueueGenericReceive164
L_xQueueGenericReceive157:
;queue.c,1417 :: 		prvUnlockQueue( pxQueue );
LDR	R0, [SP, #20]
PUSH	(R0)
BL	queue_prvUnlockQueue+0
ADD	SP, SP, #4
;queue.c,1418 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;queue.c,1420 :: 		if( prvIsQueueEmpty( pxQueue ) != pdFALSE )
LDR	R0, [SP, #20]
PUSH	(R0)
BL	queue_prvIsQueueEmpty+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueGenericReceive165
;queue.c,1423 :: 		return errQUEUE_EMPTY;
MOV	R0, #0
IT	AL
BAL	L_end_xQueueGenericReceive
;queue.c,1424 :: 		}
L_xQueueGenericReceive165:
;queue.c,1429 :: 		}
L_xQueueGenericReceive164:
;queue.c,1430 :: 		}
IT	AL
BAL	L_xQueueGenericReceive134
;queue.c,1431 :: 		}
L_end_xQueueGenericReceive:
LDR	LR, [SP, #0]
ADD	SP, SP, #32
BX	LR
; end of _xQueueGenericReceive
_xQueueReceiveFromISR:
;queue.c,1434 :: 		BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue, void * const pvBuffer, BaseType_t * const pxHigherPriorityTaskWoken )
SUB	SP, SP, #24
STR	LR, [SP, #0]
;queue.c,1438 :: 		Queue_t * const pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #24]
STR	R0, [SP, #20]
;queue.c,1440 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_xQueueReceiveFromISR167
BL	queue_vPortRaiseBASEPRI+0
L_xQueueReceiveFromISR168:
IT	AL
BAL	L_xQueueReceiveFromISR168
L_xQueueReceiveFromISR167:
;queue.c,1441 :: 		configASSERT( !( ( pvBuffer == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
LDR	R0, [SP, #28]
CMP	R0, #0
IT	NE
BNE	L_xQueueReceiveFromISR171
LDR	R0, [SP, #20]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueReceiveFromISR171
MOVS	R0, #1
IT	AL
BAL	L_xQueueReceiveFromISR170
L_xQueueReceiveFromISR171:
MOVS	R0, #0
L_xQueueReceiveFromISR170:
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueReceiveFromISR289
MOVS	R0, #1
L__xQueueReceiveFromISR289:
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_xQueueReceiveFromISR172
BL	queue_vPortRaiseBASEPRI+0
L_xQueueReceiveFromISR173:
IT	AL
BAL	L_xQueueReceiveFromISR173
L_xQueueReceiveFromISR172:
;queue.c,1457 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;queue.c,1459 :: 		uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
BL	queue_ulPortRaiseBASEPRI+0
STR	R0, [SP, #16]
;queue.c,1461 :: 		const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
LDR	R0, [SP, #20]
ADDS	R0, #56
LDR	R0, [R0, #0]
STR	R0, [SP, #8]
;queue.c,1464 :: 		if( uxMessagesWaiting > ( UBaseType_t ) 0 )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	LS
BLS	L_xQueueReceiveFromISR175
;queue.c,1466 :: 		const int8_t cRxLock = pxQueue->cRxLock;
LDR	R0, [SP, #20]
ADDS	R0, #68
LDRSB	R0, [R0, #0]
STRB	R0, [SP, #4]
;queue.c,1470 :: 		prvCopyDataFromQueue( pxQueue, pvBuffer );
LDR	R0, [SP, #28]
PUSH	(R0)
LDR	R0, [SP, #24]
PUSH	(R0)
BL	queue_prvCopyDataFromQueue+0
ADD	SP, SP, #8
;queue.c,1471 :: 		pxQueue->uxMessagesWaiting = uxMessagesWaiting - 1;
LDR	R0, [SP, #20]
ADDW	R1, R0, #56
LDR	R0, [SP, #8]
SUBS	R0, R0, #1
STR	R0, [R1, #0]
;queue.c,1477 :: 		if( cRxLock == queueUNLOCKED )
LDRSB	R0, [SP, #4]
CMP	R0, #-1
IT	NE
BNE	L_xQueueReceiveFromISR176
;queue.c,1479 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
LDR	R0, [SP, #20]
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueueReceiveFromISR290
MOVS	R0, #1
L__xQueueReceiveFromISR290:
CMP	R0, #0
IT	NE
BNE	L_xQueueReceiveFromISR177
;queue.c,1481 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
LDR	R0, [SP, #20]
ADDS	R0, #16
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xQueueReceiveFromISR178
;queue.c,1485 :: 		if( pxHigherPriorityTaskWoken != NULL )
LDR	R0, [SP, #32]
CMP	R0, #0
IT	EQ
BEQ	L_xQueueReceiveFromISR179
;queue.c,1487 :: 		*pxHigherPriorityTaskWoken = pdTRUE;
MOV	R1, #1
LDR	R0, [SP, #32]
STR	R1, [R0, #0]
;queue.c,1488 :: 		}
IT	AL
BAL	L_xQueueReceiveFromISR180
L_xQueueReceiveFromISR179:
;queue.c,1492 :: 		}
L_xQueueReceiveFromISR180:
;queue.c,1493 :: 		}
IT	AL
BAL	L_xQueueReceiveFromISR181
L_xQueueReceiveFromISR178:
;queue.c,1497 :: 		}
L_xQueueReceiveFromISR181:
;queue.c,1498 :: 		}
IT	AL
BAL	L_xQueueReceiveFromISR182
L_xQueueReceiveFromISR177:
;queue.c,1502 :: 		}
L_xQueueReceiveFromISR182:
;queue.c,1503 :: 		}
IT	AL
BAL	L_xQueueReceiveFromISR183
L_xQueueReceiveFromISR176:
;queue.c,1508 :: 		pxQueue->cRxLock = ( int8_t ) ( cRxLock + 1 );
LDR	R0, [SP, #20]
ADDW	R1, R0, #68
LDRSB	R0, [SP, #4]
ADDS	R0, R0, #1
SXTB	R0, R0
STRB	R0, [R1, #0]
;queue.c,1509 :: 		}
L_xQueueReceiveFromISR183:
;queue.c,1511 :: 		xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #12]
;queue.c,1512 :: 		}
IT	AL
BAL	L_xQueueReceiveFromISR184
L_xQueueReceiveFromISR175:
;queue.c,1515 :: 		xReturn = pdFAIL;
MOV	R0, #0
STR	R0, [SP, #12]
;queue.c,1517 :: 		}
L_xQueueReceiveFromISR184:
;queue.c,1519 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
LDR	R0, [SP, #16]
PUSH	(R0)
BL	queue_vPortSetBASEPRI+0
ADD	SP, SP, #4
;queue.c,1521 :: 		return xReturn;
LDR	R0, [SP, #12]
;queue.c,1522 :: 		}
L_end_xQueueReceiveFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _xQueueReceiveFromISR
_xQueuePeekFromISR:
;queue.c,1525 :: 		BaseType_t xQueuePeekFromISR( QueueHandle_t xQueue,  void * const pvBuffer )
SUB	SP, SP, #20
STR	LR, [SP, #0]
;queue.c,1530 :: 		Queue_t * const pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #20]
STR	R0, [SP, #16]
;queue.c,1532 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_xQueuePeekFromISR185
BL	queue_vPortRaiseBASEPRI+0
L_xQueuePeekFromISR186:
IT	AL
BAL	L_xQueuePeekFromISR186
L_xQueuePeekFromISR185:
;queue.c,1533 :: 		configASSERT( !( ( pvBuffer == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
LDR	R0, [SP, #24]
CMP	R0, #0
IT	NE
BNE	L_xQueuePeekFromISR189
LDR	R0, [SP, #16]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xQueuePeekFromISR189
MOVS	R0, #1
IT	AL
BAL	L_xQueuePeekFromISR188
L_xQueuePeekFromISR189:
MOVS	R0, #0
L_xQueuePeekFromISR188:
CMP	R0, #0
MOVW	R0, #0
BNE	L__xQueuePeekFromISR292
MOVS	R0, #1
L__xQueuePeekFromISR292:
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_xQueuePeekFromISR190
BL	queue_vPortRaiseBASEPRI+0
L_xQueuePeekFromISR191:
IT	AL
BAL	L_xQueuePeekFromISR191
L_xQueuePeekFromISR190:
;queue.c,1534 :: 		configASSERT( pxQueue->uxItemSize != 0 ); /* Can't peek a semaphore. */
LDR	R0, [SP, #16]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BEQ	L__xQueuePeekFromISR293
MOVS	R0, #1
L__xQueuePeekFromISR293:
CMP	R0, #0
IT	NE
BNE	L_xQueuePeekFromISR193
BL	queue_vPortRaiseBASEPRI+0
L_xQueuePeekFromISR194:
IT	AL
BAL	L_xQueuePeekFromISR194
L_xQueuePeekFromISR193:
;queue.c,1550 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;queue.c,1552 :: 		uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
BL	queue_ulPortRaiseBASEPRI+0
STR	R0, [SP, #8]
;queue.c,1555 :: 		if( pxQueue->uxMessagesWaiting > ( UBaseType_t ) 0 )
LDR	R0, [SP, #16]
ADDS	R0, #56
LDR	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_xQueuePeekFromISR196
;queue.c,1561 :: 		pcOriginalReadPosition = pxQueue->u.pcReadFrom;
LDR	R0, [SP, #16]
ADDS	R0, #12
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
;queue.c,1562 :: 		prvCopyDataFromQueue( pxQueue, pvBuffer );
LDR	R0, [SP, #24]
PUSH	(R0)
LDR	R0, [SP, #20]
PUSH	(R0)
BL	queue_prvCopyDataFromQueue+0
ADD	SP, SP, #8
;queue.c,1563 :: 		pxQueue->u.pcReadFrom = pcOriginalReadPosition;
LDR	R0, [SP, #16]
ADDS	R0, #12
MOV	R1, R0
LDR	R0, [SP, #12]
STR	R0, [R1, #0]
;queue.c,1565 :: 		xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #4]
;queue.c,1566 :: 		}
IT	AL
BAL	L_xQueuePeekFromISR197
L_xQueuePeekFromISR196:
;queue.c,1569 :: 		xReturn = pdFAIL;
MOV	R0, #0
STR	R0, [SP, #4]
;queue.c,1571 :: 		}
L_xQueuePeekFromISR197:
;queue.c,1573 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
LDR	R0, [SP, #8]
PUSH	(R0)
BL	queue_vPortSetBASEPRI+0
ADD	SP, SP, #4
;queue.c,1575 :: 		return xReturn;
LDR	R0, [SP, #4]
;queue.c,1576 :: 		}
L_end_xQueuePeekFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _xQueuePeekFromISR
_uxQueueMessagesWaiting:
;queue.c,1579 :: 		UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,1583 :: 		configASSERT( xQueue );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_uxQueueMessagesWaiting198
BL	queue_vPortRaiseBASEPRI+0
L_uxQueueMessagesWaiting199:
IT	AL
BAL	L_uxQueueMessagesWaiting199
L_uxQueueMessagesWaiting198:
;queue.c,1585 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,1587 :: 		uxReturn = ( ( Queue_t * ) xQueue )->uxMessagesWaiting;
LDR	R0, [SP, #8]
ADDS	R0, #56
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;queue.c,1589 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1591 :: 		return uxReturn;
LDR	R0, [SP, #4]
;queue.c,1592 :: 		} /*lint !e818 Pointer cannot be declared const as xQueue is a typedef not pointer. */
L_end_uxQueueMessagesWaiting:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _uxQueueMessagesWaiting
_uxQueueSpacesAvailable:
;queue.c,1595 :: 		UBaseType_t uxQueueSpacesAvailable( const QueueHandle_t xQueue )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;queue.c,1600 :: 		pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #12]
STR	R0, [SP, #8]
;queue.c,1601 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_uxQueueSpacesAvailable201
BL	queue_vPortRaiseBASEPRI+0
L_uxQueueSpacesAvailable202:
IT	AL
BAL	L_uxQueueSpacesAvailable202
L_uxQueueSpacesAvailable201:
;queue.c,1603 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,1605 :: 		uxReturn = pxQueue->uxLength - pxQueue->uxMessagesWaiting;
LDR	R0, [SP, #8]
ADDS	R0, #60
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
ADDS	R0, #56
LDR	R0, [R0, #0]
SUB	R0, R1, R0
STR	R0, [SP, #4]
;queue.c,1607 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1609 :: 		return uxReturn;
LDR	R0, [SP, #4]
;queue.c,1610 :: 		} /*lint !e818 Pointer cannot be declared const as xQueue is a typedef not pointer. */
L_end_uxQueueSpacesAvailable:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _uxQueueSpacesAvailable
_uxQueueMessagesWaitingFromISR:
;queue.c,1613 :: 		UBaseType_t uxQueueMessagesWaitingFromISR( const QueueHandle_t xQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,1617 :: 		configASSERT( xQueue );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_uxQueueMessagesWaitingFromISR204
BL	queue_vPortRaiseBASEPRI+0
L_uxQueueMessagesWaitingFromISR205:
IT	AL
BAL	L_uxQueueMessagesWaitingFromISR205
L_uxQueueMessagesWaitingFromISR204:
;queue.c,1619 :: 		uxReturn = ( ( Queue_t * ) xQueue )->uxMessagesWaiting;
LDR	R0, [SP, #8]
ADDS	R0, #56
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;queue.c,1621 :: 		return uxReturn;
LDR	R0, [SP, #4]
;queue.c,1622 :: 		} /*lint !e818 Pointer cannot be declared const as xQueue is a typedef not pointer. */
L_end_uxQueueMessagesWaitingFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _uxQueueMessagesWaitingFromISR
_vQueueDelete:
;queue.c,1625 :: 		void vQueueDelete( QueueHandle_t xQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,1627 :: 		Queue_t * const pxQueue = ( Queue_t * ) xQueue;
LDR	R0, [SP, #8]
STR	R0, [SP, #4]
;queue.c,1629 :: 		configASSERT( pxQueue );
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_vQueueDelete207
BL	queue_vPortRaiseBASEPRI+0
L_vQueueDelete208:
IT	AL
BAL	L_vQueueDelete208
L_vQueueDelete207:
;queue.c,1642 :: 		vPortFree( pxQueue );
LDR	R0, [SP, #4]
PUSH	(R0)
BL	_vPortFree+0
ADD	SP, SP, #4
;queue.c,1664 :: 		}
L_end_vQueueDelete:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vQueueDelete
queue_prvCopyDataToQueue:
;queue.c,1697 :: 		static BaseType_t prvCopyDataToQueue( Queue_t * const pxQueue, const void *pvItemToQueue, const BaseType_t xPosition )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;queue.c,1699 :: 		BaseType_t xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #8]
;queue.c,1704 :: 		uxMessagesWaiting = pxQueue->uxMessagesWaiting;
LDR	R0, [SP, #12]
ADDS	R0, #56
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;queue.c,1706 :: 		if( pxQueue->uxItemSize == ( UBaseType_t ) 0 )
LDR	R0, [SP, #12]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_queue_prvCopyDataToQueue210
;queue.c,1710 :: 		if( pxQueue->uxQueueType == queueQUEUE_IS_MUTEX )
LDR	R0, [SP, #12]
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_queue_prvCopyDataToQueue211
;queue.c,1713 :: 		xReturn = xTaskPriorityDisinherit( ( void * ) pxQueue->pxMutexHolder );
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
PUSH	(R0)
BL	_xTaskPriorityDisinherit+0
ADD	SP, SP, #4
STR	R0, [SP, #8]
;queue.c,1714 :: 		pxQueue->pxMutexHolder = NULL;
LDR	R0, [SP, #12]
ADDS	R1, R0, #4
MOVS	R0, #0
STR	R0, [R1, #0]
;queue.c,1715 :: 		}
IT	AL
BAL	L_queue_prvCopyDataToQueue212
L_queue_prvCopyDataToQueue211:
;queue.c,1719 :: 		}
L_queue_prvCopyDataToQueue212:
;queue.c,1722 :: 		}
IT	AL
BAL	L_queue_prvCopyDataToQueue213
L_queue_prvCopyDataToQueue210:
;queue.c,1723 :: 		else if( xPosition == queueSEND_TO_BACK )
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_queue_prvCopyDataToQueue214
;queue.c,1725 :: 		( void ) memcpy( ( void * ) pxQueue->pcWriteTo, pvItemToQueue, ( size_t ) pxQueue->uxItemSize ); /*lint !e961 !e418 MISRA exception as the casts are only redundant for some ports, plus previous logic ensures a null pointer can only be passed to memcpy() if the copy size is 0. */
LDR	R0, [SP, #12]
ADDS	R0, #64
LDR	R0, [R0, #0]
MOV	R5, R0
LDR	R0, [SP, #12]
ADDS	R0, #8
LDR	R0, [R0, #0]
MOV	R4, R0
SXTH	R2, R5
LDR	R1, [SP, #16]
MOV	R0, R4
BL	_memcpy+0
;queue.c,1726 :: 		pxQueue->pcWriteTo += pxQueue->uxItemSize;
LDR	R0, [SP, #12]
ADDW	R2, R0, #8
LDR	R0, [SP, #12]
ADDS	R0, #64
LDR	R1, [R0, #0]
LDR	R0, [R2, #0]
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;queue.c,1727 :: 		if( pxQueue->pcWriteTo >= pxQueue->pcTail ) /*lint !e946 MISRA exception justified as comparison of pointers is the cleanest solution. */
LDR	R0, [SP, #12]
ADDS	R0, #8
LDR	R1, [R0, #0]
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CC
BCC	L_queue_prvCopyDataToQueue215
;queue.c,1729 :: 		pxQueue->pcWriteTo = pxQueue->pcHead;
LDR	R0, [SP, #12]
ADDW	R1, R0, #8
LDR	R0, [SP, #12]
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;queue.c,1730 :: 		}
IT	AL
BAL	L_queue_prvCopyDataToQueue216
L_queue_prvCopyDataToQueue215:
;queue.c,1734 :: 		}
L_queue_prvCopyDataToQueue216:
;queue.c,1735 :: 		}
IT	AL
BAL	L_queue_prvCopyDataToQueue217
L_queue_prvCopyDataToQueue214:
;queue.c,1738 :: 		( void ) memcpy( ( void * ) pxQueue->u.pcReadFrom, pvItemToQueue, ( size_t ) pxQueue->uxItemSize ); /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
LDR	R0, [SP, #12]
ADDS	R0, #64
LDR	R0, [R0, #0]
MOV	R5, R0
LDR	R0, [SP, #12]
ADDS	R0, #12
LDR	R0, [R0, #0]
MOV	R4, R0
SXTH	R2, R5
LDR	R1, [SP, #16]
MOV	R0, R4
BL	_memcpy+0
;queue.c,1739 :: 		pxQueue->u.pcReadFrom -= pxQueue->uxItemSize;
LDR	R0, [SP, #12]
ADDS	R0, #12
MOV	R2, R0
LDR	R0, [SP, #12]
ADDS	R0, #64
LDR	R1, [R0, #0]
LDR	R0, [R2, #0]
LDR	R0, [R2, #0]
SUB	R0, R0, R1
STR	R0, [R2, #0]
;queue.c,1740 :: 		if( pxQueue->u.pcReadFrom < pxQueue->pcHead ) /*lint !e946 MISRA exception justified as comparison of pointers is the cleanest solution. */
LDR	R0, [SP, #12]
ADDS	R0, #12
LDR	R1, [R0, #0]
LDR	R0, [SP, #12]
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CS
BCS	L_queue_prvCopyDataToQueue218
;queue.c,1742 :: 		pxQueue->u.pcReadFrom = ( pxQueue->pcTail - pxQueue->uxItemSize );
LDR	R0, [SP, #12]
ADDS	R0, #12
MOV	R2, R0
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
LDR	R1, [R0, #0]
LDR	R0, [SP, #12]
ADDS	R0, #64
LDR	R0, [R0, #0]
SUB	R0, R1, R0
STR	R0, [R2, #0]
;queue.c,1743 :: 		}
IT	AL
BAL	L_queue_prvCopyDataToQueue219
L_queue_prvCopyDataToQueue218:
;queue.c,1747 :: 		}
L_queue_prvCopyDataToQueue219:
;queue.c,1749 :: 		if( xPosition == queueOVERWRITE )
LDR	R0, [SP, #20]
CMP	R0, #2
IT	NE
BNE	L_queue_prvCopyDataToQueue220
;queue.c,1751 :: 		if( uxMessagesWaiting > ( UBaseType_t ) 0 )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	LS
BLS	L_queue_prvCopyDataToQueue221
;queue.c,1757 :: 		--uxMessagesWaiting;
LDR	R0, [SP, #4]
SUBS	R0, R0, #1
STR	R0, [SP, #4]
;queue.c,1758 :: 		}
IT	AL
BAL	L_queue_prvCopyDataToQueue222
L_queue_prvCopyDataToQueue221:
;queue.c,1762 :: 		}
L_queue_prvCopyDataToQueue222:
;queue.c,1763 :: 		}
IT	AL
BAL	L_queue_prvCopyDataToQueue223
L_queue_prvCopyDataToQueue220:
;queue.c,1767 :: 		}
L_queue_prvCopyDataToQueue223:
;queue.c,1768 :: 		}
L_queue_prvCopyDataToQueue217:
L_queue_prvCopyDataToQueue213:
;queue.c,1770 :: 		pxQueue->uxMessagesWaiting = uxMessagesWaiting + 1;
LDR	R0, [SP, #12]
ADDW	R1, R0, #56
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;queue.c,1772 :: 		return xReturn;
LDR	R0, [SP, #8]
;queue.c,1773 :: 		}
L_end_prvCopyDataToQueue:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of queue_prvCopyDataToQueue
queue_prvCopyDataFromQueue:
;queue.c,1776 :: 		static void prvCopyDataFromQueue( Queue_t * const pxQueue, void * const pvBuffer )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;queue.c,1778 :: 		if( pxQueue->uxItemSize != ( UBaseType_t ) 0 )
LDR	R0, [SP, #4]
ADDS	R0, #64
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_queue_prvCopyDataFromQueue224
;queue.c,1780 :: 		pxQueue->u.pcReadFrom += pxQueue->uxItemSize;
LDR	R0, [SP, #4]
ADDS	R0, #12
MOV	R2, R0
LDR	R0, [SP, #4]
ADDS	R0, #64
LDR	R1, [R0, #0]
LDR	R0, [R2, #0]
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;queue.c,1781 :: 		if( pxQueue->u.pcReadFrom >= pxQueue->pcTail ) /*lint !e946 MISRA exception justified as use of the relational operator is the cleanest solutions. */
LDR	R0, [SP, #4]
ADDS	R0, #12
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CC
BCC	L_queue_prvCopyDataFromQueue225
;queue.c,1783 :: 		pxQueue->u.pcReadFrom = pxQueue->pcHead;
LDR	R0, [SP, #4]
ADDS	R0, #12
MOV	R1, R0
LDR	R0, [SP, #4]
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;queue.c,1784 :: 		}
IT	AL
BAL	L_queue_prvCopyDataFromQueue226
L_queue_prvCopyDataFromQueue225:
;queue.c,1788 :: 		}
L_queue_prvCopyDataFromQueue226:
;queue.c,1789 :: 		( void ) memcpy( ( void * ) pvBuffer, ( void * ) pxQueue->u.pcReadFrom, ( size_t ) pxQueue->uxItemSize ); /*lint !e961 !e418 MISRA exception as the casts are only redundant for some ports.  Also previous logic ensures a null pointer can only be passed to memcpy() when the count is 0. */
LDR	R0, [SP, #4]
ADDS	R0, #64
LDR	R0, [R0, #0]
MOV	R6, R0
LDR	R0, [SP, #4]
ADDS	R0, #12
LDR	R0, [R0, #0]
MOV	R5, R0
LDR	R4, [SP, #8]
SXTH	R2, R6
MOV	R1, R5
MOV	R0, R4
BL	_memcpy+0
;queue.c,1790 :: 		}
L_queue_prvCopyDataFromQueue224:
;queue.c,1791 :: 		}
L_end_prvCopyDataFromQueue:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of queue_prvCopyDataFromQueue
queue_prvUnlockQueue:
;queue.c,1794 :: 		static void prvUnlockQueue( Queue_t * const pxQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,1802 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,1804 :: 		int8_t cTxLock = pxQueue->cTxLock;
LDR	R0, [SP, #8]
ADDS	R0, #69
LDRSB	R0, [R0, #0]
STRB	R0, [SP, #4]
;queue.c,1807 :: 		while( cTxLock > queueLOCKED_UNMODIFIED )
L_queue_prvUnlockQueue227:
LDRSB	R0, [SP, #4]
CMP	R0, #0
IT	LE
BLE	L_queue_prvUnlockQueue228
;queue.c,1855 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
LDR	R0, [SP, #8]
ADDS	R0, #36
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L_queue_prvUnlockQueue301
MOVS	R0, #1
L_queue_prvUnlockQueue301:
CMP	R0, #0
IT	NE
BNE	L_queue_prvUnlockQueue229
;queue.c,1857 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
LDR	R0, [SP, #8]
ADDS	R0, #36
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_queue_prvUnlockQueue230
;queue.c,1861 :: 		vTaskMissedYield();
BL	_vTaskMissedYield+0
;queue.c,1862 :: 		}
IT	AL
BAL	L_queue_prvUnlockQueue231
L_queue_prvUnlockQueue230:
;queue.c,1866 :: 		}
L_queue_prvUnlockQueue231:
;queue.c,1867 :: 		}
IT	AL
BAL	L_queue_prvUnlockQueue232
L_queue_prvUnlockQueue229:
;queue.c,1870 :: 		break;
IT	AL
BAL	L_queue_prvUnlockQueue228
;queue.c,1871 :: 		}
L_queue_prvUnlockQueue232:
;queue.c,1875 :: 		--cTxLock;
LDRSB	R0, [SP, #4]
SUBS	R0, R0, #1
STRB	R0, [SP, #4]
;queue.c,1876 :: 		}
IT	AL
BAL	L_queue_prvUnlockQueue227
L_queue_prvUnlockQueue228:
;queue.c,1878 :: 		pxQueue->cTxLock = queueUNLOCKED;
LDR	R0, [SP, #8]
ADDW	R1, R0, #69
MOVS	R0, #-1
SXTB	R0, R0
STRB	R0, [R1, #0]
;queue.c,1880 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1883 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,1885 :: 		int8_t cRxLock = pxQueue->cRxLock;
LDR	R0, [SP, #8]
ADDS	R0, #68
LDRSB	R0, [R0, #0]
STRB	R0, [SP, #5]
;queue.c,1887 :: 		while( cRxLock > queueLOCKED_UNMODIFIED )
L_queue_prvUnlockQueue233:
LDRSB	R0, [SP, #5]
CMP	R0, #0
IT	LE
BLE	L_queue_prvUnlockQueue234
;queue.c,1889 :: 		if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
LDR	R0, [SP, #8]
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L_queue_prvUnlockQueue302
MOVS	R0, #1
L_queue_prvUnlockQueue302:
CMP	R0, #0
IT	NE
BNE	L_queue_prvUnlockQueue235
;queue.c,1891 :: 		if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
LDR	R0, [SP, #8]
ADDS	R0, #16
PUSH	(R0)
BL	_xTaskRemoveFromEventList+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_queue_prvUnlockQueue236
;queue.c,1893 :: 		vTaskMissedYield();
BL	_vTaskMissedYield+0
;queue.c,1894 :: 		}
IT	AL
BAL	L_queue_prvUnlockQueue237
L_queue_prvUnlockQueue236:
;queue.c,1898 :: 		}
L_queue_prvUnlockQueue237:
;queue.c,1900 :: 		--cRxLock;
LDRSB	R0, [SP, #5]
SUBS	R0, R0, #1
STRB	R0, [SP, #5]
;queue.c,1901 :: 		}
IT	AL
BAL	L_queue_prvUnlockQueue238
L_queue_prvUnlockQueue235:
;queue.c,1904 :: 		break;
IT	AL
BAL	L_queue_prvUnlockQueue234
;queue.c,1905 :: 		}
L_queue_prvUnlockQueue238:
;queue.c,1906 :: 		}
IT	AL
BAL	L_queue_prvUnlockQueue233
L_queue_prvUnlockQueue234:
;queue.c,1908 :: 		pxQueue->cRxLock = queueUNLOCKED;
LDR	R0, [SP, #8]
ADDW	R1, R0, #68
MOVS	R0, #-1
SXTB	R0, R0
STRB	R0, [R1, #0]
;queue.c,1910 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1911 :: 		}
L_end_prvUnlockQueue:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of queue_prvUnlockQueue
queue_prvIsQueueEmpty:
;queue.c,1914 :: 		static BaseType_t prvIsQueueEmpty( const Queue_t *pxQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,1918 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,1920 :: 		if( pxQueue->uxMessagesWaiting == ( UBaseType_t )  0 )
LDR	R0, [SP, #8]
ADDS	R0, #56
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_queue_prvIsQueueEmpty239
;queue.c,1922 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;queue.c,1923 :: 		}
IT	AL
BAL	L_queue_prvIsQueueEmpty240
L_queue_prvIsQueueEmpty239:
;queue.c,1926 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;queue.c,1927 :: 		}
L_queue_prvIsQueueEmpty240:
;queue.c,1929 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1931 :: 		return xReturn;
LDR	R0, [SP, #4]
;queue.c,1932 :: 		}
L_end_prvIsQueueEmpty:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of queue_prvIsQueueEmpty
_xQueueIsQueueEmptyFromISR:
;queue.c,1935 :: 		BaseType_t xQueueIsQueueEmptyFromISR( const QueueHandle_t xQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,1939 :: 		configASSERT( xQueue );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_xQueueIsQueueEmptyFromISR241
BL	queue_vPortRaiseBASEPRI+0
L_xQueueIsQueueEmptyFromISR242:
IT	AL
BAL	L_xQueueIsQueueEmptyFromISR242
L_xQueueIsQueueEmptyFromISR241:
;queue.c,1940 :: 		if( ( ( Queue_t * ) xQueue )->uxMessagesWaiting == ( UBaseType_t ) 0 )
LDR	R0, [SP, #8]
ADDS	R0, #56
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xQueueIsQueueEmptyFromISR244
;queue.c,1942 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;queue.c,1943 :: 		}
IT	AL
BAL	L_xQueueIsQueueEmptyFromISR245
L_xQueueIsQueueEmptyFromISR244:
;queue.c,1946 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;queue.c,1947 :: 		}
L_xQueueIsQueueEmptyFromISR245:
;queue.c,1949 :: 		return xReturn;
LDR	R0, [SP, #4]
;queue.c,1950 :: 		} /*lint !e818 xQueue could not be pointer to const because it is a typedef. */
L_end_xQueueIsQueueEmptyFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _xQueueIsQueueEmptyFromISR
queue_prvIsQueueFull:
;queue.c,1953 :: 		static BaseType_t prvIsQueueFull( const Queue_t *pxQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,1957 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;queue.c,1959 :: 		if( pxQueue->uxMessagesWaiting == pxQueue->uxLength )
LDR	R0, [SP, #8]
ADDS	R0, #56
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
ADDS	R0, #60
LDR	R0, [R0, #0]
CMP	R1, R0
IT	NE
BNE	L_queue_prvIsQueueFull246
;queue.c,1961 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;queue.c,1962 :: 		}
IT	AL
BAL	L_queue_prvIsQueueFull247
L_queue_prvIsQueueFull246:
;queue.c,1965 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;queue.c,1966 :: 		}
L_queue_prvIsQueueFull247:
;queue.c,1968 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;queue.c,1970 :: 		return xReturn;
LDR	R0, [SP, #4]
;queue.c,1971 :: 		}
L_end_prvIsQueueFull:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of queue_prvIsQueueFull
_xQueueIsQueueFullFromISR:
;queue.c,1974 :: 		BaseType_t xQueueIsQueueFullFromISR( const QueueHandle_t xQueue )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;queue.c,1978 :: 		configASSERT( xQueue );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_xQueueIsQueueFullFromISR248
BL	queue_vPortRaiseBASEPRI+0
L_xQueueIsQueueFullFromISR249:
IT	AL
BAL	L_xQueueIsQueueFullFromISR249
L_xQueueIsQueueFullFromISR248:
;queue.c,1979 :: 		if( ( ( Queue_t * ) xQueue )->uxMessagesWaiting == ( ( Queue_t * ) xQueue )->uxLength )
LDR	R0, [SP, #8]
ADDS	R0, #56
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
ADDS	R0, #60
LDR	R0, [R0, #0]
CMP	R1, R0
IT	NE
BNE	L_xQueueIsQueueFullFromISR251
;queue.c,1981 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;queue.c,1982 :: 		}
IT	AL
BAL	L_xQueueIsQueueFullFromISR252
L_xQueueIsQueueFullFromISR251:
;queue.c,1985 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;queue.c,1986 :: 		}
L_xQueueIsQueueFullFromISR252:
;queue.c,1988 :: 		return xReturn;
LDR	R0, [SP, #4]
;queue.c,1989 :: 		} /*lint !e818 xQueue could not be pointer to const because it is a typedef. */
L_end_xQueueIsQueueFullFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _xQueueIsQueueFullFromISR
