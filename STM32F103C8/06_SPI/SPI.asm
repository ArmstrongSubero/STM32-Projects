_initMain:
;SPI.c,48 :: 		void initMain()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SPI.c,55 :: 		&_GPIO_MODULE_SPI1_PA567);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PA567+0)
;SPI.c,54 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;SPI.c,52 :: 		SPI1_Init_Advanced(_SPI_FPCLK_DIV128, _SPI_MASTER  | _SPI_8_BIT |
MOVS	R0, #6
;SPI.c,55 :: 		&_GPIO_MODULE_SPI1_PA567);
BL	_SPI1_Init_Advanced+0
;SPI.c,56 :: 		}
L_end_initMain:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initMain
_main:
;SPI.c,66 :: 		void main() {
;SPI.c,67 :: 		initMain();
BL	_initMain+0
;SPI.c,70 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;SPI.c,72 :: 		while(1)
L_main0:
;SPI.c,75 :: 		for(val = 0; val <= 128; val++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
STRH	R1, [R0, #0]
L_main2:
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
LDRSH	R0, [R0, #0]
CMP	R0, #128
IT	GT
BGT	L_main3
;SPI.c,77 :: 		digiPot_Write(val);
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
LDRSH	R0, [R0, #0]
BL	_digiPot_Write+0
;SPI.c,78 :: 		Delay_ms(250);
MOVW	R7, #50879
MOVT	R7, #45
NOP
NOP
L_main5:
SUBS	R7, R7, #1
BNE	L_main5
NOP
NOP
NOP
;SPI.c,75 :: 		for(val = 0; val <= 128; val++)
MOVW	R1, #lo_addr(_val+0)
MOVT	R1, #hi_addr(_val+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;SPI.c,79 :: 		}
IT	AL
BAL	L_main2
L_main3:
;SPI.c,81 :: 		}
IT	AL
BAL	L_main0
;SPI.c,82 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_digiPot_Write:
;SPI.c,94 :: 		void digiPot_Write(int i)
; i start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
SXTH	R4, R0
; i end address is: 0 (R0)
; i start address is: 16 (R4)
;SPI.c,97 :: 		DigiPot_CS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;SPI.c,100 :: 		SPI1_Write(0x00);
MOVS	R0, #0
BL	_SPI1_Write+0
;SPI.c,103 :: 		SPI1_Write(i);
UXTH	R0, R4
; i end address is: 16 (R4)
BL	_SPI1_Write+0
;SPI.c,106 :: 		DigiPot_CS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;SPI.c,107 :: 		}
L_end_digiPot_Write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _digiPot_Write
