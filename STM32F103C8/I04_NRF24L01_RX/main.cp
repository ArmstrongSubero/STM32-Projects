#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I04_NRF24L01_RX/main.c"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i04_nrf24l01_rx/nrf24l01_rx.h"
#line 123 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i04_nrf24l01_rx/nrf24l01_rx.h"
extern char stat;

void Clear_Data(char dat[]);
void toggleCSN();
char Get_Status();
char *getConst(char dest[], const char source[]);
char Get_FIFO_Flags();
char readBuffer();
char init_Radio();
#line 32 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I04_NRF24L01_RX/main.c"
char Data_In [21];
char Data_Out[21];
char txt[5];
char dat1;

void main()
{
 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);
 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);
 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);

 GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);


 UART1_Init(9600);
 Delay_ms(1000);

 SPI1_Init();
 Delay_ms(200);
 stat = init_Radio();
 Delay_ms(10);

 ByteToHex(stat, txt);
 UART1_Write_Text(stat);
 UART1_Write(13);

 Delay_ms(1000);

 while(1)
 {
 GPIOB_ODR.B15 = 1;

 dat1 = readBuffer();

 if((dat1 & 2) != 0)
 {
 GPIOC_ODR.B13 = 1;
 Delay_ms(10);
 UART1_Write_Text(Data_In);
 UART1_Write(13);
 GPIOC_ODR.B13 = 0;
 Delay_ms(10);
 }

 Delay_ms(500);
 }
}
