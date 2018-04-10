#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I03_NRF24L01_TX/main.c"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i03_nrf24l01_tx/nrf24l01_tx.h"
#line 122 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i03_nrf24l01_tx/nrf24l01_tx.h"
char init_Radio();
void sendBuffer();
char readBuffer();
void makeMsg(char* msg);
char Get_FIFO_Flags();
char *getConst(char dest[], const char source[]);
char Get_Status();
void toggleCSN();
void Clear_Data(char dat[]);
#line 32 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I03_NRF24L01_TX/main.c"
char Data_In[21];
char Data_Out[21];
char stat;
int count;
char txt[3];

void initMain()
{
 SPI1_Init();
 Delay_ms(100);

 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_13);
 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_14);
 GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_15);

 GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);
}

void main()
{
 initMain();
 stat = init_Radio();
 Clear_Data(Data_Out);

 while(1)
 {

 for (count = 0; count <= 100; count++)
 {
 GPIOC_ODR.B13 = 1;
 Delay_ms(10);

 IntToStr(count, txt);
 makeMsg(txt);
 sendBuffer();

 GPIOC_ODR.B13 = 0;
 Delay_ms(10);
 }
 }
}
