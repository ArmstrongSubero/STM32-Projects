/*
 * File: main.c
 * Author: Armstrong Subero
 * uC:  STM32F103C8T6 HS w/PLL OSC @ 72 MHz, 3.3v
 * Program: I04_NRF24L01_RX
 * Compiler: mikroC Pro ARM (v6.0.0.0)
 * Program Version: 1.0
 *
 * Program Description: This Program Allows the STM32F103C8T6 to communicate
 *                      via SPI with the NRF24L01+ module in reciever mode,
 *                      this program was ported from the version provided by
 *                      Allen Mulvey on Libstock
 *
 * Hardware Description: A NRF24L01+ module is connected as follows:
 *
 *                       Vcc  --> Vcc
 *                       Gnd  --> Gnd
 *                       CSN  --> PB14
 *                       CE   --> PB15
 *                       MOSI --> PA7
 *                       SCK  --> PA5
 *                       IRQ  --> PB13
 *                       MISO --> PA6
 *
 *
 * Created April 10th, 2018, 3:03 PM
 */


#include "NRF24L01_RX.h"

char Data_In [21];
char Data_Out[21];
char txt[5];
char dat1;

void main()
{
     GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);    // IRQ out
     GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);    // CSN out
     GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);    // CE  out

     GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);    // RX LED


     UART1_Init(9600);               // Initialize UART module at 9600 bps
     Delay_ms(1000);                 // Wait for UART module to stabilize

     SPI1_Init();                    // Initialize the SPI1 module
     Delay_ms(200);
     stat = init_Radio();            // Initialize radio
     Delay_ms(10);

     ByteToHex(stat, txt);           // Convert status to string
     UART1_Write_Text(stat);         // Write status
     UART1_Write(13);

     Delay_ms(1000);

       while(1)
       {
           GPIOB_ODR.B15  = 1;             // Enable the module

           dat1 = readBuffer();            // Read buffer

           if((dat1 & 2) != 0)             // Once buffer is not empty read
           {
             GPIOC_ODR.B13 = 1;            // Status On
             Delay_ms(10);
             UART1_Write_Text(Data_In);    // Write read data
             UART1_Write(13);
             GPIOC_ODR.B13 = 0;            // Status Off
             Delay_ms(10);
           }
           
           Delay_ms(500);
       }
}