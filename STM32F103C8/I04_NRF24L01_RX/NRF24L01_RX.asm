_Clear_Data:
;NRF24L01_RX.c,41 :: 		void Clear_Data(char dat[])
; dat start address is: 0 (R0)
; dat end address is: 0 (R0)
; dat start address is: 0 (R0)
;NRF24L01_RX.c,44 :: 		for(i=0;i<dataLength;i++)dat[i] = ' ';
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
;NRF24L01_RX.c,45 :: 		}
L_end_Clear_Data:
BX	LR
; end of _Clear_Data
_toggleCSN:
;NRF24L01_RX.c,47 :: 		void toggleCSN()
;NRF24L01_RX.c,49 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,50 :: 		Delay_us(20);                      // You can experiment with this delay
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
;NRF24L01_RX.c,51 :: 		Csn_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,52 :: 		Delay_us(10);
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
;NRF24L01_RX.c,53 :: 		}
L_end_toggleCSN:
BX	LR
; end of _toggleCSN
_Get_Status:
;NRF24L01_RX.c,55 :: 		char Get_Status()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NRF24L01_RX.c,58 :: 		Ce_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,59 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,60 :: 		SPI1_Write(STATUS);
MOVS	R0, #7
BL	_SPI1_Write+0
;NRF24L01_RX.c,61 :: 		Delay_us(10);
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
;NRF24L01_RX.c,62 :: 		s = SPI1_Read(NOP);
MOVS	R0, #255
BL	_SPI1_Read+0
; s start address is: 8 (R2)
UXTB	R2, R0
;NRF24L01_RX.c,63 :: 		Delay_us(10);
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
;NRF24L01_RX.c,64 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,65 :: 		return s;
UXTB	R0, R2
; s end address is: 8 (R2)
;NRF24L01_RX.c,66 :: 		}
L_end_Get_Status:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Get_Status
_getConst:
;NRF24L01_RX.c,68 :: 		char *getConst(char dest[], const char source[])
; source start address is: 4 (R1)
; dest start address is: 0 (R0)
MOV	R2, R1
MOV	R1, R0
; source end address is: 4 (R1)
; dest end address is: 0 (R0)
; dest start address is: 4 (R1)
; source start address is: 8 (R2)
;NRF24L01_RX.c,70 :: 		int i = 0;
; i start address is: 0 (R0)
MOVW	R0, #0
SXTH	R0, R0
; source end address is: 8 (R2)
; i end address is: 0 (R0)
; dest end address is: 4 (R1)
SXTH	R4, R0
MOV	R0, R2
;NRF24L01_RX.c,71 :: 		while (source[i])                  // while (source[i] != '\0')
L_getConst11:
; i start address is: 16 (R4)
; source start address is: 0 (R0)
; dest start address is: 4 (R1)
ADDS	R2, R0, R4
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_getConst12
;NRF24L01_RX.c,72 :: 		{dest[i] = source[i]; i++;}
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
;NRF24L01_RX.c,73 :: 		dest[i] = '\0';
ADDS	R3, R1, R4
; i end address is: 16 (R4)
MOVS	R2, #0
STRB	R2, [R3, #0]
;NRF24L01_RX.c,74 :: 		return dest;
MOV	R0, R1
; dest end address is: 4 (R1)
;NRF24L01_RX.c,75 :: 		}
L_end_getConst:
BX	LR
; end of _getConst
_Get_FIFO_Flags:
;NRF24L01_RX.c,77 :: 		char Get_FIFO_Flags()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NRF24L01_RX.c,80 :: 		Ce_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,81 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,82 :: 		SPI1_Write(FIFO_STATUS);
MOVS	R0, #23
BL	_SPI1_Write+0
;NRF24L01_RX.c,83 :: 		Delay_us(10);
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
;NRF24L01_RX.c,84 :: 		s = SPI1_Read(NOP);
MOVS	R0, #255
BL	_SPI1_Read+0
; s start address is: 8 (R2)
UXTB	R2, R0
;NRF24L01_RX.c,85 :: 		Delay_us(10);
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
;NRF24L01_RX.c,86 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,87 :: 		return s;
UXTB	R0, R2
; s end address is: 8 (R2)
;NRF24L01_RX.c,88 :: 		}
L_end_Get_FIFO_Flags:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Get_FIFO_Flags
_readBuffer:
;NRF24L01_RX.c,91 :: 		char readBuffer()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;NRF24L01_RX.c,94 :: 		Ce_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,95 :: 		Clear_Data(Data_In);
MOVW	R0, #lo_addr(_Data_In+0)
MOVT	R0, #hi_addr(_Data_In+0)
BL	_Clear_Data+0
;NRF24L01_RX.c,96 :: 		s = Get_FIFO_Flags();
BL	_Get_FIFO_Flags+0
; s start address is: 20 (R5)
UXTB	R5, R0
;NRF24L01_RX.c,97 :: 		if((s & 2) != 0){
AND	R0, R0, #2
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__readBuffer126
;NRF24L01_RX.c,98 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,99 :: 		SPI1_Write(R_RX_PAYLOAD);
MOVS	R0, #97
BL	_SPI1_Write+0
;NRF24L01_RX.c,100 :: 		for(i=0; i < dataLength; i++){Delay_us(10); Data_In[i] = SPI1_Read(0);}
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
;NRF24L01_RX.c,101 :: 		Delay_us(10);
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
;NRF24L01_RX.c,102 :: 		}
IT	AL
BAL	L_readBuffer17
L__readBuffer126:
;NRF24L01_RX.c,97 :: 		if((s & 2) != 0){
UXTB	R2, R5
;NRF24L01_RX.c,102 :: 		}
L_readBuffer17:
;NRF24L01_RX.c,103 :: 		Csn_pin = 1;
; s start address is: 8 (R2)
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,104 :: 		Ce_pin = 1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,105 :: 		return s;
UXTB	R0, R2
; s end address is: 8 (R2)
;NRF24L01_RX.c,106 :: 		}
L_end_readBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _readBuffer
_init_Radio:
;NRF24L01_RX.c,110 :: 		char init_Radio()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;NRF24L01_RX.c,113 :: 		Ce_pin = 0;                                      // must be in standby or power down to write
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,114 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio25:
SUBS	R7, R7, #1
BNE	L_init_Radio25
NOP
NOP
NOP
;NRF24L01_RX.c,115 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,116 :: 		SPI1_Write(CONFIG | W_REGISTER);
MOVS	R0, #32
BL	_SPI1_Write+0
;NRF24L01_RX.c,117 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio27:
SUBS	R7, R7, #1
BNE	L_init_Radio27
NOP
NOP
NOP
;NRF24L01_RX.c,119 :: 		SPI1_Write(PRIM_RX + PWR_UP + CRCO + EN_CRC);    // Receiver
MOVW	R0, #15
BL	_SPI1_Write+0
;NRF24L01_RX.c,121 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,122 :: 		SPI1_Write(EN_AA | W_REGISTER);
MOVS	R0, #33
BL	_SPI1_Write+0
;NRF24L01_RX.c,123 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio29:
SUBS	R7, R7, #1
BNE	L_init_Radio29
NOP
NOP
NOP
;NRF24L01_RX.c,124 :: 		SPI1_Write(ENAA_P0 + ENAA_P1 + ENAA_P2 + ENAA_P3 + ENAA_P4 + ENAA_P5);
MOVW	R0, #63
BL	_SPI1_Write+0
;NRF24L01_RX.c,125 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio31:
SUBS	R7, R7, #1
BNE	L_init_Radio31
NOP
NOP
NOP
;NRF24L01_RX.c,127 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,128 :: 		SPI1_Write(EN_RXADDR | W_REGISTER);
MOVS	R0, #34
BL	_SPI1_Write+0
;NRF24L01_RX.c,129 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio33:
SUBS	R7, R7, #1
BNE	L_init_Radio33
NOP
NOP
NOP
;NRF24L01_RX.c,130 :: 		SPI1_Write(ERX_P0 + ERX_P1 + ERX_P2 + ERX_P3 + ERX_P4 + ERX_P5);
MOVW	R0, #63
BL	_SPI1_Write+0
;NRF24L01_RX.c,131 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio35:
SUBS	R7, R7, #1
BNE	L_init_Radio35
NOP
NOP
NOP
;NRF24L01_RX.c,133 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,134 :: 		SPI1_Write(SETUP_AW | W_REGISTER);
MOVS	R0, #35
BL	_SPI1_Write+0
;NRF24L01_RX.c,135 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio37:
SUBS	R7, R7, #1
BNE	L_init_Radio37
NOP
NOP
NOP
;NRF24L01_RX.c,136 :: 		SPI1_Write(AW5);
MOVS	R0, #3
BL	_SPI1_Write+0
;NRF24L01_RX.c,137 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio39:
SUBS	R7, R7, #1
BNE	L_init_Radio39
NOP
NOP
NOP
;NRF24L01_RX.c,139 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,140 :: 		SPI1_Write(SETUP_RETR | W_REGISTER);
MOVS	R0, #36
BL	_SPI1_Write+0
;NRF24L01_RX.c,141 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio41:
SUBS	R7, R7, #1
BNE	L_init_Radio41
NOP
NOP
NOP
;NRF24L01_RX.c,142 :: 		SPI1_Write(0xfaf);
MOVW	R0, #4015
BL	_SPI1_Write+0
;NRF24L01_RX.c,143 :: 		Delay_us(10);
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
;NRF24L01_RX.c,145 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,146 :: 		SPI1_Write(RF_CH | W_REGISTER);
MOVS	R0, #37
BL	_SPI1_Write+0
;NRF24L01_RX.c,147 :: 		Delay_us(10);
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
;NRF24L01_RX.c,148 :: 		SPI1_Write(Channel);                                      // Set your channel here.
MOVS	R0, #83
BL	_SPI1_Write+0
;NRF24L01_RX.c,149 :: 		Delay_us(10);
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
;NRF24L01_RX.c,151 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,152 :: 		SPI1_Write(RF_SETUP | W_REGISTER);
MOVS	R0, #38
BL	_SPI1_Write+0
;NRF24L01_RX.c,153 :: 		Delay_us(10);
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
;NRF24L01_RX.c,154 :: 		SPI1_Write(RF_PWR + LNA_HCURR);
MOVW	R0, #7
BL	_SPI1_Write+0
;NRF24L01_RX.c,155 :: 		Delay_us(10);
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
;NRF24L01_RX.c,158 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,159 :: 		SPI1_Write(RX_ADDR_P0 | W_REGISTER);
MOVS	R0, #42
BL	_SPI1_Write+0
;NRF24L01_RX.c,160 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr0[i]);}
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio53:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio54
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio56:
SUBS	R7, R7, #1
BNE	L_init_Radio56
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
BAL	L_init_Radio53
L_init_Radio54:
;NRF24L01_RX.c,161 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio58:
SUBS	R7, R7, #1
BNE	L_init_Radio58
NOP
NOP
NOP
;NRF24L01_RX.c,163 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,164 :: 		SPI1_Write(RX_ADDR_P1 | W_REGISTER);
MOVS	R0, #43
BL	_SPI1_Write+0
;NRF24L01_RX.c,165 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr1[i]);}
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio60:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio61
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio63:
SUBS	R7, R7, #1
BNE	L_init_Radio63
NOP
NOP
NOP
MOVW	R0, #lo_addr(_adr1+0)
MOVT	R0, #hi_addr(_adr1+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_SPI1_Write+0
ADDS	R4, R4, #1
UXTB	R4, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_init_Radio60
L_init_Radio61:
;NRF24L01_RX.c,166 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio65:
SUBS	R7, R7, #1
BNE	L_init_Radio65
NOP
NOP
NOP
;NRF24L01_RX.c,168 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,169 :: 		SPI1_Write(RX_ADDR_P2 | W_REGISTER);
MOVS	R0, #44
BL	_SPI1_Write+0
;NRF24L01_RX.c,170 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr2[i]);}
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio67:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio68
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio70:
SUBS	R7, R7, #1
BNE	L_init_Radio70
NOP
NOP
NOP
MOVW	R0, #lo_addr(_adr2+0)
MOVT	R0, #hi_addr(_adr2+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_SPI1_Write+0
ADDS	R4, R4, #1
UXTB	R4, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_init_Radio67
L_init_Radio68:
;NRF24L01_RX.c,171 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio72:
SUBS	R7, R7, #1
BNE	L_init_Radio72
NOP
NOP
NOP
;NRF24L01_RX.c,173 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,174 :: 		SPI1_Write(RX_ADDR_P3 | W_REGISTER);
MOVS	R0, #45
BL	_SPI1_Write+0
;NRF24L01_RX.c,175 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr3[i]);}
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio74:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio75
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
MOVW	R0, #lo_addr(_adr3+0)
MOVT	R0, #hi_addr(_adr3+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_SPI1_Write+0
ADDS	R4, R4, #1
UXTB	R4, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_init_Radio74
L_init_Radio75:
;NRF24L01_RX.c,176 :: 		Delay_us(10);
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
;NRF24L01_RX.c,178 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,179 :: 		SPI1_Write(RX_ADDR_P4 | W_REGISTER);
MOVS	R0, #46
BL	_SPI1_Write+0
;NRF24L01_RX.c,180 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr4[i]);}
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio81:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio82
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio84:
SUBS	R7, R7, #1
BNE	L_init_Radio84
NOP
NOP
NOP
MOVW	R0, #lo_addr(_adr4+0)
MOVT	R0, #hi_addr(_adr4+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_SPI1_Write+0
ADDS	R4, R4, #1
UXTB	R4, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_init_Radio81
L_init_Radio82:
;NRF24L01_RX.c,181 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio86:
SUBS	R7, R7, #1
BNE	L_init_Radio86
NOP
NOP
NOP
;NRF24L01_RX.c,183 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,184 :: 		SPI1_Write(RX_ADDR_P5 | W_REGISTER);
MOVS	R0, #47
BL	_SPI1_Write+0
;NRF24L01_RX.c,185 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr5[i]);}
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio88:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio89
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio91:
SUBS	R7, R7, #1
BNE	L_init_Radio91
NOP
NOP
NOP
MOVW	R0, #lo_addr(_adr5+0)
MOVT	R0, #hi_addr(_adr5+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
BL	_SPI1_Write+0
ADDS	R4, R4, #1
UXTB	R4, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_init_Radio88
L_init_Radio89:
;NRF24L01_RX.c,186 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio93:
SUBS	R7, R7, #1
BNE	L_init_Radio93
NOP
NOP
NOP
;NRF24L01_RX.c,188 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,189 :: 		SPI1_Write(TX_ADDR | W_REGISTER);
MOVS	R0, #48
BL	_SPI1_Write+0
;NRF24L01_RX.c,190 :: 		for(i=0;i<5;i++){Delay_us(10); SPI1_Write(adr0[i]);}
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_init_Radio95:
; i start address is: 16 (R4)
CMP	R4, #5
IT	CS
BCS	L_init_Radio96
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio98:
SUBS	R7, R7, #1
BNE	L_init_Radio98
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
BAL	L_init_Radio95
L_init_Radio96:
;NRF24L01_RX.c,191 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio100:
SUBS	R7, R7, #1
BNE	L_init_Radio100
NOP
NOP
NOP
;NRF24L01_RX.c,193 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,194 :: 		SPI1_Write(RX_PW_P1 | W_REGISTER);
MOVS	R0, #50
BL	_SPI1_Write+0
;NRF24L01_RX.c,195 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio102:
SUBS	R7, R7, #1
BNE	L_init_Radio102
NOP
NOP
NOP
;NRF24L01_RX.c,196 :: 		SPI1_Write(dataLength);
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R0, [R0, #0]
BL	_SPI1_Write+0
;NRF24L01_RX.c,197 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio104:
SUBS	R7, R7, #1
BNE	L_init_Radio104
NOP
NOP
NOP
;NRF24L01_RX.c,199 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,200 :: 		SPI1_Write(RX_PW_P2 | W_REGISTER);
MOVS	R0, #51
BL	_SPI1_Write+0
;NRF24L01_RX.c,201 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio106:
SUBS	R7, R7, #1
BNE	L_init_Radio106
NOP
NOP
NOP
;NRF24L01_RX.c,202 :: 		SPI1_Write(dataLength);
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R0, [R0, #0]
BL	_SPI1_Write+0
;NRF24L01_RX.c,203 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio108:
SUBS	R7, R7, #1
BNE	L_init_Radio108
NOP
NOP
NOP
;NRF24L01_RX.c,205 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,206 :: 		SPI1_Write(RX_PW_P3 | W_REGISTER);
MOVS	R0, #52
BL	_SPI1_Write+0
;NRF24L01_RX.c,207 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio110:
SUBS	R7, R7, #1
BNE	L_init_Radio110
NOP
NOP
NOP
;NRF24L01_RX.c,208 :: 		SPI1_Write(dataLength);
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R0, [R0, #0]
BL	_SPI1_Write+0
;NRF24L01_RX.c,209 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio112:
SUBS	R7, R7, #1
BNE	L_init_Radio112
NOP
NOP
NOP
;NRF24L01_RX.c,211 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,212 :: 		SPI1_Write(RX_PW_P4 | W_REGISTER);
MOVS	R0, #53
BL	_SPI1_Write+0
;NRF24L01_RX.c,213 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio114:
SUBS	R7, R7, #1
BNE	L_init_Radio114
NOP
NOP
NOP
;NRF24L01_RX.c,214 :: 		SPI1_Write(dataLength);
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R0, [R0, #0]
BL	_SPI1_Write+0
;NRF24L01_RX.c,215 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio116:
SUBS	R7, R7, #1
BNE	L_init_Radio116
NOP
NOP
NOP
;NRF24L01_RX.c,217 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,218 :: 		SPI1_Write(RX_PW_P5 | W_REGISTER);
MOVS	R0, #54
BL	_SPI1_Write+0
;NRF24L01_RX.c,219 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio118:
SUBS	R7, R7, #1
BNE	L_init_Radio118
NOP
NOP
NOP
;NRF24L01_RX.c,220 :: 		SPI1_Write(dataLength);
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R0, [R0, #0]
BL	_SPI1_Write+0
;NRF24L01_RX.c,221 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio120:
SUBS	R7, R7, #1
BNE	L_init_Radio120
NOP
NOP
NOP
;NRF24L01_RX.c,224 :: 		toggleCSN();
BL	_toggleCSN+0
;NRF24L01_RX.c,225 :: 		SPI1_Write(RX_PW_P0 | W_REGISTER);
MOVS	R0, #49
BL	_SPI1_Write+0
;NRF24L01_RX.c,226 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio122:
SUBS	R7, R7, #1
BNE	L_init_Radio122
NOP
NOP
NOP
;NRF24L01_RX.c,227 :: 		SPI1_Write(dataLength);
MOVW	R0, #lo_addr(_dataLength+0)
MOVT	R0, #hi_addr(_dataLength+0)
LDRSB	R0, [R0, #0]
BL	_SPI1_Write+0
;NRF24L01_RX.c,228 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_init_Radio124:
SUBS	R7, R7, #1
BNE	L_init_Radio124
NOP
NOP
NOP
;NRF24L01_RX.c,230 :: 		Csn_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;NRF24L01_RX.c,231 :: 		i = Get_Status();
BL	_Get_Status+0
;NRF24L01_RX.c,232 :: 		return i;
;NRF24L01_RX.c,233 :: 		}
L_end_init_Radio:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_Radio
