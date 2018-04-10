_initMain:
;Demo.c,43 :: 		void initMain()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Demo.c,46 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);   // Reset
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;Demo.c,47 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);   // D/C (RS)
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;Demo.c,48 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);   // CS
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;Demo.c,55 :: 		&_GPIO_MODULE_SPI1_PA567);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PA567+0)
;Demo.c,54 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;Demo.c,52 :: 		SPI1_Init_Advanced(_SPI_FPCLK_DIV8, _SPI_MASTER  | _SPI_8_BIT |
MOVS	R0, #2
;Demo.c,55 :: 		&_GPIO_MODULE_SPI1_PA567);
BL	_SPI1_Init_Advanced+0
;Demo.c,58 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_initMain0:
SUBS	R7, R7, #1
BNE	L_initMain0
NOP
NOP
NOP
;Demo.c,59 :: 		}
L_end_initMain:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initMain
_main:
;Demo.c,69 :: 		void main() {
;Demo.c,71 :: 		initMain();
BL	_initMain+0
;Demo.c,74 :: 		ST7735_Init();
BL	_ST7735_Init+0
;Demo.c,76 :: 		while(1)
L_main2:
;Demo.c,79 :: 		ST7735_test();
BL	_ST7735_test+0
;Demo.c,80 :: 		}
IT	AL
BAL	L_main2
;Demo.c,81 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
