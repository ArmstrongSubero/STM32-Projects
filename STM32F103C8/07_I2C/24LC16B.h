//EEPROM_24LC16B library header file

void EEPROM_24LC16B_Init();
void EEPROM_24LC16B_WrSingle(unsigned short wAddr, unsigned short wData);
unsigned short EEPROM_24LC16B_RdSingle(unsigned short rAddr);
void EEPROM_24LC16B_RdSeq(unsigned short rAddr,
                        unsigned char *rdData,
                        unsigned long rLen);