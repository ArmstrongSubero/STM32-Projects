main_ucPortCountLeadingZeros:
;portmacro.h,176 :: 		static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
;portmacro.h,178 :: 		asm CLZ R0, R0;
CLZ	R0, R0
;portmacro.h,179 :: 		return R0;
UXTB	R0, R0
;portmacro.h,180 :: 		}
L_end_ucPortCountLeadingZeros:
BX	LR
; end of main_ucPortCountLeadingZeros
main_xPortIsInsideInterrupt:
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
BNE	L_main_xPortIsInsideInterrupt0
;portmacro.h,228 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;portmacro.h,229 :: 		}
IT	AL
BAL	L_main_xPortIsInsideInterrupt1
L_main_xPortIsInsideInterrupt0:
;portmacro.h,232 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;portmacro.h,233 :: 		}
L_main_xPortIsInsideInterrupt1:
;portmacro.h,235 :: 		return xReturn;
LDR	R0, [SP, #4]
;portmacro.h,236 :: 		}
L_end_xPortIsInsideInterrupt:
ADD	SP, SP, #8
BX	LR
; end of main_xPortIsInsideInterrupt
main_vPortRaiseBASEPRI:
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
; end of main_vPortRaiseBASEPRI
main_ulPortRaiseBASEPRI:
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
; end of main_ulPortRaiseBASEPRI
main_vPortSetBASEPRI:
;portmacro.h,268 :: 		portFORCE_INLINE static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
;portmacro.h,270 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,271 :: 		}
L_end_vPortSetBASEPRI:
BX	LR
; end of main_vPortSetBASEPRI
_task1:
;main.c,26 :: 		void task1(void *pvParameters)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,29 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_5);
MOVW	R1, #32
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,31 :: 		while (1)
L_task12:
;main.c,33 :: 		vTaskDelay(pdMS_TO_TICKS(250));
MOV	R0, #250
PUSH	(R0)
BL	_vTaskDelay+0
ADD	SP, SP, #4
;main.c,34 :: 		GPIOB_ODR.B5 = ~GPIOB_ODR.B5;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_LX	[R0, ByteOffset(GPIOB_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;main.c,35 :: 		}
IT	AL
BAL	L_task12
;main.c,36 :: 		}
L_end_task1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _task1
_task2:
;main.c,40 :: 		void task2(void *pvParameters)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,43 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_6);
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,45 :: 		while (1)
L_task24:
;main.c,47 :: 		vTaskDelay(pdMS_TO_TICKS(500));
MOV	R0, #500
PUSH	(R0)
BL	_vTaskDelay+0
ADD	SP, SP, #4
;main.c,48 :: 		GPIOB_ODR.B6 = ~GPIOB_ODR.B6;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_LX	[R0, ByteOffset(GPIOB_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;main.c,49 :: 		}
IT	AL
BAL	L_task24
;main.c,50 :: 		}
L_end_task2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _task2
_task3:
;main.c,53 :: 		void task3(void *pvParameters)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,56 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_7);
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,58 :: 		while (1)
L_task36:
;main.c,60 :: 		vTaskDelay(pdMS_TO_TICKS(1000));
MOV	R0, #1000
PUSH	(R0)
BL	_vTaskDelay+0
ADD	SP, SP, #4
;main.c,61 :: 		GPIOB_ODR.B7 = ~GPIOB_ODR.B7;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_LX	[R0, ByteOffset(GPIOB_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;main.c,62 :: 		}
IT	AL
BAL	L_task36
;main.c,63 :: 		}
L_end_task3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _task3
_main:
;main.c,66 :: 		void main()
;main.c,75 :: 		NULL
MOVS	R0, #0
PUSH	(R0)
;main.c,74 :: 		10,
MOVS	R0, #10
PUSH	(R0)
;main.c,73 :: 		NULL,
MOVS	R0, #0
PUSH	(R0)
;main.c,72 :: 		configMINIMAL_STACK_SIZE,
MOVS	R0, #128
PUSH	(R0)
;main.c,71 :: 		"Task 1",
MOVW	R0, #lo_addr(?lstr_1_main+0)
MOVT	R0, #hi_addr(?lstr_1_main+0)
PUSH	(R0)
;main.c,70 :: 		(TaskFunction_t)task1,
MOVW	R0, #lo_addr(_task1+0)
MOVT	R0, #hi_addr(_task1+0)
PUSH	(R0)
;main.c,75 :: 		NULL
BL	_xTaskCreate+0
ADD	SP, SP, #24
;main.c,85 :: 		NULL
MOVS	R0, #0
PUSH	(R0)
;main.c,84 :: 		10,
MOVS	R0, #10
PUSH	(R0)
;main.c,83 :: 		NULL,
MOVS	R0, #0
PUSH	(R0)
;main.c,82 :: 		configMINIMAL_STACK_SIZE,
MOVS	R0, #128
PUSH	(R0)
;main.c,81 :: 		"Task 2",
MOVW	R0, #lo_addr(?lstr_2_main+0)
MOVT	R0, #hi_addr(?lstr_2_main+0)
PUSH	(R0)
;main.c,80 :: 		(TaskFunction_t)task2,
MOVW	R0, #lo_addr(_task2+0)
MOVT	R0, #hi_addr(_task2+0)
PUSH	(R0)
;main.c,85 :: 		NULL
BL	_xTaskCreate+0
ADD	SP, SP, #24
;main.c,95 :: 		NULL
MOVS	R0, #0
PUSH	(R0)
;main.c,94 :: 		10,
MOVS	R0, #10
PUSH	(R0)
;main.c,93 :: 		NULL,
MOVS	R0, #0
PUSH	(R0)
;main.c,92 :: 		configMINIMAL_STACK_SIZE,
MOVS	R0, #128
PUSH	(R0)
;main.c,91 :: 		"Task 3",
MOVW	R0, #lo_addr(?lstr_3_main+0)
MOVT	R0, #hi_addr(?lstr_3_main+0)
PUSH	(R0)
;main.c,90 :: 		(TaskFunction_t)task3,
MOVW	R0, #lo_addr(_task3+0)
MOVT	R0, #hi_addr(_task3+0)
PUSH	(R0)
;main.c,95 :: 		NULL
BL	_xTaskCreate+0
ADD	SP, SP, #24
;main.c,99 :: 		vTaskStartScheduler();
BL	_vTaskStartScheduler+0
;main.c,102 :: 		while (1);
L_main8:
IT	AL
BAL	L_main8
;main.c,103 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
