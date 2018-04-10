/*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: 03_Timer
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to uses Timer2 to
 *                      toggle an LED
 *
 * Hardware Description: An LED is connected via a 1k resistor to PIN C13
 *
 * Created January 21st, 2018, 8:49 PM
 */

void Timer2_interrupt() iv IVT_INT_TIM2 {
  TIM2_SR.UIF = 0;
  GPIOC_ODR.B13 = ~GPIOC_ODR.B13; // Toggle PIN C13
}


void main() {
     GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);       // Set PORTC13 as digital output

     RCC_APB1ENR.TIM2EN = 1;       // Enable clock gating for timer module 2
     TIM2_CR1.CEN = 0;             // Disable timer
     TIM2_PSC = 1098;              // Set timer prescaler.
     TIM2_ARR = 65514;             // Auto reload register
     NVIC_IntEnable(IVT_INT_TIM2); // Enable timer interrupt
     TIM2_DIER.UIE = 1;            // Update interrupt enable
     TIM2_CR1.CEN = 1;             // Enable timer
}