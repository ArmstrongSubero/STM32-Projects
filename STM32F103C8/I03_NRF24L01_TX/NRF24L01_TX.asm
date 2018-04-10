_Clear_Data:
;NRF24L01_TX.c,42 :: 		void Clear_Data(char dat[])
; dat start address is: 0 (R0)
; dat end address is: 0 (R0)
; dat start address is: 0 (R0)
;NRF24L01_TX.c,45 :: 		for(i=0;i<dataLength;i++)dat[i] = ' ';
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_Clear_Data0:
; i start address is: 12 (R3)
; dat start address is: 0 (R0)
; dat end address is: 0 (R0)
MOVW	R1, #lo_addr(_dataLength+0)
MOVT	R1, #hi_addr(_dataLength+0)
LDRSB	R1, [R1, #0]
CMP	R3, R1
IT	GE
BGE	L_Clear_Data1
; dat end address is: 0 (R0)
; dat start address is: 0 (R0)
ADDS	R2, R0, R3
MOVS	R1, #32
STRB	R1, [R2, #0]
ADDS	R3, R3, #1
UXTB	R3, R3
; dat end address is: 0 (R0)
; i end address is: 12 (R3)
IT	AL
BAL	L_Clear_Data0
L_Clear_Data1:
;NRF24L01_TX.c,46 :: 		}
L_end_Clear_Data:
BX	LR
; end of _Clear_Data
_toggleCSN:
;NRF24L01_TX.c,48 :: 		void toggleCSN()
;NRF24L01_TX.c,50 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,51 :: 		Delay_us(20);                      // You can experiment with this delay
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_toggleCSN3:
SUBS	R7, R7, #1
BNE	L_toggleCSN3
NOP
NOP
NOP
;NRF24L01_TX.c,52 :: 		Csn_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,53 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_toggleCSN5:
SUBS	R7, R7, #1
BNE	L_toggleCSN5
NOP
NOP
NOP
;NRF24L01_TX.c,54 :: 		}
L_end_toggleCSN:
BX	LR
; end of _toggleCSN
_Get_Status:
;NRF24L01_TX.c,56 :: 		char Get_Status()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NRF24L01_TX.c,59 :: 		Ce_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,60 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,61 :: 		SPI1_Write(STATUS);
MOVS	R0, #7
BL	_SPI1_Write+0
;NRF24L01_TX.c,62 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_Get_Status7:
SUBS	R7, R7, #1
BNE	L_Get_Status7
NOP
NOP
NOP
;NRF24L01_TX.c,63 :: 		s = SPI1_Read(NOP);
MOVS	R0, #255
BL	_SPI1_Read+0
; s start address is: 8 (R2)
UXTB	R2, R0
;NRF24L01_TX.c,64 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_Get_Status9:
SUBS	R7, R7, #1
BNE	L_Get_Status9
NOP
NOP
NOP
;NRF24L01_TX.c,65 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,66 :: 		return s;
UXTB	R0, R2
; s end address is: 8 (R2)
;NRF24L01_TX.c,67 :: 		}
L_end_Get_Status:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Get_Status
_getConst:
;NRF24L01_TX.c,69 :: 		char *getConst(char dest[], const char source[])
; source start address is: 4 (R1)
; dest start address is: 0 (R0)
MOV	R2, R1
MOV	R1, R0
; source end address is: 4 (R1)
; dest end address is: 0 (R0)
; dest start address is: 4 (R1)
; source start address is: 8 (R2)
;NRF24L01_TX.c,71 :: 		int i = 0;
; i start address is: 0 (R0)
MOVW	R0, #0
SXTH	R0, R0
; source end address is: 8 (R2)
; i end address is: 0 (R0)
; dest end address is: 4 (R1)
SXTH	R4, R0
MOV	R0, R2
;NRF24L01_TX.c,72 :: 		while (source[i])                  // while (source[i] != '\0')
L_getConst11:
; i start address is: 16 (R4)
; source start address is: 0 (R0)
; dest start address is: 4 (R1)
ADDS	R2, R0, R4
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_getConst12
;NRF24L01_TX.c,73 :: 		{dest[i] = source[i]; i++;}
ADDS	R3, R1, R4
ADDS	R2, R0, R4
LDRB	R2, [R2, #0]
STRB	R2, [R3, #0]
ADDS	R4, R4, #1
SXTH	R4, R4
; source end address is: 0 (R0)
IT	AL
BAL	L_getConst11
L_getConst12:
;NRF24L01_TX.c,74 :: 		dest[i] = '\0';
ADDS	R3, R1, R4
; i end address is: 16 (R4)
MOVS	R2, #0
STRB	R2, [R3, #0]
;NRF24L01_TX.c,75 :: 		return dest;
MOV	R0, R1
; dest end address is: 4 (R1)
;NRF24L01_TX.c,76 :: 		}
L_end_getConst:
BX	LR
; end of _getConst
_Get_FIFO_Flags:
;NRF24L01_TX.c,78 :: 		char Get_FIFO_Flags()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NRF24L01_TX.c,81 :: 		Ce_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,82 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,83 :: 		SPI1_Write(FIFO_STATUS);
MOVS	R0, #23
BL	_SPI1_Write+0
;NRF24L01_TX.c,84 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_Get_FIFO_Flags13:
SUBS	R7, R7, #1
BNE	L_Get_FIFO_Flags13
NOP
NOP
NOP
;NRF24L01_TX.c,85 :: 		s = SPI1_Read(NOP);
MOVS	R0, #255
BL	_SPI1_Read+0
; s start address is: 8 (R2)
UXTB	R2, R0
;NRF24L01_TX.c,86 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_Get_FIFO_Flags15:
SUBS	R7, R7, #1
BNE	L_Get_FIFO_Flags15
NOP
NOP
NOP
;NRF24L01_TX.c,87 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,88 :: 		return s;
UXTB	R0, R2
; s end address is: 8 (R2)
;NRF24L01_TX.c,89 :: 		}
L_end_Get_FIFO_Flags:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Get_FIFO_Flags
_makeMsg:
;NRF24L01_TX.c,91 :: 		void makeMsg(char* msg)
; msg start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R0
; msg end address is: 0 (R0)
; msg start address is: 16 (R4)
;NRF24L01_TX.c,93 :: 		Clear_Data(Data_Out);
MOVW	R0, #lo_addr(_Data_Out+0)
MOVT	R0, #hi_addr(_Data_Out+0)
BL	_Clear_Data+0
;NRF24L01_TX.c,94 :: 		getConst(Data_Out, msg);
MOV	R1, R4
; msg end address is: 16 (R4)
MOVW	R0, #lo_addr(_Data_Out+0)
MOVT	R0, #hi_addr(_Data_Out+0)
BL	_getConst+0
;NRF24L01_TX.c,95 :: 		}
L_end_makeMsg:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _makeMsg
_readBuffer:
;NRF24L01_TX.c,97 :: 		char readBuffer()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;NRF24L01_TX.c,100 :: 		Ce_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,101 :: 		Clear_Data(Data_In);
MOVW	R0, #lo_addr(_Data_In+0)
MOVT	R0, #hi_addr(_Data_In+0)
BL	_Clear_Data+0
;NRF24L01_TX.c,102 :: 		s = Get_FIFO_Flags();
BL	_Get_FIFO_Flags+0
; s start address is: 20 (R5)
UXTB	R5, R0
;NRF24L01_TX.c,103 :: 		if((s & 2) != 0){
AND	R0, R0, #2
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__readBuffer91
;NRF24L01_TX.c,104 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,105 :: 		SPI1_Write(R_RX_PAYLOAD);
MOVS	R0, #97
BL	_SPI1_Write+0
;NRF24L01_TX.c,106 :: 		for(i=0; i < dataLength; i++){Delay_us(10); Data_In[i] = SPI1_Read(0);}
; i start address is: 16 (R4)
MOVS	R4, #0
; s end address is: 20 (R5)
; i end address is: 16 (R4)
L_readBuffer18:
; i start address is: 16 (R4)
; s start address is: 20 (R5)
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R0, [R0, #0]
CMP	R4, R0
IT	GE
BGE	L_readBuffer19
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_readBuffer21:
SUBS	R7, R7, #1
BNE	L_readBuffer21
NOP
NOP
NOP
MOVW	R0, #lo_addr(_Data_In+0)
MOVT	R0, #hi_addr(_Data_In+0)
ADDS	R0, R0, R4
STR	R0, [SP, #4]
MOVS	R0, #0
BL	_SPI1_Read+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
ADDS	R4, R4, #1
UXTB	R4, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_readBuffer18
L_readBuffer19:
;NRF24L01_TX.c,107 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_readBuffer23:
SUBS	R7, R7, #1
BNE	L_readBuffer23
NOP
NOP
NOP
; s end address is: 20 (R5)
UXTB	R2, R5
;NRF24L01_TX.c,108 :: 		}
IT	AL
BAL	L_readBuffer17
L__readBuffer91:
;NRF24L01_TX.c,103 :: 		if((s & 2) != 0){
UXTB	R2, R5
;NRF24L01_TX.c,108 :: 		}
L_readBuffer17:
;NRF24L01_TX.c,109 :: 		Csn_pin = 1;
; s start address is: 8 (R2)
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,110 :: 		Ce_pin = 1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,111 :: 		return s;
UXTB	R0, R2
; s end address is: 8 (R2)
;NRF24L01_TX.c,112 :: 		}
L_end_readBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _readBuffer
_sendBuffer:
;NRF24L01_TX.c,114 :: 		void sendBuffer()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;NRF24L01_TX.c,117 :: 		do{
L_sendBuffer25:
;NRF24L01_TX.c,118 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,119 :: 		SPI1_Write(STATUS | W_REGISTER);
MOVS	R0, #39
BL	_SPI1_Write+0
;NRF24L01_TX.c,120 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_sendBuffer28:
SUBS	R7, R7, #1
BNE	L_sendBuffer28
NOP
NOP
NOP
;NRF24L01_TX.c,121 :: 		SPI1_Write(0xff);            //clear flags
MOVS	R0, #255
BL	_SPI1_Write+0
;NRF24L01_TX.c,122 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_sendBuffer30:
SUBS	R7, R7, #1
BNE	L_sendBuffer30
NOP
NOP
NOP
;NRF24L01_TX.c,123 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,124 :: 		SPI1_Write(FLUSH_TX);
MOVS	R0, #225
BL	_SPI1_Write+0
;NRF24L01_TX.c,125 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_sendBuffer32:
SUBS	R7, R7, #1
BNE	L_sendBuffer32
NOP
NOP
NOP
;NRF24L01_TX.c,126 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,127 :: 		SPI1_Write(W_TX_PAYLOAD);
MOVS	R0, #160
BL	_SPI1_Write+0
;NRF24L01_TX.c,128 :: 		for(i = 0; i < dataLength; i++) {Delay_us(10); SPI1_Write(Data_Out[i]);}
MOVS	R0, #0
STRB	R0, [SP, #4]
L_sendBuffer34:
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R1, [R0, #0]
LDRB	R0, [SP, #4]
CMP	R0, R1
IT	GE
BGE	L_sendBuffer35
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_sendBuffer37:
SUBS	R7, R7, #1
BNE	L_sendBuffer37
NOP
NOP
NOP
LDRB	R1, [SP, #4]
MOVW	R0, #lo_addr(_Data_Out+0)
MOVT	R0, #hi_addr(_Data_Out+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
BL	_SPI1_Write+0
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
IT	AL
BAL	L_sendBuffer34
L_sendBuffer35:
;NRF24L01_TX.c,129 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_sendBuffer39:
SUBS	R7, R7, #1
BNE	L_sendBuffer39
NOP
NOP
NOP
;NRF24L01_TX.c,130 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,131 :: 		Ce_pin = 1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,132 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_sendBuffer41:
SUBS	R7, R7, #1
BNE	L_sendBuffer41
NOP
NOP
NOP
;NRF24L01_TX.c,133 :: 		j = (Get_Status() & 0x20);                     // keep trying until ack is received
BL	_Get_Status+0
AND	R0, R0, #32
UXTB	R0, R0
;NRF24L01_TX.c,134 :: 		}while(j==0);
CMP	R0, #0
IT	EQ
BEQ	L_sendBuffer25
;NRF24L01_TX.c,135 :: 		}
L_end_sendBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _sendBuffer
_init_Radio:
;NRF24L01_TX.c,137 :: 		char init_Radio()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NRF24L01_TX.c,140 :: 		Ce_pin = 0;                                      // must be in standby or power down to write
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,141 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio43:
SUBS	R7, R7, #1
BNE	L_init_Radio43
NOP
NOP
NOP
;NRF24L01_TX.c,142 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,143 :: 		SPI1_Write(CONFIG | W_REGISTER);
MOVS	R0, #32
BL	_SPI1_Write+0
;NRF24L01_TX.c,144 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio45:
SUBS	R7, R7, #1
BNE	L_init_Radio45
NOP
NOP
NOP
;NRF24L01_TX.c,163 :: 		SPI1_Write(PWR_UP + CRCO + EN_CRC);              // Transmitter
MOVW	R0, #14
BL	_SPI1_Write+0
;NRF24L01_TX.c,164 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio47:
SUBS	R7, R7, #1
BNE	L_init_Radio47
NOP
NOP
NOP
;NRF24L01_TX.c,166 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,167 :: 		SPI1_Write(EN_AA | W_REGISTER);
MOVS	R0, #33
BL	_SPI1_Write+0
;NRF24L01_TX.c,168 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio49:
SUBS	R7, R7, #1
BNE	L_init_Radio49
NOP
NOP
NOP
;NRF24L01_TX.c,169 :: 		SPI1_Write(ENAA_P0);
MOVS	R0, #1
BL	_SPI1_Write+0
;NRF24L01_TX.c,170 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio51:
SUBS	R7, R7, #1
BNE	L_init_Radio51
NOP
NOP
NOP
;NRF24L01_TX.c,172 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,173 :: 		SPI1_Write(EN_RXADDR | W_REGISTER);
MOVS	R0, #34
BL	_SPI1_Write+0
;NRF24L01_TX.c,174 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio53:
SUBS	R7, R7, #1
BNE	L_init_Radio53
NOP
NOP
NOP
;NRF24L01_TX.c,175 :: 		SPI1_Write(ERX_P0);
MOVS	R0, #1
BL	_SPI1_Write+0
;NRF24L01_TX.c,176 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio55:
SUBS	R7, R7, #1
BNE	L_init_Radio55
NOP
NOP
NOP
;NRF24L01_TX.c,178 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,179 :: 		SPI1_Write(RX_ADDR_P0 | W_REGISTER);
MOVS	R0, #42
BL	_SPI1_Write+0
;NRF24L01_TX.c,180 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr0[i]);} // This is the pipe in use by this transmitter
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio57:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio58
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio60:
SUBS	R7, R7, #1
BNE	L_init_Radio60
NOP
NOP
NOP
MOVW	R0, #lo_addr(_adr0+0)
MOVT	R0, #hi_addr(_adr0+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_SPI1_Write+0
ADDS	R4, R4, #1
UXTB	R4, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_init_Radio57
L_init_Radio58:
;NRF24L01_TX.c,181 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio62:
SUBS	R7, R7, #1
BNE	L_init_Radio62
NOP
NOP
NOP
;NRF24L01_TX.c,183 :: 		toggleCSN();                                         // Choose any of the 6 addresses used by the receiver
BL	_toggleCSN+0
;NRF24L01_TX.c,184 :: 		SPI1_Write(TX_ADDR | W_REGISTER);
MOVS	R0, #48
BL	_SPI1_Write+0
;NRF24L01_TX.c,185 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr0[i]);} // This is the pipe in use by this transmitter
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio64:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio65
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio67:
SUBS	R7, R7, #1
BNE	L_init_Radio67
NOP
NOP
NOP
MOVW	R0, #lo_addr(_adr0+0)
MOVT	R0, #hi_addr(_adr0+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_SPI1_Write+0
ADDS	R4, R4, #1
UXTB	R4, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_init_Radio64
L_init_Radio65:
;NRF24L01_TX.c,186 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio69:
SUBS	R7, R7, #1
BNE	L_init_Radio69
NOP
NOP
NOP
;NRF24L01_TX.c,189 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,190 :: 		SPI1_Write(SETUP_AW | W_REGISTER);
MOVS	R0, #35
BL	_SPI1_Write+0
;NRF24L01_TX.c,191 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio71:
SUBS	R7, R7, #1
BNE	L_init_Radio71
NOP
NOP
NOP
;NRF24L01_TX.c,192 :: 		SPI1_Write(AW5);
MOVS	R0, #3
BL	_SPI1_Write+0
;NRF24L01_TX.c,193 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio73:
SUBS	R7, R7, #1
BNE	L_init_Radio73
NOP
NOP
NOP
;NRF24L01_TX.c,195 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,196 :: 		SPI1_Write(SETUP_RETR | W_REGISTER);
MOVS	R0, #36
BL	_SPI1_Write+0
;NRF24L01_TX.c,197 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio75:
SUBS	R7, R7, #1
BNE	L_init_Radio75
NOP
NOP
NOP
;NRF24L01_TX.c,198 :: 		SPI1_Write(0xfaf);
MOVW	R0, #4015
BL	_SPI1_Write+0
;NRF24L01_TX.c,199 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio77:
SUBS	R7, R7, #1
BNE	L_init_Radio77
NOP
NOP
NOP
;NRF24L01_TX.c,201 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,202 :: 		SPI1_Write(RF_CH | W_REGISTER);
MOVS	R0, #37
BL	_SPI1_Write+0
;NRF24L01_TX.c,203 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio79:
SUBS	R7, R7, #1
BNE	L_init_Radio79
NOP
NOP
NOP
;NRF24L01_TX.c,204 :: 		SPI1_Write(83);                                      // Set your channel here. Obviously it must be the same for TX and RX.
MOVS	R0, #83
BL	_SPI1_Write+0
;NRF24L01_TX.c,205 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio81:
SUBS	R7, R7, #1
BNE	L_init_Radio81
NOP
NOP
NOP
;NRF24L01_TX.c,207 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,208 :: 		SPI1_Write(RF_SETUP | W_REGISTER);
MOVS	R0, #38
BL	_SPI1_Write+0
;NRF24L01_TX.c,209 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio83:
SUBS	R7, R7, #1
BNE	L_init_Radio83
NOP
NOP
NOP
;NRF24L01_TX.c,210 :: 		SPI1_Write(RF_PWR + LNA_HCURR);
MOVW	R0, #7
BL	_SPI1_Write+0
;NRF24L01_TX.c,211 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio85:
SUBS	R7, R7, #1
BNE	L_init_Radio85
NOP
NOP
NOP
;NRF24L01_TX.c,280 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_TX.c,281 :: 		SPI1_Write(RX_PW_P0 | W_REGISTER);
MOVS	R0, #49
BL	_SPI1_Write+0
;NRF24L01_TX.c,282 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio87:
SUBS	R7, R7, #1
BNE	L_init_Radio87
NOP
NOP
NOP
;NRF24L01_TX.c,283 :: 		SPI1_Write(dataLength);
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R0, [R0, #0]
BL	_SPI1_Write+0
;NRF24L01_TX.c,284 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio89:
SUBS	R7, R7, #1
BNE	L_init_Radio89
NOP
NOP
NOP
;NRF24L01_TX.c,286 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_TX.c,287 :: 		i = Get_Status();
BL	_Get_Status+0
;NRF24L01_TX.c,288 :: 		return i;
;NRF24L01_TX.c,289 :: 		}
L_end_init_Radio:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_Radio
