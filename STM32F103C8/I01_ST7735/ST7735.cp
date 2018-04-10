#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
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
#line 18 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
sbit ST7735_RESET at GPIOB_ODR.B13;
sbit ST7735_RS at GPIOB_ODR.B14;
sbit ST7735_CS at GPIOB_ODR.B15;

unsigned char colorB;
char madctl;
unsigned int dx, dy;
int err;
int ystep;
#line 31 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
static const char Alpha1[] = {
 0x00,0x00,0x00,0x00,0x00,
 0x00,0x00,0x5f,0x00,0x00,
 0x00,0x07,0x00,0x07,0x00,
 0x14,0x7f,0x14,0x7f,0x14,
 0x24,0x2a,0x7f,0x2a,0x12,
 0x23,0x13,0x08,0x64,0x62,
 0x36,0x49,0x55,0x22,0x50,
 0x00,0x05,0x03,0x00,0x00,
 0x00,0x1c,0x22,0x41,0x00,
 0x00,0x41,0x22,0x1c,0x00,
 0x14,0x08,0x3e,0x08,0x14,
 0x08,0x08,0x3e,0x08,0x08,
 0x00,0x50,0x30,0x00,0x00,
 0x08,0x08,0x08,0x08,0x08,
 0x00,0x60,0x60,0x00,0x00,
 0x20,0x10,0x08,0x04,0x02,
 0x3e,0x51,0x49,0x45,0x3e,
 0x00,0x42,0x7f,0x40,0x00,
 0x42,0x61,0x51,0x49,0x46,
 0x21,0x41,0x45,0x4b,0x31,
 0x18,0x14,0x12,0x7f,0x10,
 0x27,0x45,0x45,0x45,0x39,
 0x3c,0x4a,0x49,0x49,0x30,
 0x01,0x71,0x09,0x05,0x03,
 0x36,0x49,0x49,0x49,0x36,
 0x06,0x49,0x49,0x29,0x1e,
 0x00,0x36,0x36,0x00,0x00,
 0x00,0x56,0x36,0x00,0x00,
 0x08,0x14,0x22,0x41,0x00,
 0x14,0x14,0x14,0x14,0x14,
 0x00,0x41,0x22,0x14,0x08,
 0x02,0x01,0x51,0x09,0x06,
 0x32,0x49,0x79,0x41,0x3e,
 0x7e,0x11,0x11,0x11,0x7e,
 0x7f,0x49,0x49,0x49,0x36,
 0x3e,0x41,0x41,0x41,0x22,
 0x7f,0x41,0x41,0x22,0x1c,
 0x7f,0x49,0x49,0x49,0x41,
 0x7f,0x09,0x09,0x09,0x01,
 0x3e,0x41,0x49,0x49,0x7a,
 0x7f,0x08,0x08,0x08,0x7f,
 0x00,0x41,0x7f,0x41,0x00,
 0x20,0x40,0x41,0x3f,0x01,
 0x7f,0x08,0x14,0x22,0x41,
 0x7f,0x40,0x40,0x40,0x40,
 0x7f,0x02,0x0c,0x02,0x7f,
 0x7f,0x04,0x08,0x10,0x7f,
 0x3e,0x41,0x41,0x41,0x3e,
 0x7f,0x09,0x09,0x09,0x06,
 0x3e,0x41,0x51,0x21,0x5e};

