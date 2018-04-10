/*
 * File: main.c
 * Author: Armstrong Subero
 * uC:  STM32F103C8T6 HS w/PLL OSC @ 72 MHz, 3.3v
 * Program: I03_NRF24L01_TX
 * Compiler: mikroC Pro ARM (v6.0.0.0)
 * Program Version: 1.0
 *
 * Program Description: This Program Allows the STM32F103C8T6 to communicate
 *                      via SPI with the NRF24L01+ module in transmitter mode,
 *                      this program was ported from the version provided by
 *                      Allen Mulvey on Libstock and sends numbers from 1 to
 *                      100 via the NRF24L01+
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
 * Created April 10th, 2018, 4:38 PM
 */

#include "NRF24L01_TX.h"

char Data_In[21];
char Data_Out[21];
char stat;
int count;
char txt[3];

void initMain()
{
  SPI1_Init();                       // initialize SPI module
  Delay_ms(100);                     // Allow to stabilize

  GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);  // IRQ out
  GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);  // CSN out
  GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);  // CE  out

  GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);  // TX LED
}

void main()
{
  initMain();              // initialize main
  stat = init_Radio();     // initialize radio
  Clear_Data(Data_Out);    // clear data out buffer
  
  while(1)
  {

    for (count = 0; count <= 100; count++)
    {
       GPIOC_ODR.B13 = 1;        // TX LED on
       Delay_ms(10);
       
       IntToStr(count, txt);     // convert count to string
       makeMsg(txt);             // make read to transmit
       sendBuffer();             // transmit
       
       GPIOC_ODR.B13 = 0;        // TX LED off
       Delay_ms(10);
    }
  }
}