//EEPROM 24LC16B read/write library
char data_[256];

//--------------- Performs 24LC16B Init
void EEPROM_24LC16B_Init() {
  I2C1_Init();
}

//--------------- Writes data to 24LC16B EEPROM - signle location
void EEPROM_24LC16B_WrSingle(unsigned short wAddr, unsigned short wData) {
  data_[0] = wAddr;
  data_[1] = wData;
  I2C1_Start();
  // issue I2C start signal
  I2C1_Write(0x50,data_,2,END_MODE_STOP);
}

//--------------- Reads data from 24LC16B EEPROM - single location (random)
unsigned short EEPROM_24LC16B_RdSingle(unsigned short rAddr) {
  data_[0] = rAddr;
  I2C1_Start();              // issue I2C start signal
  I2C1_Write(0x50,data_,1,END_MODE_RESTART);
  I2C1_Read(0x50,data_,1,END_MODE_STOP);

  return data_[0];
}

//--------------- Reads data from 24LC16B EEPROM - sequential read
void EEPROM_24LC16B_RdSeq(unsigned short rAddr,
                        unsigned char *rdData,
                        unsigned long rLen) {
  data_[0] = rAddr;
  I2C1_Start();              // issue I2C start signal
  I2C1_Write(0x50,data_,1,END_MODE_RESTART);
  I2C1_Read(0x50,rdData,rLen,END_MODE_STOP);
}