event_groups_ucPortCountLeadingZeros:
;portmacro.h,176 :: 		static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
;portmacro.h,178 :: 		asm CLZ R0, R0;
CLZ	R0, R0
;portmacro.h,179 :: 		return R0;
UXTB	R0, R0
;portmacro.h,180 :: 		}
L_end_ucPortCountLeadingZeros:
BX	LR
; end of event_groups_ucPortCountLeadingZeros
event_groups_xPortIsInsideInterrupt:
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
BNE	L_event_groups_xPortIsInsideInterrupt0
;portmacro.h,228 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;portmacro.h,229 :: 		}
IT	AL
BAL	L_event_groups_xPortIsInsideInterrupt1
L_event_groups_xPortIsInsideInterrupt0:
;portmacro.h,232 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;portmacro.h,233 :: 		}
L_event_groups_xPortIsInsideInterrupt1:
;portmacro.h,235 :: 		return xReturn;
LDR	R0, [SP, #4]
;portmacro.h,236 :: 		}
L_end_xPortIsInsideInterrupt:
ADD	SP, SP, #8
BX	LR
; end of event_groups_xPortIsInsideInterrupt
event_groups_vPortRaiseBASEPRI:
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
; end of event_groups_vPortRaiseBASEPRI
event_groups_ulPortRaiseBASEPRI:
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
; end of event_groups_ulPortRaiseBASEPRI
event_groups_vPortSetBASEPRI:
;portmacro.h,268 :: 		portFORCE_INLINE static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
;portmacro.h,270 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,271 :: 		}
L_end_vPortSetBASEPRI:
BX	LR
; end of event_groups_vPortSetBASEPRI
_xEventGroupCreate:
;event_groups.c,174 :: 		EventGroupHandle_t xEventGroupCreate( void )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;event_groups.c,179 :: 		pxEventBits = ( EventGroup_t * ) pvPortMalloc( sizeof( EventGroup_t ) );
MOVS	R0, #24
PUSH	(R0)
BL	_pvPortMalloc+0
ADD	SP, SP, #4
STR	R0, [SP, #4]
;event_groups.c,181 :: 		if( pxEventBits != NULL )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupCreate2
;event_groups.c,183 :: 		pxEventBits->uxEventBits = 0;
LDR	R0, [SP, #4]
MOV	R1, R0
MOVS	R0, #0
STR	R0, [R1, #0]
;event_groups.c,184 :: 		vListInitialise( &( pxEventBits->xTasksWaitingForBits ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;event_groups.c,196 :: 		}
IT	AL
BAL	L_xEventGroupCreate3
L_xEventGroupCreate2:
;event_groups.c,200 :: 		}
L_xEventGroupCreate3:
;event_groups.c,202 :: 		return ( EventGroupHandle_t ) pxEventBits;
LDR	R0, [SP, #4]
;event_groups.c,203 :: 		}
L_end_xEventGroupCreate:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _xEventGroupCreate
_xEventGroupSync:
;event_groups.c,208 :: 		EventBits_t xEventGroupSync( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet, const EventBits_t uxBitsToWaitFor, TickType_t xTicksToWait )
SUB	SP, SP, #24
STR	LR, [SP, #0]
;event_groups.c,211 :: 		EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
LDR	R0, [SP, #24]
STR	R0, [SP, #12]
;event_groups.c,213 :: 		BaseType_t xTimeoutOccurred = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #20]
;event_groups.c,215 :: 		configASSERT( ( uxBitsToWaitFor & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
LDR	R0, [SP, #32]
AND	R0, R0, #-16777216
CMP	R0, #0
MOVW	R0, #0
BNE	L__xEventGroupSync90
MOVS	R0, #1
L__xEventGroupSync90:
CMP	R0, #0
IT	NE
BNE	L_xEventGroupSync4
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupSync5:
IT	AL
BAL	L_xEventGroupSync5
L_xEventGroupSync4:
;event_groups.c,216 :: 		configASSERT( uxBitsToWaitFor != 0 );
LDR	R0, [SP, #32]
CMP	R0, #0
MOVW	R0, #0
BEQ	L__xEventGroupSync91
MOVS	R0, #1
L__xEventGroupSync91:
CMP	R0, #0
IT	NE
BNE	L_xEventGroupSync7
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupSync8:
IT	AL
BAL	L_xEventGroupSync8
L_xEventGroupSync7:
;event_groups.c,223 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;event_groups.c,225 :: 		uxOriginalBitValue = pxEventBits->uxEventBits;
LDR	R0, [SP, #12]
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;event_groups.c,227 :: 		( void ) xEventGroupSetBits( xEventGroup, uxBitsToSet );
LDR	R0, [SP, #28]
PUSH	(R0)
LDR	R0, [SP, #28]
PUSH	(R0)
BL	_xEventGroupSetBits+0
ADD	SP, SP, #8
;event_groups.c,229 :: 		if( ( ( uxOriginalBitValue | uxBitsToSet ) & uxBitsToWaitFor ) == uxBitsToWaitFor )
LDR	R1, [SP, #28]
LDR	R0, [SP, #4]
ORR	R1, R0, R1, LSL #0
LDR	R0, [SP, #32]
ANDS	R1, R0
LDR	R0, [SP, #32]
CMP	R1, R0
IT	NE
BNE	L_xEventGroupSync10
;event_groups.c,232 :: 		uxReturn = ( uxOriginalBitValue | uxBitsToSet );
LDR	R1, [SP, #28]
LDR	R0, [SP, #4]
ORRS	R0, R1
STR	R0, [SP, #8]
;event_groups.c,236 :: 		pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
LDR	R0, [SP, #12]
MOV	R2, R0
LDR	R0, [SP, #32]
MVN	R1, R0
LDR	R0, [R2, #0]
ANDS	R0, R1
STR	R0, [R2, #0]
;event_groups.c,238 :: 		xTicksToWait = 0;
MOVS	R0, #0
STR	R0, [SP, #36]
;event_groups.c,239 :: 		}
IT	AL
BAL	L_xEventGroupSync11
L_xEventGroupSync10:
;event_groups.c,242 :: 		if( xTicksToWait != ( TickType_t ) 0 )
LDR	R0, [SP, #36]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupSync12
;event_groups.c,249 :: 		vTaskPlaceOnUnorderedEventList( &( pxEventBits->xTasksWaitingForBits ), ( uxBitsToWaitFor | eventCLEAR_EVENTS_ON_EXIT_BIT | eventWAIT_FOR_ALL_BITS ), xTicksToWait );
LDR	R0, [SP, #36]
PUSH	(R0)
LDR	R0, [SP, #36]
ORR	R0, R0, #16777216
ORR	R0, R0, #67108864
PUSH	(R0)
LDR	R0, [SP, #20]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_vTaskPlaceOnUnorderedEventList+0
ADD	SP, SP, #12
;event_groups.c,255 :: 		uxReturn = 0;
MOVS	R0, #0
STR	R0, [SP, #8]
;event_groups.c,256 :: 		}
IT	AL
BAL	L_xEventGroupSync13
L_xEventGroupSync12:
;event_groups.c,261 :: 		uxReturn = pxEventBits->uxEventBits;
LDR	R0, [SP, #12]
LDR	R0, [R0, #0]
STR	R0, [SP, #8]
;event_groups.c,262 :: 		}
L_xEventGroupSync13:
;event_groups.c,263 :: 		}
L_xEventGroupSync11:
;event_groups.c,265 :: 		xAlreadyYielded = xTaskResumeAll();
BL	_xTaskResumeAll+0
STR	R0, [SP, #16]
;event_groups.c,267 :: 		if( xTicksToWait != ( TickType_t ) 0 )
LDR	R0, [SP, #36]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupSync14
;event_groups.c,269 :: 		if( xAlreadyYielded == pdFALSE )
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_xEventGroupSync15
;event_groups.c,271 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;event_groups.c,272 :: 		}
IT	AL
BAL	L_xEventGroupSync16
L_xEventGroupSync15:
;event_groups.c,276 :: 		}
L_xEventGroupSync16:
;event_groups.c,282 :: 		uxReturn = uxTaskResetEventItemValue();
BL	_uxTaskResetEventItemValue+0
STR	R0, [SP, #8]
;event_groups.c,284 :: 		if( ( uxReturn & eventUNBLOCKED_DUE_TO_BIT_SET ) == ( EventBits_t ) 0 )
LDR	R0, [SP, #8]
AND	R0, R0, #33554432
CMP	R0, #0
IT	NE
BNE	L_xEventGroupSync17
;event_groups.c,287 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;event_groups.c,289 :: 		uxReturn = pxEventBits->uxEventBits;
LDR	R0, [SP, #12]
LDR	R0, [R0, #0]
STR	R0, [SP, #8]
;event_groups.c,295 :: 		if( ( uxReturn & uxBitsToWaitFor ) == uxBitsToWaitFor )
LDR	R1, [SP, #32]
LDR	R0, [SP, #8]
AND	R1, R0, R1, LSL #0
LDR	R0, [SP, #32]
CMP	R1, R0
IT	NE
BNE	L_xEventGroupSync18
;event_groups.c,297 :: 		pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
LDR	R0, [SP, #12]
MOV	R2, R0
LDR	R0, [SP, #32]
MVN	R1, R0
LDR	R0, [R2, #0]
ANDS	R0, R1
STR	R0, [R2, #0]
;event_groups.c,298 :: 		}
IT	AL
BAL	L_xEventGroupSync19
L_xEventGroupSync18:
;event_groups.c,302 :: 		}
L_xEventGroupSync19:
;event_groups.c,304 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;event_groups.c,306 :: 		xTimeoutOccurred = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #20]
;event_groups.c,307 :: 		}
IT	AL
BAL	L_xEventGroupSync20
L_xEventGroupSync17:
;event_groups.c,311 :: 		}
L_xEventGroupSync20:
;event_groups.c,315 :: 		uxReturn &= ~eventEVENT_BITS_CONTROL_BYTES;
LDR	R1, [SP, #8]
MVN	R0, #-16777216
AND	R0, R1, R0, LSL #0
STR	R0, [SP, #8]
;event_groups.c,316 :: 		}
L_xEventGroupSync14:
;event_groups.c,320 :: 		return uxReturn;
LDR	R0, [SP, #8]
;event_groups.c,321 :: 		}
L_end_xEventGroupSync:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _xEventGroupSync
_xEventGroupWaitBits:
;event_groups.c,324 :: 		EventBits_t xEventGroupWaitBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToWaitFor, const BaseType_t xClearOnExit, const BaseType_t xWaitForAllBits, TickType_t xTicksToWait )
SUB	SP, SP, #32
STR	LR, [SP, #0]
;event_groups.c,326 :: 		EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
LDR	R0, [SP, #32]
STR	R0, [SP, #8]
;event_groups.c,327 :: 		EventBits_t uxReturn, uxControlBits = 0;
ADD	R11, SP, #24
ADD	R10, R11, #8
MOVW	R12, #lo_addr(?ICSxEventGroupWaitBits_uxControlBits_L0+0)
MOVT	R12, #hi_addr(?ICSxEventGroupWaitBits_uxControlBits_L0+0)
BL	___CC2DW+0
;event_groups.c,329 :: 		BaseType_t xTimeoutOccurred = pdFALSE;
;event_groups.c,333 :: 		configASSERT( xEventGroup );
LDR	R0, [SP, #32]
CMP	R0, #0
IT	NE
BNE	L_xEventGroupWaitBits21
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupWaitBits22:
IT	AL
BAL	L_xEventGroupWaitBits22
L_xEventGroupWaitBits21:
;event_groups.c,334 :: 		configASSERT( ( uxBitsToWaitFor & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
LDR	R0, [SP, #36]
AND	R0, R0, #-16777216
CMP	R0, #0
MOVW	R0, #0
BNE	L__xEventGroupWaitBits93
MOVS	R0, #1
L__xEventGroupWaitBits93:
CMP	R0, #0
IT	NE
BNE	L_xEventGroupWaitBits24
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupWaitBits25:
IT	AL
BAL	L_xEventGroupWaitBits25
L_xEventGroupWaitBits24:
;event_groups.c,335 :: 		configASSERT( uxBitsToWaitFor != 0 );
LDR	R0, [SP, #36]
CMP	R0, #0
MOVW	R0, #0
BEQ	L__xEventGroupWaitBits94
MOVS	R0, #1
L__xEventGroupWaitBits94:
CMP	R0, #0
IT	NE
BNE	L_xEventGroupWaitBits27
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupWaitBits28:
IT	AL
BAL	L_xEventGroupWaitBits28
L_xEventGroupWaitBits27:
;event_groups.c,342 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;event_groups.c,344 :: 		const EventBits_t uxCurrentEventBits = pxEventBits->uxEventBits;
LDR	R0, [SP, #8]
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;event_groups.c,347 :: 		xWaitConditionMet = prvTestWaitCondition( uxCurrentEventBits, uxBitsToWaitFor, xWaitForAllBits );
LDR	R0, [SP, #44]
PUSH	(R0)
LDR	R0, [SP, #40]
PUSH	(R0)
LDR	R0, [SP, #12]
PUSH	(R0)
BL	event_groups_prvTestWaitCondition+0
ADD	SP, SP, #12
STR	R0, [SP, #16]
;event_groups.c,349 :: 		if( xWaitConditionMet != pdFALSE )
LDR	R0, [SP, #16]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupWaitBits30
;event_groups.c,353 :: 		uxReturn = uxCurrentEventBits;
LDR	R0, [SP, #4]
STR	R0, [SP, #12]
;event_groups.c,354 :: 		xTicksToWait = ( TickType_t ) 0;
MOV	R0, #0
STR	R0, [SP, #48]
;event_groups.c,357 :: 		if( xClearOnExit != pdFALSE )
LDR	R0, [SP, #40]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupWaitBits31
;event_groups.c,359 :: 		pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
LDR	R0, [SP, #8]
MOV	R2, R0
LDR	R0, [SP, #36]
MVN	R1, R0
LDR	R0, [R2, #0]
ANDS	R0, R1
STR	R0, [R2, #0]
;event_groups.c,360 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits32
L_xEventGroupWaitBits31:
;event_groups.c,364 :: 		}
L_xEventGroupWaitBits32:
;event_groups.c,365 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits33
L_xEventGroupWaitBits30:
;event_groups.c,366 :: 		else if( xTicksToWait == ( TickType_t ) 0 )
LDR	R0, [SP, #48]
CMP	R0, #0
IT	NE
BNE	L_xEventGroupWaitBits34
;event_groups.c,370 :: 		uxReturn = uxCurrentEventBits;
LDR	R0, [SP, #4]
STR	R0, [SP, #12]
;event_groups.c,371 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits35
L_xEventGroupWaitBits34:
;event_groups.c,378 :: 		if( xClearOnExit != pdFALSE )
LDR	R0, [SP, #40]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupWaitBits36
;event_groups.c,380 :: 		uxControlBits |= eventCLEAR_EVENTS_ON_EXIT_BIT;
LDR	R0, [SP, #24]
ORR	R0, R0, #16777216
STR	R0, [SP, #24]
;event_groups.c,381 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits37
L_xEventGroupWaitBits36:
;event_groups.c,385 :: 		}
L_xEventGroupWaitBits37:
;event_groups.c,387 :: 		if( xWaitForAllBits != pdFALSE )
LDR	R0, [SP, #44]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupWaitBits38
;event_groups.c,389 :: 		uxControlBits |= eventWAIT_FOR_ALL_BITS;
LDR	R0, [SP, #24]
ORR	R0, R0, #67108864
STR	R0, [SP, #24]
;event_groups.c,390 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits39
L_xEventGroupWaitBits38:
;event_groups.c,394 :: 		}
L_xEventGroupWaitBits39:
;event_groups.c,399 :: 		vTaskPlaceOnUnorderedEventList( &( pxEventBits->xTasksWaitingForBits ), ( uxBitsToWaitFor | uxControlBits ), xTicksToWait );
LDR	R0, [SP, #48]
PUSH	(R0)
LDR	R1, [SP, #28]
LDR	R0, [SP, #40]
ORRS	R0, R1
PUSH	(R0)
LDR	R0, [SP, #16]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_vTaskPlaceOnUnorderedEventList+0
ADD	SP, SP, #12
;event_groups.c,404 :: 		uxReturn = 0;
MOVS	R0, #0
STR	R0, [SP, #12]
;event_groups.c,407 :: 		}
L_xEventGroupWaitBits35:
L_xEventGroupWaitBits33:
;event_groups.c,409 :: 		xAlreadyYielded = xTaskResumeAll();
BL	_xTaskResumeAll+0
STR	R0, [SP, #20]
;event_groups.c,411 :: 		if( xTicksToWait != ( TickType_t ) 0 )
LDR	R0, [SP, #48]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupWaitBits40
;event_groups.c,413 :: 		if( xAlreadyYielded == pdFALSE )
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_xEventGroupWaitBits41
;event_groups.c,415 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;event_groups.c,416 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits42
L_xEventGroupWaitBits41:
;event_groups.c,420 :: 		}
L_xEventGroupWaitBits42:
;event_groups.c,426 :: 		uxReturn = uxTaskResetEventItemValue();
BL	_uxTaskResetEventItemValue+0
STR	R0, [SP, #12]
;event_groups.c,428 :: 		if( ( uxReturn & eventUNBLOCKED_DUE_TO_BIT_SET ) == ( EventBits_t ) 0 )
LDR	R0, [SP, #12]
AND	R0, R0, #33554432
CMP	R0, #0
IT	NE
BNE	L_xEventGroupWaitBits43
;event_groups.c,430 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;event_groups.c,433 :: 		uxReturn = pxEventBits->uxEventBits;
LDR	R0, [SP, #8]
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
;event_groups.c,437 :: 		if( prvTestWaitCondition( uxReturn, uxBitsToWaitFor, xWaitForAllBits ) != pdFALSE )
LDR	R0, [SP, #44]
PUSH	(R0)
LDR	R0, [SP, #40]
PUSH	(R0)
LDR	R0, [SP, #20]
PUSH	(R0)
BL	event_groups_prvTestWaitCondition+0
ADD	SP, SP, #12
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupWaitBits44
;event_groups.c,439 :: 		if( xClearOnExit != pdFALSE )
LDR	R0, [SP, #40]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupWaitBits45
;event_groups.c,441 :: 		pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
LDR	R0, [SP, #8]
MOV	R2, R0
LDR	R0, [SP, #36]
MVN	R1, R0
LDR	R0, [R2, #0]
ANDS	R0, R1
STR	R0, [R2, #0]
;event_groups.c,442 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits46
L_xEventGroupWaitBits45:
;event_groups.c,446 :: 		}
L_xEventGroupWaitBits46:
;event_groups.c,447 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits47
L_xEventGroupWaitBits44:
;event_groups.c,451 :: 		}
L_xEventGroupWaitBits47:
;event_groups.c,453 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;event_groups.c,456 :: 		xTimeoutOccurred = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #28]
;event_groups.c,457 :: 		}
IT	AL
BAL	L_xEventGroupWaitBits48
L_xEventGroupWaitBits43:
;event_groups.c,461 :: 		}
L_xEventGroupWaitBits48:
;event_groups.c,464 :: 		uxReturn &= ~eventEVENT_BITS_CONTROL_BYTES;
LDR	R1, [SP, #12]
MVN	R0, #-16777216
AND	R0, R1, R0, LSL #0
STR	R0, [SP, #12]
;event_groups.c,465 :: 		}
L_xEventGroupWaitBits40:
;event_groups.c,468 :: 		return uxReturn;
LDR	R0, [SP, #12]
;event_groups.c,469 :: 		}
L_end_xEventGroupWaitBits:
LDR	LR, [SP, #0]
ADD	SP, SP, #32
BX	LR
; end of _xEventGroupWaitBits
_xEventGroupClearBits:
;event_groups.c,472 :: 		EventBits_t xEventGroupClearBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;event_groups.c,474 :: 		EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
LDR	R0, [SP, #12]
STR	R0, [SP, #4]
;event_groups.c,479 :: 		configASSERT( xEventGroup );
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_xEventGroupClearBits49
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupClearBits50:
IT	AL
BAL	L_xEventGroupClearBits50
L_xEventGroupClearBits49:
;event_groups.c,480 :: 		configASSERT( ( uxBitsToClear & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
LDR	R0, [SP, #16]
AND	R0, R0, #-16777216
CMP	R0, #0
MOVW	R0, #0
BNE	L__xEventGroupClearBits96
MOVS	R0, #1
L__xEventGroupClearBits96:
CMP	R0, #0
IT	NE
BNE	L_xEventGroupClearBits52
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupClearBits53:
IT	AL
BAL	L_xEventGroupClearBits53
L_xEventGroupClearBits52:
;event_groups.c,482 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;event_groups.c,488 :: 		uxReturn = pxEventBits->uxEventBits;
LDR	R0, [SP, #4]
LDR	R0, [R0, #0]
STR	R0, [SP, #8]
;event_groups.c,491 :: 		pxEventBits->uxEventBits &= ~uxBitsToClear;
LDR	R0, [SP, #4]
MOV	R2, R0
LDR	R0, [SP, #16]
MVN	R1, R0
LDR	R0, [R2, #0]
ANDS	R0, R1
STR	R0, [R2, #0]
;event_groups.c,493 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;event_groups.c,495 :: 		return uxReturn;
LDR	R0, [SP, #8]
;event_groups.c,496 :: 		}
L_end_xEventGroupClearBits:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _xEventGroupClearBits
_xEventGroupGetBitsFromISR:
;event_groups.c,514 :: 		EventBits_t xEventGroupGetBitsFromISR( EventGroupHandle_t xEventGroup )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;event_groups.c,517 :: 		EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
LDR	R0, [SP, #16]
STR	R0, [SP, #8]
;event_groups.c,520 :: 		uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
BL	event_groups_ulPortRaiseBASEPRI+0
STR	R0, [SP, #4]
;event_groups.c,522 :: 		uxReturn = pxEventBits->uxEventBits;
LDR	R0, [SP, #8]
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
;event_groups.c,524 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
LDR	R0, [SP, #4]
PUSH	(R0)
BL	event_groups_vPortSetBASEPRI+0
ADD	SP, SP, #4
;event_groups.c,526 :: 		return uxReturn;
LDR	R0, [SP, #12]
;event_groups.c,527 :: 		}
L_end_xEventGroupGetBitsFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xEventGroupGetBitsFromISR
_xEventGroupSetBits:
;event_groups.c,530 :: 		EventBits_t xEventGroupSetBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet )
SUB	SP, SP, #40
STR	LR, [SP, #0]
;event_groups.c,535 :: 		EventBits_t uxBitsToClear = 0, uxBitsWaitedFor, uxControlBits;
MOV	R0, #0
STR	R0, [SP, #32]
;event_groups.c,536 :: 		EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
LDR	R0, [SP, #40]
STR	R0, [SP, #28]
;event_groups.c,537 :: 		BaseType_t xMatchFound = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #36]
;event_groups.c,541 :: 		configASSERT( xEventGroup );
LDR	R0, [SP, #40]
CMP	R0, #0
IT	NE
BNE	L_xEventGroupSetBits55
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupSetBits56:
IT	AL
BAL	L_xEventGroupSetBits56
L_xEventGroupSetBits55:
;event_groups.c,542 :: 		configASSERT( ( uxBitsToSet & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
LDR	R0, [SP, #44]
AND	R0, R0, #-16777216
CMP	R0, #0
MOVW	R0, #0
BNE	L__xEventGroupSetBits99
MOVS	R0, #1
L__xEventGroupSetBits99:
CMP	R0, #0
IT	NE
BNE	L_xEventGroupSetBits58
BL	event_groups_vPortRaiseBASEPRI+0
L_xEventGroupSetBits59:
IT	AL
BAL	L_xEventGroupSetBits59
L_xEventGroupSetBits58:
;event_groups.c,544 :: 		pxList = &( pxEventBits->xTasksWaitingForBits );
LDR	R0, [SP, #28]
ADDS	R0, R0, #4
STR	R0, [SP, #16]
;event_groups.c,545 :: 		pxListEnd = listGET_END_MARKER( pxList ); /*lint !e826 !e740 The mini list structure is used as the list end to save RAM.  This is checked and valid. */
LDR	R0, [SP, #16]
ADDS	R0, #8
STR	R0, [SP, #12]
;event_groups.c,546 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;event_groups.c,550 :: 		pxListItem = listGET_HEAD_ENTRY( pxList );
LDR	R0, [SP, #16]
ADDS	R0, #8
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;event_groups.c,553 :: 		pxEventBits->uxEventBits |= uxBitsToSet;
LDR	R0, [SP, #28]
MOV	R2, R0
LDR	R1, [R2, #0]
LDR	R0, [SP, #44]
ORR	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;event_groups.c,556 :: 		while( pxListItem != pxListEnd )
L_xEventGroupSetBits61:
LDR	R1, [SP, #12]
LDR	R0, [SP, #4]
CMP	R0, R1
IT	EQ
BEQ	L_xEventGroupSetBits62
;event_groups.c,558 :: 		pxNext = listGET_NEXT( pxListItem );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [SP, #8]
;event_groups.c,559 :: 		uxBitsWaitedFor = listGET_LIST_ITEM_VALUE( pxListItem );
LDR	R0, [SP, #4]
LDR	R0, [R0, #0]
STR	R0, [SP, #20]
;event_groups.c,560 :: 		xMatchFound = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #36]
;event_groups.c,563 :: 		uxControlBits = uxBitsWaitedFor & eventEVENT_BITS_CONTROL_BYTES;
LDR	R0, [SP, #20]
AND	R0, R0, #-16777216
STR	R0, [SP, #24]
;event_groups.c,564 :: 		uxBitsWaitedFor &= ~eventEVENT_BITS_CONTROL_BYTES;
LDR	R1, [SP, #20]
MVN	R0, #-16777216
AND	R0, R1, R0, LSL #0
STR	R0, [SP, #20]
;event_groups.c,566 :: 		if( ( uxControlBits & eventWAIT_FOR_ALL_BITS ) == ( EventBits_t ) 0 )
LDR	R0, [SP, #24]
AND	R0, R0, #67108864
CMP	R0, #0
IT	NE
BNE	L_xEventGroupSetBits63
;event_groups.c,569 :: 		if( ( uxBitsWaitedFor & pxEventBits->uxEventBits ) != ( EventBits_t ) 0 )
LDR	R0, [SP, #28]
LDR	R1, [R0, #0]
LDR	R0, [SP, #20]
ANDS	R0, R1
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupSetBits64
;event_groups.c,571 :: 		xMatchFound = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #36]
;event_groups.c,572 :: 		}
IT	AL
BAL	L_xEventGroupSetBits65
L_xEventGroupSetBits64:
;event_groups.c,576 :: 		}
L_xEventGroupSetBits65:
;event_groups.c,577 :: 		}
IT	AL
BAL	L_xEventGroupSetBits66
L_xEventGroupSetBits63:
;event_groups.c,578 :: 		else if( ( uxBitsWaitedFor & pxEventBits->uxEventBits ) == uxBitsWaitedFor )
LDR	R0, [SP, #28]
LDR	R1, [R0, #0]
LDR	R0, [SP, #20]
AND	R1, R0, R1, LSL #0
LDR	R0, [SP, #20]
CMP	R1, R0
IT	NE
BNE	L_xEventGroupSetBits67
;event_groups.c,581 :: 		xMatchFound = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #36]
;event_groups.c,582 :: 		}
IT	AL
BAL	L_xEventGroupSetBits68
L_xEventGroupSetBits67:
;event_groups.c,586 :: 		}
L_xEventGroupSetBits68:
L_xEventGroupSetBits66:
;event_groups.c,588 :: 		if( xMatchFound != pdFALSE )
LDR	R0, [SP, #36]
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupSetBits69
;event_groups.c,591 :: 		if( ( uxControlBits & eventCLEAR_EVENTS_ON_EXIT_BIT ) != ( EventBits_t ) 0 )
LDR	R0, [SP, #24]
AND	R0, R0, #16777216
CMP	R0, #0
IT	EQ
BEQ	L_xEventGroupSetBits70
;event_groups.c,593 :: 		uxBitsToClear |= uxBitsWaitedFor;
LDR	R1, [SP, #20]
LDR	R0, [SP, #32]
ORRS	R0, R1
STR	R0, [SP, #32]
;event_groups.c,594 :: 		}
IT	AL
BAL	L_xEventGroupSetBits71
L_xEventGroupSetBits70:
;event_groups.c,598 :: 		}
L_xEventGroupSetBits71:
;event_groups.c,605 :: 		( void ) xTaskRemoveFromUnorderedEventList( pxListItem, pxEventBits->uxEventBits | eventUNBLOCKED_DUE_TO_BIT_SET );
LDR	R0, [SP, #28]
LDR	R0, [R0, #0]
ORR	R0, R0, #33554432
PUSH	(R0)
LDR	R0, [SP, #8]
PUSH	(R0)
BL	_xTaskRemoveFromUnorderedEventList+0
ADD	SP, SP, #8
;event_groups.c,606 :: 		}
L_xEventGroupSetBits69:
;event_groups.c,611 :: 		pxListItem = pxNext;
LDR	R0, [SP, #8]
STR	R0, [SP, #4]
;event_groups.c,612 :: 		}
IT	AL
BAL	L_xEventGroupSetBits61
L_xEventGroupSetBits62:
;event_groups.c,616 :: 		pxEventBits->uxEventBits &= ~uxBitsToClear;
LDR	R0, [SP, #28]
MOV	R2, R0
LDR	R0, [SP, #32]
MVN	R1, R0
LDR	R0, [R2, #0]
ANDS	R0, R1
STR	R0, [R2, #0]
;event_groups.c,618 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;event_groups.c,620 :: 		return pxEventBits->uxEventBits;
LDR	R0, [SP, #28]
LDR	R0, [R0, #0]
;event_groups.c,621 :: 		}
L_end_xEventGroupSetBits:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _xEventGroupSetBits
_vEventGroupDelete:
;event_groups.c,624 :: 		void vEventGroupDelete( EventGroupHandle_t xEventGroup )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;event_groups.c,626 :: 		EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
LDR	R0, [SP, #12]
STR	R0, [SP, #4]
;event_groups.c,627 :: 		const List_t *pxTasksWaitingForBits = &( pxEventBits->xTasksWaitingForBits );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
STR	R0, [SP, #8]
;event_groups.c,629 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;event_groups.c,633 :: 		while( listCURRENT_LIST_LENGTH( pxTasksWaitingForBits ) > ( UBaseType_t ) 0 )
L_vEventGroupDelete72:
LDR	R0, [SP, #8]
LDR	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_vEventGroupDelete73
;event_groups.c,637 :: 		configASSERT( pxTasksWaitingForBits->xListEnd.pxNext != ( ListItem_t * ) &( pxTasksWaitingForBits->xListEnd ) );
LDR	R0, [SP, #8]
ADDS	R0, #8
ADDS	R0, R0, #4
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
ADDS	R0, #8
CMP	R1, R0
MOVW	R0, #0
BEQ	L__vEventGroupDelete101
MOVS	R0, #1
L__vEventGroupDelete101:
CMP	R0, #0
IT	NE
BNE	L_vEventGroupDelete74
BL	event_groups_vPortRaiseBASEPRI+0
L_vEventGroupDelete75:
IT	AL
BAL	L_vEventGroupDelete75
L_vEventGroupDelete74:
;event_groups.c,638 :: 		( void ) xTaskRemoveFromUnorderedEventList( pxTasksWaitingForBits->xListEnd.pxNext, eventUNBLOCKED_DUE_TO_BIT_SET );
MOV	R0, #33554432
PUSH	(R0)
LDR	R0, [SP, #12]
ADDS	R0, #8
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
PUSH	(R0)
BL	_xTaskRemoveFromUnorderedEventList+0
ADD	SP, SP, #8
;event_groups.c,639 :: 		}
IT	AL
BAL	L_vEventGroupDelete72
L_vEventGroupDelete73:
;event_groups.c,645 :: 		vPortFree( pxEventBits );
LDR	R0, [SP, #4]
PUSH	(R0)
BL	_vPortFree+0
ADD	SP, SP, #4
;event_groups.c,662 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;event_groups.c,663 :: 		}
L_end_vEventGroupDelete:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vEventGroupDelete
_vEventGroupSetBitsCallback:
;event_groups.c,668 :: 		void vEventGroupSetBitsCallback( void *pvEventGroup, const uint32_t ulBitsToSet )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;event_groups.c,670 :: 		( void ) xEventGroupSetBits( pvEventGroup, ( EventBits_t ) ulBitsToSet );
LDR	R0, [SP, #8]
PUSH	(R0)
LDR	R0, [SP, #8]
PUSH	(R0)
BL	_xEventGroupSetBits+0
ADD	SP, SP, #8
;event_groups.c,671 :: 		}
L_end_vEventGroupSetBitsCallback:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vEventGroupSetBitsCallback
_vEventGroupClearBitsCallback:
;event_groups.c,676 :: 		void vEventGroupClearBitsCallback( void *pvEventGroup, const uint32_t ulBitsToClear )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;event_groups.c,678 :: 		( void ) xEventGroupClearBits( pvEventGroup, ( EventBits_t ) ulBitsToClear );
LDR	R0, [SP, #8]
PUSH	(R0)
LDR	R0, [SP, #8]
PUSH	(R0)
BL	_xEventGroupClearBits+0
ADD	SP, SP, #8
;event_groups.c,679 :: 		}
L_end_vEventGroupClearBitsCallback:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vEventGroupClearBitsCallback
event_groups_prvTestWaitCondition:
;event_groups.c,682 :: 		static BaseType_t prvTestWaitCondition( const EventBits_t uxCurrentEventBits, const EventBits_t uxBitsToWaitFor, const BaseType_t xWaitForAllBits )
SUB	SP, SP, #4
;event_groups.c,684 :: 		BaseType_t xWaitConditionMet = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #0]
;event_groups.c,686 :: 		if( xWaitForAllBits == pdFALSE )
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_event_groups_prvTestWaitCondition77
;event_groups.c,690 :: 		if( ( uxCurrentEventBits & uxBitsToWaitFor ) != ( EventBits_t ) 0 )
LDR	R1, [SP, #8]
LDR	R0, [SP, #4]
ANDS	R0, R1
CMP	R0, #0
IT	EQ
BEQ	L_event_groups_prvTestWaitCondition78
;event_groups.c,692 :: 		xWaitConditionMet = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #0]
;event_groups.c,693 :: 		}
IT	AL
BAL	L_event_groups_prvTestWaitCondition79
L_event_groups_prvTestWaitCondition78:
;event_groups.c,697 :: 		}
L_event_groups_prvTestWaitCondition79:
;event_groups.c,698 :: 		}
IT	AL
BAL	L_event_groups_prvTestWaitCondition80
L_event_groups_prvTestWaitCondition77:
;event_groups.c,703 :: 		if( ( uxCurrentEventBits & uxBitsToWaitFor ) == uxBitsToWaitFor )
LDR	R1, [SP, #8]
LDR	R0, [SP, #4]
AND	R1, R0, R1, LSL #0
LDR	R0, [SP, #8]
CMP	R1, R0
IT	NE
BNE	L_event_groups_prvTestWaitCondition81
;event_groups.c,705 :: 		xWaitConditionMet = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #0]
;event_groups.c,706 :: 		}
IT	AL
BAL	L_event_groups_prvTestWaitCondition82
L_event_groups_prvTestWaitCondition81:
;event_groups.c,710 :: 		}
L_event_groups_prvTestWaitCondition82:
;event_groups.c,711 :: 		}
L_event_groups_prvTestWaitCondition80:
;event_groups.c,713 :: 		return xWaitConditionMet;
LDR	R0, [SP, #0]
;event_groups.c,714 :: 		}
L_end_prvTestWaitCondition:
ADD	SP, SP, #4
BX	LR
; end of event_groups_prvTestWaitCondition