static const char Alpha2[] = {
 0x7f,0x09,0x19,0x29,0x46,
 0x46,0x49,0x49,0x49,0x31,
 0x01,0x01,0x7f,0x01,0x01,
 0x3f,0x40,0x40,0x40,0x3f,
 0x1f,0x20,0x40,0x20,0x1f,
 0x3f,0x40,0x38,0x40,0x3f,
 0x63,0x14,0x08,0x14,0x63,
 0x07,0x08,0x70,0x08,0x07,
 0x61,0x51,0x49,0x45,0x43,
 0x00,0x7f,0x41,0x41,0x00,
 0x02,0x04,0x08,0x10,0x20,
 0x00,0x41,0x41,0x7f,0x00,
 0x04,0x02,0x01,0x02,0x04,
 0x40,0x40,0x40,0x40,0x40,
 0x00,0x01,0x02,0x04,0x00,
 0x20,0x54,0x54,0x54,0x78,
 0x7f,0x48,0x44,0x44,0x38,
 0x38,0x44,0x44,0x44,0x20,
 0x38,0x44,0x44,0x48,0x7f,
 0x38,0x54,0x54,0x54,0x18,
 0x08,0x7e,0x09,0x01,0x02,
 0x0c,0x52,0x52,0x52,0x3e,
 0x7f,0x08,0x04,0x04,0x78,
 0x00,0x44,0x7d,0x40,0x00,
 0x20,0x40,0x44,0x3d,0x00,
 0x7f,0x10,0x28,0x44,0x00,
 0x00,0x41,0x7f,0x40,0x00,
 0x7c,0x04,0x18,0x04,0x78,
 0x7c,0x08,0x04,0x04,0x78,
 0x38,0x44,0x44,0x44,0x38,
 0x7c,0x14,0x14,0x14,0x08,
 0x08,0x14,0x14,0x18,0x7c,
 0x7c,0x08,0x04,0x04,0x08,
 0x48,0x54,0x54,0x54,0x20,
 0x04,0x3f,0x44,0x40,0x20,
 0x3c,0x40,0x40,0x20,0x7c,
 0x1c,0x20,0x40,0x20,0x1c,
 0x3c,0x40,0x30,0x40,0x3c,
 0x44,0x28,0x10,0x28,0x44,
 0x0c,0x50,0x50,0x50,0x3c,
 0x44,0x64,0x54,0x4c,0x44,
 0x00,0x08,0x36,0x41,0x00,
 0x00,0x00,0x7f,0x00,0x00,
 0x00,0x41,0x36,0x08,0x00,
 0x10,0x08,0x08,0x10,0x08,
 0x78,0x46,0x41,0x46,0x78};
