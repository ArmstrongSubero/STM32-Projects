/*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: 02_Switch
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to read a pushbutton
 *
 * Hardware Description: An LED is connected via a 1k resistor to PIN C13 and
 *                       a switch connected to PIN B15
 *
 * Created January 21st, 2018, 8:40 PM
 */

// flag
unsigned int oldstate;

void main() {
     GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);        // Set PORTC13 as digital output
     GPIO_Digital_Input (&GPIOB_IDR,  _GPIO_PINMASK_15);       // Set PB15 as digital input

     oldstate = 0;                                            // set oldstate false

     while(1)
     {
       if (Button(&GPIOB_IDR, 15, 1, 1))                      // detect logical one on PB15 pin
       {
         GPIOC_ODR.B13 = 1;                                  // turn LED on
         oldstate = 1;                                       // oldstate  is true
       }
       if (oldstate && Button(&GPIOB_IDR, 15, 1, 0))          // else
       {
         GPIOC_ODR.B13 = 0;                                   // turn LED off
         oldstate = 0;                                        // oldstate is false
       }
     }
}