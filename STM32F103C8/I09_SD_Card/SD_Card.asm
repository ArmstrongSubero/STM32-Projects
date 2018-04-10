_initSPI:
;SD_Card.c,40 :: 		void initSPI(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SD_Card.c,46 :: 		&_GPIO_MODULE_SPI1_PA567);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PA567+0)
;SD_Card.c,45 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;SD_Card.c,43 :: 		SPI1_Init_Advanced(_SPI_FPCLK_DIV64, _SPI_MASTER  | _SPI_8_BIT |
MOVS	R0, #5
;SD_Card.c,46 :: 		&_GPIO_MODULE_SPI1_PA567);
BL	_SPI1_Init_Advanced+0
;SD_Card.c,47 :: 		}
L_end_initSPI:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initSPI
_initFastSPI:
;SD_Card.c,49 :: 		void initFastSPI(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SD_Card.c,51 :: 		SPI1_CR1 = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(SPI1_CR1+0)
MOVT	R0, #hi_addr(SPI1_CR1+0)
STR	R1, [R0, #0]
;SD_Card.c,57 :: 		&_GPIO_MODULE_SPI1_PA567);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PA567+0)
;SD_Card.c,56 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;SD_Card.c,54 :: 		SPI1_Init_Advanced(_SPI_FPCLK_DIV2, _SPI_MASTER  | _SPI_8_BIT |
MOVS	R0, #0
;SD_Card.c,57 :: 		&_GPIO_MODULE_SPI1_PA567);
BL	_SPI1_Init_Advanced+0
;SD_Card.c,58 :: 		}
L_end_initFastSPI:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initFastSPI
SD_Card_constToVar:
;SD_Card.c,187 :: 		static char* constToVar(char *dst, const char *src)
; src start address is: 4 (R1)
; dst start address is: 0 (R0)
MOV	R2, R1
MOV	R1, R0
; src end address is: 4 (R1)
; dst end address is: 0 (R0)
; dst start address is: 4 (R1)
; src start address is: 8 (R2)
;SD_Card.c,191 :: 		tmp = dst;
; tmp start address is: 0 (R0)
; tmp start address is: 0 (R0)
MOV	R0, R1
; src end address is: 8 (R2)
; tmp end address is: 0 (R0)
; dst end address is: 4 (R1)
MOV	R3, R2
;SD_Card.c,192 :: 		for (;;)
L_SD_Card_constToVar0:
;SD_Card.c,194 :: 		*dst = *src;
; tmp start address is: 0 (R0)
; tmp end address is: 0 (R0)
; src start address is: 12 (R3)
; dst start address is: 4 (R1)
LDRB	R2, [R3, #0]
STRB	R2, [R1, #0]
;SD_Card.c,195 :: 		if (*src == 0) break;
LDRB	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_SD_Card_constToVar3
; tmp end address is: 0 (R0)
; src end address is: 12 (R3)
; dst end address is: 4 (R1)
; tmp start address is: 0 (R0)
IT	AL
BAL	L_SD_Card_constToVar1
L_SD_Card_constToVar3:
;SD_Card.c,196 :: 		src++;
; dst start address is: 4 (R1)
; src start address is: 12 (R3)
ADDS	R3, R3, #1
;SD_Card.c,197 :: 		dst++;
ADDS	R1, R1, #1
;SD_Card.c,198 :: 		}
; src end address is: 12 (R3)
; dst end address is: 4 (R1)
IT	AL
BAL	L_SD_Card_constToVar0
L_SD_Card_constToVar1:
;SD_Card.c,199 :: 		return tmp;
; tmp end address is: 0 (R0)
;SD_Card.c,200 :: 		}
L_end_constToVar:
BX	LR
; end of SD_Card_constToVar
_UART_Write_ConstText:
;SD_Card.c,214 :: 		void UART_Write_ConstText(const char *text)
; text start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; text end address is: 0 (R0)
; text start address is: 0 (R0)
;SD_Card.c,216 :: 		UART_Write_Text(constToVar(uartbuf, text));
MOV	R1, R0
; text end address is: 0 (R0)
MOVW	R0, #lo_addr(_uartbuf+0)
MOVT	R0, #hi_addr(_uartbuf+0)
BL	SD_Card_constToVar+0
BL	_UART_Write_Text+0
;SD_Card.c,217 :: 		}
L_end_UART_Write_ConstText:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UART_Write_ConstText
_main:
;SD_Card.c,224 :: 		void main(void)
;SD_Card.c,231 :: 		&_GPIO_MODULE_USART1_PA9_10);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
;SD_Card.c,230 :: 		UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT,
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
;SD_Card.c,231 :: 		&_GPIO_MODULE_USART1_PA9_10);
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;SD_Card.c,232 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
;SD_Card.c,234 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,235 :: 		UART_Write_ConstText(line);
MOVW	R0, #lo_addr(_line+0)
MOVT	R0, #hi_addr(_line+0)
BL	_UART_Write_ConstText+0
;SD_Card.c,236 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,237 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
NOP
;SD_Card.c,242 :: 		initSPI();
BL	_initSPI+0
;SD_Card.c,249 :: 		err = FAT32_Init();
BL	_FAT32_Init+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,251 :: 		if (err < 0)
CMP	R0, #0
IT	GE
BGE	L_main8
;SD_Card.c,253 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,254 :: 		UART_Write_Text(constToVar(uartbuf, cmdFAIL[0]));
MOVW	R1, #lo_addr(_cmdFAIL+0)
MOVT	R1, #hi_addr(_cmdFAIL+0)
MOVW	R0, #lo_addr(_uartbuf+0)
MOVT	R0, #hi_addr(_uartbuf+0)
BL	SD_Card_constToVar+0
BL	_UART_Write_Text+0
;SD_Card.c,255 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,257 :: 		while(err < 0)  //  ...retry each second
L_main9:
MOVW	R0, #lo_addr(_err+0)
MOVT	R0, #hi_addr(_err+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_main10
;SD_Card.c,259 :: 		err = FAT32_Init();
BL	_FAT32_Init+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,260 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
NOP
;SD_Card.c,261 :: 		}
IT	AL
BAL	L_main9
L_main10:
;SD_Card.c,262 :: 		}
L_main8:
;SD_Card.c,267 :: 		initFastSPI();
BL	_initFastSPI+0
;SD_Card.c,268 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,269 :: 		UART_Write_Text(constToVar(uartbuf, cmdOK[0]));
MOVW	R1, #lo_addr(_cmdOK+0)
MOVT	R1, #hi_addr(_cmdOK+0)
MOVW	R0, #lo_addr(_uartbuf+0)
MOVT	R0, #hi_addr(_uartbuf+0)
BL	SD_Card_constToVar+0
BL	_UART_Write_Text+0
;SD_Card.c,270 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,272 :: 		err = FAT32_Dir();
BL	_FAT32_Dir+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,273 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,288 :: 		fileHandle[0] = FAT32_Open("FILE1.TXT", FILE_WRITE);
MOVW	R0, #lo_addr(?lstr1_SD_Card+0)
MOVT	R0, #hi_addr(?lstr1_SD_Card+0)
MOVS	R1, #2
BL	_FAT32_Open+0
MOVW	R1, #lo_addr(_fileHandle+0)
MOVT	R1, #hi_addr(_fileHandle+0)
STRB	R0, [R1, #0]
;SD_Card.c,289 :: 		fileHandle[1] = FAT32_Open("FILE2.TXT", FILE_APPEND);
MOVW	R0, #lo_addr(?lstr2_SD_Card+0)
MOVT	R0, #hi_addr(?lstr2_SD_Card+0)
MOVS	R1, #4
BL	_FAT32_Open+0
MOVW	R1, #lo_addr(_fileHandle+1)
MOVT	R1, #hi_addr(_fileHandle+1)
STRB	R0, [R1, #0]
;SD_Card.c,290 :: 		fileHandle[2] = FAT32_Open("FILE3.TXT", FILE_APPEND);
MOVW	R0, #lo_addr(?lstr3_SD_Card+0)
MOVT	R0, #hi_addr(?lstr3_SD_Card+0)
MOVS	R1, #4
BL	_FAT32_Open+0
MOVW	R1, #lo_addr(_fileHandle+2)
MOVT	R1, #hi_addr(_fileHandle+2)
STRB	R0, [R1, #0]
;SD_Card.c,291 :: 		fileHandle[3] = FAT32_Open("FILE4.TXT", FILE_APPEND);
MOVW	R0, #lo_addr(?lstr4_SD_Card+0)
MOVT	R0, #hi_addr(?lstr4_SD_Card+0)
MOVS	R1, #4
BL	_FAT32_Open+0
MOVW	R1, #lo_addr(_fileHandle+3)
MOVT	R1, #hi_addr(_fileHandle+3)
STRB	R0, [R1, #0]
;SD_Card.c,293 :: 		if (fileHandle[0] < 0) while(1);
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_main13
L_main14:
IT	AL
BAL	L_main14
L_main13:
;SD_Card.c,294 :: 		if (fileHandle[1] < 0) while(1);
MOVW	R0, #lo_addr(_fileHandle+1)
MOVT	R0, #hi_addr(_fileHandle+1)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_main16
L_main17:
IT	AL
BAL	L_main17
L_main16:
;SD_Card.c,295 :: 		if (fileHandle[2] < 0) while(1);
MOVW	R0, #lo_addr(_fileHandle+2)
MOVT	R0, #hi_addr(_fileHandle+2)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_main19
L_main20:
IT	AL
BAL	L_main20
L_main19:
;SD_Card.c,296 :: 		if (fileHandle[3] < 0) while(1);
MOVW	R0, #lo_addr(_fileHandle+3)
MOVT	R0, #hi_addr(_fileHandle+3)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_main22
L_main23:
IT	AL
BAL	L_main23
L_main22:
;SD_Card.c,299 :: 		for (k = 0; k < 1000; k++)
MOVS	R1, #0
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
STR	R1, [R0, #0]
L_main25:
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
LDR	R0, [R0, #0]
CMP	R0, #1000
IT	CS
BCS	L_main26
;SD_Card.c,301 :: 		err = FAT32_Write(fileHandle[0], wrbuf, sizeof(wrbuf));
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
MOVS	R2, #15
MOVW	R1, #lo_addr(_wrbuf+0)
MOVT	R1, #hi_addr(_wrbuf+0)
BL	_FAT32_Write+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,299 :: 		for (k = 0; k < 1000; k++)
MOVW	R1, #lo_addr(_k+0)
MOVT	R1, #hi_addr(_k+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;SD_Card.c,302 :: 		}
IT	AL
BAL	L_main25
L_main26:
;SD_Card.c,303 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,304 :: 		err = FAT32_Close(fileHandle[0]);
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
BL	_FAT32_Close+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,306 :: 		err = FAT32_Dir();
BL	_FAT32_Dir+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,307 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,309 :: 		fileHandle[0] = FAT32_Open("FILE1.TXT", FILE_READ);
MOVW	R0, #lo_addr(?lstr5_SD_Card+0)
MOVT	R0, #hi_addr(?lstr5_SD_Card+0)
MOVS	R1, #1
BL	_FAT32_Open+0
MOVW	R1, #lo_addr(_fileHandle+0)
MOVT	R1, #hi_addr(_fileHandle+0)
STRB	R0, [R1, #0]
;SD_Card.c,310 :: 		if (fileHandle[0] < 0) while(1);
CMP	R0, #0
IT	GE
BGE	L_main28
L_main29:
IT	AL
BAL	L_main29
L_main28:
;SD_Card.c,312 :: 		err = FAT32_Size("FILE1.TXT", &size);
MOVW	R0, #lo_addr(?lstr6_SD_Card+0)
MOVT	R0, #hi_addr(?lstr6_SD_Card+0)
MOVW	R1, #lo_addr(_size+0)
MOVT	R1, #hi_addr(_size+0)
BL	_FAT32_Size+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,313 :: 		for (k = 0; k < size;)
MOVS	R1, #0
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
STR	R1, [R0, #0]
L_main31:
MOVW	R0, #lo_addr(_size+0)
MOVT	R0, #hi_addr(_size+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_main32
;SD_Card.c,315 :: 		err = FAT32_Read(fileHandle[0], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Read+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,316 :: 		for (cnt = 0; cnt < sizeof(rdbuf); cnt++, k++)
MOVS	R1, #0
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
STRH	R1, [R0, #0]
L_main34:
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R0, [R0, #0]
CMP	R0, #19
IT	CS
BCS	L_main35
;SD_Card.c,318 :: 		if (k < size)
MOVW	R0, #lo_addr(_size+0)
MOVT	R0, #hi_addr(_size+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_main37
;SD_Card.c,320 :: 		UART_Write(rdbuf[cnt]);
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_rdbuf+0)
MOVT	R0, #hi_addr(_rdbuf+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
BL	_UART_Write+0
;SD_Card.c,321 :: 		}
IT	AL
BAL	L_main38
L_main37:
;SD_Card.c,324 :: 		break;
IT	AL
BAL	L_main35
;SD_Card.c,325 :: 		}
L_main38:
;SD_Card.c,316 :: 		for (cnt = 0; cnt < sizeof(rdbuf); cnt++, k++)
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
MOVW	R1, #lo_addr(_k+0)
MOVT	R1, #hi_addr(_k+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;SD_Card.c,326 :: 		}
IT	AL
BAL	L_main34
L_main35:
;SD_Card.c,327 :: 		}
IT	AL
BAL	L_main31
L_main32:
;SD_Card.c,328 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,329 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,332 :: 		FAT32_Seek(fileHandle[0], 0);   // reset file cursor to 0.
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
MOVS	R1, #0
BL	_FAT32_Seek+0
;SD_Card.c,337 :: 		err = FAT32_Read (fileHandle[0], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Read+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,338 :: 		err = FAT32_Write(fileHandle[1], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+1)
MOVT	R0, #hi_addr(_fileHandle+1)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Write+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,339 :: 		err = FAT32_Write(fileHandle[2], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+2)
MOVT	R0, #hi_addr(_fileHandle+2)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Write+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,343 :: 		err = FAT32_Read (fileHandle[0], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Read+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,344 :: 		err = FAT32_Write(fileHandle[3], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+3)
MOVT	R0, #hi_addr(_fileHandle+3)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Write+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,345 :: 		err = FAT32_Read (fileHandle[0], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Read+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,346 :: 		err = FAT32_Write(fileHandle[3], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+3)
MOVT	R0, #hi_addr(_fileHandle+3)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Write+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,347 :: 		err = FAT32_Read (fileHandle[0], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Read+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,348 :: 		err = FAT32_Write(fileHandle[3], rdbuf, sizeof(rdbuf));
MOVW	R0, #lo_addr(_fileHandle+3)
MOVT	R0, #hi_addr(_fileHandle+3)
LDRSB	R0, [R0, #0]
MOVS	R2, #19
MOVW	R1, #lo_addr(_rdbuf+0)
MOVT	R1, #hi_addr(_rdbuf+0)
BL	_FAT32_Write+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,351 :: 		err = FAT32_Close(fileHandle[0]);
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
BL	_FAT32_Close+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,352 :: 		err = FAT32_Close(fileHandle[1]);
MOVW	R0, #lo_addr(_fileHandle+1)
MOVT	R0, #hi_addr(_fileHandle+1)
LDRSB	R0, [R0, #0]
BL	_FAT32_Close+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,353 :: 		err = FAT32_Close(fileHandle[2]);
MOVW	R0, #lo_addr(_fileHandle+2)
MOVT	R0, #hi_addr(_fileHandle+2)
LDRSB	R0, [R0, #0]
BL	_FAT32_Close+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,354 :: 		err = FAT32_Close(fileHandle[3]);
MOVW	R0, #lo_addr(_fileHandle+3)
MOVT	R0, #hi_addr(_fileHandle+3)
LDRSB	R0, [R0, #0]
BL	_FAT32_Close+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,358 :: 		err = FAT32_Dir();
BL	_FAT32_Dir+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,359 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,362 :: 		err = FAT32_GetAttr("FILE1.TXT", &attr);
MOVW	R0, #lo_addr(?lstr7_SD_Card+0)
MOVT	R0, #hi_addr(?lstr7_SD_Card+0)
MOVW	R1, #lo_addr(_attr+0)
MOVT	R1, #hi_addr(_attr+0)
BL	_FAT32_GetAttr+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,363 :: 		err = FAT32_SetAttr("FILE1.TXT", attr | ATTR_HIDDEN);
MOVW	R0, #lo_addr(_attr+0)
MOVT	R0, #hi_addr(_attr+0)
LDRB	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(?lstr8_SD_Card+0)
MOVT	R0, #hi_addr(?lstr8_SD_Card+0)
BL	_FAT32_SetAttr+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,365 :: 		err = FAT32_Dir();
BL	_FAT32_Dir+0
MOVW	R1, #lo_addr(_err+0)
MOVT	R1, #hi_addr(_err+0)
STRB	R0, [R1, #0]
;SD_Card.c,366 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,369 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,370 :: 		FAT32_GetFreeSpace(&freeClusts, &bpcl);
MOVW	R1, #lo_addr(_bpcl+0)
MOVT	R1, #hi_addr(_bpcl+0)
MOVW	R0, #lo_addr(_freeClusts+0)
MOVT	R0, #hi_addr(_freeClusts+0)
BL	_FAT32_GetFreeSpace+0
;SD_Card.c,371 :: 		UART_Write_Text("Free Space Info:");
MOVW	R0, #lo_addr(?lstr9_SD_Card+0)
MOVT	R0, #hi_addr(?lstr9_SD_Card+0)
BL	_UART_Write_Text+0
;SD_Card.c,372 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,373 :: 		UART_Write_Text("Free bytes: ");
MOVW	R0, #lo_addr(?lstr10_SD_Card+0)
MOVT	R0, #hi_addr(?lstr10_SD_Card+0)
BL	_UART_Write_Text+0
;SD_Card.c,374 :: 		LongWordToStr(freeClusts*bpcl, uartbuf);
MOVW	R0, #lo_addr(_bpcl+0)
MOVT	R0, #hi_addr(_bpcl+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_freeClusts+0)
MOVT	R0, #hi_addr(_freeClusts+0)
LDR	R0, [R0, #0]
MULS	R0, R1, R0
MOVW	R1, #lo_addr(_uartbuf+0)
MOVT	R1, #hi_addr(_uartbuf+0)
BL	_LongWordToStr+0
;SD_Card.c,375 :: 		UART_Write_Text(uartbuf);
MOVW	R0, #lo_addr(_uartbuf+0)
MOVT	R0, #hi_addr(_uartbuf+0)
BL	_UART_Write_Text+0
;SD_Card.c,376 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,378 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,379 :: 		UART_Write_Text(constToVar(uartbuf, line));
MOVW	R1, #lo_addr(_line+0)
MOVT	R1, #hi_addr(_line+0)
MOVW	R0, #lo_addr(_uartbuf+0)
MOVT	R0, #hi_addr(_uartbuf+0)
BL	SD_Card_constToVar+0
BL	_UART_Write_Text+0
;SD_Card.c,380 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;SD_Card.c,381 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