#line 139 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
void ST7735_WriteCommand(int i)
{

 ST7735_RS = 0;


 ST7735_CS = 0;


 SPI1_Write(i);


 ST7735_CS = 1;
}
#line 161 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
void ST7735_WriteData(int i)
{

 ST7735_RS = 1;


 ST7735_CS = 0;


 SPI1_Write(i);


 ST7735_CS = 1;
}
#line 183 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
void ST7735_Init(void)
{
 ST7735_RESET = 1;
 Delay_us(500);
 ST7735_RESET = 0;
 Delay_us(500);
 ST7735_RESET = 1;
 Delay_us(500);

 ST7735_CS = 0;

 ST7735_WriteCommand( 0x01 );
 Delay_us(150);

 ST7735_WriteCommand( 0x11 );
 Delay_us(500);

 ST7735_WriteCommand( 0x3A );
 ST7735_WriteData(0x05);
 Delay_us(10);

 ST7735_WriteCommand( 0xB1 );
 ST7735_WriteData(0x01);
 ST7735_WriteData(0x2C);
 ST7735_WriteData(0x2D);

 ST7735_WriteCommand( 0xB2 );
 ST7735_WriteData(0x01);
 ST7735_WriteData(0x2C);
 ST7735_WriteData(0x2D);

 ST7735_WriteCommand( 0xB3 );
 ST7735_WriteData(0x01);
 ST7735_WriteData(0x2C);
 ST7735_WriteData(0x2D);
 ST7735_WriteData(0x01);
 ST7735_WriteData(0x2C);
 ST7735_WriteData(0x2D);

 ST7735_WriteCommand( 0xB4 );
 ST7735_WriteData(0x07);

 ST7735_WriteCommand( 0xC0 );
 ST7735_WriteData(0xA2);
 ST7735_WriteData(0x02);
 ST7735_WriteData(0x84);

 ST7735_WriteCommand( 0xC1 );
 ST7735_WriteData(0xC5);

 ST7735_WriteCommand( 0xC2 );
 ST7735_WriteData(0x0A);
 ST7735_WriteData(0x00);

 ST7735_WriteCommand( 0xC3 );
 ST7735_WriteData(0x8A);
 ST7735_WriteData(0x2A);

 ST7735_WriteCommand( 0xC4 );
 ST7735_WriteData(0x8A);
 ST7735_WriteData(0xEE);

 ST7735_WriteCommand( 0xC5 );
 ST7735_WriteData(0x0E);

 ST7735_WriteCommand( 0x20 );

 ST7735_WriteCommand( 0x36 );


 madctl = 0xC0;
 ST7735_WriteData(madctl);

 ST7735_WriteCommand( 0x3A );
 ST7735_WriteData(0x05);

 ST7735_WriteCommand( 0x2A );
 ST7735_WriteData(0x00);
 ST7735_WriteData(0x00);
 ST7735_WriteData(0x00);
 ST7735_WriteData(0x7F);

 ST7735_WriteCommand( 0x2B );
 ST7735_WriteData(0x00);
 ST7735_WriteData(0x00);
 ST7735_WriteData(0x00);
 ST7735_WriteData(0x9F);

 ST7735_WriteCommand( 0xE0 );
 ST7735_WriteData(0x0f);
 ST7735_WriteData(0x1a);
 ST7735_WriteData(0x0f);
 ST7735_WriteData(0x18);
 ST7735_WriteData(0x2f);
 ST7735_WriteData(0x28);
 ST7735_WriteData(0x20);
 ST7735_WriteData(0x22);
 ST7735_WriteData(0x1f);
 ST7735_WriteData(0x1b);
 ST7735_WriteData(0x23);
 ST7735_WriteData(0x37);
 ST7735_WriteData(0x00);
 ST7735_WriteData(0x07);
 ST7735_WriteData(0x02);
 ST7735_WriteData(0x10);
 ST7735_WriteCommand( 0xE1 );
 ST7735_WriteData(0x0f);
 ST7735_WriteData(0x1b);
 ST7735_WriteData(0x0f);
 ST7735_WriteData(0x17);
 ST7735_WriteData(0x33);
 ST7735_WriteData(0x2c);
 ST7735_WriteData(0x29);
 ST7735_WriteData(0x2e);
 ST7735_WriteData(0x30);
 ST7735_WriteData(0x30);
 ST7735_WriteData(0x39);
 ST7735_WriteData(0x3f);
 ST7735_WriteData(0x00);
 ST7735_WriteData(0x07);
 ST7735_WriteData(0x03);
 ST7735_WriteData(0x10);

 ST7735_WriteCommand(0xF6);
 ST7735_WriteData(0x00);

 ST7735_WriteCommand( 0x29 );
 Delay_us(100);

 ST7735_WriteCommand( 0x13 );
 Delay_us(10);

 ST7735_CS = 1;
}
#line 325 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
void ST7735_test(){
 int x;
 ST7735_fillScreen( ((((255>>3)<<11) | ((255>>2)<<5) | (255>>3))) );


 for (x = 0; x <= 500; x += 50){
 ST7735_drawCircle(60, ( 128 /2) + 15 , 42,  ((((255>>3)<<11) | ((0>>2)<<5) | (255>>3))) );
 ST7735_writeInteger(25,  128 /2, x,  ((((0>>3)<<11) | ((255>>2)<<5) | (255>>3))) , 2);
 ST7735_drawString(1, 1, "Reading",  ((((186>>3)<<11) | ((85>>2)<<5) | (211>>3))) , 3);
 Delay_ms(1000);
 ST7735_writeInteger(25,  128 /2, x,  ((((255>>3)<<11) | ((255>>2)<<5) | (255>>3))) , 2);
 if (x >= 500){
 break;
 }
 }
}
#line 349 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
void ST7735_writeInteger(int x, int y, int v, unsigned int colour, int size)
{
 unsigned char buf[8];


 IntToStr(v, buf);

 ST7735_drawString(x, y, buf, colour, size);

}
#line 365 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I01_ST7735/ST7735.c"
void setAddrWindow(unsigned char x0, unsigned char y0, unsigned char x1, unsigned char y1)
{
 ST7735_WriteCommand( 0x2A );
 ST7735_WriteData(0x00);
 ST7735_WriteData(x0+0);
 ST7735_WriteData(0x00);
 ST7735_WriteData(x1+0);

 ST7735_WriteCommand( 0x2B );
 ST7735_WriteData(0x00);
 ST7735_WriteData(y0+0);
 ST7735_WriteData(0x00);
 ST7735_WriteData(y1+0);

 ST7735_WriteCommand( 0x2C );
}

