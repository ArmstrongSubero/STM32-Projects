#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/04_ADC/ADC.c"

unsigned adc_value;
int myint[16];

void main() {
 ADC_Set_Input_Channel(_ADC_CHANNEL_0);
 ADC1_Init();


 UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
 Delay_ms(100);

 while(1){
 adc_value = ADC1_Get_Sample(0);
 WordToStr( adc_value, myint );
 UART1_Write_Text( myint );
 UART1_Write( 13 );
 UART1_Write( 10 );
 Delay_ms(1000);
 }
}
