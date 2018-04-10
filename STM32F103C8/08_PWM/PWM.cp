#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/07_PWM/PWM.c"


unsigned int val = 0;

void main() {

 unsigned int ratio = PWM_TIM2_Init(10000);
 PWM_TIM2_Set_Duty(val,_PWM_NON_INVERTED, _PWM_CHANNEL1);
 PWM_TIM2_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM2_CH1_PA0);

 while(1)
 {

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
