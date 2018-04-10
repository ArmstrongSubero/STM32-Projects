/*
 * File: Main.c
 * Author: Armstrong Subero (modified by code on forums provided by 'eva')
 * uC:  STM32F103C8T6 HS w/PLL OSC @ 72 MHz, 3.3v     (USB 48Mhz)
 * Program: USB HID
 * Compiler: mikroC Pro ARM (v6.0.0.0)
 * Program Version: 1.0
 *
 * Program Description: This Program Allows the STM32F103C8T6 to communicate
 *                      via USB using HID device class. When the character 'b'
 *                      is recieved and LED connected to the uC turns on and
 *                      when the character 't' is recieved the LED turns off.
 *                      When either character is recieved, a number is incremented
 *                      and sent to the host.
 *
 * Hardware Description: A STM32F103C8T6 is connected via USB as follows:
 *
 *                       Vss --> Vss
 *                       Vdd --> 5v
 *                       USB- --> PA11
 *                       USB+ --> PA12
 *
 *                    Additionally an LED is connected via a 1k resistor to PA9
 *
 * Created December 11th, 2017, 11:38 PM
 */

/*******************************************************************************
*Includes, defines and Function Prototypes
*******************************************************************************/

char readbuff[64];
char writebuff[64];
int count = 0;

/*******************************************************************************
* Function: void USB0Interrupt() iv IVT_INT_USB_LP_CAN_RX0
*
* Returns: Nothing
*
* Description: Services USB interrupt
*******************************************************************************/

// USB Interrupt
void USB0Interrupt() iv IVT_INT_USB_LP_CAN_RX0
{
  // Service USB
  USB_Interrupt_Proc();
}

/*******************************************************************************
 * Function: Main
 *
 * Returns: Nothing
 *
 * Description: Program entry point
 ******************************************************************************/
void main(void){
  unsigned char n_byte;

  //set A9 as output pin
  GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_9);
  GPIOA_ODR=0;
  
  // enable USB communication
  HID_Enable(&readbuff,&writebuff);

  while(1)
  {
    // recieve message from host and store in buffer
    n_byte= HID_Read();
    if(n_byte !=0)         // packet received !
    {
          // if b (0x62h) read turn LED on
          if(readbuff[0]=='b')
          {
           GPIOA_ODR.B9=1; // turn on led
          }

          // if t (0x74h) read turn off led
          if(readbuff[0]=='t')
          {
           GPIOA_ODR.B9=0; // turn off led
          }
          
          // once data read send count via USB
          writebuff[0]=count;
          HID_Write(&writebuff,64);
          
          // increent count
          count++;
          
          // if count is 255, make count 0
          if (count == 255)
          {
           count = 0;
          }
    }
  }
}