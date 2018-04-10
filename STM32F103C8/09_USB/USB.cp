#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/10_USB/USB.c"
char readbuff[64];
char writebuff[64];

int count = 0;

void USB0Interrupt() iv IVT_INT_USB_LP_CAN_RX0
{
 USB_Interrupt_Proc();
}

void main(void){
 unsigned char n_byte;


 GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_9);
 GPIOA_ODR=0;


 HID_Enable(&readbuff,&writebuff);

 while(1)
 {

 n_byte= HID_Read();
 if(n_byte !=0)
 {

 if(readbuff[0]=='b')
 {
 GPIOA_ODR.B9=1;
 }


 if(readbuff[0]=='t')
 {
 GPIOA_ODR.B9=0;
 }


 writebuff[0]=count;
 HID_Write(&writebuff,64);


 count++;


 if (count == 255)
 {
 count = 0;
 }
 }
 }
}
