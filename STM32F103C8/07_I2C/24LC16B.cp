#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/06_I2C/24LC16B.c"

char data_[256];


void EEPROM_24LC16B_Init() {
 I2C1_Init();
}


void EEPROM_24LC16B_WrSingle(unsigned short wAddr, unsigned short wData) {
 data_[0] = wAddr;
 data_[1] = wData;
 I2C1_Start();

 I2C1_Write(0x50,data_,2,END_MODE_STOP);
}


unsigned short EEPROM_24LC16B_RdSingle(unsigned short rAddr) {
 data_[0] = rAddr;
 I2C1_Start();
 I2C1_Write(0x50,data_,1,END_MODE_RESTART);
 I2C1_Read(0x50,data_,1,END_MODE_STOP);

 return data_[0];
}


void EEPROM_24LC16B_RdSeq(unsigned short rAddr,
 unsigned char *rdData,
 unsigned long rLen) {
 data_[0] = rAddr;
 I2C1_Start();
 I2C1_Write(0x50,data_,1,END_MODE_RESTART);
 I2C1_Read(0x50,rdData,rLen,END_MODE_STOP);
}
