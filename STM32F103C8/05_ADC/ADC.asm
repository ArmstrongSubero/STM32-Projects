_main:
;ADC.c,5 :: 		void main() {
;ADC.c,6 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_0); // Set ADC channel 0 as an analog input
MOVW	R0, #1
BL	_ADC_Set_Input_Channel+0
;ADC.c,7 :: 		ADC1_Init();                            // Initialize ADC module
BL	_ADC1_Init+0
;ADC.c,10 :: 		UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;ADC.c,11 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
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
;ADC.c,13 :: 		while(1){
L_main2:
;ADC.c,14 :: 		adc_value = ADC1_Get_Sample(0);        // read analog value from ADC module channel 0
MOVS	R0, #0
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_adc_value+0)
MOVT	R1, #hi_addr(_adc_value+0)
STRH	R0, [R1, #0]
;ADC.c,15 :: 		WordToStr( adc_value, myint );         // convert for sending via uart
MOVW	R1, #lo_addr(_myint+0)
MOVT	R1, #hi_addr(_myint+0)
BL	_WordToStr+0
;ADC.c,16 :: 		UART1_Write_Text( myint );             // write via uart
MOVW	R0, #lo_addr(_myint+0)
MOVT	R0, #hi_addr(_myint+0)
BL	_UART1_Write_Text+0
;ADC.c,17 :: 		UART1_Write( 13 );                     // carriage return
MOVS	R0, #13
BL	_UART1_Write+0
;ADC.c,18 :: 		UART1_Write( 10 );                     // line feed
MOVS	R0, #10
BL	_UART1_Write+0
;ADC.c,19 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
;ADC.c,20 :: 		}
IT	AL
BAL	L_main2
;ADC.c,21 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
