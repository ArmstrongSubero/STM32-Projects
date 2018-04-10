#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/04_UART/UART.c"
#line 17 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/04_UART/UART.c"
void main() {
 unsigned char ch = 0;


 UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
 Delay_ms(100);

 while (1)
 {
 if (UART1_Data_Ready())
 {
 ch = UART1_Read();
 UART1_Write(ch+1);
 UART1_Write_Text(" Recieved");
 }
 }

}
