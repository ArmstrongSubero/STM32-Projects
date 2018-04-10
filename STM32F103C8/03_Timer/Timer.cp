#line 1 "C:/Users/armst/Desktop/STM32/STM32F103C8T6/MikroC/03_Timer/Timer.c"
#line 17 "C:/Users/armst/Desktop/STM32/STM32F103C8T6/MikroC/03_Timer/Timer.c"
void Timer2_interrupt() iv IVT_INT_TIM2 {
 TIM2_SR.UIF = 0;
 GPIOC_ODR.B13 = ~GPIOC_ODR.B13;
}


void main() {
 GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);

 RCC_APB1ENR.TIM2EN = 1;
 TIM2_CR1.CEN = 0;
 TIM2_PSC = 1098;
 TIM2_ARR = 65514;
 NVIC_IntEnable(IVT_INT_TIM2);
 TIM2_DIER.UIE = 1;
 TIM2_CR1.CEN = 1;
}
