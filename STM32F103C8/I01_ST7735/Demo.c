  /*
 * File: Demo.c
 * Author: Armstrong Subero  (modified from Adafruit Libraries)
 * uC:  STM32F103C8T6 HS w/PLL OSC @ 72 MHz, 3.3v
 * Program: ST7735
 * Compiler: mikroC Pro ARM (v6.0.0.0)
 * Program Version: 1.0
 *
 * Program Description: This Program Allows the STM32F103C8T6 to communicate
 *                      via SPI with a ST7735 TFT LCD.
 *
 * Hardware Description: A ST7735 is connected to  the microcontroller as 
 *                       follows:
 *
 *                       RST  --> PB13
 *                       CS   --> PB15
 *                       D/C  --> PB14
 *                       DIN  --> PA7
 *                       CLK  --> PA5
 *                       VCC  --> VCC
 *                       BL   --> VCC via 1k resistor
 *                       GND  --> GND
 *
 *
 * Created December 15th, 2017, 7:46 PM
 */

/*******************************************************************************
*Includes, defines and Function Prototypes
*******************************************************************************/
#include "ST7735.h"

/*******************************************************************************
 * Function: void initMain()
 *
 * Returns: Nothing
 *
 * Description: Contains initializations for main
 *
 * Usage: initMain()
 ******************************************************************************/

void initMain()
{
  // setup output pins
  GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);   // Reset
  GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);   // D/C (RS)
  GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);   // CS


  // Initialize SPI1 module
  SPI1_Init_Advanced(_SPI_FPCLK_DIV8, _SPI_MASTER  | _SPI_8_BIT |
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI1_PA567);
                     
  // Allow module to stabalize
  Delay_ms(100);
}

/*******************************************************************************
 * Function: Main
 *
 * Returns: Nothing
 *
 * Description: Program entry point
 ******************************************************************************/

void main() {
     // Init Main
     initMain();

     // Initialize LCD
     ST7735_Init();
     
     while(1)
     {
         // Run test function
         ST7735_test();
     }
}

