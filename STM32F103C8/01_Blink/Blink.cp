#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/01_Blink/Blink.c"
#line 17 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/01_Blink/Blink.c"
void main()
{

 GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);


 while(1)
 {
 GPIOC_ODR.B13 = ~GPIOC_ODR.B13;
 Delay_ms(100);
 }
}
