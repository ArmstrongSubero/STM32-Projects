_initMain:
;I2C.c,6 :: 		void initMain()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;I2C.c,9 :: 		UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;I2C.c,11 :: 		Delay_ms(100);
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
;I2C.c,14 :: 		I2C1_Init_Advanced(100000, &_GPIO_MODULE_I2C1_PB67);
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C1_PB67+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C1_PB67+0)
MOVW	R0, #34464
MOVT	R0, #1
BL	_I2C1_Init_Advanced+0
;I2C.c,15 :: 		}
L_end_initMain:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initMain
_main:
;I2C.c,17 :: 		void main()
;I2C.c,19 :: 		initMain();                                       // initalize main
BL	_initMain+0
;I2C.c,21 :: 		ee_addr = 10;                                     // addr 10
MOVS	R1, #10
MOVW	R0, #lo_addr(_ee_addr+0)
MOVT	R0, #hi_addr(_ee_addr+0)
STRB	R1, [R0, #0]
;I2C.c,22 :: 		wr_data = 40;                                     // write 40
MOVS	R1, #40
MOVW	R0, #lo_addr(_wr_data+0)
MOVT	R0, #hi_addr(_wr_data+0)
STRB	R1, [R0, #0]
;I2C.c,24 :: 		while(1)
L_main2:
;I2C.c,26 :: 		EEPROM_24LC16B_WrSingle(ee_addr, wr_data);    // write data into the EEPROM
MOVW	R0, #lo_addr(_wr_data+0)
MOVT	R0, #hi_addr(_wr_data+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ee_addr+0)
MOVT	R0, #hi_addr(_ee_addr+0)
LDRB	R0, [R0, #0]
BL	_EEPROM_24LC16B_WrSingle+0
;I2C.c,27 :: 		Delay_ms(20);                                 // short delay
MOVW	R7, #43391
MOVT	R7, #3
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
;I2C.c,29 :: 		rd_data = EEPROM_24LC16B_RdSingle(ee_addr);   // read data from EEPROM
MOVW	R0, #lo_addr(_ee_addr+0)
MOVT	R0, #hi_addr(_ee_addr+0)
LDRB	R0, [R0, #0]
BL	_EEPROM_24LC16B_RdSingle+0
MOVW	R1, #lo_addr(_rd_data+0)
MOVT	R1, #hi_addr(_rd_data+0)
STRB	R0, [R1, #0]
;I2C.c,31 :: 		IntToStr(rd_data, txt);                       // convert read data to string
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_IntToStr+0
;I2C.c,33 :: 		Uart_Write_Text(txt);                         // write to UART
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_UART_Write_Text+0
;I2C.c,34 :: 		Delay_ms(2000);                               // send every 2 seconds
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
NOP
;I2C.c,35 :: 		}
IT	AL
BAL	L_main2
;I2C.c,36 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
