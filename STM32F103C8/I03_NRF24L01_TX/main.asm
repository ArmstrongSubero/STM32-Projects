_initMain:
;main.c,38 :: 		void initMain()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,40 :: 		SPI1_Init();                       // initialize SPI module
BL	_SPI1_Init+0
;main.c,41 :: 		Delay_ms(100);                     // Allow to stabilize
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
;main.c,43 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);  // IRQ out
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,44 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);  // CSN out
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,45 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);  // CE  out
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,47 :: 		GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);  // TX LED
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,48 :: 		}
L_end_initMain:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initMain
_main:
;main.c,50 :: 		void main()
;main.c,52 :: 		initMain();              // initialize main
BL	_initMain+0
;main.c,53 :: 		stat = init_Radio();     // initialize radio
BL	_init_Radio+0
MOVW	R1, #lo_addr(_stat+0)
MOVT	R1, #hi_addr(_stat+0)
STRB	R0, [R1, #0]
;main.c,54 :: 		Clear_Data(Data_Out);    // clear data out buffer
MOVW	R0, #lo_addr(_Data_Out+0)
MOVT	R0, #hi_addr(_Data_Out+0)
BL	_Clear_Data+0
;main.c,56 :: 		while(1)
L_main2:
;main.c,59 :: 		for (count = 0; count <= 100; count++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_count+0)
MOVT	R0, #hi_addr(_count+0)
STRH	R1, [R0, #0]
L_main4:
MOVW	R0, #lo_addr(_count+0)
MOVT	R0, #hi_addr(_count+0)
LDRSH	R0, [R0, #0]
CMP	R0, #100
IT	GT
BGT	L_main5
;main.c,61 :: 		GPIOC_ODR.B13 = 1;        // TX LED on
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,62 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main7:
SUBS	R7, R7, #1
BNE	L_main7
NOP
NOP
NOP
;main.c,64 :: 		IntToStr(count, txt);     // convert count to string
MOVW	R0, #lo_addr(_count+0)
MOVT	R0, #hi_addr(_count+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_IntToStr+0
;main.c,65 :: 		makeMsg(txt);             // make read to transmit
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_makeMsg+0
;main.c,66 :: 		sendBuffer();             // transmit
BL	_sendBuffer+0
;main.c,68 :: 		GPIOC_ODR.B13 = 0;        // TX LED off
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,69 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main9:
SUBS	R7, R7, #1
BNE	L_main9
NOP
NOP
NOP
;main.c,59 :: 		for (count = 0; count <= 100; count++)
MOVW	R1, #lo_addr(_count+0)
MOVT	R1, #hi_addr(_count+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;main.c,70 :: 		}
IT	AL
BAL	L_main4
L_main5:
;main.c,71 :: 		}
IT	AL
BAL	L_main2
;main.c,72 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
