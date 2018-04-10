heap_3_ucPortCountLeadingZeros:
;portmacro.h,176 :: 		static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
;portmacro.h,178 :: 		asm CLZ R0, R0;
CLZ	R0, R0
;portmacro.h,179 :: 		return R0;
UXTB	R0, R0
;portmacro.h,180 :: 		}
L_end_ucPortCountLeadingZeros:
BX	LR
; end of heap_3_ucPortCountLeadingZeros
heap_3_xPortIsInsideInterrupt:
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
BNE	L_heap_3_xPortIsInsideInterrupt0
;portmacro.h,228 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;portmacro.h,229 :: 		}
IT	AL
BAL	L_heap_3_xPortIsInsideInterrupt1
L_heap_3_xPortIsInsideInterrupt0:
;portmacro.h,232 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;portmacro.h,233 :: 		}
L_heap_3_xPortIsInsideInterrupt1:
;portmacro.h,235 :: 		return xReturn;
LDR	R0, [SP, #4]
;portmacro.h,236 :: 		}
L_end_xPortIsInsideInterrupt:
ADD	SP, SP, #8
BX	LR
; end of heap_3_xPortIsInsideInterrupt
heap_3_vPortRaiseBASEPRI:
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
; end of heap_3_vPortRaiseBASEPRI
heap_3_ulPortRaiseBASEPRI:
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
; end of heap_3_ulPortRaiseBASEPRI
heap_3_vPortSetBASEPRI:
;portmacro.h,268 :: 		portFORCE_INLINE static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
;portmacro.h,270 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,271 :: 		}
L_end_vPortSetBASEPRI:
BX	LR
; end of heap_3_vPortSetBASEPRI
_pvPortMalloc:
;heap_3.c,102 :: 		void *pvPortMalloc( size_t xWantedSize )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;heap_3.c,106 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;heap_3.c,108 :: 		pvReturn = malloc( xWantedSize );
LDR	R0, [SP, #8]
BL	_malloc+0
STR	R0, [SP, #4]
;heap_3.c,111 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;heap_3.c,123 :: 		return pvReturn;
LDR	R0, [SP, #4]
;heap_3.c,124 :: 		}
L_end_pvPortMalloc:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _pvPortMalloc
_vPortFree:
;heap_3.c,127 :: 		void vPortFree( void *pv )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;heap_3.c,129 :: 		if( pv )
LDR	R0, [SP, #4]
CMP	R0, #0
IT	EQ
BEQ	L_vPortFree2
;heap_3.c,131 :: 		vTaskSuspendAll();
BL	_vTaskSuspendAll+0
;heap_3.c,133 :: 		free( pv );
LDR	R0, [SP, #4]
BL	_free+0
;heap_3.c,136 :: 		( void ) xTaskResumeAll();
BL	_xTaskResumeAll+0
;heap_3.c,137 :: 		}
L_vPortFree2:
;heap_3.c,138 :: 		}
L_end_vPortFree:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _vPortFree
