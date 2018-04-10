_main:
;main.c,37 :: 		void main()
;main.c,39 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);    // IRQ out
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,40 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);    // CSN out
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,41 :: 		GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);    // CE  out
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,43 :: 		GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);    // Status output
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
BL	_GPIO_Digital_Output+0
;main.c,46 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
MOVW	R0, #9600
BL	_UART1_Init+0
;main.c,47 :: 		Delay_ms(1000);                 // Wait for UART module to stabilize
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main0:
SUBS	R7, R7, #1
BNE	L_main0
NOP
NOP
NOP
;main.c,49 :: 		SPI1_Init();                    // Initialize the SPI1 module
BL	_SPI1_Init+0
;main.c,50 :: 		Delay_ms(200);
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_main2:
SUBS	R7, R7, #1
BNE	L_main2
NOP
NOP
NOP
;main.c,51 :: 		stat = init_Radio();            // Initialize radio
BL	_init_Radio+0
MOVW	R1, #lo_addr(_stat+0)
MOVT	R1, #hi_addr(_stat+0)
STRB	R0, [R1, #0]
;main.c,52 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
;main.c,54 :: 		ByteToHex(stat, txt);           // Convert status to string
MOVW	R0, #lo_addr(_stat+0)
MOVT	R0, #hi_addr(_stat+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToHex+0
;main.c,55 :: 		UART1_Write_Text(stat);         // Write status
MOVW	R0, #lo_addr(_stat+0)
MOVT	R0, #hi_addr(_stat+0)
LDRB	R0, [R0, #0]
BL	_UART1_Write_Text+0
;main.c,56 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;main.c,58 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
NOP
;main.c,60 :: 		while(1)
L_main8:
;main.c,62 :: 		GPIOB_ODR.B15  = 1;             // Enable the module
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;main.c,64 :: 		dat1 = readBuffer();            // Read buffer
BL	_readBuffer+0
MOVW	R1, #lo_addr(_dat1+0)
MOVT	R1, #hi_addr(_dat1+0)
STRB	R0, [R1, #0]
;main.c,66 :: 		if((dat1 & 2) != 0)             // Once buffer is not empty read
AND	R0, R0, #2
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_main10
;main.c,68 :: 		GPIOC_ODR.B13 = 1;            // Status On
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,69 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
NOP
;main.c,70 :: 		UART1_Write_Text(Data_In);    // Write read data
MOVW	R0, #lo_addr(_Data_In+0)
MOVT	R0, #hi_addr(_Data_In+0)
BL	_UART1_Write_Text+0
;main.c,71 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;main.c,72 :: 		GPIOC_ODR.B13 = 0;            // Status Off
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main.c,73 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main13:
SUBS	R7, R7, #1
BNE	L_main13
NOP
NOP
NOP
;main.c,74 :: 		}
L_main10:
;main.c,76 :: 		Delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_main15:
SUBS	R7, R7, #1
BNE	L_main15
NOP
NOP
NOP
;main.c,77 :: 		}
IT	AL
BAL	L_main8
;main.c,78 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
