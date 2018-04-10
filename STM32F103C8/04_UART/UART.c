 /*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: 04_UART
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to communicate via
 *                      UART
 *
 * Hardware Description: An CP2104 is connected to a STM32 via USART1
 *
 * Created January 21st, 2018, 9:05 PM
 */

void main() {
    unsigned char ch = 0;

    // Initialize the module at 9600 baud with no parity bit, one stop bit at UART1
    UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
    Delay_ms(100);                  // Wait for UART module to stabilize

    while (1)
    {
      if (UART1_Data_Ready())       // If data is received
      {
        ch = UART1_Read();     // read the received data
        UART1_Write(ch+1);       // and send data via UART
        UART1_Write_Text(" Recieved");
      }
  }

}