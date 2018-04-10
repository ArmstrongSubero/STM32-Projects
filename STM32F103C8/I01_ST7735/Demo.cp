#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/Demo.c"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i01_st7735/st7735.h"
#line 212 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i01_st7735/st7735.h"
void ST7735_WriteCommand(int i);
void ST7735_WriteData(int i);
void ST7735_Init(void);
void ST7735_drawPixel(unsigned char x, unsigned char y, unsigned int color) ;
void ST7735_fillScreen(unsigned int color);
void setAddrWindow(unsigned char x0, unsigned char y0, unsigned char x1, unsigned char y1);
void ST7735_pushColor(unsigned int color);
void ST7735_drawChar(unsigned char x, unsigned char y, char c, unsigned int color, unsigned char size);
void ST7735_drawString(unsigned char x, unsigned char y, char *c, unsigned int color, unsigned char size);
void ST7735_fillCircle(unsigned char x0, unsigned char y0, unsigned char r, unsigned int color);
void ST7735_drawCircle(unsigned char x0, unsigned char y0, unsigned char r, unsigned int color);
void ST7735_setRotation(unsigned char m);
void ST7735_drawRect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned int color);
void ST7735_fillRect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned int color);
void ST7735_drawVerticalLine(unsigned char x, unsigned char y, unsigned char length, unsigned int color);
void ST7735_drawHorizontalLine(unsigned char x, unsigned char y, unsigned char length, unsigned int color);
void ST7735_drawFastLine(unsigned char x, unsigned char y, unsigned char length, unsigned int color, unsigned char rotflag);
void ST7735_drawLine(int x0, int y0, int x1, int y1, unsigned int color);
void ST7735_writeInteger(int x, int y, int v, unsigned int colour, int size);
void ST7735_test();
#line 43 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/Demo.c"
void initMain()
{

 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);
 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);
 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);



 SPI1_Init_Advanced(_SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT |
 _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
 _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
 &_GPIO_MODULE_SPI1_PA567);


 Delay_ms(100);
}
#line 69 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/Demo.c"
void main() {

 initMain();


 ST7735_Init();

 while(1)
 {

 ST7735_test();
 }
}
