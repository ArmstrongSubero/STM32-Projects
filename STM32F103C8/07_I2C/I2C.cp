#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/06_I2C/I2C.c"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/06_i2c/24lc16b.h"


void EEPROM_24LC16B_Init();
void EEPROM_24LC16B_WrSingle(unsigned short wAddr, unsigned short wData);
unsigned short EEPROM_24LC16B_RdSingle(unsigned short rAddr);
void EEPROM_24LC16B_RdSeq(unsigned short rAddr,
 unsigned char *rdData,
 unsigned long rLen);
#line 3 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/06_I2C/I2C.c"
char txt[3];
char ee_addr, wr_data, rd_data;

void initMain()
{

 UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);

 Delay_ms(100);


 I2C1_Init_Advanced(100000, &_GPIO_MODULE_I2C1_PB67);
}

void main()
{
 initMain();

 ee_addr = 10;
 wr_data = 40;

 while(1)
 {
 EEPROM_24LC16B_WrSingle(ee_addr, wr_data);
 Delay_ms(20);

 rd_data = EEPROM_24LC16B_RdSingle(ee_addr);

 IntToStr(rd_data, txt);

 Uart_Write_Text(txt);
 Delay_ms(2000);
 }
}
