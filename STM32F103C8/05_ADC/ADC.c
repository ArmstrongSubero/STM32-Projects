 /*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: 05_ADC
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to use the ADC module
 *
 * Hardware Description: An CP2104 is connected to a STM32 via USART1
 *
 * Created January 21st, 2018, 11:05 PM
 */
unsigned adc_value;
int myint[16];

void main() {
     ADC_Set_Input_Channel(_ADC_CHANNEL_0); // Set ADC channel 0 as an analog input
     ADC1_Init();                            // Initialize ADC module
     
     // Initialize UART at 9600 baud
     UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
     Delay_ms(100);                  // Wait for UART module to stabilize
       
       while(1){
               adc_value = ADC1_Get_Sample(0);        // read analog value from ADC module channel 0
               WordToStr( adc_value, myint );         // convert for sending via uart
               UART1_Write_Text( myint );             // write via uart
               UART1_Write( 13 );                     // carriage return
               UART1_Write( 10 );                     // line feed
               Delay_ms(1000);
       }
}