port_ucPortCountLeadingZeros:
;portmacro.h,176 :: 		static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
;portmacro.h,178 :: 		asm CLZ R0, R0;
CLZ	R0, R0
;portmacro.h,179 :: 		return R0;
UXTB	R0, R0
;portmacro.h,180 :: 		}
L_end_ucPortCountLeadingZeros:
BX	LR
; end of port_ucPortCountLeadingZeros
port_xPortIsInsideInterrupt:
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
BNE	L_port_xPortIsInsideInterrupt0
;portmacro.h,228 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;portmacro.h,229 :: 		}
IT	AL
BAL	L_port_xPortIsInsideInterrupt1
L_port_xPortIsInsideInterrupt0:
;portmacro.h,232 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;portmacro.h,233 :: 		}
L_port_xPortIsInsideInterrupt1:
;portmacro.h,235 :: 		return xReturn;
LDR	R0, [SP, #4]
;portmacro.h,236 :: 		}
L_end_xPortIsInsideInterrupt:
ADD	SP, SP, #8
BX	LR
; end of port_xPortIsInsideInterrupt
port_vPortRaiseBASEPRI:
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
; end of port_vPortRaiseBASEPRI
port_ulPortRaiseBASEPRI:
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
; end of port_ulPortRaiseBASEPRI
port_vPortSetBASEPRI:
;portmacro.h,268 :: 		portFORCE_INLINE static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
;portmacro.h,270 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,271 :: 		}
L_end_vPortSetBASEPRI:
BX	LR
; end of port_vPortSetBASEPRI
_pxPortInitialiseStack:
;port.c,181 :: 		StackType_t *pxTopOfStack, TaskFunction_t pxCode, void *pvParameters)
;port.c,188 :: 		pxTopOfStack--;
LDR	R0, [SP, #0]
SUBS	R0, R0, #4
STR	R0, [SP, #0]
;port.c,190 :: 		*pxTopOfStack = portINITIAL_XPSR;                               // xPSR
MOV	R1, #16777216
LDR	R0, [SP, #0]
STR	R1, [R0, #0]
;port.c,191 :: 		pxTopOfStack--;
LDR	R0, [SP, #0]
SUBS	R0, R0, #4
STR	R0, [SP, #0]
;port.c,192 :: 		*pxTopOfStack = ((StackType_t)pxCode) & portSTART_ADDRESS_MASK; // PC
LDR	R1, [SP, #4]
MVN	R0, #1
ANDS	R1, R0
LDR	R0, [SP, #0]
STR	R1, [R0, #0]
;port.c,193 :: 		pxTopOfStack--;
LDR	R0, [SP, #0]
SUBS	R0, R0, #4
STR	R0, [SP, #0]
;port.c,194 :: 		*pxTopOfStack = (StackType_t) portTASK_RETURN_ADDRESS;        // LR
MOVW	R1, #lo_addr(port_prvTaskExitError+0)
MOVT	R1, #hi_addr(port_prvTaskExitError+0)
LDR	R0, [SP, #0]
STR	R1, [R0, #0]
;port.c,195 :: 		pxTopOfStack -= 5;        // R12, R3, R2 and R1.
MOVS	R1, #5
MOVS	R0, #4
MULS	R1, R0, R1
LDR	R0, [SP, #0]
SUB	R0, R0, R1
STR	R0, [SP, #0]
;port.c,196 :: 		*pxTopOfStack = (StackType_t) pvParameters;                   // R0
LDR	R1, [SP, #8]
LDR	R0, [SP, #0]
STR	R1, [R0, #0]
;port.c,197 :: 		pxTopOfStack -= 8;        // R11, R10, R9, R8, R7, R6, R5 and R4.
MOVS	R1, #8
MOVS	R0, #4
MULS	R1, R0, R1
LDR	R0, [SP, #0]
SUB	R0, R0, R1
STR	R0, [SP, #0]
;port.c,199 :: 		return pxTopOfStack;
LDR	R0, [SP, #0]
;port.c,200 :: 		}
L_end_pxPortInitialiseStack:
BX	LR
; end of _pxPortInitialiseStack
port_prvTaskExitError:
;port.c,203 :: 		static void prvTaskExitError()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;port.c,205 :: 		volatile uint32_t ulDummy = 0UL;
MOV	R0, #0
STR	R0, [SP, #4]
;port.c,213 :: 		configASSERT( uxCriticalNesting == ~0UL );
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
LDR	R0, [R0, #0]
CMP	R0, #-1
MOVW	R0, #0
BNE	L_port_prvTaskExitError38
MOVS	R0, #1
L_port_prvTaskExitError38:
CMP	R0, #0
IT	NE
BNE	L_port_prvTaskExitError2
BL	port_vPortRaiseBASEPRI+0
L_port_prvTaskExitError3:
IT	AL
BAL	L_port_prvTaskExitError3
L_port_prvTaskExitError2:
;port.c,214 :: 		portDISABLE_INTERRUPTS();
BL	port_vPortRaiseBASEPRI+0
;port.c,215 :: 		while( ulDummy == 0 )
L_port_prvTaskExitError5:
LDR	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_port_prvTaskExitError6
;port.c,224 :: 		}
IT	AL
BAL	L_port_prvTaskExitError5
L_port_prvTaskExitError6:
;port.c,225 :: 		}
L_end_prvTaskExitError:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of port_prvTaskExitError
_vPortSVCHandler:
;port.c,228 :: 		void vPortSVCHandler() iv IVT_INT_SVCall ics ICS_OFF
;port.c,232 :: 		LDR R3, =_pxCurrentTCB
LDR	R3, _pxCurrentTCB+0
;port.c,234 :: 		LDR R1, [R3]
LDR	R1, [R3, #0]
;port.c,236 :: 		LDR R0, [R1]
LDR	R0, [R1, #0]
;port.c,239 :: 		LDM R0!, (R4-R11)
LDM	R0, (R4, R5, R6, R7, R8, R9, R10, R11)
;port.c,241 :: 		MSR CPU_PSP, R0
MSR	#9, R0
;port.c,242 :: 		ISB
ISB	#15
;port.c,243 :: 		MOV R0, #0
MOV	R0, #0
;port.c,244 :: 		MSR CPU_BASEPRI, R0
MSR	#17, R0
;port.c,245 :: 		ORR R14, #0xD
ORR	LR, LR, #13
;port.c,246 :: 		BX R14
BX	LR
;port.c,247 :: 		}
B	#4
	_pxCurrentTCB+0
NOP
;port.c,248 :: 		}
L_end_vPortSVCHandler:
BX	LR
; end of _vPortSVCHandler
port_prvPortStartFirstTask:
;port.c,251 :: 		static void prvPortStartFirstTask()
;port.c,255 :: 		LDR R0, =0xE000ED08
LDR	R0, [PC, #-536810232]
;port.c,256 :: 		LDR R0, [R0]
LDR	R0, [R0, #0]
;port.c,257 :: 		LDR R0, [R0]
LDR	R0, [R0, #0]
;port.c,259 :: 		MSR CPU_MSP, R0
MSR	#8, R0
;port.c,261 :: 		CPSIE I
CPSIE	i
;port.c,262 :: 		CPSIE F
CPSIE	f
;port.c,263 :: 		DSB
DSB	#15
;port.c,264 :: 		ISB
ISB	#15
;port.c,266 :: 		SVC #0
SVC	#0
;port.c,267 :: 		NOP
NOP
;port.c,268 :: 		}
B	#4
	#-536810232
NOP
;port.c,269 :: 		}
L_end_prvPortStartFirstTask:
BX	LR
; end of port_prvPortStartFirstTask
_xPortStartScheduler:
;port.c,273 :: 		BaseType_t xPortStartScheduler()
SUB	SP, SP, #16
STR	LR, [SP, #0]
;port.c,277 :: 		configASSERT( configMAX_SYSCALL_INTERRUPT_PRIORITY );
L_xPortStartScheduler7:
;port.c,283 :: 		(volatile uint8_t * const)(&NVIC_IPR0);
MOVW	R0, #lo_addr(NVIC_IPR0+0)
MOVT	R0, #hi_addr(NVIC_IPR0+0)
STR	R0, [SP, #12]
;port.c,293 :: 		ulOriginalPriority = *pucFirstUserPriorityRegister;
LDR	R0, [SP, #12]
LDRB	R0, [R0, #0]
STR	R0, [SP, #4]
;port.c,297 :: 		*pucFirstUserPriorityRegister = portMAX_8_BIT_VALUE;
MOVS	R1, #255
LDR	R0, [SP, #12]
STRB	R1, [R0, #0]
;port.c,300 :: 		ucMaxPriorityValue = *pucFirstUserPriorityRegister;
LDR	R0, [SP, #12]
LDRB	R0, [R0, #0]
STRB	R0, [SP, #8]
;port.c,304 :: 		configMAX_SYSCALL_INTERRUPT_PRIORITY & ucMaxPriorityValue;
LDRB	R0, [SP, #8]
AND	R1, R0, #16
MOVW	R0, #lo_addr(port_ucMaxSysCallPriority+0)
MOVT	R0, #hi_addr(port_ucMaxSysCallPriority+0)
STRB	R1, [R0, #0]
;port.c,308 :: 		ulMaxPRIGROUPValue = portMAX_PRIGROUP_BITS;
MOVS	R1, #7
MOVW	R0, #lo_addr(port_ulMaxPRIGROUPValue+0)
MOVT	R0, #hi_addr(port_ulMaxPRIGROUPValue+0)
STR	R1, [R0, #0]
;port.c,309 :: 		while ((ucMaxPriorityValue & portTOP_BIT_OF_BYTE)
L_xPortStartScheduler10:
LDRB	R0, [SP, #8]
AND	R0, R0, #128
UXTB	R0, R0
;port.c,310 :: 		== portTOP_BIT_OF_BYTE)
CMP	R0, #128
IT	NE
BNE	L_xPortStartScheduler11
;port.c,312 :: 		ulMaxPRIGROUPValue--;
MOVW	R0, #lo_addr(port_ulMaxPRIGROUPValue+0)
MOVT	R0, #hi_addr(port_ulMaxPRIGROUPValue+0)
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
MOVW	R0, #lo_addr(port_ulMaxPRIGROUPValue+0)
MOVT	R0, #hi_addr(port_ulMaxPRIGROUPValue+0)
STR	R1, [R0, #0]
;port.c,313 :: 		ucMaxPriorityValue <<= (uint8_t)0x01;
LDRB	R0, [SP, #8]
LSLS	R0, R0, #1
STRB	R0, [SP, #8]
;port.c,314 :: 		}
IT	AL
BAL	L_xPortStartScheduler10
L_xPortStartScheduler11:
;port.c,338 :: 		ulMaxPRIGROUPValue <<= portPRIGROUP_SHIFT;
MOVW	R0, #lo_addr(port_ulMaxPRIGROUPValue+0)
MOVT	R0, #hi_addr(port_ulMaxPRIGROUPValue+0)
LDR	R0, [R0, #0]
LSLS	R1, R0, #8
MOVW	R0, #lo_addr(port_ulMaxPRIGROUPValue+0)
MOVT	R0, #hi_addr(port_ulMaxPRIGROUPValue+0)
STR	R1, [R0, #0]
;port.c,339 :: 		ulMaxPRIGROUPValue &= portPRIORITY_GROUP_MASK;
MOVW	R0, #lo_addr(port_ulMaxPRIGROUPValue+0)
MOVT	R0, #hi_addr(port_ulMaxPRIGROUPValue+0)
LDR	R0, [R0, #0]
AND	R1, R0, #1792
MOVW	R0, #lo_addr(port_ulMaxPRIGROUPValue+0)
MOVT	R0, #hi_addr(port_ulMaxPRIGROUPValue+0)
STR	R1, [R0, #0]
;port.c,343 :: 		*pucFirstUserPriorityRegister = ulOriginalPriority;
LDR	R1, [SP, #4]
LDR	R0, [SP, #12]
STRB	R1, [R0, #0]
;port.c,348 :: 		SCB_SHPR3 |= portNVIC_PENDSV_PRI;
MOVW	R0, #lo_addr(SCB_SHPR3+0)
MOVT	R0, #hi_addr(SCB_SHPR3+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16711680
MOVW	R0, #lo_addr(SCB_SHPR3+0)
MOVT	R0, #hi_addr(SCB_SHPR3+0)
STR	R1, [R0, #0]
;port.c,349 :: 		SCB_SHPR3 |= portNVIC_SYSTICK_PRI;
MOVW	R0, #lo_addr(SCB_SHPR3+0)
MOVT	R0, #hi_addr(SCB_SHPR3+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #-16777216
MOVW	R0, #lo_addr(SCB_SHPR3+0)
MOVT	R0, #hi_addr(SCB_SHPR3+0)
STR	R1, [R0, #0]
;port.c,353 :: 		vPortSetupTimerInterrupt();
BL	_vPortSetupTimerInterrupt+0
;port.c,356 :: 		uxCriticalNesting = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
STR	R1, [R0, #0]
;port.c,359 :: 		prvPortStartFirstTask();
BL	port_prvPortStartFirstTask+0
;port.c,367 :: 		vTaskSwitchContext();
BL	_vTaskSwitchContext+0
;port.c,368 :: 		prvTaskExitError();
BL	port_prvTaskExitError+0
;port.c,371 :: 		return 0;
MOVS	R0, #0
;port.c,372 :: 		}
L_end_xPortStartScheduler:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _xPortStartScheduler
_vPortEndScheduler:
;port.c,380 :: 		void vPortEndScheduler()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;port.c,384 :: 		configASSERT(uxCriticalNesting == 1000UL);
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
LDR	R0, [R0, #0]
CMP	R0, #1000
MOVW	R0, #0
BNE	L__vPortEndScheduler43
MOVS	R0, #1
L__vPortEndScheduler43:
CMP	R0, #0
IT	NE
BNE	L_vPortEndScheduler12
BL	port_vPortRaiseBASEPRI+0
L_vPortEndScheduler13:
IT	AL
BAL	L_vPortEndScheduler13
L_vPortEndScheduler12:
;port.c,385 :: 		}
L_end_vPortEndScheduler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vPortEndScheduler
_vPortEnterCritical:
;port.c,388 :: 		void vPortEnterCritical()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;port.c,390 :: 		portDISABLE_INTERRUPTS();
BL	port_vPortRaiseBASEPRI+0
;port.c,391 :: 		uxCriticalNesting++;
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
STR	R1, [R0, #0]
;port.c,398 :: 		if(uxCriticalNesting == 1)
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_vPortEnterCritical15
;port.c,400 :: 		configASSERT((SCB_ICSR & portVECTACTIVE_MASK ) == 0);
MOVW	R0, #lo_addr(SCB_ICSR+0)
MOVT	R0, #hi_addr(SCB_ICSR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #255
CMP	R0, #0
MOVW	R0, #0
BNE	L__vPortEnterCritical45
MOVS	R0, #1
L__vPortEnterCritical45:
CMP	R0, #0
IT	NE
BNE	L_vPortEnterCritical16
BL	port_vPortRaiseBASEPRI+0
L_vPortEnterCritical17:
IT	AL
BAL	L_vPortEnterCritical17
L_vPortEnterCritical16:
;port.c,401 :: 		}
L_vPortEnterCritical15:
;port.c,402 :: 		}
L_end_vPortEnterCritical:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vPortEnterCritical
_vPortExitCritical:
;port.c,405 :: 		void vPortExitCritical()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;port.c,407 :: 		configASSERT(uxCriticalNesting);
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vPortExitCritical19
BL	port_vPortRaiseBASEPRI+0
L_vPortExitCritical20:
IT	AL
BAL	L_vPortExitCritical20
L_vPortExitCritical19:
;port.c,408 :: 		uxCriticalNesting--;
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
STR	R1, [R0, #0]
;port.c,409 :: 		if(uxCriticalNesting == 0)
MOVW	R0, #lo_addr(port_uxCriticalNesting+0)
MOVT	R0, #hi_addr(port_uxCriticalNesting+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_vPortExitCritical22
;port.c,411 :: 		portENABLE_INTERRUPTS();
MOVS	R0, #0
PUSH	(R0)
BL	port_vPortSetBASEPRI+0
ADD	SP, SP, #4
;port.c,412 :: 		}
L_vPortExitCritical22:
;port.c,413 :: 		}
L_end_vPortExitCritical:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vPortExitCritical
_xPortPendSVHandler:
;port.c,416 :: 		void xPortPendSVHandler() iv IVT_INT_PendSV ics ICS_OFF
SUB	SP, SP, #4
STR	LR, [SP, #0]
;port.c,422 :: 		ADD SP, SP, #4
ADD	SP, SP, #4
;port.c,424 :: 		MRS R0, CPU_PSP
MRS	R0, #9
;port.c,425 :: 		ISB
ISB	#15
;port.c,428 :: 		LDR R3, =_pxCurrentTCB
LDR	R3, _pxCurrentTCB+0
;port.c,429 :: 		LDR R2, [R3]
LDR	R2, [R3, #0]
;port.c,432 :: 		STMDB R0!, (R4-R11)
STMDB	R0, (R4, R5, R6, R7, R8, R9, R10, R11)
;port.c,434 :: 		STR R0, [R2]
STR	R0, [R2, #0]
;port.c,436 :: 		STMDB SP!, (R3, R14)
STMDB	SP, (R3, R14)
;port.c,437 :: 		MOV R0, # configMAX_SYSCALL_INTERRUPT_PRIORITY
MOV	R0, #16
;port.c,438 :: 		MSR CPU_BASEPRI, R0
MSR	#17, R0
;port.c,440 :: 		BL _vTaskSwitchContext
BL	_vTaskSwitchContext+0
;port.c,442 :: 		MOV R0, #0
MOV	R0, #0
;port.c,443 :: 		MSR CPU_BASEPRI, R0
MSR	#17, R0
;port.c,444 :: 		LDM SP!, (R3, R14)
LDM	SP, (R3, R14)
;port.c,447 :: 		LDR R1, [R3]
LDR	R1, [R3, #0]
;port.c,449 :: 		LDR R0, [R1]
LDR	R0, [R1, #0]
;port.c,451 :: 		LDM R0!, (R4-R11)
LDM	R0, (R4, R5, R6, R7, R8, R9, R10, R11)
;port.c,453 :: 		MSR CPU_PSP, R0
MSR	#9, R0
;port.c,454 :: 		ISB
ISB	#15
;port.c,456 :: 		BX R14
BX	LR
;port.c,457 :: 		}
B	#4
	_pxCurrentTCB+0
NOP
;port.c,458 :: 		}
L_end_xPortPendSVHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _xPortPendSVHandler
_xPortSysTickHandler:
;port.c,461 :: 		void xPortSysTickHandler() iv IVT_INT_SysTick
SUB	SP, SP, #4
STR	LR, [SP, #0]
;port.c,467 :: 		portDISABLE_INTERRUPTS();
BL	port_vPortRaiseBASEPRI+0
;port.c,470 :: 		if( xTaskIncrementTick() != pdFALSE )
BL	_xTaskIncrementTick+0
CMP	R0, #0
IT	EQ
BEQ	L_xPortSysTickHandler23
;port.c,474 :: 		PENDSVSET_bit = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(PENDSVSET_bit+0)
MOVT	R1, #hi_addr(PENDSVSET_bit+0)
_LX	[R1, ByteOffset(PENDSVSET_bit+0)]
BFI	R0, R2, BitPos(PENDSVSET_bit+0), #1
_SX	[R1, ByteOffset(PENDSVSET_bit+0)]
;port.c,475 :: 		}
L_xPortSysTickHandler23:
;port.c,477 :: 		portENABLE_INTERRUPTS();
MOVS	R0, #0
PUSH	(R0)
BL	port_vPortSetBASEPRI+0
ADD	SP, SP, #4
;port.c,478 :: 		}
L_end_xPortSysTickHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _xPortSysTickHandler
_vPortSetupTimerInterrupt:
;port.c,651 :: 		void vPortSetupTimerInterrupt()
;port.c,665 :: 		STK_CTRL = 0UL;
MOV	R1, #0
MOVW	R0, #lo_addr(STK_CTRL+0)
MOVT	R0, #hi_addr(STK_CTRL+0)
STR	R1, [R0, #0]
;port.c,666 :: 		STK_VAL = 0UL;
MOV	R1, #0
MOVW	R0, #lo_addr(STK_VAL+0)
MOVT	R0, #hi_addr(STK_VAL+0)
STR	R1, [R0, #0]
;port.c,669 :: 		STK_LOAD = (configSYSTICK_CLOCK_HZ / configTICK_RATE_HZ) - 1UL;
MOVW	R1, #6463
MOVT	R1, #1
MOVW	R0, #lo_addr(STK_LOAD+0)
MOVT	R0, #hi_addr(STK_LOAD+0)
STR	R1, [R0, #0]
;port.c,670 :: 		STK_CTRL |= 0x7;
MOVW	R0, #lo_addr(STK_CTRL+0)
MOVT	R0, #hi_addr(STK_CTRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #7
MOVW	R0, #lo_addr(STK_CTRL+0)
MOVT	R0, #hi_addr(STK_CTRL+0)
STR	R1, [R0, #0]
;port.c,671 :: 		}
L_end_vPortSetupTimerInterrupt:
BX	LR
; end of _vPortSetupTimerInterrupt
_vPortValidateInterruptPriority:
;port.c,676 :: 		void vPortValidateInterruptPriority()
SUB	SP, SP, #12
STR	LR, [SP, #0]
;port.c,682 :: 		ulCurrentInterrupt = CPU_REG_GET(CPU_IPSR);
MRS	R12, #5
MOV	R0, R12
STR	R0, [SP, #4]
;port.c,685 :: 		if( ulCurrentInterrupt >= portFIRST_USER_INTERRUPT_NUMBER )
LDR	R0, [SP, #4]
CMP	R0, #16
IT	CC
BCC	L_vPortValidateInterruptPriority24
;port.c,689 :: 		- portFIRST_USER_INTERRUPT_NUMBER + ulCurrentInterrupt);
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(NVIC_IPR0+-16)
MOVT	R0, #hi_addr(NVIC_IPR0+-16)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [SP, #8]
;port.c,714 :: 		configASSERT(ucCurrentPriority >= ucMaxSysCallPriority);
MOVW	R0, #lo_addr(port_ucMaxSysCallPriority+0)
MOVT	R0, #hi_addr(port_ucMaxSysCallPriority+0)
LDRB	R1, [R0, #0]
LDRB	R0, [SP, #8]
CMP	R0, R1
MOVW	R0, #0
BCC	L__vPortValidateInterruptPriority51
MOVS	R0, #1
L__vPortValidateInterruptPriority51:
CMP	R0, #0
IT	NE
BNE	L_vPortValidateInterruptPriority25
BL	port_vPortRaiseBASEPRI+0
L_vPortValidateInterruptPriority26:
IT	AL
BAL	L_vPortValidateInterruptPriority26
L_vPortValidateInterruptPriority25:
;port.c,715 :: 		}
L_vPortValidateInterruptPriority24:
;port.c,730 :: 		configASSERT(
MOVW	R0, #lo_addr(SCB_AIRCR+0)
MOVT	R0, #hi_addr(SCB_AIRCR+0)
LDR	R0, [R0, #0]
AND	R1, R0, #1792
MOVW	R0, #lo_addr(port_ulMaxPRIGROUPValue+0)
MOVT	R0, #hi_addr(port_ulMaxPRIGROUPValue+0)
LDR	R0, [R0, #0]
CMP	R1, R0
MOVW	R0, #0
BHI	L__vPortValidateInterruptPriority52
MOVS	R0, #1
L__vPortValidateInterruptPriority52:
CMP	R0, #0
IT	NE
BNE	L_vPortValidateInterruptPriority28
BL	port_vPortRaiseBASEPRI+0
L_vPortValidateInterruptPriority29:
IT	AL
BAL	L_vPortValidateInterruptPriority29
L_vPortValidateInterruptPriority28:
;port.c,732 :: 		}
L_end_vPortValidateInterruptPriority:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _vPortValidateInterruptPriority
