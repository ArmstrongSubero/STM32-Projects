 /*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: 07_SPI
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to use the I2C module
 *                      which is used to read and write a 24LC16B EEPROM 
 *
 * Hardware Description: An CP2104 is connected to a STM32 via USART1 and a 
 *                       24LC16B EEPROM is connected to the I2C1 bus
 *
 * Created January 21st, 2018, 11:05 PM
 */
 
#include "24LC16B.h"

char txt[3];
char ee_addr, wr_data, rd_data;

void initMain()
{
    // Initialize the module at 9600 baud with no parity bit, one stop bit at UART1
    UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
    // Wait for UART module to stabilize
    Delay_ms(100);

    // Initialize the I2C1 module with 100Kbps speed on PORTB
    I2C1_Init_Advanced(100000, &_GPIO_MODULE_I2C1_PB67);
}

void main() 
{
    initMain();                                       // initalize main
    
    ee_addr = 10;                                     // addr 10
    wr_data = 40;                                     // write 40
     
    while(1) 
    {
        EEPROM_24LC16B_WrSingle(ee_addr, wr_data);    // write data into the EEPROM
        Delay_ms(20);                                 // short delay
        
        rd_data = EEPROM_24LC16B_RdSingle(ee_addr);   // read data from EEPROM
        
        IntToStr(rd_data, txt);                       // convert read data to string
        
        Uart_Write_Text(txt);                         // write to UART
        Delay_ms(2000);                               // send every 2 seconds
    }
}