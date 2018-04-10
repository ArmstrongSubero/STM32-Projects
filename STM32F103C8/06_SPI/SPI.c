/*
 * File: Main.c
 * Author: Armstrong Subero
 * uC:  STM32F103C8T6 HS w/PLL OSC @ 72 MHz, 3.3v
 * Program: 06_SPI
 * Compiler: mikroC Pro ARM (v6.0.0.0)
 * Program Version: 1.0
 *
 * Program Description: This Program Allows the STM32F103C8T6 to communicate
 *                      via SPI with an MCP4131. The MCP4131 operates at
 *                      5v for maximum LED brightness.
 *
 * Hardware Description: A MCP4131 digipot is connected via a logic level 
 *                       converter to  the microcontroller as follows:
 *
 *                       Vss --> Vss
 *                       Vdd --> 5v
 *                       SS  --> PB15
 *                       SCK --> PA5
 *                       SDI --> PA7
 *                       POB --> GND
 *                       POW --> LED via 1k resistor
 *                       POA --> Vdd
 *
 *
 * Created December 11th, 2017, 10:15 AM
 */

/*******************************************************************************
*Includes, defines and Function Prototypes
*******************************************************************************/

sbit DigiPot_CS at GPIOB_ODR.B15;
int val;

void digiPot_Write(int i);

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

  // Initialize SPI1 module
  SPI1_Init_Advanced(_SPI_FPCLK_DIV128, _SPI_MASTER  | _SPI_8_BIT |
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI1_PA567);
}

/*******************************************************************************
 * Function: Main
 *
 * Returns: Nothing
 *
 * Description: Program entry point
 ******************************************************************************/
 
void main() {
     initMain();
     
     // Set PORTB15 as digital output (CS)
     GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);

     while(1)
     {
       // Send values to digipot  (seven bit resolution)
       for(val = 0; val <= 128; val++)
       {
        digiPot_Write(val);
        Delay_ms(250);
       }
       
     }
}

 /******************************************************************************
 * Function: digiPot_Write(int i)
 *
 * Returns: Nothing
 *
 * Description: Writes a particular value to a MCP4131 digital potentiometer
 *
 * Usage: digiPot_write(x);
 ******************************************************************************/
 
void digiPot_Write(int i)
{
  // set CS low
  DigiPot_CS = 0;
  
  // Write to Slave Address
  SPI1_Write(0x00);
  
  // Write Data
  SPI1_Write(i);
  
  // set CS high
  DigiPot_CS = 1;
}