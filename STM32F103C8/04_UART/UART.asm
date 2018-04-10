_main:
;UART.c,17 :: 		void main() {
;UART.c,18 :: 		unsigned char ch = 0;
;UART.c,21 :: 		UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;UART.c,22 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main0:
SUBS	R7, R7, #1
BNE	L_main0
NOP
NOP
NOP
;UART.c,24 :: 		while (1)
L_main2:
;UART.c,26 :: 		if (UART1_Data_Ready())       // If data is received
BL	_UART1_Data_Ready+0
CMP	R0, #0
IT	EQ
BEQ	L_main4
;UART.c,28 :: 		ch = UART1_Read();     // read the received data
BL	_UART1_Read+0
;UART.c,29 :: 		UART1_Write(ch+1);       // and send data via UART
UXTB	R0, R0
ADDS	R0, R0, #1
UXTH	R0, R0
BL	_UART1_Write+0
;UART.c,30 :: 		UART1_Write_Text(" Recieved");
MOVW	R0, #lo_addr(?lstr1_UART+0)
MOVT	R0, #hi_addr(?lstr1_UART+0)
BL	_UART1_Write_Text+0
;UART.c,31 :: 		}
L_main4:
;UART.c,32 :: 		}
IT	AL
BAL	L_main2
;UART.c,34 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
