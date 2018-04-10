#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/05_SPI/SPI.c"
#line 33 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/05_SPI/SPI.c"
sbit DigiPot_CS at GPIOB_ODR.B15;
int val;

void digiPot_Write(int i);
#line 48 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/05_SPI/SPI.c"
void initMain()
{


 SPI1_Init_Advanced(_SPI_FPCLK_DIV128, _SPI_MASTER | _SPI_8_BIT |
 _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
 _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
 &_GPIO_MODULE_SPI1_PA567);
}
#line 66 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/05_SPI/SPI.c"
void main() {
 initMain();


 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);

 while(1)
 {

 for(val = 0; val <= 128; val++)
 {
 digiPot_Write(val);
 Delay_ms(250);
 }

 }
}
#line 94 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/05_SPI/SPI.c"
void digiPot_Write(int i)
{

 DigiPot_CS = 0;


 SPI1_Write(0x00);


 SPI1_Write(i);


 DigiPot_CS = 1;
}
