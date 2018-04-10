/*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: 01_Blink
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to blink an LED
 *
 * Hardware Description: An LED is connected via a 1k resistor to PIN C13
 *
 * Created January 21st, 2018, 8:32 PM
 */


void main() 
{
     // set PORTC13 as digital output
     GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);
     
     // Toggle PIC C13
     while(1)
     {
       GPIOC_ODR.B13 = ~GPIOC_ODR.B13;
       Delay_ms(100);
     }
}