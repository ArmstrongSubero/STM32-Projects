tasks_ucPortCountLeadingZeros:
;portmacro.h,176 :: 		static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
;portmacro.h,178 :: 		asm CLZ R0, R0;
CLZ	R0, R0
;portmacro.h,179 :: 		return R0;
UXTB	R0, R0
;portmacro.h,180 :: 		}
L_end_ucPortCountLeadingZeros:
BX	LR
; end of tasks_ucPortCountLeadingZeros
tasks_xPortIsInsideInterrupt:
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
BNE	L_tasks_xPortIsInsideInterrupt0
;portmacro.h,228 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;portmacro.h,229 :: 		}
IT	AL
BAL	L_tasks_xPortIsInsideInterrupt1
L_tasks_xPortIsInsideInterrupt0:
;portmacro.h,232 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;portmacro.h,233 :: 		}
L_tasks_xPortIsInsideInterrupt1:
;portmacro.h,235 :: 		return xReturn;
LDR	R0, [SP, #4]
;portmacro.h,236 :: 		}
L_end_xPortIsInsideInterrupt:
ADD	SP, SP, #8
BX	LR
; end of tasks_xPortIsInsideInterrupt
tasks_vPortRaiseBASEPRI:
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
; end of tasks_vPortRaiseBASEPRI
tasks_ulPortRaiseBASEPRI:
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
; end of tasks_ulPortRaiseBASEPRI
tasks_vPortSetBASEPRI:
;portmacro.h,268 :: 		portFORCE_INLINE static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
;portmacro.h,270 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,271 :: 		}
L_end_vPortSetBASEPRI:
BX	LR
; end of tasks_vPortSetBASEPRI
_xTaskCreate:
;tasks.c,681 :: 		TaskHandle_t * const pxCreatedTask ) /*lint !e971 Unqualified char types are allowed for strings and single characters only. */
SUB	SP, SP, #16
STR	LR, [SP, #0]
;tasks.c,716 :: 		pxStack = ( StackType_t * ) pvPortMalloc( ( ( ( size_t ) usStackDepth ) * sizeof( StackType_t ) ) ); /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
LDRH	R1, [SP, #24]
MOVS	R0, #4
MULS	R0, R1, R0
PUSH	(R0)
BL	_pvPortMalloc+0
ADD	SP, SP, #4
STR	R0, [SP, #4]
;tasks.c,718 :: 		if( pxStack != NULL )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskCreate2
;tasks.c,721 :: 		pxNewTCB = ( TCB_t * ) pvPortMalloc( sizeof( TCB_t ) ); /*lint !e961 MISRA exception as the casts are only redundant for some paths. */
MOVS	R0, #84
PUSH	(R0)
BL	_pvPortMalloc+0
ADD	SP, SP, #4
STR	R0, [SP, #8]
;tasks.c,723 :: 		if( pxNewTCB != NULL )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskCreate3
;tasks.c,726 :: 		pxNewTCB->pxStack = pxStack;
LDR	R0, [SP, #8]
ADDW	R1, R0, #48
LDR	R0, [SP, #4]
STR	R0, [R1, #0]
;tasks.c,727 :: 		}
IT	AL
BAL	L_xTaskCreate4
L_xTaskCreate3:
;tasks.c,732 :: 		vPortFree( pxStack );
LDR	R0, [SP, #4]
PUSH	(R0)
BL	_vPortFree+0
ADD	SP, SP, #4
;tasks.c,733 :: 		}
L_xTaskCreate4:
;tasks.c,734 :: 		}
IT	AL
BAL	L_xTaskCreate5
L_xTaskCreate2:
;tasks.c,737 :: 		pxNewTCB = NULL;
MOVS	R0, #0
STR	R0, [SP, #8]
;tasks.c,738 :: 		}
L_xTaskCreate5:
;tasks.c,742 :: 		if( pxNewTCB != NULL )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskCreate6
;tasks.c,752 :: 		prvInitialiseNewTask( pxTaskCode, pcName, ( uint32_t ) usStackDepth, pvParameters, uxPriority, pxCreatedTask, pxNewTCB, NULL );
MOVS	R0, #0
PUSH	(R0)
LDR	R0, [SP, #12]
PUSH	(R0)
LDR	R0, [SP, #44]
PUSH	(R0)
LDR	R0, [SP, #44]
PUSH	(R0)
LDR	R0, [SP, #44]
PUSH	(R0)
LDRH	R0, [SP, #44]
PUSH	(R0)
LDR	R0, [SP, #44]
PUSH	(R0)
LDR	R0, [SP, #44]
PUSH	(R0)
BL	tasks_prvInitialiseNewTask+0
ADD	SP, SP, #32
;tasks.c,753 :: 		prvAddNewTaskToReadyList( pxNewTCB );
LDR	R0, [SP, #8]
PUSH	(R0)
BL	tasks_prvAddNewTaskToReadyList+0
ADD	SP, SP, #4
;tasks.c,754 :: 		xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #12]
;tasks.c,755 :: 		}
IT	AL
BAL	L_xTaskCreate7
L_xTaskCreate6:
;tasks.c,758 :: 		xReturn = errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY;
MOV	R0, #-1
STR	R0, [SP, #12]
;tasks.c,759 :: 		}
L_xTaskCreate7:
;tasks.c,761 :: 		return xReturn;
LDR	R0, [SP, #12]
;tasks.c,762 :: 		}
L_end_xTaskCreate:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xTaskCreate
tasks_prvInitialiseNewTask:
;tasks.c,774 :: 		const MemoryRegion_t * const xRegions ) /*lint !e971 Unqualified char types are allowed for strings and single characters only. */
SUB	SP, SP, #16
STR	LR, [SP, #0]
;tasks.c,807 :: 		pxTopOfStack = pxNewTCB->pxStack + ( ulStackDepth - ( uint32_t ) 1 );
LDR	R0, [SP, #40]
ADDS	R0, #48
LDR	R2, [R0, #0]
LDR	R0, [SP, #24]
SUBS	R1, R0, #1
MOVS	R0, #4
MULS	R0, R1, R0
ADDS	R0, R2, R0
STR	R0, [SP, #4]
;tasks.c,808 :: 		pxTopOfStack = ( StackType_t * ) ( ( ( portPOINTER_SIZE_TYPE ) pxTopOfStack ) & ( ~( ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK ) ) ); /*lint !e923 MISRA exception.  Avoiding casts between pointers and integers is not practical.  Size differences accounted for using portPOINTER_SIZE_TYPE type. */
LDR	R1, [SP, #4]
MVN	R0, #7
AND	R0, R1, R0, LSL #0
STR	R0, [SP, #4]
;tasks.c,811 :: 		configASSERT( ( ( ( portPOINTER_SIZE_TYPE ) pxTopOfStack & ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK ) == 0UL ) );
LDR	R0, [SP, #4]
AND	R0, R0, #7
CMP	R0, #0
MOVW	R0, #0
BNE	L_tasks_prvInitialiseNewTask394
MOVS	R0, #1
L_tasks_prvInitialiseNewTask394:
CMP	R0, #0
IT	NE
BNE	L_tasks_prvInitialiseNewTask8
BL	tasks_vPortRaiseBASEPRI+0
L_tasks_prvInitialiseNewTask9:
IT	AL
BAL	L_tasks_prvInitialiseNewTask9
L_tasks_prvInitialiseNewTask8:
;tasks.c,827 :: 		for( x = ( UBaseType_t ) 0; x < ( UBaseType_t ) configMAX_TASK_NAME_LEN; x++ )
MOV	R0, #0
STR	R0, [SP, #8]
L_tasks_prvInitialiseNewTask11:
LDR	R0, [SP, #8]
CMP	R0, #16
IT	CS
BCS	L_tasks_prvInitialiseNewTask12
;tasks.c,829 :: 		pxNewTCB->pcTaskName[ x ] = pcName[ x ];
LDR	R0, [SP, #40]
ADDS	R0, #52
MOV	R1, R0
LDR	R0, [SP, #8]
ADDS	R2, R1, R0
LDR	R1, [SP, #8]
LDR	R0, [SP, #20]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;tasks.c,834 :: 		if( pcName[ x ] == 0x00 )
LDR	R1, [SP, #8]
LDR	R0, [SP, #20]
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_tasks_prvInitialiseNewTask14
;tasks.c,836 :: 		break;
IT	AL
BAL	L_tasks_prvInitialiseNewTask12
;tasks.c,837 :: 		}
L_tasks_prvInitialiseNewTask14:
;tasks.c,827 :: 		for( x = ( UBaseType_t ) 0; x < ( UBaseType_t ) configMAX_TASK_NAME_LEN; x++ )
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;tasks.c,842 :: 		}
IT	AL
BAL	L_tasks_prvInitialiseNewTask11
L_tasks_prvInitialiseNewTask12:
;tasks.c,846 :: 		pxNewTCB->pcTaskName[ configMAX_TASK_NAME_LEN - 1 ] = '\0';
LDR	R0, [SP, #40]
ADDS	R0, #52
ADDW	R1, R0, #15
MOVS	R0, #0
STRB	R0, [R1, #0]
;tasks.c,850 :: 		if( uxPriority >= ( UBaseType_t ) configMAX_PRIORITIES )
LDR	R0, [SP, #32]
CMP	R0, #16
IT	CC
BCC	L_tasks_prvInitialiseNewTask16
;tasks.c,852 :: 		uxPriority = ( UBaseType_t ) configMAX_PRIORITIES - ( UBaseType_t ) 1U;
MOV	R0, #15
STR	R0, [SP, #32]
;tasks.c,853 :: 		}
IT	AL
BAL	L_tasks_prvInitialiseNewTask17
L_tasks_prvInitialiseNewTask16:
;tasks.c,857 :: 		}
L_tasks_prvInitialiseNewTask17:
;tasks.c,859 :: 		pxNewTCB->uxPriority = uxPriority;
LDR	R0, [SP, #40]
ADDW	R1, R0, #44
LDR	R0, [SP, #32]
STR	R0, [R1, #0]
;tasks.c,862 :: 		pxNewTCB->uxBasePriority = uxPriority;
LDR	R0, [SP, #40]
ADDW	R1, R0, #68
LDR	R0, [SP, #32]
STR	R0, [R1, #0]
;tasks.c,863 :: 		pxNewTCB->uxMutexesHeld = 0;
LDR	R0, [SP, #40]
ADDW	R1, R0, #72
MOVS	R0, #0
STR	R0, [R1, #0]
;tasks.c,867 :: 		vListInitialiseItem( &( pxNewTCB->xStateListItem ) );
LDR	R0, [SP, #40]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_vListInitialiseItem+0
ADD	SP, SP, #4
;tasks.c,868 :: 		vListInitialiseItem( &( pxNewTCB->xEventListItem ) );
LDR	R0, [SP, #40]
ADDS	R0, #24
PUSH	(R0)
BL	_vListInitialiseItem+0
ADD	SP, SP, #4
;tasks.c,872 :: 		listSET_LIST_ITEM_OWNER( &( pxNewTCB->xStateListItem ), pxNewTCB );
LDR	R0, [SP, #40]
ADDS	R0, R0, #4
ADDW	R1, R0, #12
LDR	R0, [SP, #40]
STR	R0, [R1, #0]
;tasks.c,875 :: 		listSET_LIST_ITEM_VALUE( &( pxNewTCB->xEventListItem ), ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) uxPriority ); /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
LDR	R0, [SP, #40]
ADDS	R0, #24
MOV	R1, R0
LDR	R0, [SP, #32]
RSB	R0, R0, #16
STR	R0, [R1, #0]
;tasks.c,876 :: 		listSET_LIST_ITEM_OWNER( &( pxNewTCB->xEventListItem ), pxNewTCB );
LDR	R0, [SP, #40]
ADDS	R0, #24
ADDW	R1, R0, #12
LDR	R0, [SP, #40]
STR	R0, [R1, #0]
;tasks.c,918 :: 		pxNewTCB->ulNotifiedValue = 0;
LDR	R0, [SP, #40]
ADDW	R1, R0, #76
MOVS	R0, #0
STR	R0, [R1, #0]
;tasks.c,919 :: 		pxNewTCB->ucNotifyState = taskNOT_WAITING_NOTIFICATION;
LDR	R0, [SP, #40]
ADDW	R1, R0, #80
MOVS	R0, #0
STRB	R0, [R1, #0]
;tasks.c,946 :: 		pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxTaskCode, pvParameters );
LDR	R0, [SP, #40]
STR	R0, [SP, #12]
LDR	R0, [SP, #28]
PUSH	(R0)
LDR	R0, [SP, #20]
PUSH	(R0)
LDR	R0, [SP, #12]
PUSH	(R0)
BL	_pxPortInitialiseStack+0
ADD	SP, SP, #12
LDR	R1, [SP, #12]
STR	R0, [R1, #0]
;tasks.c,950 :: 		if( ( void * ) pxCreatedTask != NULL )
LDR	R0, [SP, #36]
CMP	R0, #0
IT	EQ
BEQ	L_tasks_prvInitialiseNewTask18
;tasks.c,954 :: 		*pxCreatedTask = ( TaskHandle_t ) pxNewTCB;
LDR	R1, [SP, #40]
LDR	R0, [SP, #36]
STR	R1, [R0, #0]
;tasks.c,955 :: 		}
IT	AL
BAL	L_tasks_prvInitialiseNewTask19
L_tasks_prvInitialiseNewTask18:
;tasks.c,959 :: 		}
L_tasks_prvInitialiseNewTask19:
;tasks.c,960 :: 		}
L_end_prvInitialiseNewTask:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of tasks_prvInitialiseNewTask
tasks_prvAddNewTaskToReadyList:
;tasks.c,963 :: 		static void prvAddNewTaskToReadyList( TCB_t *pxNewTCB )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tasks.c,967 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,969 :: 		uxCurrentNumberOfTasks++;
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
STR	R1, [R0, #0]
;tasks.c,970 :: 		if( pxCurrentTCB == NULL )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_tasks_prvAddNewTaskToReadyList20
;tasks.c,974 :: 		pxCurrentTCB = pxNewTCB;
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
STR	R1, [R0, #0]
;tasks.c,976 :: 		if( uxCurrentNumberOfTasks == ( UBaseType_t ) 1 )
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_tasks_prvAddNewTaskToReadyList21
;tasks.c,981 :: 		prvInitialiseTaskLists();
BL	tasks_prvInitialiseTaskLists+0
;tasks.c,982 :: 		}
IT	AL
BAL	L_tasks_prvAddNewTaskToReadyList22
L_tasks_prvAddNewTaskToReadyList21:
;tasks.c,986 :: 		}
L_tasks_prvAddNewTaskToReadyList22:
;tasks.c,987 :: 		}
IT	AL
BAL	L_tasks_prvAddNewTaskToReadyList23
L_tasks_prvAddNewTaskToReadyList20:
;tasks.c,993 :: 		if( xSchedulerRunning == pdFALSE )
MOVW	R0, #lo_addr(tasks_xSchedulerRunning+0)
MOVT	R0, #hi_addr(tasks_xSchedulerRunning+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_tasks_prvAddNewTaskToReadyList24
;tasks.c,995 :: 		if( pxCurrentTCB->uxPriority <= pxNewTCB->uxPriority )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	HI
BHI	L_tasks_prvAddNewTaskToReadyList25
;tasks.c,997 :: 		pxCurrentTCB = pxNewTCB;
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
STR	R1, [R0, #0]
;tasks.c,998 :: 		}
IT	AL
BAL	L_tasks_prvAddNewTaskToReadyList26
L_tasks_prvAddNewTaskToReadyList25:
;tasks.c,1002 :: 		}
L_tasks_prvAddNewTaskToReadyList26:
;tasks.c,1003 :: 		}
IT	AL
BAL	L_tasks_prvAddNewTaskToReadyList27
L_tasks_prvAddNewTaskToReadyList24:
;tasks.c,1007 :: 		}
L_tasks_prvAddNewTaskToReadyList27:
;tasks.c,1008 :: 		}
L_tasks_prvAddNewTaskToReadyList23:
;tasks.c,1010 :: 		uxTaskNumber++;
MOVW	R0, #lo_addr(tasks_uxTaskNumber+0)
MOVT	R0, #hi_addr(tasks_uxTaskNumber+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxTaskNumber+0)
MOVT	R0, #hi_addr(tasks_uxTaskNumber+0)
STR	R1, [R0, #0]
;tasks.c,1020 :: 		prvAddTaskToReadyList( pxNewTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,1024 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,1026 :: 		if( xSchedulerRunning != pdFALSE )
MOVW	R0, #lo_addr(tasks_xSchedulerRunning+0)
MOVT	R0, #hi_addr(tasks_xSchedulerRunning+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_tasks_prvAddNewTaskToReadyList28
;tasks.c,1030 :: 		if( pxCurrentTCB->uxPriority < pxNewTCB->uxPriority )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CS
BCS	L_tasks_prvAddNewTaskToReadyList29
;tasks.c,1032 :: 		taskYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,1033 :: 		}
IT	AL
BAL	L_tasks_prvAddNewTaskToReadyList30
L_tasks_prvAddNewTaskToReadyList29:
;tasks.c,1037 :: 		}
L_tasks_prvAddNewTaskToReadyList30:
;tasks.c,1038 :: 		}
IT	AL
BAL	L_tasks_prvAddNewTaskToReadyList31
L_tasks_prvAddNewTaskToReadyList28:
;tasks.c,1042 :: 		}
L_tasks_prvAddNewTaskToReadyList31:
;tasks.c,1043 :: 		}
L_end_prvAddNewTaskToReadyList:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of tasks_prvAddNewTaskToReadyList
_vTaskDelete:
;tasks.c,1048 :: 		void vTaskDelete( TaskHandle_t xTaskToDelete )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,1052 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,1056 :: 		pxTCB = prvGetTCBFromHandle( xTaskToDelete );
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_vTaskDelete32
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
IT	AL
BAL	L_vTaskDelete33
L_vTaskDelete32:
LDR	R0, [SP, #12]
STR	R0, [SP, #4]
L_vTaskDelete33:
LDR	R0, [SP, #4]
STR	R0, [SP, #8]
;tasks.c,1059 :: 		if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
CMP	R0, #0
IT	NE
BNE	L_vTaskDelete34
;tasks.c,1061 :: 		taskRESET_READY_PRIORITY( pxTCB->uxPriority );
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vTaskDelete35
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSLS	R0, R1
MVN	R1, R0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
AND	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
L_vTaskDelete35:
;tasks.c,1062 :: 		}
IT	AL
BAL	L_vTaskDelete36
L_vTaskDelete34:
;tasks.c,1066 :: 		}
L_vTaskDelete36:
;tasks.c,1069 :: 		if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) != NULL )
LDR	R0, [SP, #8]
ADDS	R0, #24
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskDelete37
;tasks.c,1071 :: 		( void ) uxListRemove( &( pxTCB->xEventListItem ) );
LDR	R0, [SP, #8]
ADDS	R0, #24
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,1072 :: 		}
IT	AL
BAL	L_vTaskDelete38
L_vTaskDelete37:
;tasks.c,1076 :: 		}
L_vTaskDelete38:
;tasks.c,1082 :: 		uxTaskNumber++;
MOVW	R0, #lo_addr(tasks_uxTaskNumber+0)
MOVT	R0, #hi_addr(tasks_uxTaskNumber+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxTaskNumber+0)
MOVT	R0, #hi_addr(tasks_uxTaskNumber+0)
STR	R1, [R0, #0]
;tasks.c,1084 :: 		if( pxTCB == pxCurrentTCB )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	NE
BNE	L_vTaskDelete39
;tasks.c,1091 :: 		vListInsertEnd( &xTasksWaitingTermination, &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_xTasksWaitingTermination+0)
MOVT	R0, #hi_addr(tasks_xTasksWaitingTermination+0)
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,1096 :: 		++uxDeletedTasksWaitingCleanUp;
MOVW	R0, #lo_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
MOVT	R0, #hi_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
MOVT	R0, #hi_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
STR	R1, [R0, #0]
;tasks.c,1104 :: 		}
IT	AL
BAL	L_vTaskDelete40
L_vTaskDelete39:
;tasks.c,1107 :: 		--uxCurrentNumberOfTasks;
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
STR	R1, [R0, #0]
;tasks.c,1108 :: 		prvDeleteTCB( pxTCB );
LDR	R0, [SP, #8]
PUSH	(R0)
BL	tasks_prvDeleteTCB+0
ADD	SP, SP, #4
;tasks.c,1112 :: 		prvResetNextTaskUnblockTime();
BL	tasks_prvResetNextTaskUnblockTime+0
;tasks.c,1113 :: 		}
L_vTaskDelete40:
;tasks.c,1117 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,1121 :: 		if( xSchedulerRunning != pdFALSE )
MOVW	R0, #lo_addr(tasks_xSchedulerRunning+0)
MOVT	R0, #hi_addr(tasks_xSchedulerRunning+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskDelete41
;tasks.c,1123 :: 		if( pxTCB == pxCurrentTCB )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	NE
BNE	L_vTaskDelete42
;tasks.c,1125 :: 		configASSERT( uxSchedulerSuspended == 0 );
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__vTaskDelete397
MOVS	R0, #1
L__vTaskDelete397:
CMP	R0, #0
IT	NE
BNE	L_vTaskDelete43
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskDelete44:
IT	AL
BAL	L_vTaskDelete44
L_vTaskDelete43:
;tasks.c,1126 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,1127 :: 		}
IT	AL
BAL	L_vTaskDelete46
L_vTaskDelete42:
;tasks.c,1131 :: 		}
L_vTaskDelete46:
;tasks.c,1132 :: 		}
L_vTaskDelete41:
;tasks.c,1133 :: 		}
L_end_vTaskDelete:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vTaskDelete
_vTaskDelayUntil:
;tasks.c,1140 :: 		void vTaskDelayUntil( TickType_t * const pxPreviousWakeTime, const TickType_t xTimeIncrement )
SUB	SP, SP, #20
STR	LR, [SP, #0]
;tasks.c,1143 :: 		BaseType_t xAlreadyYielded, xShouldDelay = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #16]
;tasks.c,1145 :: 		configASSERT( pxPreviousWakeTime );
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_vTaskDelayUntil47
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskDelayUntil48:
IT	AL
BAL	L_vTaskDelayUntil48
L_vTaskDelayUntil47:
;tasks.c,1146 :: 		configASSERT( ( xTimeIncrement > 0U ) );
LDR	R0, [SP, #24]
CMP	R0, #0
MOVW	R0, #0
BLS	L__vTaskDelayUntil399
MOVS	R0, #1
L__vTaskDelayUntil399:
CMP	R0, #0
IT	NE
BNE	L_vTaskDelayUntil50
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskDelayUntil51:
IT	AL
BAL	L_vTaskDelayUntil51
L_vTaskDelayUntil50:
;tasks.c,1147 :: 		configASSERT( uxSchedulerSuspended == 0 );
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__vTaskDelayUntil400
MOVS	R0, #1
L__vTaskDelayUntil400:
CMP	R0, #0
IT	NE
BNE	L_vTaskDelayUntil53
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskDelayUntil54:
IT	AL
BAL	L_vTaskDelayUntil54
L_vTaskDelayUntil53:
;tasks.c,1149 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;tasks.c,1153 :: 		const TickType_t xConstTickCount = xTickCount;
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;tasks.c,1156 :: 		xTimeToWake = *pxPreviousWakeTime + xTimeIncrement;
LDR	R0, [SP, #20]
LDR	R1, [R0, #0]
LDR	R0, [SP, #24]
ADDS	R0, R1, R0
STR	R0, [SP, #8]
;tasks.c,1158 :: 		if( xConstTickCount < *pxPreviousWakeTime )
LDR	R0, [SP, #20]
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_vTaskDelayUntil56
;tasks.c,1165 :: 		if( ( xTimeToWake < *pxPreviousWakeTime ) && ( xTimeToWake > xConstTickCount ) )
LDR	R0, [SP, #20]
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	CS
BCS	L_vTaskDelayUntil59
LDR	R1, [SP, #4]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	LS
BLS	L_vTaskDelayUntil59
L__vTaskDelayUntil383:
;tasks.c,1167 :: 		xShouldDelay = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #16]
;tasks.c,1168 :: 		}
IT	AL
BAL	L_vTaskDelayUntil60
L_vTaskDelayUntil59:
;tasks.c,1172 :: 		}
L_vTaskDelayUntil60:
;tasks.c,1173 :: 		}
IT	AL
BAL	L_vTaskDelayUntil61
L_vTaskDelayUntil56:
;tasks.c,1179 :: 		if( ( xTimeToWake < *pxPreviousWakeTime ) || ( xTimeToWake > xConstTickCount ) )
LDR	R0, [SP, #20]
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	CC
BCC	L__vTaskDelayUntil382
LDR	R1, [SP, #4]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	HI
BHI	L__vTaskDelayUntil382
IT	AL
BAL	L_vTaskDelayUntil64
L__vTaskDelayUntil382:
;tasks.c,1181 :: 		xShouldDelay = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #16]
;tasks.c,1182 :: 		}
IT	AL
BAL	L_vTaskDelayUntil65
L_vTaskDelayUntil64:
;tasks.c,1186 :: 		}
L_vTaskDelayUntil65:
;tasks.c,1187 :: 		}
L_vTaskDelayUntil61:
;tasks.c,1190 :: 		*pxPreviousWakeTime = xTimeToWake;
LDR	R1, [SP, #8]
LDR	R0, [SP, #20]
STR	R1, [R0, #0]
;tasks.c,1192 :: 		if( xShouldDelay != pdFALSE )
LDR	R0, [SP, #16]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskDelayUntil66
;tasks.c,1198 :: 		prvAddCurrentTaskToDelayedList( xTimeToWake - xConstTickCount, pdFALSE );
MOV	R0, #0
PUSH	(R0)
LDR	R1, [SP, #8]
LDR	R0, [SP, #12]
SUB	R0, R0, R1
PUSH	(R0)
BL	tasks_prvAddCurrentTaskToDelayedList+0
ADD	SP, SP, #8
;tasks.c,1199 :: 		}
IT	AL
BAL	L_vTaskDelayUntil67
L_vTaskDelayUntil66:
;tasks.c,1203 :: 		}
L_vTaskDelayUntil67:
;tasks.c,1205 :: 		xAlreadyYielded = xTaskResumeAll();
BL	_xTaskResumeAll+0
STR	R0, [SP, #12]
;tasks.c,1209 :: 		if( xAlreadyYielded == pdFALSE )
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_vTaskDelayUntil68
;tasks.c,1211 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,1212 :: 		}
IT	AL
BAL	L_vTaskDelayUntil69
L_vTaskDelayUntil68:
;tasks.c,1216 :: 		}
L_vTaskDelayUntil69:
;tasks.c,1217 :: 		}
L_end_vTaskDelayUntil:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _vTaskDelayUntil
_vTaskDelay:
;tasks.c,1224 :: 		void vTaskDelay( const TickType_t xTicksToDelay )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;tasks.c,1226 :: 		BaseType_t xAlreadyYielded = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;tasks.c,1229 :: 		if( xTicksToDelay > ( TickType_t ) 0U )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	LS
BLS	L_vTaskDelay70
;tasks.c,1231 :: 		configASSERT( uxSchedulerSuspended == 0 );
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__vTaskDelay402
MOVS	R0, #1
L__vTaskDelay402:
CMP	R0, #0
IT	NE
BNE	L_vTaskDelay71
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskDelay72:
IT	AL
BAL	L_vTaskDelay72
L_vTaskDelay71:
;tasks.c,1232 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;tasks.c,1243 :: 		prvAddCurrentTaskToDelayedList( xTicksToDelay, pdFALSE );
MOV	R0, #0
PUSH	(R0)
LDR	R0, [SP, #12]
PUSH	(R0)
BL	tasks_prvAddCurrentTaskToDelayedList+0
ADD	SP, SP, #8
;tasks.c,1245 :: 		xAlreadyYielded = xTaskResumeAll();
BL	_xTaskResumeAll+0
STR	R0, [SP, #4]
;tasks.c,1246 :: 		}
IT	AL
BAL	L_vTaskDelay74
L_vTaskDelay70:
;tasks.c,1250 :: 		}
L_vTaskDelay74:
;tasks.c,1254 :: 		if( xAlreadyYielded == pdFALSE )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_vTaskDelay75
;tasks.c,1256 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,1257 :: 		}
IT	AL
BAL	L_vTaskDelay76
L_vTaskDelay75:
;tasks.c,1261 :: 		}
L_vTaskDelay76:
;tasks.c,1262 :: 		}
L_end_vTaskDelay:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vTaskDelay
_uxTaskPriorityGet:
;tasks.c,1340 :: 		UBaseType_t uxTaskPriorityGet( TaskHandle_t xTask )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;tasks.c,1345 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,1349 :: 		pxTCB = prvGetTCBFromHandle( xTask );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_uxTaskPriorityGet77
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
IT	AL
BAL	L_uxTaskPriorityGet78
L_uxTaskPriorityGet77:
LDR	R0, [SP, #16]
STR	R0, [SP, #4]
L_uxTaskPriorityGet78:
LDR	R0, [SP, #4]
STR	R0, [SP, #8]
;tasks.c,1350 :: 		uxReturn = pxTCB->uxPriority;
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
;tasks.c,1352 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,1354 :: 		return uxReturn;
LDR	R0, [SP, #12]
;tasks.c,1355 :: 		}
L_end_uxTaskPriorityGet:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _uxTaskPriorityGet
_uxTaskPriorityGetFromISR:
;tasks.c,1362 :: 		UBaseType_t uxTaskPriorityGetFromISR( TaskHandle_t xTask )
SUB	SP, SP, #20
STR	LR, [SP, #0]
;tasks.c,1383 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;tasks.c,1385 :: 		uxSavedInterruptState = portSET_INTERRUPT_MASK_FROM_ISR();
BL	tasks_ulPortRaiseBASEPRI+0
STR	R0, [SP, #16]
;tasks.c,1389 :: 		pxTCB = prvGetTCBFromHandle( xTask );
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_uxTaskPriorityGetFromISR79
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
IT	AL
BAL	L_uxTaskPriorityGetFromISR80
L_uxTaskPriorityGetFromISR79:
LDR	R0, [SP, #20]
STR	R0, [SP, #4]
L_uxTaskPriorityGetFromISR80:
LDR	R0, [SP, #4]
STR	R0, [SP, #8]
;tasks.c,1390 :: 		uxReturn = pxTCB->uxPriority;
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
;tasks.c,1392 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptState );
LDR	R0, [SP, #16]
PUSH	(R0)
BL	tasks_vPortSetBASEPRI+0
ADD	SP, SP, #4
;tasks.c,1394 :: 		return uxReturn;
LDR	R0, [SP, #12]
;tasks.c,1395 :: 		}
L_end_uxTaskPriorityGetFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _uxTaskPriorityGetFromISR
_vTaskPrioritySet:
;tasks.c,1402 :: 		void vTaskPrioritySet( TaskHandle_t xTask, UBaseType_t uxNewPriority )
SUB	SP, SP, #24
STR	LR, [SP, #0]
;tasks.c,1406 :: 		BaseType_t xYieldRequired = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #20]
;tasks.c,1408 :: 		configASSERT( ( uxNewPriority < configMAX_PRIORITIES ) );
LDR	R0, [SP, #28]
CMP	R0, #16
MOVW	R0, #0
BCS	L__vTaskPrioritySet406
MOVS	R0, #1
L__vTaskPrioritySet406:
CMP	R0, #0
IT	NE
BNE	L_vTaskPrioritySet81
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskPrioritySet82:
IT	AL
BAL	L_vTaskPrioritySet82
L_vTaskPrioritySet81:
;tasks.c,1411 :: 		if( uxNewPriority >= ( UBaseType_t ) configMAX_PRIORITIES )
LDR	R0, [SP, #28]
CMP	R0, #16
IT	CC
BCC	L_vTaskPrioritySet84
;tasks.c,1413 :: 		uxNewPriority = ( UBaseType_t ) configMAX_PRIORITIES - ( UBaseType_t ) 1U;
MOV	R0, #15
STR	R0, [SP, #28]
;tasks.c,1414 :: 		}
IT	AL
BAL	L_vTaskPrioritySet85
L_vTaskPrioritySet84:
;tasks.c,1418 :: 		}
L_vTaskPrioritySet85:
;tasks.c,1420 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,1424 :: 		pxTCB = prvGetTCBFromHandle( xTask );
LDR	R0, [SP, #24]
CMP	R0, #0
IT	NE
BNE	L_vTaskPrioritySet86
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
IT	AL
BAL	L_vTaskPrioritySet87
L_vTaskPrioritySet86:
LDR	R0, [SP, #24]
STR	R0, [SP, #4]
L_vTaskPrioritySet87:
LDR	R0, [SP, #4]
STR	R0, [SP, #8]
;tasks.c,1430 :: 		uxCurrentBasePriority = pxTCB->uxBasePriority;
LDR	R0, [SP, #8]
ADDS	R0, #68
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
;tasks.c,1438 :: 		if( uxCurrentBasePriority != uxNewPriority )
LDR	R1, [SP, #28]
LDR	R0, [SP, #12]
CMP	R0, R1
IT	EQ
BEQ	L_vTaskPrioritySet88
;tasks.c,1442 :: 		if( uxNewPriority > uxCurrentBasePriority )
LDR	R1, [SP, #12]
LDR	R0, [SP, #28]
CMP	R0, R1
IT	LS
BLS	L_vTaskPrioritySet89
;tasks.c,1444 :: 		if( pxTCB != pxCurrentTCB )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	EQ
BEQ	L_vTaskPrioritySet90
;tasks.c,1449 :: 		if( uxNewPriority >= pxCurrentTCB->uxPriority )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R1, [R0, #0]
LDR	R0, [SP, #28]
CMP	R0, R1
IT	CC
BCC	L_vTaskPrioritySet91
;tasks.c,1451 :: 		xYieldRequired = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #20]
;tasks.c,1452 :: 		}
IT	AL
BAL	L_vTaskPrioritySet92
L_vTaskPrioritySet91:
;tasks.c,1456 :: 		}
L_vTaskPrioritySet92:
;tasks.c,1457 :: 		}
IT	AL
BAL	L_vTaskPrioritySet93
L_vTaskPrioritySet90:
;tasks.c,1463 :: 		}
L_vTaskPrioritySet93:
;tasks.c,1464 :: 		}
IT	AL
BAL	L_vTaskPrioritySet94
L_vTaskPrioritySet89:
;tasks.c,1465 :: 		else if( pxTCB == pxCurrentTCB )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	NE
BNE	L_vTaskPrioritySet95
;tasks.c,1470 :: 		xYieldRequired = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #20]
;tasks.c,1471 :: 		}
IT	AL
BAL	L_vTaskPrioritySet96
L_vTaskPrioritySet95:
;tasks.c,1477 :: 		}
L_vTaskPrioritySet96:
L_vTaskPrioritySet94:
;tasks.c,1482 :: 		uxPriorityUsedOnEntry = pxTCB->uxPriority;
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R0, [R0, #0]
STR	R0, [SP, #16]
;tasks.c,1488 :: 		if( pxTCB->uxBasePriority == pxTCB->uxPriority )
LDR	R0, [SP, #8]
ADDS	R0, #68
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	NE
BNE	L_vTaskPrioritySet97
;tasks.c,1490 :: 		pxTCB->uxPriority = uxNewPriority;
LDR	R0, [SP, #8]
ADDW	R1, R0, #44
LDR	R0, [SP, #28]
STR	R0, [R1, #0]
;tasks.c,1491 :: 		}
IT	AL
BAL	L_vTaskPrioritySet98
L_vTaskPrioritySet97:
;tasks.c,1495 :: 		}
L_vTaskPrioritySet98:
;tasks.c,1498 :: 		pxTCB->uxBasePriority = uxNewPriority;
LDR	R0, [SP, #8]
ADDW	R1, R0, #68
LDR	R0, [SP, #28]
STR	R0, [R1, #0]
;tasks.c,1508 :: 		if( ( listGET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ) ) & taskEVENT_LIST_ITEM_VALUE_IN_USE ) == 0UL )
LDR	R0, [SP, #8]
ADDS	R0, #24
LDR	R0, [R0, #0]
AND	R0, R0, #-2147483648
CMP	R0, #0
IT	NE
BNE	L_vTaskPrioritySet99
;tasks.c,1510 :: 		listSET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ), ( ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) uxNewPriority ) ); /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
LDR	R0, [SP, #8]
ADDS	R0, #24
MOV	R1, R0
LDR	R0, [SP, #28]
RSB	R0, R0, #16
STR	R0, [R1, #0]
;tasks.c,1511 :: 		}
IT	AL
BAL	L_vTaskPrioritySet100
L_vTaskPrioritySet99:
;tasks.c,1515 :: 		}
L_vTaskPrioritySet100:
;tasks.c,1521 :: 		if( listIS_CONTAINED_WITHIN( &( pxReadyTasksLists[ uxPriorityUsedOnEntry ] ), &( pxTCB->xStateListItem ) ) != pdFALSE )
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
ADDS	R0, #16
LDR	R2, [R0, #0]
LDR	R1, [SP, #16]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
CMP	R2, R0
MOVW	R0, #0
BNE	L__vTaskPrioritySet407
MOVS	R0, #1
L__vTaskPrioritySet407:
CMP	R0, #0
IT	EQ
BEQ	L_vTaskPrioritySet101
;tasks.c,1526 :: 		if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
CMP	R0, #0
IT	NE
BNE	L_vTaskPrioritySet102
;tasks.c,1531 :: 		portRESET_READY_PRIORITY( uxPriorityUsedOnEntry, uxTopReadyPriority );
LDR	R1, [SP, #16]
MOV	R0, #1
LSLS	R0, R1
MVN	R1, R0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
AND	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
;tasks.c,1532 :: 		}
IT	AL
BAL	L_vTaskPrioritySet103
L_vTaskPrioritySet102:
;tasks.c,1536 :: 		}
L_vTaskPrioritySet103:
;tasks.c,1537 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #12]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,1538 :: 		}
IT	AL
BAL	L_vTaskPrioritySet104
L_vTaskPrioritySet101:
;tasks.c,1542 :: 		}
L_vTaskPrioritySet104:
;tasks.c,1544 :: 		if( xYieldRequired != pdFALSE )
LDR	R0, [SP, #20]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskPrioritySet105
;tasks.c,1546 :: 		taskYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,1547 :: 		}
IT	AL
BAL	L_vTaskPrioritySet106
L_vTaskPrioritySet105:
;tasks.c,1551 :: 		}
L_vTaskPrioritySet106:
;tasks.c,1556 :: 		}
L_vTaskPrioritySet88:
;tasks.c,1558 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,1559 :: 		}
L_end_vTaskPrioritySet:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _vTaskPrioritySet
_vTaskSuspend:
;tasks.c,1566 :: 		void vTaskSuspend( TaskHandle_t xTaskToSuspend )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,1570 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,1574 :: 		pxTCB = prvGetTCBFromHandle( xTaskToSuspend );
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_vTaskSuspend107
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
IT	AL
BAL	L_vTaskSuspend108
L_vTaskSuspend107:
LDR	R0, [SP, #12]
STR	R0, [SP, #4]
L_vTaskSuspend108:
LDR	R0, [SP, #4]
STR	R0, [SP, #8]
;tasks.c,1580 :: 		if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
CMP	R0, #0
IT	NE
BNE	L_vTaskSuspend109
;tasks.c,1582 :: 		taskRESET_READY_PRIORITY( pxTCB->uxPriority );
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vTaskSuspend110
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSLS	R0, R1
MVN	R1, R0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
AND	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
L_vTaskSuspend110:
;tasks.c,1583 :: 		}
IT	AL
BAL	L_vTaskSuspend111
L_vTaskSuspend109:
;tasks.c,1587 :: 		}
L_vTaskSuspend111:
;tasks.c,1590 :: 		if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) != NULL )
LDR	R0, [SP, #8]
ADDS	R0, #24
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskSuspend112
;tasks.c,1592 :: 		( void ) uxListRemove( &( pxTCB->xEventListItem ) );
LDR	R0, [SP, #8]
ADDS	R0, #24
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,1593 :: 		}
IT	AL
BAL	L_vTaskSuspend113
L_vTaskSuspend112:
;tasks.c,1597 :: 		}
L_vTaskSuspend113:
;tasks.c,1599 :: 		vListInsertEnd( &xSuspendedTaskList, &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_xSuspendedTaskList+0)
MOVT	R0, #hi_addr(tasks_xSuspendedTaskList+0)
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,1601 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,1603 :: 		if( xSchedulerRunning != pdFALSE )
MOVW	R0, #lo_addr(tasks_xSchedulerRunning+0)
MOVT	R0, #hi_addr(tasks_xSchedulerRunning+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskSuspend114
;tasks.c,1607 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,1609 :: 		prvResetNextTaskUnblockTime();
BL	tasks_prvResetNextTaskUnblockTime+0
;tasks.c,1611 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,1612 :: 		}
IT	AL
BAL	L_vTaskSuspend115
L_vTaskSuspend114:
;tasks.c,1616 :: 		}
L_vTaskSuspend115:
;tasks.c,1618 :: 		if( pxTCB == pxCurrentTCB )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	NE
BNE	L_vTaskSuspend116
;tasks.c,1620 :: 		if( xSchedulerRunning != pdFALSE )
MOVW	R0, #lo_addr(tasks_xSchedulerRunning+0)
MOVT	R0, #hi_addr(tasks_xSchedulerRunning+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskSuspend117
;tasks.c,1623 :: 		configASSERT( uxSchedulerSuspended == 0 );
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__vTaskSuspend409
MOVS	R0, #1
L__vTaskSuspend409:
CMP	R0, #0
IT	NE
BNE	L_vTaskSuspend118
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskSuspend119:
IT	AL
BAL	L_vTaskSuspend119
L_vTaskSuspend118:
;tasks.c,1624 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,1625 :: 		}
IT	AL
BAL	L_vTaskSuspend121
L_vTaskSuspend117:
;tasks.c,1631 :: 		if( listCURRENT_LIST_LENGTH( &xSuspendedTaskList ) == uxCurrentNumberOfTasks )
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(tasks_xSuspendedTaskList+0)
MOVT	R0, #hi_addr(tasks_xSuspendedTaskList+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	NE
BNE	L_vTaskSuspend122
;tasks.c,1637 :: 		pxCurrentTCB = NULL;
MOVS	R1, #0
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
STR	R1, [R0, #0]
;tasks.c,1638 :: 		}
IT	AL
BAL	L_vTaskSuspend123
L_vTaskSuspend122:
;tasks.c,1641 :: 		vTaskSwitchContext();
BL	_vTaskSwitchContext+0
;tasks.c,1642 :: 		}
L_vTaskSuspend123:
;tasks.c,1643 :: 		}
L_vTaskSuspend121:
;tasks.c,1644 :: 		}
IT	AL
BAL	L_vTaskSuspend124
L_vTaskSuspend116:
;tasks.c,1648 :: 		}
L_vTaskSuspend124:
;tasks.c,1649 :: 		}
L_end_vTaskSuspend:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vTaskSuspend
tasks_prvTaskIsTaskSuspended:
;tasks.c,1656 :: 		static BaseType_t prvTaskIsTaskSuspended( const TaskHandle_t xTask )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,1658 :: 		BaseType_t xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #8]
;tasks.c,1659 :: 		const TCB_t * const pxTCB = ( TCB_t * ) xTask;
LDR	R0, [SP, #12]
STR	R0, [SP, #4]
;tasks.c,1665 :: 		configASSERT( xTask );
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_tasks_prvTaskIsTaskSuspended125
BL	tasks_vPortRaiseBASEPRI+0
L_tasks_prvTaskIsTaskSuspended126:
IT	AL
BAL	L_tasks_prvTaskIsTaskSuspended126
L_tasks_prvTaskIsTaskSuspended125:
;tasks.c,1668 :: 		if( listIS_CONTAINED_WITHIN( &xSuspendedTaskList, &( pxTCB->xStateListItem ) ) != pdFALSE )
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
ADDS	R0, #16
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(tasks_xSuspendedTaskList+0)
MOVT	R0, #hi_addr(tasks_xSuspendedTaskList+0)
CMP	R1, R0
MOVW	R0, #0
BNE	L_tasks_prvTaskIsTaskSuspended411
MOVS	R0, #1
L_tasks_prvTaskIsTaskSuspended411:
CMP	R0, #0
IT	EQ
BEQ	L_tasks_prvTaskIsTaskSuspended128
;tasks.c,1671 :: 		if( listIS_CONTAINED_WITHIN( &xPendingReadyList, &( pxTCB->xEventListItem ) ) == pdFALSE )
LDR	R0, [SP, #4]
ADDS	R0, #24
ADDS	R0, #16
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(tasks_xPendingReadyList+0)
MOVT	R0, #hi_addr(tasks_xPendingReadyList+0)
CMP	R1, R0
MOVW	R0, #0
BNE	L_tasks_prvTaskIsTaskSuspended412
MOVS	R0, #1
L_tasks_prvTaskIsTaskSuspended412:
CMP	R0, #0
IT	NE
BNE	L_tasks_prvTaskIsTaskSuspended129
;tasks.c,1675 :: 		if( listIS_CONTAINED_WITHIN( NULL, &( pxTCB->xEventListItem ) ) != pdFALSE )
LDR	R0, [SP, #4]
ADDS	R0, #24
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L_tasks_prvTaskIsTaskSuspended413
MOVS	R0, #1
L_tasks_prvTaskIsTaskSuspended413:
CMP	R0, #0
IT	EQ
BEQ	L_tasks_prvTaskIsTaskSuspended130
;tasks.c,1677 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #8]
;tasks.c,1678 :: 		}
IT	AL
BAL	L_tasks_prvTaskIsTaskSuspended131
L_tasks_prvTaskIsTaskSuspended130:
;tasks.c,1682 :: 		}
L_tasks_prvTaskIsTaskSuspended131:
;tasks.c,1683 :: 		}
IT	AL
BAL	L_tasks_prvTaskIsTaskSuspended132
L_tasks_prvTaskIsTaskSuspended129:
;tasks.c,1687 :: 		}
L_tasks_prvTaskIsTaskSuspended132:
;tasks.c,1688 :: 		}
IT	AL
BAL	L_tasks_prvTaskIsTaskSuspended133
L_tasks_prvTaskIsTaskSuspended128:
;tasks.c,1692 :: 		}
L_tasks_prvTaskIsTaskSuspended133:
;tasks.c,1694 :: 		return xReturn;
LDR	R0, [SP, #8]
;tasks.c,1695 :: 		} /*lint !e818 xTask cannot be a pointer to const because it is a typedef. */
L_end_prvTaskIsTaskSuspended:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of tasks_prvTaskIsTaskSuspended
_vTaskResume:
;tasks.c,1702 :: 		void vTaskResume( TaskHandle_t xTaskToResume )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;tasks.c,1704 :: 		TCB_t * const pxTCB = ( TCB_t * ) xTaskToResume;
LDR	R0, [SP, #8]
STR	R0, [SP, #4]
;tasks.c,1707 :: 		configASSERT( xTaskToResume );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_vTaskResume134
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskResume135:
IT	AL
BAL	L_vTaskResume135
L_vTaskResume134:
;tasks.c,1711 :: 		if( ( pxTCB != NULL ) && ( pxTCB != pxCurrentTCB ) )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskResume139
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R0, R1
IT	EQ
BEQ	L_vTaskResume139
L__vTaskResume384:
;tasks.c,1713 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,1715 :: 		if( prvTaskIsTaskSuspended( pxTCB ) != pdFALSE )
LDR	R0, [SP, #4]
PUSH	(R0)
BL	tasks_prvTaskIsTaskSuspended+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_vTaskResume140
;tasks.c,1721 :: 		( void ) uxListRemove(  &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,1722 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,1725 :: 		if( pxTCB->uxPriority >= pxCurrentTCB->uxPriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CC
BCC	L_vTaskResume141
;tasks.c,1730 :: 		taskYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,1731 :: 		}
IT	AL
BAL	L_vTaskResume142
L_vTaskResume141:
;tasks.c,1735 :: 		}
L_vTaskResume142:
;tasks.c,1736 :: 		}
IT	AL
BAL	L_vTaskResume143
L_vTaskResume140:
;tasks.c,1740 :: 		}
L_vTaskResume143:
;tasks.c,1742 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,1743 :: 		}
IT	AL
BAL	L_vTaskResume144
L_vTaskResume139:
;tasks.c,1747 :: 		}
L_vTaskResume144:
;tasks.c,1748 :: 		}
L_end_vTaskResume:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vTaskResume
_xTaskResumeFromISR:
;tasks.c,1756 :: 		BaseType_t xTaskResumeFromISR( TaskHandle_t xTaskToResume )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;tasks.c,1758 :: 		BaseType_t xYieldRequired = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #12]
;tasks.c,1759 :: 		TCB_t * const pxTCB = ( TCB_t * ) xTaskToResume;
LDR	R0, [SP, #16]
STR	R0, [SP, #4]
;tasks.c,1762 :: 		configASSERT( xTaskToResume );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_xTaskResumeFromISR145
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskResumeFromISR146:
IT	AL
BAL	L_xTaskResumeFromISR146
L_xTaskResumeFromISR145:
;tasks.c,1780 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;tasks.c,1782 :: 		uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
BL	tasks_ulPortRaiseBASEPRI+0
STR	R0, [SP, #8]
;tasks.c,1784 :: 		if( prvTaskIsTaskSuspended( pxTCB ) != pdFALSE )
LDR	R0, [SP, #4]
PUSH	(R0)
BL	tasks_prvTaskIsTaskSuspended+0
ADD	SP, SP, #4
CMP	R0, #0
IT	EQ
BEQ	L_xTaskResumeFromISR148
;tasks.c,1789 :: 		if( uxSchedulerSuspended == ( UBaseType_t ) pdFALSE )
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskResumeFromISR149
;tasks.c,1793 :: 		if( pxTCB->uxPriority >= pxCurrentTCB->uxPriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CC
BCC	L_xTaskResumeFromISR150
;tasks.c,1795 :: 		xYieldRequired = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #12]
;tasks.c,1796 :: 		}
IT	AL
BAL	L_xTaskResumeFromISR151
L_xTaskResumeFromISR150:
;tasks.c,1800 :: 		}
L_xTaskResumeFromISR151:
;tasks.c,1802 :: 		( void ) uxListRemove( &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,1803 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,1804 :: 		}
IT	AL
BAL	L_xTaskResumeFromISR152
L_xTaskResumeFromISR149:
;tasks.c,1810 :: 		vListInsertEnd( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, #24
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_xPendingReadyList+0)
MOVT	R0, #hi_addr(tasks_xPendingReadyList+0)
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,1811 :: 		}
L_xTaskResumeFromISR152:
;tasks.c,1812 :: 		}
IT	AL
BAL	L_xTaskResumeFromISR153
L_xTaskResumeFromISR148:
;tasks.c,1816 :: 		}
L_xTaskResumeFromISR153:
;tasks.c,1818 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
LDR	R0, [SP, #8]
PUSH	(R0)
BL	tasks_vPortSetBASEPRI+0
ADD	SP, SP, #4
;tasks.c,1820 :: 		return xYieldRequired;
LDR	R0, [SP, #12]
;tasks.c,1821 :: 		}
L_end_xTaskResumeFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xTaskResumeFromISR
_vTaskStartScheduler:
;tasks.c,1826 :: 		void vTaskStartScheduler( void )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;tasks.c,1864 :: 		&xIdleTaskHandle ); /*lint !e961 MISRA exception, justified as it is not a redundant explicit cast to all supported compilers. */
MOVW	R0, #lo_addr(tasks_xIdleTaskHandle+0)
MOVT	R0, #hi_addr(tasks_xIdleTaskHandle+0)
PUSH	(R0)
;tasks.c,1863 :: 		( tskIDLE_PRIORITY | portPRIVILEGE_BIT ),
MOV	R0, #0
PUSH	(R0)
;tasks.c,1862 :: 		( void * ) NULL,
MOVS	R0, #0
PUSH	(R0)
;tasks.c,1861 :: 		"IDLE", configMINIMAL_STACK_SIZE,
MOVS	R0, #128
PUSH	(R0)
MOVW	R0, #lo_addr(?lstr_1_tasks+0)
MOVT	R0, #hi_addr(?lstr_1_tasks+0)
PUSH	(R0)
;tasks.c,1860 :: 		xReturn = xTaskCreate(        prvIdleTask,
MOVW	R0, #lo_addr(tasks_prvIdleTask+0)
MOVT	R0, #hi_addr(tasks_prvIdleTask+0)
PUSH	(R0)
;tasks.c,1864 :: 		&xIdleTaskHandle ); /*lint !e961 MISRA exception, justified as it is not a redundant explicit cast to all supported compilers. */
BL	_xTaskCreate+0
ADD	SP, SP, #24
STR	R0, [SP, #4]
;tasks.c,1881 :: 		if( xReturn == pdPASS )
LDR	R0, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_vTaskStartScheduler154
;tasks.c,1888 :: 		portDISABLE_INTERRUPTS();
BL	tasks_vPortRaiseBASEPRI+0
;tasks.c,1898 :: 		xNextTaskUnblockTime = portMAX_DELAY;
MOV	R1, #-1
MOVW	R0, #lo_addr(tasks_xNextTaskUnblockTime+0)
MOVT	R0, #hi_addr(tasks_xNextTaskUnblockTime+0)
STR	R1, [R0, #0]
;tasks.c,1899 :: 		xSchedulerRunning = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xSchedulerRunning+0)
MOVT	R0, #hi_addr(tasks_xSchedulerRunning+0)
STR	R1, [R0, #0]
;tasks.c,1900 :: 		xTickCount = ( TickType_t ) 0U;
MOV	R1, #0
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
STR	R1, [R0, #0]
;tasks.c,1909 :: 		if( xPortStartScheduler() != pdFALSE )
BL	_xPortStartScheduler+0
CMP	R0, #0
IT	EQ
BEQ	L_vTaskStartScheduler155
;tasks.c,1913 :: 		}
IT	AL
BAL	L_vTaskStartScheduler156
L_vTaskStartScheduler155:
;tasks.c,1917 :: 		}
L_vTaskStartScheduler156:
;tasks.c,1918 :: 		}
IT	AL
BAL	L_vTaskStartScheduler157
L_vTaskStartScheduler154:
;tasks.c,1924 :: 		configASSERT( xReturn != errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY );
LDR	R0, [SP, #4]
CMP	R0, #-1
MOVW	R0, #0
BEQ	L__vTaskStartScheduler417
MOVS	R0, #1
L__vTaskStartScheduler417:
CMP	R0, #0
IT	NE
BNE	L_vTaskStartScheduler158
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskStartScheduler159:
IT	AL
BAL	L_vTaskStartScheduler159
L_vTaskStartScheduler158:
;tasks.c,1925 :: 		}
L_vTaskStartScheduler157:
;tasks.c,1930 :: 		}
L_end_vTaskStartScheduler:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vTaskStartScheduler
_vTaskEndScheduler:
;tasks.c,1933 :: 		void vTaskEndScheduler( void )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tasks.c,1938 :: 		portDISABLE_INTERRUPTS();
BL	tasks_vPortRaiseBASEPRI+0
;tasks.c,1939 :: 		xSchedulerRunning = pdFALSE;
MOV	R1, #0
MOVW	R0, #lo_addr(tasks_xSchedulerRunning+0)
MOVT	R0, #hi_addr(tasks_xSchedulerRunning+0)
STR	R1, [R0, #0]
;tasks.c,1940 :: 		vPortEndScheduler();
BL	_vPortEndScheduler+0
;tasks.c,1941 :: 		}
L_end_vTaskEndScheduler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vTaskEndScheduler
_vTaskSuspendAll:
;tasks.c,1944 :: 		void vTaskSuspendAll( void )
;tasks.c,1950 :: 		++uxSchedulerSuspended;
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
STR	R1, [R0, #0]
;tasks.c,1951 :: 		}
L_end_vTaskSuspendAll:
BX	LR
; end of _vTaskSuspendAll
_xTaskResumeAll:
;tasks.c,2017 :: 		BaseType_t xTaskResumeAll( void )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;tasks.c,2019 :: 		TCB_t *pxTCB = NULL;
MOV	R0, #0
STR	R0, [SP, #8]
;tasks.c,2020 :: 		BaseType_t xAlreadyYielded = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #12]
;tasks.c,2024 :: 		configASSERT( uxSchedulerSuspended );
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskResumeAll161
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskResumeAll162:
IT	AL
BAL	L_xTaskResumeAll162
L_xTaskResumeAll161:
;tasks.c,2031 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,2033 :: 		--uxSchedulerSuspended;
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
STR	R1, [R0, #0]
;tasks.c,2035 :: 		if( uxSchedulerSuspended == ( UBaseType_t ) pdFALSE )
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskResumeAll164
;tasks.c,2037 :: 		if( uxCurrentNumberOfTasks > ( UBaseType_t ) 0U )
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_xTaskResumeAll165
;tasks.c,2041 :: 		while( listLIST_IS_EMPTY( &xPendingReadyList ) == pdFALSE )
L_xTaskResumeAll166:
MOVW	R0, #lo_addr(tasks_xPendingReadyList+0)
MOVT	R0, #hi_addr(tasks_xPendingReadyList+0)
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xTaskResumeAll421
MOVS	R0, #1
L__xTaskResumeAll421:
CMP	R0, #0
IT	NE
BNE	L_xTaskResumeAll167
;tasks.c,2043 :: 		pxTCB = ( TCB_t * ) listGET_OWNER_OF_HEAD_ENTRY( ( &xPendingReadyList ) );
MOVW	R0, #lo_addr(tasks_xPendingReadyList+12)
MOVT	R0, #hi_addr(tasks_xPendingReadyList+12)
LDR	R0, [R0, #0]
ADDS	R0, #12
LDR	R0, [R0, #0]
STR	R0, [SP, #8]
;tasks.c,2044 :: 		( void ) uxListRemove( &( pxTCB->xEventListItem ) );
LDR	R0, [SP, #8]
ADDS	R0, #24
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,2045 :: 		( void ) uxListRemove( &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,2046 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #12]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,2050 :: 		if( pxTCB->uxPriority >= pxCurrentTCB->uxPriority )
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CC
BCC	L_xTaskResumeAll168
;tasks.c,2052 :: 		xYieldPending = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,2053 :: 		}
IT	AL
BAL	L_xTaskResumeAll169
L_xTaskResumeAll168:
;tasks.c,2057 :: 		}
L_xTaskResumeAll169:
;tasks.c,2058 :: 		}
IT	AL
BAL	L_xTaskResumeAll166
L_xTaskResumeAll167:
;tasks.c,2060 :: 		if( pxTCB != NULL )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskResumeAll170
;tasks.c,2068 :: 		prvResetNextTaskUnblockTime();
BL	tasks_prvResetNextTaskUnblockTime+0
;tasks.c,2069 :: 		}
L_xTaskResumeAll170:
;tasks.c,2076 :: 		UBaseType_t uxPendedCounts = uxPendedTicks; /* Non-volatile copy. */
MOVW	R0, #lo_addr(tasks_uxPendedTicks+0)
MOVT	R0, #hi_addr(tasks_uxPendedTicks+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;tasks.c,2078 :: 		if( uxPendedCounts > ( UBaseType_t ) 0U )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	LS
BLS	L_xTaskResumeAll171
;tasks.c,2080 :: 		do
L_xTaskResumeAll172:
;tasks.c,2082 :: 		if( xTaskIncrementTick() != pdFALSE )
BL	_xTaskIncrementTick+0
CMP	R0, #0
IT	EQ
BEQ	L_xTaskResumeAll175
;tasks.c,2084 :: 		xYieldPending = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,2085 :: 		}
IT	AL
BAL	L_xTaskResumeAll176
L_xTaskResumeAll175:
;tasks.c,2089 :: 		}
L_xTaskResumeAll176:
;tasks.c,2090 :: 		--uxPendedCounts;
LDR	R0, [SP, #4]
SUBS	R0, R0, #1
STR	R0, [SP, #4]
;tasks.c,2091 :: 		} while( uxPendedCounts > ( UBaseType_t ) 0U );
LDR	R0, [SP, #4]
CMP	R0, #0
IT	HI
BHI	L_xTaskResumeAll172
;tasks.c,2093 :: 		uxPendedTicks = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(tasks_uxPendedTicks+0)
MOVT	R0, #hi_addr(tasks_uxPendedTicks+0)
STR	R1, [R0, #0]
;tasks.c,2094 :: 		}
IT	AL
BAL	L_xTaskResumeAll177
L_xTaskResumeAll171:
;tasks.c,2098 :: 		}
L_xTaskResumeAll177:
;tasks.c,2101 :: 		if( xYieldPending != pdFALSE )
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskResumeAll178
;tasks.c,2105 :: 		xAlreadyYielded = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #12]
;tasks.c,2108 :: 		taskYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,2109 :: 		}
IT	AL
BAL	L_xTaskResumeAll179
L_xTaskResumeAll178:
;tasks.c,2113 :: 		}
L_xTaskResumeAll179:
;tasks.c,2114 :: 		}
L_xTaskResumeAll165:
;tasks.c,2115 :: 		}
IT	AL
BAL	L_xTaskResumeAll180
L_xTaskResumeAll164:
;tasks.c,2119 :: 		}
L_xTaskResumeAll180:
;tasks.c,2121 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,2123 :: 		return xAlreadyYielded;
LDR	R0, [SP, #12]
;tasks.c,2124 :: 		}
L_end_xTaskResumeAll:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xTaskResumeAll
_xTaskGetTickCount:
;tasks.c,2127 :: 		TickType_t xTaskGetTickCount( void )
SUB	SP, SP, #4
;tasks.c,2134 :: 		xTicks = xTickCount;
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #0]
;tasks.c,2138 :: 		return xTicks;
LDR	R0, [SP, #0]
;tasks.c,2139 :: 		}
L_end_xTaskGetTickCount:
ADD	SP, SP, #4
BX	LR
; end of _xTaskGetTickCount
_xTaskGetTickCountFromISR:
;tasks.c,2142 :: 		TickType_t xTaskGetTickCountFromISR( void )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,2161 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;tasks.c,2163 :: 		uxSavedInterruptStatus = portTICK_TYPE_SET_INTERRUPT_MASK_FROM_ISR();
MOVS	R0, #0
STR	R0, [SP, #8]
;tasks.c,2165 :: 		xReturn = xTickCount;
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;tasks.c,2169 :: 		return xReturn;
LDR	R0, [SP, #4]
;tasks.c,2170 :: 		}
L_end_xTaskGetTickCountFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _xTaskGetTickCountFromISR
_uxTaskGetNumberOfTasks:
;tasks.c,2173 :: 		UBaseType_t uxTaskGetNumberOfTasks( void )
;tasks.c,2177 :: 		return uxCurrentNumberOfTasks;
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
LDR	R0, [R0, #0]
;tasks.c,2178 :: 		}
L_end_uxTaskGetNumberOfTasks:
BX	LR
; end of _uxTaskGetNumberOfTasks
_pcTaskGetName:
;tasks.c,2181 :: 		char *pcTaskGetName( TaskHandle_t xTaskToQuery ) /*lint !e971 Unqualified char types are allowed for strings and single characters only. */
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,2187 :: 		pxTCB = prvGetTCBFromHandle( xTaskToQuery );
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_pcTaskGetName181
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
IT	AL
BAL	L_pcTaskGetName182
L_pcTaskGetName181:
LDR	R0, [SP, #12]
STR	R0, [SP, #4]
L_pcTaskGetName182:
LDR	R0, [SP, #4]
STR	R0, [SP, #8]
;tasks.c,2188 :: 		configASSERT( pxTCB );
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_pcTaskGetName183
BL	tasks_vPortRaiseBASEPRI+0
L_pcTaskGetName184:
IT	AL
BAL	L_pcTaskGetName184
L_pcTaskGetName183:
;tasks.c,2189 :: 		return &( pxTCB->pcTaskName[ 0 ] );
LDR	R0, [SP, #8]
ADDS	R0, #52
ADDS	R0, R0, #0
;tasks.c,2190 :: 		}
L_end_pcTaskGetName:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _pcTaskGetName
_xTaskIncrementTick:
;tasks.c,2499 :: 		BaseType_t xTaskIncrementTick( void )
SUB	SP, SP, #24
STR	LR, [SP, #0]
;tasks.c,2503 :: 		BaseType_t xSwitchRequired = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #20]
;tasks.c,2509 :: 		if( uxSchedulerSuspended == ( UBaseType_t ) pdFALSE )
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskIncrementTick186
;tasks.c,2513 :: 		const TickType_t xConstTickCount = xTickCount + 1;
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;tasks.c,2517 :: 		xTickCount = xConstTickCount;
LDR	R1, [SP, #8]
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
STR	R1, [R0, #0]
;tasks.c,2519 :: 		if( xConstTickCount == ( TickType_t ) 0U )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_xTaskIncrementTick187
;tasks.c,2521 :: 		taskSWITCH_DELAYED_LISTS();
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
LDR	R0, [R0, #0]
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xTaskIncrementTick427
MOVS	R0, #1
L__xTaskIncrementTick427:
CMP	R0, #0
IT	NE
BNE	L_xTaskIncrementTick188
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskIncrementTick189:
IT	AL
BAL	L_xTaskIncrementTick189
L_xTaskIncrementTick188:
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
MOVW	R0, #lo_addr(tasks_pxOverflowDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxOverflowDelayedTaskList+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
STR	R1, [R0, #0]
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(tasks_pxOverflowDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxOverflowDelayedTaskList+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(tasks_xNumOfOverflows+0)
MOVT	R0, #hi_addr(tasks_xNumOfOverflows+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_xNumOfOverflows+0)
MOVT	R0, #hi_addr(tasks_xNumOfOverflows+0)
STR	R1, [R0, #0]
BL	tasks_prvResetNextTaskUnblockTime+0
;tasks.c,2522 :: 		}
IT	AL
BAL	L_xTaskIncrementTick191
L_xTaskIncrementTick187:
;tasks.c,2526 :: 		}
L_xTaskIncrementTick191:
;tasks.c,2532 :: 		if( xConstTickCount >= xNextTaskUnblockTime )
MOVW	R0, #lo_addr(tasks_xNextTaskUnblockTime+0)
MOVT	R0, #hi_addr(tasks_xNextTaskUnblockTime+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	CC
BCC	L_xTaskIncrementTick192
;tasks.c,2534 :: 		for( ;; )
L_xTaskIncrementTick193:
;tasks.c,2536 :: 		if( listLIST_IS_EMPTY( pxDelayedTaskList ) != pdFALSE )
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
LDR	R0, [R0, #0]
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xTaskIncrementTick428
MOVS	R0, #1
L__xTaskIncrementTick428:
CMP	R0, #0
IT	EQ
BEQ	L_xTaskIncrementTick196
;tasks.c,2543 :: 		xNextTaskUnblockTime = portMAX_DELAY; /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
MOV	R1, #-1
MOVW	R0, #lo_addr(tasks_xNextTaskUnblockTime+0)
MOVT	R0, #hi_addr(tasks_xNextTaskUnblockTime+0)
STR	R1, [R0, #0]
;tasks.c,2544 :: 		break;
IT	AL
BAL	L_xTaskIncrementTick194
;tasks.c,2545 :: 		}
L_xTaskIncrementTick196:
;tasks.c,2552 :: 		pxTCB = ( TCB_t * ) listGET_OWNER_OF_HEAD_ENTRY( pxDelayedTaskList );
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
LDR	R0, [R0, #0]
ADDS	R0, #8
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
ADDS	R0, #12
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
;tasks.c,2553 :: 		xItemValue = listGET_LIST_ITEM_VALUE( &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [SP, #16]
;tasks.c,2555 :: 		if( xConstTickCount < xItemValue )
LDR	R1, [SP, #16]
LDR	R0, [SP, #8]
CMP	R0, R1
IT	CS
BCS	L_xTaskIncrementTick198
;tasks.c,2562 :: 		xNextTaskUnblockTime = xItemValue;
LDR	R1, [SP, #16]
MOVW	R0, #lo_addr(tasks_xNextTaskUnblockTime+0)
MOVT	R0, #hi_addr(tasks_xNextTaskUnblockTime+0)
STR	R1, [R0, #0]
;tasks.c,2563 :: 		break;
IT	AL
BAL	L_xTaskIncrementTick194
;tasks.c,2564 :: 		}
L_xTaskIncrementTick198:
;tasks.c,2571 :: 		( void ) uxListRemove( &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,2575 :: 		if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) != NULL )
LDR	R0, [SP, #12]
ADDS	R0, #24
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskIncrementTick200
;tasks.c,2577 :: 		( void ) uxListRemove( &( pxTCB->xEventListItem ) );
LDR	R0, [SP, #12]
ADDS	R0, #24
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,2578 :: 		}
IT	AL
BAL	L_xTaskIncrementTick201
L_xTaskIncrementTick200:
;tasks.c,2582 :: 		}
L_xTaskIncrementTick201:
;tasks.c,2586 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #12]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #16]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,2596 :: 		if( pxTCB->uxPriority >= pxCurrentTCB->uxPriority )
LDR	R0, [SP, #12]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CC
BCC	L_xTaskIncrementTick202
;tasks.c,2598 :: 		xSwitchRequired = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #20]
;tasks.c,2599 :: 		}
IT	AL
BAL	L_xTaskIncrementTick203
L_xTaskIncrementTick202:
;tasks.c,2603 :: 		}
L_xTaskIncrementTick203:
;tasks.c,2607 :: 		}
IT	AL
BAL	L_xTaskIncrementTick193
L_xTaskIncrementTick194:
;tasks.c,2608 :: 		}
L_xTaskIncrementTick192:
;tasks.c,2615 :: 		if( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ pxCurrentTCB->uxPriority ] ) ) > ( UBaseType_t ) 1 )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
CMP	R0, #1
IT	LS
BLS	L_xTaskIncrementTick204
;tasks.c,2617 :: 		xSwitchRequired = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #20]
;tasks.c,2618 :: 		}
IT	AL
BAL	L_xTaskIncrementTick205
L_xTaskIncrementTick204:
;tasks.c,2622 :: 		}
L_xTaskIncrementTick205:
;tasks.c,2640 :: 		}
IT	AL
BAL	L_xTaskIncrementTick206
L_xTaskIncrementTick186:
;tasks.c,2643 :: 		++uxPendedTicks;
MOVW	R0, #lo_addr(tasks_uxPendedTicks+0)
MOVT	R0, #hi_addr(tasks_uxPendedTicks+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxPendedTicks+0)
MOVT	R0, #hi_addr(tasks_uxPendedTicks+0)
STR	R1, [R0, #0]
;tasks.c,2652 :: 		}
L_xTaskIncrementTick206:
;tasks.c,2656 :: 		if( xYieldPending != pdFALSE )
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskIncrementTick207
;tasks.c,2658 :: 		xSwitchRequired = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #20]
;tasks.c,2659 :: 		}
IT	AL
BAL	L_xTaskIncrementTick208
L_xTaskIncrementTick207:
;tasks.c,2663 :: 		}
L_xTaskIncrementTick208:
;tasks.c,2667 :: 		return xSwitchRequired;
LDR	R0, [SP, #20]
;tasks.c,2668 :: 		}
L_end_xTaskIncrementTick:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _xTaskIncrementTick
_vTaskSwitchContext:
;tasks.c,2761 :: 		void vTaskSwitchContext( void )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,2763 :: 		if( uxSchedulerSuspended != ( UBaseType_t ) pdFALSE )
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskSwitchContext209
;tasks.c,2767 :: 		xYieldPending = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,2768 :: 		}
IT	AL
BAL	L_vTaskSwitchContext210
L_vTaskSwitchContext209:
;tasks.c,2771 :: 		xYieldPending = pdFALSE;
MOV	R1, #0
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,2806 :: 		taskSELECT_HIGHEST_PRIORITY_TASK();
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
PUSH	(R0)
BL	tasks_ucPortCountLeadingZeros+0
ADD	SP, SP, #4
RSB	R0, R0, #31
STR	R0, [SP, #8]
LDR	R1, [SP, #8]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BLS	L__vTaskSwitchContext430
MOVS	R0, #1
L__vTaskSwitchContext430:
CMP	R0, #0
IT	NE
BNE	L_vTaskSwitchContext211
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskSwitchContext212:
IT	AL
BAL	L_vTaskSwitchContext212
L_vTaskSwitchContext211:
LDR	R1, [SP, #8]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
STR	R0, [SP, #4]
LDR	R0, [SP, #4]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
MOV	R1, R0
LDR	R0, [SP, #4]
ADDS	R0, #8
CMP	R1, R0
IT	NE
BNE	L_vTaskSwitchContext214
LDR	R0, [SP, #4]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
L_vTaskSwitchContext214:
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
ADDS	R0, #12
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
STR	R1, [R0, #0]
;tasks.c,2816 :: 		}
L_vTaskSwitchContext210:
;tasks.c,2817 :: 		}
L_end_vTaskSwitchContext:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vTaskSwitchContext
_vTaskPlaceOnEventList:
;tasks.c,2820 :: 		void vTaskPlaceOnEventList( List_t * const pxEventList, const TickType_t xTicksToWait )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tasks.c,2822 :: 		configASSERT( pxEventList );
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_vTaskPlaceOnEventList215
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskPlaceOnEventList216:
IT	AL
BAL	L_vTaskPlaceOnEventList216
L_vTaskPlaceOnEventList215:
;tasks.c,2831 :: 		vListInsert( pxEventList, &( pxCurrentTCB->xEventListItem ) );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #24
PUSH	(R0)
LDR	R0, [SP, #8]
PUSH	(R0)
BL	_vListInsert+0
ADD	SP, SP, #8
;tasks.c,2833 :: 		prvAddCurrentTaskToDelayedList( xTicksToWait, pdTRUE );
MOV	R0, #1
PUSH	(R0)
LDR	R0, [SP, #12]
PUSH	(R0)
BL	tasks_prvAddCurrentTaskToDelayedList+0
ADD	SP, SP, #8
;tasks.c,2834 :: 		}
L_end_vTaskPlaceOnEventList:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vTaskPlaceOnEventList
_vTaskPlaceOnUnorderedEventList:
;tasks.c,2837 :: 		void vTaskPlaceOnUnorderedEventList( List_t * pxEventList, const TickType_t xItemValue, const TickType_t xTicksToWait )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tasks.c,2839 :: 		configASSERT( pxEventList );
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_vTaskPlaceOnUnorderedEventList218
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskPlaceOnUnorderedEventList219:
IT	AL
BAL	L_vTaskPlaceOnUnorderedEventList219
L_vTaskPlaceOnUnorderedEventList218:
;tasks.c,2843 :: 		configASSERT( uxSchedulerSuspended != 0 );
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BEQ	L__vTaskPlaceOnUnorderedEventList433
MOVS	R0, #1
L__vTaskPlaceOnUnorderedEventList433:
CMP	R0, #0
IT	NE
BNE	L_vTaskPlaceOnUnorderedEventList221
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskPlaceOnUnorderedEventList222:
IT	AL
BAL	L_vTaskPlaceOnUnorderedEventList222
L_vTaskPlaceOnUnorderedEventList221:
;tasks.c,2848 :: 		listSET_LIST_ITEM_VALUE( &( pxCurrentTCB->xEventListItem ), xItemValue | taskEVENT_LIST_ITEM_VALUE_IN_USE );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #24
MOV	R1, R0
LDR	R0, [SP, #8]
ORR	R0, R0, #-2147483648
STR	R0, [R1, #0]
;tasks.c,2855 :: 		vListInsertEnd( pxEventList, &( pxCurrentTCB->xEventListItem ) );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #24
PUSH	(R0)
LDR	R0, [SP, #8]
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,2857 :: 		prvAddCurrentTaskToDelayedList( xTicksToWait, pdTRUE );
MOV	R0, #1
PUSH	(R0)
LDR	R0, [SP, #16]
PUSH	(R0)
BL	tasks_prvAddCurrentTaskToDelayedList+0
ADD	SP, SP, #8
;tasks.c,2858 :: 		}
L_end_vTaskPlaceOnUnorderedEventList:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vTaskPlaceOnUnorderedEventList
_xTaskRemoveFromEventList:
;tasks.c,2894 :: 		BaseType_t xTaskRemoveFromEventList( const List_t * const pxEventList )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,2912 :: 		pxUnblockedTCB = ( TCB_t * ) listGET_OWNER_OF_HEAD_ENTRY( pxEventList );
LDR	R0, [SP, #12]
ADDS	R0, #8
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
ADDS	R0, #12
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;tasks.c,2913 :: 		configASSERT( pxUnblockedTCB );
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_xTaskRemoveFromEventList224
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskRemoveFromEventList225:
IT	AL
BAL	L_xTaskRemoveFromEventList225
L_xTaskRemoveFromEventList224:
;tasks.c,2914 :: 		( void ) uxListRemove( &( pxUnblockedTCB->xEventListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, #24
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,2916 :: 		if( uxSchedulerSuspended == ( UBaseType_t ) pdFALSE )
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskRemoveFromEventList227
;tasks.c,2918 :: 		( void ) uxListRemove( &( pxUnblockedTCB->xStateListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,2919 :: 		prvAddTaskToReadyList( pxUnblockedTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,2920 :: 		}
IT	AL
BAL	L_xTaskRemoveFromEventList228
L_xTaskRemoveFromEventList227:
;tasks.c,2925 :: 		vListInsertEnd( &( xPendingReadyList ), &( pxUnblockedTCB->xEventListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, #24
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_xPendingReadyList+0)
MOVT	R0, #hi_addr(tasks_xPendingReadyList+0)
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,2926 :: 		}
L_xTaskRemoveFromEventList228:
;tasks.c,2928 :: 		if( pxUnblockedTCB->uxPriority > pxCurrentTCB->uxPriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_xTaskRemoveFromEventList229
;tasks.c,2933 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #8]
;tasks.c,2937 :: 		xYieldPending = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,2938 :: 		}
IT	AL
BAL	L_xTaskRemoveFromEventList230
L_xTaskRemoveFromEventList229:
;tasks.c,2941 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #8]
;tasks.c,2942 :: 		}
L_xTaskRemoveFromEventList230:
;tasks.c,2958 :: 		return xReturn;
LDR	R0, [SP, #8]
;tasks.c,2959 :: 		}
L_end_xTaskRemoveFromEventList:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _xTaskRemoveFromEventList
_xTaskRemoveFromUnorderedEventList:
;tasks.c,2962 :: 		BaseType_t xTaskRemoveFromUnorderedEventList( ListItem_t * pxEventListItem, const TickType_t xItemValue )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,2969 :: 		configASSERT( uxSchedulerSuspended != pdFALSE );
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BEQ	L__xTaskRemoveFromUnorderedEventList436
MOVS	R0, #1
L__xTaskRemoveFromUnorderedEventList436:
CMP	R0, #0
IT	NE
BNE	L_xTaskRemoveFromUnorderedEventList231
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskRemoveFromUnorderedEventList232:
IT	AL
BAL	L_xTaskRemoveFromUnorderedEventList232
L_xTaskRemoveFromUnorderedEventList231:
;tasks.c,2972 :: 		listSET_LIST_ITEM_VALUE( pxEventListItem, xItemValue | taskEVENT_LIST_ITEM_VALUE_IN_USE );
LDR	R0, [SP, #12]
MOV	R1, R0
LDR	R0, [SP, #16]
ORR	R0, R0, #-2147483648
STR	R0, [R1, #0]
;tasks.c,2976 :: 		pxUnblockedTCB = ( TCB_t * ) listGET_LIST_ITEM_OWNER( pxEventListItem );
LDR	R0, [SP, #12]
ADDS	R0, #12
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;tasks.c,2977 :: 		configASSERT( pxUnblockedTCB );
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_xTaskRemoveFromUnorderedEventList234
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskRemoveFromUnorderedEventList235:
IT	AL
BAL	L_xTaskRemoveFromUnorderedEventList235
L_xTaskRemoveFromUnorderedEventList234:
;tasks.c,2978 :: 		( void ) uxListRemove( pxEventListItem );
LDR	R0, [SP, #12]
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,2983 :: 		( void ) uxListRemove( &( pxUnblockedTCB->xStateListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,2984 :: 		prvAddTaskToReadyList( pxUnblockedTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,2986 :: 		if( pxUnblockedTCB->uxPriority > pxCurrentTCB->uxPriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_xTaskRemoveFromUnorderedEventList237
;tasks.c,2992 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #8]
;tasks.c,2996 :: 		xYieldPending = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,2997 :: 		}
IT	AL
BAL	L_xTaskRemoveFromUnorderedEventList238
L_xTaskRemoveFromUnorderedEventList237:
;tasks.c,3000 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #8]
;tasks.c,3001 :: 		}
L_xTaskRemoveFromUnorderedEventList238:
;tasks.c,3003 :: 		return xReturn;
LDR	R0, [SP, #8]
;tasks.c,3004 :: 		}
L_end_xTaskRemoveFromUnorderedEventList:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _xTaskRemoveFromUnorderedEventList
_vTaskSetTimeOutState:
;tasks.c,3007 :: 		void vTaskSetTimeOutState( TimeOut_t * const pxTimeOut )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tasks.c,3009 :: 		configASSERT( pxTimeOut );
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_vTaskSetTimeOutState239
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskSetTimeOutState240:
IT	AL
BAL	L_vTaskSetTimeOutState240
L_vTaskSetTimeOutState239:
;tasks.c,3010 :: 		pxTimeOut->xOverflowCount = xNumOfOverflows;
LDR	R0, [SP, #4]
MOV	R1, R0
MOVW	R0, #lo_addr(tasks_xNumOfOverflows+0)
MOVT	R0, #hi_addr(tasks_xNumOfOverflows+0)
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;tasks.c,3011 :: 		pxTimeOut->xTimeOnEntering = xTickCount;
LDR	R0, [SP, #4]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;tasks.c,3012 :: 		}
L_end_vTaskSetTimeOutState:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vTaskSetTimeOutState
_xTaskCheckForTimeOut:
;tasks.c,3015 :: 		BaseType_t xTaskCheckForTimeOut( TimeOut_t * const pxTimeOut, TickType_t * const pxTicksToWait )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,3019 :: 		configASSERT( pxTimeOut );
LDR	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_xTaskCheckForTimeOut242
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskCheckForTimeOut243:
IT	AL
BAL	L_xTaskCheckForTimeOut243
L_xTaskCheckForTimeOut242:
;tasks.c,3020 :: 		configASSERT( pxTicksToWait );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_xTaskCheckForTimeOut245
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskCheckForTimeOut246:
IT	AL
BAL	L_xTaskCheckForTimeOut246
L_xTaskCheckForTimeOut245:
;tasks.c,3022 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,3025 :: 		const TickType_t xConstTickCount = xTickCount;
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;tasks.c,3039 :: 		if( *pxTicksToWait == portMAX_DELAY )
LDR	R0, [SP, #16]
LDR	R0, [R0, #0]
CMP	R0, #-1
IT	NE
BNE	L_xTaskCheckForTimeOut248
;tasks.c,3044 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #8]
;tasks.c,3045 :: 		}
IT	AL
BAL	L_xTaskCheckForTimeOut249
L_xTaskCheckForTimeOut248:
;tasks.c,3049 :: 		if( ( xNumOfOverflows != pxTimeOut->xOverflowCount ) && ( xConstTickCount >= pxTimeOut->xTimeOnEntering ) ) /*lint !e525 Indentation preferred as is to make code within pre-processor directives clearer. */
LDR	R0, [SP, #12]
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(tasks_xNumOfOverflows+0)
MOVT	R0, #hi_addr(tasks_xNumOfOverflows+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_xTaskCheckForTimeOut252
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R0, R1
IT	CC
BCC	L_xTaskCheckForTimeOut252
L__xTaskCheckForTimeOut385:
;tasks.c,3056 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #8]
;tasks.c,3057 :: 		}
IT	AL
BAL	L_xTaskCheckForTimeOut253
L_xTaskCheckForTimeOut252:
;tasks.c,3058 :: 		else if( ( ( TickType_t ) ( xConstTickCount - pxTimeOut->xTimeOnEntering ) ) < *pxTicksToWait ) /*lint !e961 Explicit casting is only redundant with some compilers, whereas others require it to prevent integer conversion errors. */
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
SUB	R0, R0, R1
MOV	R1, R0
LDR	R0, [SP, #16]
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CS
BCS	L_xTaskCheckForTimeOut254
;tasks.c,3061 :: 		*pxTicksToWait -= ( xConstTickCount - pxTimeOut->xTimeOnEntering );
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
SUB	R1, R0, R1
LDR	R0, [SP, #16]
LDR	R0, [R0, #0]
SUB	R1, R0, R1
LDR	R0, [SP, #16]
STR	R1, [R0, #0]
;tasks.c,3062 :: 		vTaskSetTimeOutState( pxTimeOut );
LDR	R0, [SP, #12]
PUSH	(R0)
BL	_vTaskSetTimeOutState+0
ADD	SP, SP, #4
;tasks.c,3063 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #8]
;tasks.c,3064 :: 		}
IT	AL
BAL	L_xTaskCheckForTimeOut255
L_xTaskCheckForTimeOut254:
;tasks.c,3067 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #8]
;tasks.c,3068 :: 		}
L_xTaskCheckForTimeOut255:
L_xTaskCheckForTimeOut253:
L_xTaskCheckForTimeOut249:
;tasks.c,3070 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,3072 :: 		return xReturn;
LDR	R0, [SP, #8]
;tasks.c,3073 :: 		}
L_end_xTaskCheckForTimeOut:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _xTaskCheckForTimeOut
_vTaskMissedYield:
;tasks.c,3076 :: 		void vTaskMissedYield( void )
;tasks.c,3078 :: 		xYieldPending = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,3079 :: 		}
L_end_vTaskMissedYield:
BX	LR
; end of _vTaskMissedYield
tasks_prvIdleTask:
;tasks.c,3131 :: 		static portTASK_FUNCTION( prvIdleTask, pvParameters )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tasks.c,3139 :: 		for( ;; )
L_tasks_prvIdleTask256:
;tasks.c,3143 :: 		prvCheckTasksWaitingTermination();
BL	tasks_prvCheckTasksWaitingTermination+0
;tasks.c,3166 :: 		if( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ tskIDLE_PRIORITY ] ) ) > ( UBaseType_t ) 1 )
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	LS
BLS	L_tasks_prvIdleTask259
;tasks.c,3168 :: 		taskYIELD();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,3169 :: 		}
IT	AL
BAL	L_tasks_prvIdleTask260
L_tasks_prvIdleTask259:
;tasks.c,3173 :: 		}
L_tasks_prvIdleTask260:
;tasks.c,3234 :: 		}
IT	AL
BAL	L_tasks_prvIdleTask256
;tasks.c,3235 :: 		}
L_end_prvIdleTask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of tasks_prvIdleTask
tasks_prvInitialiseTaskLists:
;tasks.c,3333 :: 		static void prvInitialiseTaskLists( void )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;tasks.c,3337 :: 		for( uxPriority = ( UBaseType_t ) 0U; uxPriority < ( UBaseType_t ) configMAX_PRIORITIES; uxPriority++ )
MOV	R0, #0
STR	R0, [SP, #4]
L_tasks_prvInitialiseTaskLists261:
LDR	R0, [SP, #4]
CMP	R0, #16
IT	CS
BCS	L_tasks_prvInitialiseTaskLists262
;tasks.c,3339 :: 		vListInitialise( &( pxReadyTasksLists[ uxPriority ] ) );
LDR	R1, [SP, #4]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;tasks.c,3337 :: 		for( uxPriority = ( UBaseType_t ) 0U; uxPriority < ( UBaseType_t ) configMAX_PRIORITIES; uxPriority++ )
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
STR	R0, [SP, #4]
;tasks.c,3340 :: 		}
IT	AL
BAL	L_tasks_prvInitialiseTaskLists261
L_tasks_prvInitialiseTaskLists262:
;tasks.c,3342 :: 		vListInitialise( &xDelayedTaskList1 );
MOVW	R0, #lo_addr(tasks_xDelayedTaskList1+0)
MOVT	R0, #hi_addr(tasks_xDelayedTaskList1+0)
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;tasks.c,3343 :: 		vListInitialise( &xDelayedTaskList2 );
MOVW	R0, #lo_addr(tasks_xDelayedTaskList2+0)
MOVT	R0, #hi_addr(tasks_xDelayedTaskList2+0)
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;tasks.c,3344 :: 		vListInitialise( &xPendingReadyList );
MOVW	R0, #lo_addr(tasks_xPendingReadyList+0)
MOVT	R0, #hi_addr(tasks_xPendingReadyList+0)
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;tasks.c,3348 :: 		vListInitialise( &xTasksWaitingTermination );
MOVW	R0, #lo_addr(tasks_xTasksWaitingTermination+0)
MOVT	R0, #hi_addr(tasks_xTasksWaitingTermination+0)
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;tasks.c,3354 :: 		vListInitialise( &xSuspendedTaskList );
MOVW	R0, #lo_addr(tasks_xSuspendedTaskList+0)
MOVT	R0, #hi_addr(tasks_xSuspendedTaskList+0)
PUSH	(R0)
BL	_vListInitialise+0
ADD	SP, SP, #4
;tasks.c,3360 :: 		pxDelayedTaskList = &xDelayedTaskList1;
MOVW	R1, #lo_addr(tasks_xDelayedTaskList1+0)
MOVT	R1, #hi_addr(tasks_xDelayedTaskList1+0)
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
STR	R1, [R0, #0]
;tasks.c,3361 :: 		pxOverflowDelayedTaskList = &xDelayedTaskList2;
MOVW	R1, #lo_addr(tasks_xDelayedTaskList2+0)
MOVT	R1, #hi_addr(tasks_xDelayedTaskList2+0)
MOVW	R0, #lo_addr(tasks_pxOverflowDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxOverflowDelayedTaskList+0)
STR	R1, [R0, #0]
;tasks.c,3362 :: 		}
L_end_prvInitialiseTaskLists:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of tasks_prvInitialiseTaskLists
tasks_prvCheckTasksWaitingTermination:
;tasks.c,3365 :: 		static void prvCheckTasksWaitingTermination( void )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,3376 :: 		while( uxDeletedTasksWaitingCleanUp > ( UBaseType_t ) 0U )
L_tasks_prvCheckTasksWaitingTermination264:
MOVW	R0, #lo_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
MOVT	R0, #hi_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_tasks_prvCheckTasksWaitingTermination265
;tasks.c,3378 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;tasks.c,3380 :: 		xListIsEmpty = listLIST_IS_EMPTY( &xTasksWaitingTermination );
MOVW	R0, #lo_addr(tasks_xTasksWaitingTermination+0)
MOVT	R0, #hi_addr(tasks_xTasksWaitingTermination+0)
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L_tasks_prvCheckTasksWaitingTermination443
MOVS	R0, #1
L_tasks_prvCheckTasksWaitingTermination443:
STR	R0, [SP, #8]
;tasks.c,3382 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;tasks.c,3384 :: 		if( xListIsEmpty == pdFALSE )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_tasks_prvCheckTasksWaitingTermination266
;tasks.c,3388 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,3390 :: 		pxTCB = ( TCB_t * ) listGET_OWNER_OF_HEAD_ENTRY( ( &xTasksWaitingTermination ) );
MOVW	R0, #lo_addr(tasks_xTasksWaitingTermination+12)
MOVT	R0, #hi_addr(tasks_xTasksWaitingTermination+12)
LDR	R0, [R0, #0]
ADDS	R0, #12
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;tasks.c,3391 :: 		( void ) uxListRemove( &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,3392 :: 		--uxCurrentNumberOfTasks;
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxCurrentNumberOfTasks+0)
MOVT	R0, #hi_addr(tasks_uxCurrentNumberOfTasks+0)
STR	R1, [R0, #0]
;tasks.c,3393 :: 		--uxDeletedTasksWaitingCleanUp;
MOVW	R0, #lo_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
MOVT	R0, #hi_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
MOVW	R0, #lo_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
MOVT	R0, #hi_addr(tasks_uxDeletedTasksWaitingCleanUp+0)
STR	R1, [R0, #0]
;tasks.c,3395 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,3397 :: 		prvDeleteTCB( pxTCB );
LDR	R0, [SP, #4]
PUSH	(R0)
BL	tasks_prvDeleteTCB+0
ADD	SP, SP, #4
;tasks.c,3398 :: 		}
IT	AL
BAL	L_tasks_prvCheckTasksWaitingTermination267
L_tasks_prvCheckTasksWaitingTermination266:
;tasks.c,3402 :: 		}
L_tasks_prvCheckTasksWaitingTermination267:
;tasks.c,3403 :: 		}
IT	AL
BAL	L_tasks_prvCheckTasksWaitingTermination264
L_tasks_prvCheckTasksWaitingTermination265:
;tasks.c,3406 :: 		}
L_end_prvCheckTasksWaitingTermination:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of tasks_prvCheckTasksWaitingTermination
tasks_prvDeleteTCB:
;tasks.c,3581 :: 		static void prvDeleteTCB( TCB_t *pxTCB )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tasks.c,3600 :: 		vPortFree( pxTCB->pxStack );
LDR	R0, [SP, #4]
ADDS	R0, #48
LDR	R0, [R0, #0]
PUSH	(R0)
BL	_vPortFree+0
ADD	SP, SP, #4
;tasks.c,3601 :: 		vPortFree( pxTCB );
LDR	R0, [SP, #4]
PUSH	(R0)
BL	_vPortFree+0
ADD	SP, SP, #4
;tasks.c,3630 :: 		}
L_end_prvDeleteTCB:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of tasks_prvDeleteTCB
tasks_prvResetNextTaskUnblockTime:
;tasks.c,3635 :: 		static void prvResetNextTaskUnblockTime( void )
SUB	SP, SP, #4
;tasks.c,3639 :: 		if( listLIST_IS_EMPTY( pxDelayedTaskList ) != pdFALSE )
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
LDR	R0, [R0, #0]
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L_tasks_prvResetNextTaskUnblockTime446
MOVS	R0, #1
L_tasks_prvResetNextTaskUnblockTime446:
CMP	R0, #0
IT	EQ
BEQ	L_tasks_prvResetNextTaskUnblockTime268
;tasks.c,3645 :: 		xNextTaskUnblockTime = portMAX_DELAY;
MOV	R1, #-1
MOVW	R0, #lo_addr(tasks_xNextTaskUnblockTime+0)
MOVT	R0, #hi_addr(tasks_xNextTaskUnblockTime+0)
STR	R1, [R0, #0]
;tasks.c,3646 :: 		}
IT	AL
BAL	L_tasks_prvResetNextTaskUnblockTime269
L_tasks_prvResetNextTaskUnblockTime268:
;tasks.c,3653 :: 		( pxTCB ) = ( TCB_t * ) listGET_OWNER_OF_HEAD_ENTRY( pxDelayedTaskList );
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
LDR	R0, [R0, #0]
ADDS	R0, #8
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
ADDS	R0, #12
LDR	R0, [R0, #0]
STR	R0, [SP, #0]
;tasks.c,3654 :: 		xNextTaskUnblockTime = listGET_LIST_ITEM_VALUE( &( ( pxTCB )->xStateListItem ) );
LDR	R0, [SP, #0]
ADDS	R0, R0, #4
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(tasks_xNextTaskUnblockTime+0)
MOVT	R0, #hi_addr(tasks_xNextTaskUnblockTime+0)
STR	R1, [R0, #0]
;tasks.c,3655 :: 		}
L_tasks_prvResetNextTaskUnblockTime269:
;tasks.c,3656 :: 		}
L_end_prvResetNextTaskUnblockTime:
ADD	SP, SP, #4
BX	LR
; end of tasks_prvResetNextTaskUnblockTime
_xTaskGetCurrentTaskHandle:
;tasks.c,3661 :: 		TaskHandle_t xTaskGetCurrentTaskHandle( void )
SUB	SP, SP, #4
;tasks.c,3668 :: 		xReturn = pxCurrentTCB;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #0]
;tasks.c,3670 :: 		return xReturn;
LDR	R0, [SP, #0]
;tasks.c,3671 :: 		}
L_end_xTaskGetCurrentTaskHandle:
ADD	SP, SP, #4
BX	LR
; end of _xTaskGetCurrentTaskHandle
_vTaskPriorityInherit:
;tasks.c,3706 :: 		void vTaskPriorityInherit( TaskHandle_t const pxMutexHolder )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;tasks.c,3708 :: 		TCB_t * const pxTCB = ( TCB_t * ) pxMutexHolder;
LDR	R0, [SP, #8]
STR	R0, [SP, #4]
;tasks.c,3712 :: 		if( pxMutexHolder != NULL )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskPriorityInherit270
;tasks.c,3717 :: 		if( pxTCB->uxPriority < pxCurrentTCB->uxPriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	CS
BCS	L_vTaskPriorityInherit271
;tasks.c,3722 :: 		if( ( listGET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ) ) & taskEVENT_LIST_ITEM_VALUE_IN_USE ) == 0UL )
LDR	R0, [SP, #4]
ADDS	R0, #24
LDR	R0, [R0, #0]
AND	R0, R0, #-2147483648
CMP	R0, #0
IT	NE
BNE	L_vTaskPriorityInherit272
;tasks.c,3724 :: 		listSET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ), ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) pxCurrentTCB->uxPriority ); /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
LDR	R0, [SP, #4]
ADDS	R0, #24
MOV	R1, R0
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
RSB	R0, R0, #16
STR	R0, [R1, #0]
;tasks.c,3725 :: 		}
IT	AL
BAL	L_vTaskPriorityInherit273
L_vTaskPriorityInherit272:
;tasks.c,3729 :: 		}
L_vTaskPriorityInherit273:
;tasks.c,3733 :: 		if( listIS_CONTAINED_WITHIN( &( pxReadyTasksLists[ pxTCB->uxPriority ] ), &( pxTCB->xStateListItem ) ) != pdFALSE )
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
ADDS	R0, #16
LDR	R2, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
CMP	R2, R0
MOVW	R0, #0
BNE	L__vTaskPriorityInherit449
MOVS	R0, #1
L__vTaskPriorityInherit449:
CMP	R0, #0
IT	EQ
BEQ	L_vTaskPriorityInherit274
;tasks.c,3735 :: 		if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
CMP	R0, #0
IT	NE
BNE	L_vTaskPriorityInherit275
;tasks.c,3737 :: 		taskRESET_READY_PRIORITY( pxTCB->uxPriority );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vTaskPriorityInherit276
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSLS	R0, R1
MVN	R1, R0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
AND	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
L_vTaskPriorityInherit276:
;tasks.c,3738 :: 		}
IT	AL
BAL	L_vTaskPriorityInherit277
L_vTaskPriorityInherit275:
;tasks.c,3742 :: 		}
L_vTaskPriorityInherit277:
;tasks.c,3745 :: 		pxTCB->uxPriority = pxCurrentTCB->uxPriority;
LDR	R0, [SP, #4]
ADDW	R1, R0, #44
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;tasks.c,3746 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,3747 :: 		}
IT	AL
BAL	L_vTaskPriorityInherit278
L_vTaskPriorityInherit274:
;tasks.c,3751 :: 		pxTCB->uxPriority = pxCurrentTCB->uxPriority;
LDR	R0, [SP, #4]
ADDW	R1, R0, #44
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;tasks.c,3752 :: 		}
L_vTaskPriorityInherit278:
;tasks.c,3755 :: 		}
IT	AL
BAL	L_vTaskPriorityInherit279
L_vTaskPriorityInherit271:
;tasks.c,3759 :: 		}
L_vTaskPriorityInherit279:
;tasks.c,3760 :: 		}
IT	AL
BAL	L_vTaskPriorityInherit280
L_vTaskPriorityInherit270:
;tasks.c,3764 :: 		}
L_vTaskPriorityInherit280:
;tasks.c,3765 :: 		}
L_end_vTaskPriorityInherit:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _vTaskPriorityInherit
_xTaskPriorityDisinherit:
;tasks.c,3772 :: 		BaseType_t xTaskPriorityDisinherit( TaskHandle_t const pxMutexHolder )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,3774 :: 		TCB_t * const pxTCB = ( TCB_t * ) pxMutexHolder;
LDR	R0, [SP, #12]
STR	R0, [SP, #4]
;tasks.c,3775 :: 		BaseType_t xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #8]
;tasks.c,3777 :: 		if( pxMutexHolder != NULL )
LDR	R0, [SP, #12]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskPriorityDisinherit281
;tasks.c,3783 :: 		configASSERT( pxTCB == pxCurrentTCB );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R0, R1
MOVW	R0, #0
BNE	L__xTaskPriorityDisinherit451
MOVS	R0, #1
L__xTaskPriorityDisinherit451:
CMP	R0, #0
IT	NE
BNE	L_xTaskPriorityDisinherit282
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskPriorityDisinherit283:
IT	AL
BAL	L_xTaskPriorityDisinherit283
L_xTaskPriorityDisinherit282:
;tasks.c,3785 :: 		configASSERT( pxTCB->uxMutexesHeld );
LDR	R0, [SP, #4]
ADDS	R0, #72
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskPriorityDisinherit285
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskPriorityDisinherit286:
IT	AL
BAL	L_xTaskPriorityDisinherit286
L_xTaskPriorityDisinherit285:
;tasks.c,3786 :: 		( pxTCB->uxMutexesHeld )--;
LDR	R0, [SP, #4]
ADDW	R1, R0, #72
LDR	R0, [R1, #0]
SUBS	R0, R0, #1
STR	R0, [R1, #0]
;tasks.c,3790 :: 		if( pxTCB->uxPriority != pxTCB->uxBasePriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, #68
LDR	R0, [R0, #0]
CMP	R1, R0
IT	EQ
BEQ	L_xTaskPriorityDisinherit288
;tasks.c,3793 :: 		if( pxTCB->uxMutexesHeld == ( UBaseType_t ) 0 )
LDR	R0, [SP, #4]
ADDS	R0, #72
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskPriorityDisinherit289
;tasks.c,3800 :: 		if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
CMP	R0, #0
IT	NE
BNE	L_xTaskPriorityDisinherit290
;tasks.c,3802 :: 		taskRESET_READY_PRIORITY( pxTCB->uxPriority );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskPriorityDisinherit291
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSLS	R0, R1
MVN	R1, R0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
AND	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
L_xTaskPriorityDisinherit291:
;tasks.c,3803 :: 		}
IT	AL
BAL	L_xTaskPriorityDisinherit292
L_xTaskPriorityDisinherit290:
;tasks.c,3807 :: 		}
L_xTaskPriorityDisinherit292:
;tasks.c,3812 :: 		pxTCB->uxPriority = pxTCB->uxBasePriority;
LDR	R0, [SP, #4]
ADDW	R1, R0, #44
LDR	R0, [SP, #4]
ADDS	R0, #68
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;tasks.c,3817 :: 		listSET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ), ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) pxTCB->uxPriority ); /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
LDR	R0, [SP, #4]
ADDS	R0, #24
MOV	R1, R0
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R0, [R0, #0]
RSB	R0, R0, #16
STR	R0, [R1, #0]
;tasks.c,3818 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,3828 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #8]
;tasks.c,3829 :: 		}
IT	AL
BAL	L_xTaskPriorityDisinherit293
L_xTaskPriorityDisinherit289:
;tasks.c,3833 :: 		}
L_xTaskPriorityDisinherit293:
;tasks.c,3834 :: 		}
IT	AL
BAL	L_xTaskPriorityDisinherit294
L_xTaskPriorityDisinherit288:
;tasks.c,3838 :: 		}
L_xTaskPriorityDisinherit294:
;tasks.c,3839 :: 		}
IT	AL
BAL	L_xTaskPriorityDisinherit295
L_xTaskPriorityDisinherit281:
;tasks.c,3843 :: 		}
L_xTaskPriorityDisinherit295:
;tasks.c,3845 :: 		return xReturn;
LDR	R0, [SP, #8]
;tasks.c,3846 :: 		}
L_end_xTaskPriorityDisinherit:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _xTaskPriorityDisinherit
_uxTaskResetEventItemValue:
;tasks.c,4162 :: 		TickType_t uxTaskResetEventItemValue( void )
SUB	SP, SP, #4
;tasks.c,4166 :: 		uxReturn = listGET_LIST_ITEM_VALUE( &( pxCurrentTCB->xEventListItem ) );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #24
LDR	R0, [R0, #0]
STR	R0, [SP, #0]
;tasks.c,4170 :: 		listSET_LIST_ITEM_VALUE( &( pxCurrentTCB->xEventListItem ), ( ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) pxCurrentTCB->uxPriority ) ); /*lint !e961 MISRA exception as the casts are only redundant for some ports. */
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #24
MOV	R1, R0
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
RSB	R0, R0, #16
STR	R0, [R1, #0]
;tasks.c,4172 :: 		return uxReturn;
LDR	R0, [SP, #0]
;tasks.c,4173 :: 		}
L_end_uxTaskResetEventItemValue:
ADD	SP, SP, #4
BX	LR
; end of _uxTaskResetEventItemValue
_pvTaskIncrementMutexHeldCount:
;tasks.c,4178 :: 		void *pvTaskIncrementMutexHeldCount( void )
;tasks.c,4182 :: 		if( pxCurrentTCB != NULL )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_pvTaskIncrementMutexHeldCount296
;tasks.c,4184 :: 		( pxCurrentTCB->uxMutexesHeld )++;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #72
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;tasks.c,4185 :: 		}
L_pvTaskIncrementMutexHeldCount296:
;tasks.c,4187 :: 		return pxCurrentTCB;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
;tasks.c,4188 :: 		}
L_end_pvTaskIncrementMutexHeldCount:
BX	LR
; end of _pvTaskIncrementMutexHeldCount
_ulTaskNotifyTake:
;tasks.c,4195 :: 		uint32_t ulTaskNotifyTake( BaseType_t xClearCountOnExit, TickType_t xTicksToWait )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;tasks.c,4199 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,4202 :: 		if( pxCurrentTCB->ulNotifiedValue == 0UL )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #76
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_ulTaskNotifyTake297
;tasks.c,4205 :: 		pxCurrentTCB->ucNotifyState = taskWAITING_NOTIFICATION;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #80
MOVS	R0, #1
STRB	R0, [R1, #0]
;tasks.c,4207 :: 		if( xTicksToWait > ( TickType_t ) 0 )
LDR	R0, [SP, #12]
CMP	R0, #0
IT	LS
BLS	L_ulTaskNotifyTake298
;tasks.c,4209 :: 		prvAddCurrentTaskToDelayedList( xTicksToWait, pdTRUE );
MOV	R0, #1
PUSH	(R0)
LDR	R0, [SP, #16]
PUSH	(R0)
BL	tasks_prvAddCurrentTaskToDelayedList+0
ADD	SP, SP, #8
;tasks.c,4216 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,4217 :: 		}
IT	AL
BAL	L_ulTaskNotifyTake299
L_ulTaskNotifyTake298:
;tasks.c,4221 :: 		}
L_ulTaskNotifyTake299:
;tasks.c,4222 :: 		}
IT	AL
BAL	L_ulTaskNotifyTake300
L_ulTaskNotifyTake297:
;tasks.c,4226 :: 		}
L_ulTaskNotifyTake300:
;tasks.c,4228 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,4230 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,4233 :: 		ulReturn = pxCurrentTCB->ulNotifiedValue;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #76
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;tasks.c,4235 :: 		if( ulReturn != 0UL )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_ulTaskNotifyTake301
;tasks.c,4237 :: 		if( xClearCountOnExit != pdFALSE )
LDR	R0, [SP, #8]
CMP	R0, #0
IT	EQ
BEQ	L_ulTaskNotifyTake302
;tasks.c,4239 :: 		pxCurrentTCB->ulNotifiedValue = 0UL;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #76
MOV	R0, #0
STR	R0, [R1, #0]
;tasks.c,4240 :: 		}
IT	AL
BAL	L_ulTaskNotifyTake303
L_ulTaskNotifyTake302:
;tasks.c,4243 :: 		pxCurrentTCB->ulNotifiedValue = ulReturn - 1;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #76
LDR	R0, [SP, #4]
SUBS	R0, R0, #1
STR	R0, [R1, #0]
;tasks.c,4244 :: 		}
L_ulTaskNotifyTake303:
;tasks.c,4245 :: 		}
IT	AL
BAL	L_ulTaskNotifyTake304
L_ulTaskNotifyTake301:
;tasks.c,4249 :: 		}
L_ulTaskNotifyTake304:
;tasks.c,4251 :: 		pxCurrentTCB->ucNotifyState = taskNOT_WAITING_NOTIFICATION;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #80
MOVS	R0, #0
STRB	R0, [R1, #0]
;tasks.c,4253 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,4255 :: 		return ulReturn;
LDR	R0, [SP, #4]
;tasks.c,4256 :: 		}
L_end_ulTaskNotifyTake:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ulTaskNotifyTake
_xTaskNotifyWait:
;tasks.c,4263 :: 		BaseType_t xTaskNotifyWait( uint32_t ulBitsToClearOnEntry, uint32_t ulBitsToClearOnExit, uint32_t *pulNotificationValue, TickType_t xTicksToWait )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;tasks.c,4267 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,4270 :: 		if( pxCurrentTCB->ucNotifyState != taskNOTIFICATION_RECEIVED )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #80
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_xTaskNotifyWait305
;tasks.c,4275 :: 		pxCurrentTCB->ulNotifiedValue &= ~ulBitsToClearOnEntry;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R2, R0, #76
LDR	R0, [SP, #8]
MVN	R1, R0
LDR	R0, [R2, #0]
ANDS	R0, R1
STR	R0, [R2, #0]
;tasks.c,4278 :: 		pxCurrentTCB->ucNotifyState = taskWAITING_NOTIFICATION;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #80
MOVS	R0, #1
STRB	R0, [R1, #0]
;tasks.c,4280 :: 		if( xTicksToWait > ( TickType_t ) 0 )
LDR	R0, [SP, #20]
CMP	R0, #0
IT	LS
BLS	L_xTaskNotifyWait306
;tasks.c,4282 :: 		prvAddCurrentTaskToDelayedList( xTicksToWait, pdTRUE );
MOV	R0, #1
PUSH	(R0)
LDR	R0, [SP, #24]
PUSH	(R0)
BL	tasks_prvAddCurrentTaskToDelayedList+0
ADD	SP, SP, #8
;tasks.c,4289 :: 		portYIELD_WITHIN_API();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,4290 :: 		}
IT	AL
BAL	L_xTaskNotifyWait307
L_xTaskNotifyWait306:
;tasks.c,4294 :: 		}
L_xTaskNotifyWait307:
;tasks.c,4295 :: 		}
IT	AL
BAL	L_xTaskNotifyWait308
L_xTaskNotifyWait305:
;tasks.c,4299 :: 		}
L_xTaskNotifyWait308:
;tasks.c,4301 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,4303 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,4307 :: 		if( pulNotificationValue != NULL )
LDR	R0, [SP, #16]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskNotifyWait309
;tasks.c,4311 :: 		*pulNotificationValue = pxCurrentTCB->ulNotifiedValue;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #76
LDR	R1, [R0, #0]
LDR	R0, [SP, #16]
STR	R1, [R0, #0]
;tasks.c,4312 :: 		}
L_xTaskNotifyWait309:
;tasks.c,4318 :: 		if( pxCurrentTCB->ucNotifyState == taskWAITING_NOTIFICATION )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #80
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_xTaskNotifyWait310
;tasks.c,4321 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;tasks.c,4322 :: 		}
IT	AL
BAL	L_xTaskNotifyWait311
L_xTaskNotifyWait310:
;tasks.c,4327 :: 		pxCurrentTCB->ulNotifiedValue &= ~ulBitsToClearOnExit;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R2, R0, #76
LDR	R0, [SP, #12]
MVN	R1, R0
LDR	R0, [R2, #0]
ANDS	R0, R1
STR	R0, [R2, #0]
;tasks.c,4328 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;tasks.c,4329 :: 		}
L_xTaskNotifyWait311:
;tasks.c,4331 :: 		pxCurrentTCB->ucNotifyState = taskNOT_WAITING_NOTIFICATION;
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #80
MOVS	R0, #0
STRB	R0, [R1, #0]
;tasks.c,4333 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,4335 :: 		return xReturn;
LDR	R0, [SP, #4]
;tasks.c,4336 :: 		}
L_end_xTaskNotifyWait:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _xTaskNotifyWait
_xTaskGenericNotify:
;tasks.c,4343 :: 		BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;tasks.c,4346 :: 		BaseType_t xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #12]
;tasks.c,4349 :: 		configASSERT( xTaskToNotify );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_xTaskGenericNotify312
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskGenericNotify313:
IT	AL
BAL	L_xTaskGenericNotify313
L_xTaskGenericNotify312:
;tasks.c,4350 :: 		pxTCB = ( TCB_t * ) xTaskToNotify;
LDR	R0, [SP, #16]
STR	R0, [SP, #4]
;tasks.c,4352 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,4354 :: 		if( pulPreviousNotificationValue != NULL )
LDR	R0, [SP, #28]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskGenericNotify315
;tasks.c,4356 :: 		*pulPreviousNotificationValue = pxTCB->ulNotifiedValue;
LDR	R0, [SP, #4]
ADDS	R0, #76
LDR	R1, [R0, #0]
LDR	R0, [SP, #28]
STR	R1, [R0, #0]
;tasks.c,4357 :: 		}
L_xTaskGenericNotify315:
;tasks.c,4359 :: 		ucOriginalNotifyState = pxTCB->ucNotifyState;
LDR	R0, [SP, #4]
ADDS	R0, #80
LDRB	R0, [R0, #0]
STRB	R0, [SP, #8]
;tasks.c,4361 :: 		pxTCB->ucNotifyState = taskNOTIFICATION_RECEIVED;
LDR	R0, [SP, #4]
ADDW	R1, R0, #80
MOVS	R0, #2
STRB	R0, [R1, #0]
;tasks.c,4363 :: 		switch( eAction )
IT	AL
BAL	L_xTaskGenericNotify316
;tasks.c,4365 :: 		case eSetBits        :
L_xTaskGenericNotify318:
;tasks.c,4366 :: 		pxTCB->ulNotifiedValue |= ulValue;
LDR	R0, [SP, #4]
ADDW	R2, R0, #76
LDR	R1, [R2, #0]
LDR	R0, [SP, #20]
ORR	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;tasks.c,4367 :: 		break;
IT	AL
BAL	L_xTaskGenericNotify317
;tasks.c,4369 :: 		case eIncrement        :
L_xTaskGenericNotify319:
;tasks.c,4370 :: 		( pxTCB->ulNotifiedValue )++;
LDR	R0, [SP, #4]
ADDW	R1, R0, #76
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;tasks.c,4371 :: 		break;
IT	AL
BAL	L_xTaskGenericNotify317
;tasks.c,4373 :: 		case eSetValueWithOverwrite        :
L_xTaskGenericNotify320:
;tasks.c,4374 :: 		pxTCB->ulNotifiedValue = ulValue;
LDR	R0, [SP, #4]
ADDW	R1, R0, #76
LDR	R0, [SP, #20]
STR	R0, [R1, #0]
;tasks.c,4375 :: 		break;
IT	AL
BAL	L_xTaskGenericNotify317
;tasks.c,4377 :: 		case eSetValueWithoutOverwrite :
L_xTaskGenericNotify321:
;tasks.c,4378 :: 		if( ucOriginalNotifyState != taskNOTIFICATION_RECEIVED )
LDRB	R0, [SP, #8]
CMP	R0, #2
IT	EQ
BEQ	L_xTaskGenericNotify322
;tasks.c,4380 :: 		pxTCB->ulNotifiedValue = ulValue;
LDR	R0, [SP, #4]
ADDW	R1, R0, #76
LDR	R0, [SP, #20]
STR	R0, [R1, #0]
;tasks.c,4381 :: 		}
IT	AL
BAL	L_xTaskGenericNotify323
L_xTaskGenericNotify322:
;tasks.c,4385 :: 		xReturn = pdFAIL;
MOV	R0, #0
STR	R0, [SP, #12]
;tasks.c,4386 :: 		}
L_xTaskGenericNotify323:
;tasks.c,4387 :: 		break;
IT	AL
BAL	L_xTaskGenericNotify317
;tasks.c,4389 :: 		case eNoAction:
L_xTaskGenericNotify324:
;tasks.c,4392 :: 		break;
IT	AL
BAL	L_xTaskGenericNotify317
;tasks.c,4393 :: 		}
L_xTaskGenericNotify316:
LDRB	R0, [SP, #24]
CMP	R0, #1
IT	EQ
BEQ	L_xTaskGenericNotify318
LDRB	R0, [SP, #24]
CMP	R0, #2
IT	EQ
BEQ	L_xTaskGenericNotify319
LDRB	R0, [SP, #24]
CMP	R0, #3
IT	EQ
BEQ	L_xTaskGenericNotify320
LDRB	R0, [SP, #24]
CMP	R0, #4
IT	EQ
BEQ	L_xTaskGenericNotify321
LDRB	R0, [SP, #24]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskGenericNotify324
L_xTaskGenericNotify317:
;tasks.c,4399 :: 		if( ucOriginalNotifyState == taskWAITING_NOTIFICATION )
LDRB	R0, [SP, #8]
CMP	R0, #1
IT	NE
BNE	L_xTaskGenericNotify325
;tasks.c,4401 :: 		( void ) uxListRemove( &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,4402 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,4405 :: 		configASSERT( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) == NULL );
LDR	R0, [SP, #4]
ADDS	R0, #24
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xTaskGenericNotify457
MOVS	R0, #1
L__xTaskGenericNotify457:
CMP	R0, #0
IT	NE
BNE	L_xTaskGenericNotify326
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskGenericNotify327:
IT	AL
BAL	L_xTaskGenericNotify327
L_xTaskGenericNotify326:
;tasks.c,4423 :: 		if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_xTaskGenericNotify329
;tasks.c,4427 :: 		taskYIELD_IF_USING_PREEMPTION();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
DSB	#15
ISB	#15
;tasks.c,4428 :: 		}
IT	AL
BAL	L_xTaskGenericNotify330
L_xTaskGenericNotify329:
;tasks.c,4432 :: 		}
L_xTaskGenericNotify330:
;tasks.c,4433 :: 		}
IT	AL
BAL	L_xTaskGenericNotify331
L_xTaskGenericNotify325:
;tasks.c,4437 :: 		}
L_xTaskGenericNotify331:
;tasks.c,4439 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,4441 :: 		return xReturn;
LDR	R0, [SP, #12]
;tasks.c,4442 :: 		}
L_end_xTaskGenericNotify:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xTaskGenericNotify
_xTaskGenericNotifyFromISR:
;tasks.c,4449 :: 		BaseType_t xTaskGenericNotifyFromISR( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue, BaseType_t *pxHigherPriorityTaskWoken )
SUB	SP, SP, #20
STR	LR, [SP, #0]
;tasks.c,4453 :: 		BaseType_t xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #16]
;tasks.c,4456 :: 		configASSERT( xTaskToNotify );
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_xTaskGenericNotifyFromISR332
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskGenericNotifyFromISR333:
IT	AL
BAL	L_xTaskGenericNotifyFromISR333
L_xTaskGenericNotifyFromISR332:
;tasks.c,4474 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;tasks.c,4476 :: 		pxTCB = ( TCB_t * ) xTaskToNotify;
LDR	R0, [SP, #20]
STR	R0, [SP, #4]
;tasks.c,4478 :: 		uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
BL	tasks_ulPortRaiseBASEPRI+0
STR	R0, [SP, #12]
;tasks.c,4480 :: 		if( pulPreviousNotificationValue != NULL )
LDR	R0, [SP, #32]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskGenericNotifyFromISR335
;tasks.c,4482 :: 		*pulPreviousNotificationValue = pxTCB->ulNotifiedValue;
LDR	R0, [SP, #4]
ADDS	R0, #76
LDR	R1, [R0, #0]
LDR	R0, [SP, #32]
STR	R1, [R0, #0]
;tasks.c,4483 :: 		}
L_xTaskGenericNotifyFromISR335:
;tasks.c,4485 :: 		ucOriginalNotifyState = pxTCB->ucNotifyState;
LDR	R0, [SP, #4]
ADDS	R0, #80
LDRB	R0, [R0, #0]
STRB	R0, [SP, #8]
;tasks.c,4486 :: 		pxTCB->ucNotifyState = taskNOTIFICATION_RECEIVED;
LDR	R0, [SP, #4]
ADDW	R1, R0, #80
MOVS	R0, #2
STRB	R0, [R1, #0]
;tasks.c,4488 :: 		switch( eAction )
IT	AL
BAL	L_xTaskGenericNotifyFromISR336
;tasks.c,4490 :: 		case eSetBits        :
L_xTaskGenericNotifyFromISR338:
;tasks.c,4491 :: 		pxTCB->ulNotifiedValue |= ulValue;
LDR	R0, [SP, #4]
ADDW	R2, R0, #76
LDR	R1, [R2, #0]
LDR	R0, [SP, #24]
ORR	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;tasks.c,4492 :: 		break;
IT	AL
BAL	L_xTaskGenericNotifyFromISR337
;tasks.c,4494 :: 		case eIncrement        :
L_xTaskGenericNotifyFromISR339:
;tasks.c,4495 :: 		( pxTCB->ulNotifiedValue )++;
LDR	R0, [SP, #4]
ADDW	R1, R0, #76
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;tasks.c,4496 :: 		break;
IT	AL
BAL	L_xTaskGenericNotifyFromISR337
;tasks.c,4498 :: 		case eSetValueWithOverwrite        :
L_xTaskGenericNotifyFromISR340:
;tasks.c,4499 :: 		pxTCB->ulNotifiedValue = ulValue;
LDR	R0, [SP, #4]
ADDW	R1, R0, #76
LDR	R0, [SP, #24]
STR	R0, [R1, #0]
;tasks.c,4500 :: 		break;
IT	AL
BAL	L_xTaskGenericNotifyFromISR337
;tasks.c,4502 :: 		case eSetValueWithoutOverwrite :
L_xTaskGenericNotifyFromISR341:
;tasks.c,4503 :: 		if( ucOriginalNotifyState != taskNOTIFICATION_RECEIVED )
LDRB	R0, [SP, #8]
CMP	R0, #2
IT	EQ
BEQ	L_xTaskGenericNotifyFromISR342
;tasks.c,4505 :: 		pxTCB->ulNotifiedValue = ulValue;
LDR	R0, [SP, #4]
ADDW	R1, R0, #76
LDR	R0, [SP, #24]
STR	R0, [R1, #0]
;tasks.c,4506 :: 		}
IT	AL
BAL	L_xTaskGenericNotifyFromISR343
L_xTaskGenericNotifyFromISR342:
;tasks.c,4510 :: 		xReturn = pdFAIL;
MOV	R0, #0
STR	R0, [SP, #16]
;tasks.c,4511 :: 		}
L_xTaskGenericNotifyFromISR343:
;tasks.c,4512 :: 		break;
IT	AL
BAL	L_xTaskGenericNotifyFromISR337
;tasks.c,4514 :: 		case eNoAction :
L_xTaskGenericNotifyFromISR344:
;tasks.c,4517 :: 		break;
IT	AL
BAL	L_xTaskGenericNotifyFromISR337
;tasks.c,4518 :: 		}
L_xTaskGenericNotifyFromISR336:
LDRB	R0, [SP, #28]
CMP	R0, #1
IT	EQ
BEQ	L_xTaskGenericNotifyFromISR338
LDRB	R0, [SP, #28]
CMP	R0, #2
IT	EQ
BEQ	L_xTaskGenericNotifyFromISR339
LDRB	R0, [SP, #28]
CMP	R0, #3
IT	EQ
BEQ	L_xTaskGenericNotifyFromISR340
LDRB	R0, [SP, #28]
CMP	R0, #4
IT	EQ
BEQ	L_xTaskGenericNotifyFromISR341
LDRB	R0, [SP, #28]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskGenericNotifyFromISR344
L_xTaskGenericNotifyFromISR337:
;tasks.c,4524 :: 		if( ucOriginalNotifyState == taskWAITING_NOTIFICATION )
LDRB	R0, [SP, #8]
CMP	R0, #1
IT	NE
BNE	L_xTaskGenericNotifyFromISR345
;tasks.c,4527 :: 		configASSERT( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) == NULL );
LDR	R0, [SP, #4]
ADDS	R0, #24
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__xTaskGenericNotifyFromISR459
MOVS	R0, #1
L__xTaskGenericNotifyFromISR459:
CMP	R0, #0
IT	NE
BNE	L_xTaskGenericNotifyFromISR346
BL	tasks_vPortRaiseBASEPRI+0
L_xTaskGenericNotifyFromISR347:
IT	AL
BAL	L_xTaskGenericNotifyFromISR347
L_xTaskGenericNotifyFromISR346:
;tasks.c,4529 :: 		if( uxSchedulerSuspended == ( UBaseType_t ) pdFALSE )
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_xTaskGenericNotifyFromISR349
;tasks.c,4531 :: 		( void ) uxListRemove( &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,4532 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,4533 :: 		}
IT	AL
BAL	L_xTaskGenericNotifyFromISR350
L_xTaskGenericNotifyFromISR349:
;tasks.c,4538 :: 		vListInsertEnd( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, #24
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_xPendingReadyList+0)
MOVT	R0, #hi_addr(tasks_xPendingReadyList+0)
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,4539 :: 		}
L_xTaskGenericNotifyFromISR350:
;tasks.c,4541 :: 		if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_xTaskGenericNotifyFromISR351
;tasks.c,4545 :: 		if( pxHigherPriorityTaskWoken != NULL )
LDR	R0, [SP, #36]
CMP	R0, #0
IT	EQ
BEQ	L_xTaskGenericNotifyFromISR352
;tasks.c,4547 :: 		*pxHigherPriorityTaskWoken = pdTRUE;
MOV	R1, #1
LDR	R0, [SP, #36]
STR	R1, [R0, #0]
;tasks.c,4548 :: 		}
IT	AL
BAL	L_xTaskGenericNotifyFromISR353
L_xTaskGenericNotifyFromISR352:
;tasks.c,4554 :: 		xYieldPending = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,4555 :: 		}
L_xTaskGenericNotifyFromISR353:
;tasks.c,4556 :: 		}
IT	AL
BAL	L_xTaskGenericNotifyFromISR354
L_xTaskGenericNotifyFromISR351:
;tasks.c,4560 :: 		}
L_xTaskGenericNotifyFromISR354:
;tasks.c,4561 :: 		}
L_xTaskGenericNotifyFromISR345:
;tasks.c,4563 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
LDR	R0, [SP, #12]
PUSH	(R0)
BL	tasks_vPortSetBASEPRI+0
ADD	SP, SP, #4
;tasks.c,4565 :: 		return xReturn;
LDR	R0, [SP, #16]
;tasks.c,4566 :: 		}
L_end_xTaskGenericNotifyFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _xTaskGenericNotifyFromISR
_vTaskNotifyGiveFromISR:
;tasks.c,4573 :: 		void vTaskNotifyGiveFromISR( TaskHandle_t xTaskToNotify, BaseType_t *pxHigherPriorityTaskWoken )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;tasks.c,4579 :: 		configASSERT( xTaskToNotify );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_vTaskNotifyGiveFromISR355
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskNotifyGiveFromISR356:
IT	AL
BAL	L_vTaskNotifyGiveFromISR356
L_vTaskNotifyGiveFromISR355:
;tasks.c,4597 :: 		portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
BL	_vPortValidateInterruptPriority+0
;tasks.c,4599 :: 		pxTCB = ( TCB_t * ) xTaskToNotify;
LDR	R0, [SP, #16]
STR	R0, [SP, #4]
;tasks.c,4601 :: 		uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
BL	tasks_ulPortRaiseBASEPRI+0
STR	R0, [SP, #12]
;tasks.c,4603 :: 		ucOriginalNotifyState = pxTCB->ucNotifyState;
LDR	R0, [SP, #4]
ADDS	R0, #80
LDRB	R0, [R0, #0]
STRB	R0, [SP, #8]
;tasks.c,4604 :: 		pxTCB->ucNotifyState = taskNOTIFICATION_RECEIVED;
LDR	R0, [SP, #4]
ADDW	R1, R0, #80
MOVS	R0, #2
STRB	R0, [R1, #0]
;tasks.c,4608 :: 		( pxTCB->ulNotifiedValue )++;
LDR	R0, [SP, #4]
ADDW	R1, R0, #76
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;tasks.c,4614 :: 		if( ucOriginalNotifyState == taskWAITING_NOTIFICATION )
LDRB	R0, [SP, #8]
CMP	R0, #1
IT	NE
BNE	L_vTaskNotifyGiveFromISR358
;tasks.c,4617 :: 		configASSERT( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) == NULL );
LDR	R0, [SP, #4]
ADDS	R0, #24
ADDS	R0, #16
LDR	R0, [R0, #0]
CMP	R0, #0
MOVW	R0, #0
BNE	L__vTaskNotifyGiveFromISR461
MOVS	R0, #1
L__vTaskNotifyGiveFromISR461:
CMP	R0, #0
IT	NE
BNE	L_vTaskNotifyGiveFromISR359
BL	tasks_vPortRaiseBASEPRI+0
L_vTaskNotifyGiveFromISR360:
IT	AL
BAL	L_vTaskNotifyGiveFromISR360
L_vTaskNotifyGiveFromISR359:
;tasks.c,4619 :: 		if( uxSchedulerSuspended == ( UBaseType_t ) pdFALSE )
MOVW	R0, #lo_addr(tasks_uxSchedulerSuspended+0)
MOVT	R0, #hi_addr(tasks_uxSchedulerSuspended+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vTaskNotifyGiveFromISR362
;tasks.c,4621 :: 		( void ) uxListRemove( &( pxTCB->xStateListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
;tasks.c,4622 :: 		prvAddTaskToReadyList( pxTCB );
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSL	R1, R0, R1
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
PUSH	(R0)
LDR	R0, [SP, #8]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVS	R0, #20
MULS	R1, R0, R1
MOVW	R0, #lo_addr(tasks_pxReadyTasksLists+0)
MOVT	R0, #hi_addr(tasks_pxReadyTasksLists+0)
ADDS	R0, R0, R1
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,4623 :: 		}
IT	AL
BAL	L_vTaskNotifyGiveFromISR363
L_vTaskNotifyGiveFromISR362:
;tasks.c,4628 :: 		vListInsertEnd( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
LDR	R0, [SP, #4]
ADDS	R0, #24
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_xPendingReadyList+0)
MOVT	R0, #hi_addr(tasks_xPendingReadyList+0)
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,4629 :: 		}
L_vTaskNotifyGiveFromISR363:
;tasks.c,4631 :: 		if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
LDR	R0, [SP, #4]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_vTaskNotifyGiveFromISR364
;tasks.c,4635 :: 		if( pxHigherPriorityTaskWoken != NULL )
LDR	R0, [SP, #20]
CMP	R0, #0
IT	EQ
BEQ	L_vTaskNotifyGiveFromISR365
;tasks.c,4637 :: 		*pxHigherPriorityTaskWoken = pdTRUE;
MOV	R1, #1
LDR	R0, [SP, #20]
STR	R1, [R0, #0]
;tasks.c,4638 :: 		}
IT	AL
BAL	L_vTaskNotifyGiveFromISR366
L_vTaskNotifyGiveFromISR365:
;tasks.c,4644 :: 		xYieldPending = pdTRUE;
MOV	R1, #1
MOVW	R0, #lo_addr(tasks_xYieldPending+0)
MOVT	R0, #hi_addr(tasks_xYieldPending+0)
STR	R1, [R0, #0]
;tasks.c,4645 :: 		}
L_vTaskNotifyGiveFromISR366:
;tasks.c,4646 :: 		}
IT	AL
BAL	L_vTaskNotifyGiveFromISR367
L_vTaskNotifyGiveFromISR364:
;tasks.c,4650 :: 		}
L_vTaskNotifyGiveFromISR367:
;tasks.c,4651 :: 		}
L_vTaskNotifyGiveFromISR358:
;tasks.c,4653 :: 		portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
LDR	R0, [SP, #12]
PUSH	(R0)
BL	tasks_vPortSetBASEPRI+0
ADD	SP, SP, #4
;tasks.c,4654 :: 		}
L_end_vTaskNotifyGiveFromISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _vTaskNotifyGiveFromISR
_xTaskNotifyStateClear:
;tasks.c,4662 :: 		BaseType_t xTaskNotifyStateClear( TaskHandle_t xTask )
SUB	SP, SP, #16
STR	LR, [SP, #0]
;tasks.c,4669 :: 		pxTCB = prvGetTCBFromHandle( xTask );
LDR	R0, [SP, #16]
CMP	R0, #0
IT	NE
BNE	L_xTaskNotifyStateClear368
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
IT	AL
BAL	L_xTaskNotifyStateClear369
L_xTaskNotifyStateClear368:
LDR	R0, [SP, #16]
STR	R0, [SP, #4]
L_xTaskNotifyStateClear369:
LDR	R0, [SP, #4]
STR	R0, [SP, #8]
;tasks.c,4671 :: 		taskENTER_CRITICAL();
BL	_vPortEnterCritical+0
;tasks.c,4673 :: 		if( pxTCB->ucNotifyState == taskNOTIFICATION_RECEIVED )
LDR	R0, [SP, #8]
ADDS	R0, #80
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_xTaskNotifyStateClear370
;tasks.c,4675 :: 		pxTCB->ucNotifyState = taskNOT_WAITING_NOTIFICATION;
LDR	R0, [SP, #8]
ADDW	R1, R0, #80
MOVS	R0, #0
STRB	R0, [R1, #0]
;tasks.c,4676 :: 		xReturn = pdPASS;
MOV	R0, #1
STR	R0, [SP, #12]
;tasks.c,4677 :: 		}
IT	AL
BAL	L_xTaskNotifyStateClear371
L_xTaskNotifyStateClear370:
;tasks.c,4680 :: 		xReturn = pdFAIL;
MOV	R0, #0
STR	R0, [SP, #12]
;tasks.c,4681 :: 		}
L_xTaskNotifyStateClear371:
;tasks.c,4683 :: 		taskEXIT_CRITICAL();
BL	_vPortExitCritical+0
;tasks.c,4685 :: 		return xReturn;
LDR	R0, [SP, #12]
;tasks.c,4686 :: 		}
L_end_xTaskNotifyStateClear:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xTaskNotifyStateClear
tasks_prvAddCurrentTaskToDelayedList:
;tasks.c,4692 :: 		static void prvAddCurrentTaskToDelayedList( TickType_t xTicksToWait, const BaseType_t xCanBlockIndefinitely )
SUB	SP, SP, #12
STR	LR, [SP, #0]
;tasks.c,4695 :: 		const TickType_t xConstTickCount = xTickCount;
MOVW	R0, #lo_addr(tasks_xTickCount+0)
MOVT	R0, #hi_addr(tasks_xTickCount+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #8]
;tasks.c,4708 :: 		if( uxListRemove( &( pxCurrentTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
PUSH	(R0)
BL	_uxListRemove+0
ADD	SP, SP, #4
CMP	R0, #0
IT	NE
BNE	L_tasks_prvAddCurrentTaskToDelayedList372
;tasks.c,4712 :: 		portRESET_READY_PRIORITY( pxCurrentTCB->uxPriority, uxTopReadyPriority );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, #44
LDR	R1, [R0, #0]
MOV	R0, #1
LSLS	R0, R1
MVN	R1, R0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
LDR	R0, [R0, #0]
AND	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(tasks_uxTopReadyPriority+0)
MOVT	R0, #hi_addr(tasks_uxTopReadyPriority+0)
STR	R1, [R0, #0]
;tasks.c,4713 :: 		}
IT	AL
BAL	L_tasks_prvAddCurrentTaskToDelayedList373
L_tasks_prvAddCurrentTaskToDelayedList372:
;tasks.c,4717 :: 		}
L_tasks_prvAddCurrentTaskToDelayedList373:
;tasks.c,4721 :: 		if( ( xTicksToWait == portMAX_DELAY ) && ( xCanBlockIndefinitely != pdFALSE ) )
LDR	R0, [SP, #12]
CMP	R0, #-1
IT	NE
BNE	L_tasks_prvAddCurrentTaskToDelayedList376
LDR	R0, [SP, #16]
CMP	R0, #0
IT	EQ
BEQ	L_tasks_prvAddCurrentTaskToDelayedList376
L_tasks_prvAddCurrentTaskToDelayedList386:
;tasks.c,4726 :: 		vListInsertEnd( &xSuspendedTaskList, &( pxCurrentTCB->xStateListItem ) );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_xSuspendedTaskList+0)
MOVT	R0, #hi_addr(tasks_xSuspendedTaskList+0)
PUSH	(R0)
BL	_vListInsertEnd+0
ADD	SP, SP, #8
;tasks.c,4727 :: 		}
IT	AL
BAL	L_tasks_prvAddCurrentTaskToDelayedList377
L_tasks_prvAddCurrentTaskToDelayedList376:
;tasks.c,4733 :: 		xTimeToWake = xConstTickCount + xTicksToWait;
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
ADDS	R0, R0, R1
STR	R0, [SP, #4]
;tasks.c,4736 :: 		listSET_LIST_ITEM_VALUE( &( pxCurrentTCB->xStateListItem ), xTimeToWake );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
MOV	R1, R0
LDR	R0, [SP, #4]
STR	R0, [R1, #0]
;tasks.c,4738 :: 		if( xTimeToWake < xConstTickCount )
LDR	R1, [SP, #8]
LDR	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_tasks_prvAddCurrentTaskToDelayedList378
;tasks.c,4742 :: 		vListInsert( pxOverflowDelayedTaskList, &( pxCurrentTCB->xStateListItem ) );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_pxOverflowDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxOverflowDelayedTaskList+0)
LDR	R0, [R0, #0]
PUSH	(R0)
BL	_vListInsert+0
ADD	SP, SP, #8
;tasks.c,4743 :: 		}
IT	AL
BAL	L_tasks_prvAddCurrentTaskToDelayedList379
L_tasks_prvAddCurrentTaskToDelayedList378:
;tasks.c,4748 :: 		vListInsert( pxDelayedTaskList, &( pxCurrentTCB->xStateListItem ) );
MOVW	R0, #lo_addr(_pxCurrentTCB+0)
MOVT	R0, #hi_addr(_pxCurrentTCB+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
PUSH	(R0)
MOVW	R0, #lo_addr(tasks_pxDelayedTaskList+0)
MOVT	R0, #hi_addr(tasks_pxDelayedTaskList+0)
LDR	R0, [R0, #0]
PUSH	(R0)
BL	_vListInsert+0
ADD	SP, SP, #8
;tasks.c,4753 :: 		if( xTimeToWake < xNextTaskUnblockTime )
MOVW	R0, #lo_addr(tasks_xNextTaskUnblockTime+0)
MOVT	R0, #hi_addr(tasks_xNextTaskUnblockTime+0)
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R0, R1
IT	CS
BCS	L_tasks_prvAddCurrentTaskToDelayedList380
;tasks.c,4755 :: 		xNextTaskUnblockTime = xTimeToWake;
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(tasks_xNextTaskUnblockTime+0)
MOVT	R0, #hi_addr(tasks_xNextTaskUnblockTime+0)
STR	R1, [R0, #0]
;tasks.c,4756 :: 		}
IT	AL
BAL	L_tasks_prvAddCurrentTaskToDelayedList381
L_tasks_prvAddCurrentTaskToDelayedList380:
;tasks.c,4760 :: 		}
L_tasks_prvAddCurrentTaskToDelayedList381:
;tasks.c,4761 :: 		}
L_tasks_prvAddCurrentTaskToDelayedList379:
;tasks.c,4762 :: 		}
L_tasks_prvAddCurrentTaskToDelayedList377:
;tasks.c,4801 :: 		}
L_end_prvAddCurrentTaskToDelayedList:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of tasks_prvAddCurrentTaskToDelayedList
