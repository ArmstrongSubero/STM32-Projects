#line 1 "C:/Users/armst/Desktop/STM32/STM32F103C8T6/MikroC/02_Switch/_Switch.c"
#line 18 "C:/Users/armst/Desktop/STM32/STM32F103C8T6/MikroC/02_Switch/_Switch.c"
unsigned int oldstate;

void main() {
 GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);
 GPIO_Digital_Input (&GPIOB_IDR, _GPIO_PINMASK_15);

 oldstate = 0;

 while(1)
 {
 if (Button(&GPIOB_IDR, 15, 1, 1))
 {
 GPIOC_ODR.B13 = 1;
 oldstate = 1;
 }
 if (oldstate && Button(&GPIOB_IDR, 15, 1, 0))
 {
 GPIOC_ODR.B13 = 0;
 oldstate = 0;
 }
 }
}
