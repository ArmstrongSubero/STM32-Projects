_EEPROM_24LC16B_Init:
;24LC16B.c,5 :: 		void EEPROM_24LC16B_Init() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;24LC16B.c,6 :: 		I2C1_Init();
BL	_I2C1_Init+0
;24LC16B.c,7 :: 		}
L_end_EEPROM_24LC16B_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EEPROM_24LC16B_Init
_EEPROM_24LC16B_WrSingle:
;24LC16B.c,10 :: 		void EEPROM_24LC16B_WrSingle(unsigned short wAddr, unsigned short wData) {
; wData start address is: 4 (R1)
; wAddr start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; wData end address is: 4 (R1)
; wAddr end address is: 0 (R0)
; wAddr start address is: 0 (R0)
; wData start address is: 4 (R1)
;24LC16B.c,11 :: 		data_[0] = wAddr;
MOVW	R2, #lo_addr(_data_+0)
MOVT	R2, #hi_addr(_data_+0)
STRB	R0, [R2, #0]
; wAddr end address is: 0 (R0)
;24LC16B.c,12 :: 		data_[1] = wData;
MOVW	R2, #lo_addr(_data_+1)
MOVT	R2, #hi_addr(_data_+1)
STRB	R1, [R2, #0]
; wData end address is: 4 (R1)
;24LC16B.c,13 :: 		I2C1_Start();
BL	_I2C1_Start+0
;24LC16B.c,15 :: 		I2C1_Write(0x50,data_,2,END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #2
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #80
BL	_I2C1_Write+0
;24LC16B.c,16 :: 		}
L_end_EEPROM_24LC16B_WrSingle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EEPROM_24LC16B_WrSingle
_EEPROM_24LC16B_RdSingle:
;24LC16B.c,19 :: 		unsigned short EEPROM_24LC16B_RdSingle(unsigned short rAddr) {
; rAddr start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; rAddr end address is: 0 (R0)
; rAddr start address is: 0 (R0)
;24LC16B.c,20 :: 		data_[0] = rAddr;
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
STRB	R0, [R1, #0]
; rAddr end address is: 0 (R0)
;24LC16B.c,21 :: 		I2C1_Start();              // issue I2C start signal
BL	_I2C1_Start+0
;24LC16B.c,22 :: 		I2C1_Write(0x50,data_,1,END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #80
BL	_I2C1_Write+0
;24LC16B.c,23 :: 		I2C1_Read(0x50,data_,1,END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #1
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #80
BL	_I2C1_Read+0
;24LC16B.c,25 :: 		return data_[0];
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
LDRB	R0, [R1, #0]
;24LC16B.c,26 :: 		}
L_end_EEPROM_24LC16B_RdSingle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EEPROM_24LC16B_RdSingle
_EEPROM_24LC16B_RdSeq:
;24LC16B.c,31 :: 		unsigned long rLen) {
; rAddr start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R1, [SP, #4]
STR	R2, [SP, #8]
; rAddr end address is: 0 (R0)
; rAddr start address is: 0 (R0)
;24LC16B.c,32 :: 		data_[0] = rAddr;
MOVW	R3, #lo_addr(_data_+0)
MOVT	R3, #hi_addr(_data_+0)
STRB	R0, [R3, #0]
; rAddr end address is: 0 (R0)
;24LC16B.c,33 :: 		I2C1_Start();              // issue I2C start signal
BL	_I2C1_Start+0
;24LC16B.c,34 :: 		I2C1_Write(0x50,data_,1,END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_data_+0)
MOVT	R1, #hi_addr(_data_+0)
MOVS	R0, #80
BL	_I2C1_Write+0
;24LC16B.c,35 :: 		I2C1_Read(0x50,rdData,rLen,END_MODE_STOP);
MOVW	R3, #1
LDR	R2, [SP, #8]
LDR	R1, [SP, #4]
MOVS	R0, #80
BL	_I2C1_Read+0
;24LC16B.c,36 :: 		}
L_end_EEPROM_24LC16B_RdSeq:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _EEPROM_24LC16B_RdSeq