void ST7735_pushColor(unsigned int color)
{
 ST7735_RS = 1;
 ST7735_CS = 0;
 SPI1_Write(color >> 8);
 SPI1_Write(color);
 ST7735_CS = 1;
}

 void ST7735_drawPixel(unsigned char x, unsigned char y, unsigned int color)
{
 setAddrWindow(x, y, x+1, y+1);

 ST7735_RS = 1;
 ST7735_CS = 0;

 SPI1_Write(color >> 8);
 SPI1_Write(color);

 ST7735_CS = 1;
}

void ST7735_fillScreen(unsigned int color)
{
 unsigned char x;
 unsigned char y;

 setAddrWindow(0, 0,  128 -1,  160 -1);


 ST7735_RS = 1;
 ST7735_CS = 0;

 colorB = color >> 8;

 for (x=0; x <  128 ; x++) {
 for (y=0; y <  160 ; y++) {
 SPI1_Write(colorB);
 SPI1_Write(color);
 }
 }

 ST7735_CS = 1;
}

 void ST7735_drawChar(unsigned char x, unsigned char y, char c, unsigned int color, unsigned char size)
{
 unsigned char i, j;

 unsigned char letter = c < 0x52 ? c - 0x20 : c - 0x52;
 for (i =0; i<5; i++ ) {
 unsigned char line = c < 0x52 ? Alpha1[letter*5+i] : Alpha2[letter*5+i];

 for (j = 0; j<8; j++) {
 if (line & 0x1) {
 if (size == 1)
 ST7735_drawPixel(x+i, y+j, color);
 else {
 ST7735_fillRect(x+i*size, y+j*size, size, size, color);
 }
 }
 line >>= 1;
 }
 }
}

void ST7735_drawString(unsigned char x, unsigned char y, char *c, unsigned int color, unsigned char size)
{
 while (c[0] != 0) {
 ST7735_drawChar(x, y, c[0], color, size);
 x += size*6;
 c++;
 if (x + 5 >=  128 ) {
 y += 10;
 x = 0;
 }
 }
}



void ST7735_fillCircle(unsigned char x0, unsigned char y0, unsigned char r, unsigned int color) {
 int f = 1 - r;
 int ddF_x = 1;
 int ddF_y = -2 * r;
 int x = 0;
 int y = r;

 ST7735_drawVerticalLine(x0, y0-r, 2*r+1, color);

 while (x<y) {
 if (f >= 0) {
 y--;
 ddF_y += 2;
 f += ddF_y;
 }
 x++;
 ddF_x += 2;
 f += ddF_x;

 ST7735_drawVerticalLine(x0+x, y0-y, 2*y+1, color);
 ST7735_drawVerticalLine(x0-x, y0-y, 2*y+1, color);
 ST7735_drawVerticalLine(x0+y, y0-x, 2*x+1, color);
 ST7735_drawVerticalLine(x0-y, y0-x, 2*x+1, color);
 }
}


