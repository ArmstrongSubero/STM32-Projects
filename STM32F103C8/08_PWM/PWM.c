 /*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: 08_PWM
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to use the PWM module
 *
 * Hardware Description: An LED is connected via a 1k resistor to Timer2 Channel 1
 *
 * Created January 21st, 2018, 11:05 PM
 */
 
// value of duty
unsigned int val = 0;

void main() {
    // Set Timer2 PWM channel1 at 10 kHz  with initial duty of 0
    unsigned int ratio = PWM_TIM2_Init(10000);
    PWM_TIM2_Set_Duty(val,_PWM_NON_INVERTED, _PWM_CHANNEL1);
    PWM_TIM2_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM2_CH1_PA0);
    
    while(1)
    {
        // PWM duty increments from 0 to 65535 (16 bit)
        for (val = 0; val <= 65535; val++)
        {
         PWM_TIM2_Set_Duty(val,_PWM_NON_INVERTED, _PWM_CHANNEL1);
         Delay_ms(10);
         
         if (val == 65530)
         {
          val = 0;
          PWM_TIM2_Set_Duty(val,_PWM_NON_INVERTED, _PWM_CHANNEL1);
         }
        }
        

    }
}