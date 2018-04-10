/*
 * File: NRF24L01_RX.c
 * Author: Armstrong Subero
 * uC:  STM32F103C8T6 HS w/PLL OSC @ 72 MHz, 3.3v
 * Compiler: mikroC Pro ARM (v6.0.0.0)
 * Program Version: 1.0
 *
 * Program Description: This contains function implementations for the NRF24L01+
 *
 * Modified From: Libstock example provided by  Allen Mulvey, May 2014
 *                  * Ported from PIC16F877 to STM32F103C8T6
 *                  * Seperated functions from main
 * Created April 10th, 2018, 3:03 PM
 */

#include "NRF24L01_RX.h"

// Pipe Addresses
// adr0 should be unique
// adr1 through adr5 must differ only in the lowest significant byte
// Bytes are arranged lowest to highest


const char adr0[] = {0x78,0x78,0x78,0x78,0x78};    // LSB first
const char adr1[] = {0xf1,0xb4,0xb5,0xb6,0xb3};
const char adr2[] = {0xb3,0xb4,0xb5,0xb6,0xb3};
const char adr3[] = {0x83,0xb4,0xb5,0xb6,0xb3};
const char adr4[] = {0xcf,0xb4,0xb5,0xb6,0xb3};
const char adr5[] = {0x75,0xb4,0xb5,0xb6,0xb3};


short dataLength = 20;
extern char Data_In[21];
extern char Data_Out[21];
char stat;

sbit Irq_pin     at GPIOB_ODR.B13; sfr;
sbit Ce_pin      at GPIOB_ODR.B15; sfr;
sbit Csn_pin     at GPIOB_ODR.B14; sfr;

void Clear_Data(char dat[])
{
     char i;
     for(i=0;i<dataLength;i++)dat[i] = ' ';
}

void toggleCSN()
{
     Csn_pin = 1;
     Delay_us(20);                      // You can experiment with this delay
     Csn_pin = 0;
     Delay_us(10);
}

char Get_Status()
{
     char s;
     Ce_pin = 0;
     toggleCSN();
     SPI1_Write(STATUS);
     Delay_us(10);
     s = SPI1_Read(NOP);
     Delay_us(10);
     Csn_pin = 1;
     return s;
}

char *getConst(char dest[], const char source[])
{
    int i = 0;
    while (source[i])                  // while (source[i] != '\0')
    {dest[i] = source[i]; i++;}
    dest[i] = '\0';
    return dest;
}

char Get_FIFO_Flags()
{
     char s;
     Ce_pin = 0;
     toggleCSN();
     SPI1_Write(FIFO_STATUS);
     Delay_us(10);
     s = SPI1_Read(NOP);
     Delay_us(10);
     Csn_pin = 1;
     return s;
}


char readBuffer()
{
     char i, s;
     Ce_pin = 0;
     Clear_Data(Data_In);
     s = Get_FIFO_Flags();
     if((s & 2) != 0){
         toggleCSN();
         SPI1_Write(R_RX_PAYLOAD);
         for(i=0; i < dataLength; i++){Delay_us(10); Data_In[i] = SPI1_Read(0);}
         Delay_us(10);
     }
     Csn_pin = 1;
     Ce_pin = 1;
     return s;
}



char init_Radio()
{
       char i;
       Ce_pin = 0;                                      // must be in standby or power down to write
       Delay_us(10);
       toggleCSN();
       SPI1_Write(CONFIG | W_REGISTER);
       Delay_us(10);

       SPI1_Write(PRIM_RX + PWR_UP + CRCO + EN_CRC);    // Receiver

       toggleCSN();
       SPI1_Write(EN_AA | W_REGISTER);
       Delay_us(10);
       SPI1_Write(ENAA_P0 + ENAA_P1 + ENAA_P2 + ENAA_P3 + ENAA_P4 + ENAA_P5);
       Delay_us(10);

       toggleCSN();
       SPI1_Write(EN_RXADDR | W_REGISTER);
       Delay_us(10);
       SPI1_Write(ERX_P0 + ERX_P1 + ERX_P2 + ERX_P3 + ERX_P4 + ERX_P5);
       Delay_us(10);

       toggleCSN();
       SPI1_Write(SETUP_AW | W_REGISTER);
       Delay_us(10);
       SPI1_Write(AW5);
       Delay_us(10);

       toggleCSN();
       SPI1_Write(SETUP_RETR | W_REGISTER);
       Delay_us(10);
       SPI1_Write(0xfaf);
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RF_CH | W_REGISTER);
       Delay_us(10);
       SPI1_Write(Channel);                                      // Set your channel here.
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RF_SETUP | W_REGISTER);
       Delay_us(10);
       SPI1_Write(RF_PWR + LNA_HCURR);
       Delay_us(10);


       toggleCSN();
       SPI1_Write(RX_ADDR_P0 | W_REGISTER);
       for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr0[i]);}
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_ADDR_P1 | W_REGISTER);
       for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr1[i]);}
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_ADDR_P2 | W_REGISTER);
       for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr2[i]);}
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_ADDR_P3 | W_REGISTER);
       for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr3[i]);}
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_ADDR_P4 | W_REGISTER);
       for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr4[i]);}
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_ADDR_P5 | W_REGISTER);
       for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr5[i]);}
       Delay_us(10);

       toggleCSN();
       SPI1_Write(TX_ADDR | W_REGISTER);
       for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr0[i]);}
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_PW_P1 | W_REGISTER);
       Delay_us(10);
       SPI1_Write(dataLength);
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_PW_P2 | W_REGISTER);
       Delay_us(10);
       SPI1_Write(dataLength);
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_PW_P3 | W_REGISTER);
       Delay_us(10);
       SPI1_Write(dataLength);
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_PW_P4 | W_REGISTER);
       Delay_us(10);
       SPI1_Write(dataLength);
       Delay_us(10);

       toggleCSN();
       SPI1_Write(RX_PW_P5 | W_REGISTER);
       Delay_us(10);
       SPI1_Write(dataLength);
       Delay_us(10);


       toggleCSN();
       SPI1_Write(RX_PW_P0 | W_REGISTER);
       Delay_us(10);
       SPI1_Write(dataLength);
       Delay_us(10);

       Csn_pin = 1;
       i = Get_Status();
       return i;
}