void ST7735_drawCircle(unsigned char x0, unsigned char y0, unsigned char r, unsigned int color) {
 int f = 1 - r;
 int ddF_x = 1;
 int ddF_y = -2 * r;
 int x = 0;
 int y = r;

 ST7735_drawPixel(x0, y0+r, color);
 ST7735_drawPixel(x0, y0-r, color);
 ST7735_drawPixel(x0+r, y0, color);
 ST7735_drawPixel(x0-r, y0, color);

 while (x<y) {
 if (f >= 0) {
 y--;
 ddF_y += 2;
 f += ddF_y;
 }
 x++;
 ddF_x += 2;
 f += ddF_x;

 ST7735_drawPixel(x0 + x, y0 + y, color);
 ST7735_drawPixel(x0 - x, y0 + y, color);
 ST7735_drawPixel(x0 + x, y0 - y, color);
 ST7735_drawPixel(x0 - x, y0 - y, color);

 ST7735_drawPixel(x0 + y, y0 + x, color);
 ST7735_drawPixel(x0 - y, y0 + x, color);
 ST7735_drawPixel(x0 + y, y0 - x, color);
 ST7735_drawPixel(x0 - y, y0 - x, color);

 }
}

unsigned char ST7735_getRotation() {
 return madctl;
}

void ST7735_setRotation(unsigned char m) {
 madctl = m;
 ST7735_WriteCommand( 0x36 );
 ST7735_WriteData(madctl);
}


void ST7735_drawRect(unsigned char x, unsigned char y, unsigned char w, unsigned char h,
unsigned int color) {

 ST7735_drawHorizontalLine(x, y, w, color);
 ST7735_drawHorizontalLine(x, y+h-1, w, color);
 ST7735_drawVerticalLine(x, y, h, color);
 ST7735_drawVerticalLine(x+w-1, y, h, color);
}

void ST7735_fillRect(unsigned char x, unsigned char y, unsigned char w, unsigned char h,
unsigned int color) {


 setAddrWindow(x, y, x+w-1, y+h-1);


 ST7735_RS = 1;
 ST7735_CS = 0;

 colorB = color >> 8;
 for (x=0; x < w; x++) {
 for (y=0; y < h; y++) {
 SPI1_Write(colorB);
 SPI1_Write(color);
 }
 }

 ST7735_CS = 1;
}

void ST7735_drawVerticalLine(unsigned char x, unsigned char y, unsigned char length, unsigned int color)
{
 if (x >=  128 ) return;
 if (y+length >=  160 ) length =  160 -y-1;

 ST7735_drawFastLine(x,y,length,color,1);
}

void ST7735_drawHorizontalLine(unsigned char x, unsigned char y, unsigned char length, unsigned int color)
{
 if (y >=  160 ) return;
 if (x+length >=  128 ) length =  128 -x-1;

 ST7735_drawFastLine(x,y,length,color,0);
}

void ST7735_drawFastLine(unsigned char x, unsigned char y, unsigned char length,
unsigned int color, unsigned char rotflag)
{
 if (rotflag) {
 setAddrWindow(x, y, x, y+length);
 } else {
 setAddrWindow(x, y, x+length, y+1);
 }

 ST7735_RS = 1;
 ST7735_CS = 0;

 colorB = color >> 8;
 while (length--) {
 SPI1_Write(colorB);
 SPI1_Write(color);
 }
 ST7735_CS = 1;
}

int abs(int val)
{
 return (val > 0) ? val : -val;
}


void ST7735_drawLine(int x0, int y0, int x1, int y1,
unsigned int color) {
 unsigned int steep = abs(y1 - y0) > abs(x1 - x0);
 if (steep) {
  { int t = x0; x0 = y0; y0 = t; } ;
  { int t = x1; x1 = y1; y1 = t; } ;
 }

 if (x0 > x1) {
  { int t = x0; x0 = x1; x1 = t; } ;
  { int t = y0; y0 = y1; y1 = t; } ;
 }


 dx = x1 - x0;
 dy = abs(y1 - y0);

 err = dx / 2;
 ystep;

 if (y0 < y1) {
 ystep = 1;
 } else {
 ystep = -1;}

 for (; x0<=x1; x0++) {
 if (steep) {
 ST7735_drawPixel(y0, x0, color);
 } else {
 ST7735_drawPixel(x0, y0, color);
 }
 err -= dy;
 if (err < 0) {
 y0 += ystep;
 err += dx;
 }
 }
}
