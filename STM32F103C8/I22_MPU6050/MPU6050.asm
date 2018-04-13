_MPU6050_Write:
;MPU6050.c,65 :: 		void MPU6050_Write(unsigned char addr, int raddr, int rdata)
; rdata start address is: 8 (R2)
; raddr start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
; rdata end address is: 8 (R2)
; raddr end address is: 4 (R1)
; raddr start address is: 4 (R1)
; rdata start address is: 8 (R2)
;MPU6050.c,67 :: 		buf[0] = raddr;                          // register address
MOVW	R3, #lo_addr(_buf+0)
MOVT	R3, #hi_addr(_buf+0)
STRB	R1, [R3, #0]
; raddr end address is: 4 (R1)
;MPU6050.c,68 :: 		buf[1] = rdata;                          // register data
MOVW	R3, #lo_addr(_buf+1)
MOVT	R3, #hi_addr(_buf+1)
STRB	R2, [R3, #0]
; rdata end address is: 8 (R2)
;MPU6050.c,69 :: 		I2C1_Start();                            // issue I2C start signal
BL	_I2C1_Start+0
;MPU6050.c,70 :: 		I2C1_Write(addr,buf,2,END_MODE_STOP);    // write data via I2C bus
MOVW	R3, #1
MOVS	R2, #2
MOVW	R1, #lo_addr(_buf+0)
MOVT	R1, #hi_addr(_buf+0)
LDRB	R0, [SP, #4]
BL	_I2C1_Write+0
;MPU6050.c,71 :: 		}
L_end_MPU6050_Write:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MPU6050_Write
_MPU6050_Test:
;MPU6050.c,74 :: 		int MPU6050_Test(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MPU6050.c,76 :: 		buf[0] =  MPU6050_RA_WHO_AM_I;
MOVS	R1, #117
MOVW	R0, #lo_addr(_buf+0)
MOVT	R0, #hi_addr(_buf+0)
STRB	R1, [R0, #0]
;MPU6050.c,77 :: 		I2C1_Start();
BL	_I2C1_Start+0
;MPU6050.c,78 :: 		I2C1_Write(MPU6050_ADDRESS, buf, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_buf+0)
MOVT	R1, #hi_addr(_buf+0)
MOVS	R0, #104
BL	_I2C1_Write+0
;MPU6050.c,79 :: 		I2C1_Read(MPU6050_ADDRESS, buf, 1, END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #1
MOVW	R1, #lo_addr(_buf+0)
MOVT	R1, #hi_addr(_buf+0)
MOVS	R0, #104
BL	_I2C1_Read+0
;MPU6050.c,81 :: 		if(buf[0] == 0x68)
MOVW	R0, #lo_addr(_buf+0)
MOVT	R0, #hi_addr(_buf+0)
LDRB	R0, [R0, #0]
CMP	R0, #104
IT	NE
BNE	L_MPU6050_Test0
;MPU6050.c,83 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_MPU6050_Test
;MPU6050.c,84 :: 		}
L_MPU6050_Test0:
;MPU6050.c,87 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
;MPU6050.c,89 :: 		}
L_end_MPU6050_Test:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MPU6050_Test
_MPU6050_Read:
;MPU6050.c,92 :: 		int MPU6050_Read(unsigned short addr, int raddr)
; raddr start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
; raddr end address is: 4 (R1)
; raddr start address is: 4 (R1)
;MPU6050.c,94 :: 		buf[0] = raddr;
MOVW	R2, #lo_addr(_buf+0)
MOVT	R2, #hi_addr(_buf+0)
STRB	R1, [R2, #0]
; raddr end address is: 4 (R1)
;MPU6050.c,95 :: 		I2C1_Start();
BL	_I2C1_Start+0
;MPU6050.c,96 :: 		I2C1_Write(addr,  buf, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOVW	R1, #lo_addr(_buf+0)
MOVT	R1, #hi_addr(_buf+0)
LDRB	R0, [SP, #4]
BL	_I2C1_Write+0
;MPU6050.c,97 :: 		I2C1_Read (addr,  buf, 1, END_MODE_STOP);
MOVW	R3, #1
MOVS	R2, #1
MOVW	R1, #lo_addr(_buf+0)
MOVT	R1, #hi_addr(_buf+0)
LDRB	R0, [SP, #4]
BL	_I2C1_Read+0
;MPU6050.c,99 :: 		return buf[0];
MOVW	R2, #lo_addr(_buf+0)
MOVT	R2, #hi_addr(_buf+0)
LDRB	R0, [R2, #0]
;MPU6050.c,100 :: 		}
L_end_MPU6050_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MPU6050_Read
_MPU6050_Init:
;MPU6050.c,103 :: 		void MPU6050_Init(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MPU6050.c,106 :: 		MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_PWR_MGMT_1, 0x00);
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #107
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,109 :: 		MPU6050_Write(MPU6050_ADDRESS,  MPU6050_RA_SMPLRT_DIV, 109);
MOVS	R2, #109
SXTH	R2, R2
MOVS	R1, #25
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,112 :: 		MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_ACCEL_CONFIG, 0x00);
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #28
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,115 :: 		MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_GYRO_CONFIG, 0x18);
MOVS	R2, #24
SXTH	R2, R2
MOVS	R1, #27
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,118 :: 		MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_CONFIG, 0x00);
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #26
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,121 :: 		MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_FIFO_EN, 0x00);
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #35
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,124 :: 		MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_I2C_MST_CTRL, 0x00);
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #36
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,127 :: 		MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_INT_PIN_CFG, 0x00);
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #55
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,130 :: 		MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_INT_ENABLE, 0x00);
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #56
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Write+0
;MPU6050.c,131 :: 		}
L_end_MPU6050_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MPU6050_Init
_MPU6050_Accel_Raw:
;MPU6050.c,134 :: 		int MPU6050_Accel_Raw(char axis)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R0, [SP, #16]
;MPU6050.c,141 :: 		ACCEL_XOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_XOUT_H);
MOVS	R1, #59
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #4]
;MPU6050.c,142 :: 		ACCEL_XOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_XOUT_L);
MOVS	R1, #60
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #6]
;MPU6050.c,143 :: 		ACCEL_YOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_YOUT_H);
MOVS	R1, #61
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #8]
;MPU6050.c,144 :: 		ACCEL_YOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_YOUT_L);
MOVS	R1, #62
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #10]
;MPU6050.c,145 :: 		ACCEL_ZOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_ZOUT_H);
MOVS	R1, #63
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #12]
;MPU6050.c,146 :: 		ACCEL_ZOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_ZOUT_L);
MOVS	R1, #64
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
;MPU6050.c,149 :: 		ACCEL_XOUT = ( ACCEL_XOUT_H<<8 | ACCEL_XOUT_L );
LDRSH	R1, [SP, #4]
LSLS	R2, R1, #8
SXTH	R2, R2
LDRSH	R1, [SP, #6]
ORRS	R2, R1
MOVW	R1, #lo_addr(_ACCEL_XOUT+0)
MOVT	R1, #hi_addr(_ACCEL_XOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,150 :: 		ACCEL_YOUT = ( ACCEL_YOUT_H<<8 | ACCEL_YOUT_L );
LDRSH	R1, [SP, #8]
LSLS	R2, R1, #8
SXTH	R2, R2
LDRSH	R1, [SP, #10]
ORRS	R2, R1
MOVW	R1, #lo_addr(_ACCEL_YOUT+0)
MOVT	R1, #hi_addr(_ACCEL_YOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,151 :: 		ACCEL_ZOUT = ( ACCEL_ZOUT_H<<8 | ACCEL_ZOUT_L );
LDRSH	R1, [SP, #12]
LSLS	R1, R1, #8
SXTH	R1, R1
ORR	R2, R1, R0, LSL #0
MOVW	R1, #lo_addr(_ACCEL_ZOUT+0)
MOVT	R1, #hi_addr(_ACCEL_ZOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,155 :: 		switch (axis)
IT	AL
BAL	L_MPU6050_Accel_Raw2
;MPU6050.c,157 :: 		case 'X':
L_MPU6050_Accel_Raw4:
;MPU6050.c,158 :: 		return ACCEL_XOUT;    //  Accel X Axis
MOVW	R1, #lo_addr(_ACCEL_XOUT+0)
MOVT	R1, #hi_addr(_ACCEL_XOUT+0)
LDRSH	R0, [R1, #0]
IT	AL
BAL	L_end_MPU6050_Accel_Raw
;MPU6050.c,160 :: 		case 'Y':
L_MPU6050_Accel_Raw5:
;MPU6050.c,161 :: 		return ACCEL_YOUT;    // Accel Y Axis
MOVW	R1, #lo_addr(_ACCEL_YOUT+0)
MOVT	R1, #hi_addr(_ACCEL_YOUT+0)
LDRSH	R0, [R1, #0]
IT	AL
BAL	L_end_MPU6050_Accel_Raw
;MPU6050.c,163 :: 		case 'Z':
L_MPU6050_Accel_Raw6:
;MPU6050.c,164 :: 		return ACCEL_ZOUT;    //  Accel Z Axis
MOVW	R1, #lo_addr(_ACCEL_ZOUT+0)
MOVT	R1, #hi_addr(_ACCEL_ZOUT+0)
LDRSH	R0, [R1, #0]
IT	AL
BAL	L_end_MPU6050_Accel_Raw
;MPU6050.c,166 :: 		default:
L_MPU6050_Accel_Raw7:
;MPU6050.c,167 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_MPU6050_Accel_Raw
;MPU6050.c,168 :: 		}
L_MPU6050_Accel_Raw2:
LDRB	R1, [SP, #16]
CMP	R1, #88
IT	EQ
BEQ	L_MPU6050_Accel_Raw4
LDRB	R1, [SP, #16]
CMP	R1, #89
IT	EQ
BEQ	L_MPU6050_Accel_Raw5
LDRB	R1, [SP, #16]
CMP	R1, #90
IT	EQ
BEQ	L_MPU6050_Accel_Raw6
IT	AL
BAL	L_MPU6050_Accel_Raw7
;MPU6050.c,169 :: 		}
L_end_MPU6050_Accel_Raw:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _MPU6050_Accel_Raw
_MPU6050_Read_Accel:
;MPU6050.c,173 :: 		double MPU6050_Read_Accel(char axis)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R0, [SP, #16]
;MPU6050.c,184 :: 		ACCEL_XOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_XOUT_H);
MOVS	R1, #59
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #4]
;MPU6050.c,185 :: 		ACCEL_XOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_XOUT_L);
MOVS	R1, #60
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #6]
;MPU6050.c,186 :: 		ACCEL_YOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_YOUT_H);
MOVS	R1, #61
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #8]
;MPU6050.c,187 :: 		ACCEL_YOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_YOUT_L);
MOVS	R1, #62
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #10]
;MPU6050.c,188 :: 		ACCEL_ZOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_ZOUT_H);
MOVS	R1, #63
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #12]
;MPU6050.c,189 :: 		ACCEL_ZOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_ZOUT_L);
MOVS	R1, #64
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
;MPU6050.c,192 :: 		ACCEL_XOUT = ( ACCEL_XOUT_H<<8 | ACCEL_XOUT_L );
LDRSH	R1, [SP, #4]
LSLS	R2, R1, #8
SXTH	R2, R2
LDRSH	R1, [SP, #6]
ORRS	R2, R1
MOVW	R1, #lo_addr(_ACCEL_XOUT+0)
MOVT	R1, #hi_addr(_ACCEL_XOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,193 :: 		ACCEL_YOUT = ( ACCEL_YOUT_H<<8 | ACCEL_YOUT_L );
LDRSH	R1, [SP, #8]
LSLS	R2, R1, #8
SXTH	R2, R2
LDRSH	R1, [SP, #10]
ORRS	R2, R1
MOVW	R1, #lo_addr(_ACCEL_YOUT+0)
MOVT	R1, #hi_addr(_ACCEL_YOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,194 :: 		ACCEL_ZOUT = ( ACCEL_ZOUT_H<<8 | ACCEL_ZOUT_L );
LDRSH	R1, [SP, #12]
LSLS	R1, R1, #8
SXTH	R1, R1
ORR	R2, R1, R0, LSL #0
MOVW	R1, #lo_addr(_ACCEL_ZOUT+0)
MOVT	R1, #hi_addr(_ACCEL_ZOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,197 :: 		GFORCEX = (ACCEL_XOUT  / G_CALC_VAL);
MOVW	R1, #lo_addr(_ACCEL_XOUT+0)
MOVT	R1, #hi_addr(_ACCEL_XOUT+0)
LDRSH	R0, [R1, #0]
BL	__SignedIntegralToFloat+0
MOV	R2, #1174405120
BL	__Div_FP+0
; GFORCEX start address is: 32 (R8)
MOV	R8, R0
;MPU6050.c,198 :: 		GFORCEY = (ACCEL_YOUT  / G_CALC_VAL);
MOVW	R1, #lo_addr(_ACCEL_YOUT+0)
MOVT	R1, #hi_addr(_ACCEL_YOUT+0)
LDRSH	R0, [R1, #0]
BL	__SignedIntegralToFloat+0
MOV	R2, #1174405120
BL	__Div_FP+0
; GFORCEY start address is: 36 (R9)
MOV	R9, R0
;MPU6050.c,199 :: 		GFORCEZ = (ACCEL_ZOUT  / G_CALC_VAL);
MOVW	R1, #lo_addr(_ACCEL_ZOUT+0)
MOVT	R1, #hi_addr(_ACCEL_ZOUT+0)
LDRSH	R0, [R1, #0]
BL	__SignedIntegralToFloat+0
MOV	R2, #1174405120
BL	__Div_FP+0
; GFORCEZ start address is: 0 (R0)
;MPU6050.c,202 :: 		switch (axis)
IT	AL
BAL	L_MPU6050_Read_Accel8
; GFORCEY end address is: 36 (R9)
; GFORCEZ end address is: 0 (R0)
;MPU6050.c,204 :: 		case 'X':
L_MPU6050_Read_Accel10:
;MPU6050.c,205 :: 		return GFORCEX;    //  Gforce X Axis
MOV	R0, R8
; GFORCEX end address is: 32 (R8)
IT	AL
BAL	L_end_MPU6050_Read_Accel
;MPU6050.c,207 :: 		case 'Y':
L_MPU6050_Read_Accel11:
;MPU6050.c,208 :: 		return GFORCEY;    // Gforce Y Axis
; GFORCEY start address is: 36 (R9)
MOV	R0, R9
; GFORCEY end address is: 36 (R9)
IT	AL
BAL	L_end_MPU6050_Read_Accel
;MPU6050.c,210 :: 		case 'Z':
L_MPU6050_Read_Accel12:
;MPU6050.c,211 :: 		return GFORCEZ;    //  Gforce Z Axis
; GFORCEZ start address is: 0 (R0)
; GFORCEZ end address is: 0 (R0)
IT	AL
BAL	L_end_MPU6050_Read_Accel
;MPU6050.c,213 :: 		default:
L_MPU6050_Read_Accel13:
;MPU6050.c,214 :: 		return 0;
MOV	R0, #0
IT	AL
BAL	L_end_MPU6050_Read_Accel
;MPU6050.c,215 :: 		}
L_MPU6050_Read_Accel8:
; GFORCEZ start address is: 0 (R0)
; GFORCEY start address is: 36 (R9)
; GFORCEX start address is: 32 (R8)
LDRB	R1, [SP, #16]
CMP	R1, #88
IT	EQ
BEQ	L_MPU6050_Read_Accel10
; GFORCEX end address is: 32 (R8)
LDRB	R1, [SP, #16]
CMP	R1, #89
IT	EQ
BEQ	L_MPU6050_Read_Accel11
; GFORCEY end address is: 36 (R9)
LDRB	R1, [SP, #16]
CMP	R1, #90
IT	EQ
BEQ	L_MPU6050_Read_Accel12
; GFORCEZ end address is: 0 (R0)
IT	AL
BAL	L_MPU6050_Read_Accel13
;MPU6050.c,216 :: 		}
L_end_MPU6050_Read_Accel:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _MPU6050_Read_Accel
_MPU6050_Gyro_Raw:
;MPU6050.c,219 :: 		int MPU6050_Gyro_Raw(char axis)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R0, [SP, #16]
;MPU6050.c,226 :: 		GYRO_XOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_XOUT_H);
MOVS	R1, #67
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #4]
;MPU6050.c,227 :: 		GYRO_XOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_XOUT_L);
MOVS	R1, #68
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #6]
;MPU6050.c,229 :: 		GYRO_YOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_YOUT_H);
MOVS	R1, #69
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #8]
;MPU6050.c,230 :: 		GYRO_YOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_YOUT_L);
MOVS	R1, #70
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #10]
;MPU6050.c,232 :: 		GYRO_ZOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_ZOUT_H);
MOVS	R1, #71
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
STRH	R0, [SP, #12]
;MPU6050.c,233 :: 		GYRO_ZOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_ZOUT_L);
MOVS	R1, #72
SXTH	R1, R1
MOVS	R0, #104
BL	_MPU6050_Read+0
;MPU6050.c,236 :: 		GYRO_XOUT = ( GYRO_XOUT_H << 8 | GYRO_XOUT_L );
LDRSH	R1, [SP, #4]
LSLS	R2, R1, #8
SXTH	R2, R2
LDRSH	R1, [SP, #6]
ORRS	R2, R1
MOVW	R1, #lo_addr(_GYRO_XOUT+0)
MOVT	R1, #hi_addr(_GYRO_XOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,237 :: 		GYRO_YOUT = ( GYRO_YOUT_H << 8 | GYRO_YOUT_L );
LDRSH	R1, [SP, #8]
LSLS	R2, R1, #8
SXTH	R2, R2
LDRSH	R1, [SP, #10]
ORRS	R2, R1
MOVW	R1, #lo_addr(_GYRO_YOUT+0)
MOVT	R1, #hi_addr(_GYRO_YOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,238 :: 		GYRO_ZOUT = ( GYRO_ZOUT_H << 8 | GYRO_ZOUT_L );
LDRSH	R1, [SP, #12]
LSLS	R1, R1, #8
SXTH	R1, R1
ORR	R2, R1, R0, LSL #0
MOVW	R1, #lo_addr(_GYRO_ZOUT+0)
MOVT	R1, #hi_addr(_GYRO_ZOUT+0)
STRH	R2, [R1, #0]
;MPU6050.c,241 :: 		switch (axis)
IT	AL
BAL	L_MPU6050_Gyro_Raw14
;MPU6050.c,243 :: 		case 'X':
L_MPU6050_Gyro_Raw16:
;MPU6050.c,244 :: 		return GYRO_XOUT;    // Gyro X Axis
MOVW	R1, #lo_addr(_GYRO_XOUT+0)
MOVT	R1, #hi_addr(_GYRO_XOUT+0)
LDRSH	R0, [R1, #0]
IT	AL
BAL	L_end_MPU6050_Gyro_Raw
;MPU6050.c,246 :: 		case 'Y':
L_MPU6050_Gyro_Raw17:
;MPU6050.c,247 :: 		return GYRO_YOUT;    //  Gyro Y Axis
MOVW	R1, #lo_addr(_GYRO_YOUT+0)
MOVT	R1, #hi_addr(_GYRO_YOUT+0)
LDRSH	R0, [R1, #0]
IT	AL
BAL	L_end_MPU6050_Gyro_Raw
;MPU6050.c,249 :: 		case 'Z':
L_MPU6050_Gyro_Raw18:
;MPU6050.c,250 :: 		return GYRO_ZOUT;    //  Gyro Z Axis
MOVW	R1, #lo_addr(_GYRO_ZOUT+0)
MOVT	R1, #hi_addr(_GYRO_ZOUT+0)
LDRSH	R0, [R1, #0]
IT	AL
BAL	L_end_MPU6050_Gyro_Raw
;MPU6050.c,252 :: 		default:
L_MPU6050_Gyro_Raw19:
;MPU6050.c,253 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_MPU6050_Gyro_Raw
;MPU6050.c,254 :: 		}
L_MPU6050_Gyro_Raw14:
LDRB	R1, [SP, #16]
CMP	R1, #88
IT	EQ
BEQ	L_MPU6050_Gyro_Raw16
LDRB	R1, [SP, #16]
CMP	R1, #89
IT	EQ
BEQ	L_MPU6050_Gyro_Raw17
LDRB	R1, [SP, #16]
CMP	R1, #90
IT	EQ
BEQ	L_MPU6050_Gyro_Raw18
IT	AL
BAL	L_MPU6050_Gyro_Raw19
;MPU6050.c,255 :: 		}
L_end_MPU6050_Gyro_Raw:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _MPU6050_Gyro_Raw
_main:
;MPU6050.c,259 :: 		void main() {
SUB	SP, SP, #4
;MPU6050.c,262 :: 		UART1_Init(230400);
MOV	R0, #230400
BL	_UART1_Init+0
;MPU6050.c,264 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main20:
SUBS	R7, R7, #1
BNE	L_main20
NOP
NOP
NOP
;MPU6050.c,267 :: 		I2C1_Init_Advanced(400000, &_GPIO_MODULE_I2C1_PB67);
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C1_PB67+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C1_PB67+0)
MOVW	R0, #6784
MOVT	R0, #6
BL	_I2C1_Init_Advanced+0
;MPU6050.c,268 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main22:
SUBS	R7, R7, #1
BNE	L_main22
NOP
NOP
NOP
;MPU6050.c,271 :: 		UART1_Write_Text("Pre Init Okay");
MOVW	R0, #lo_addr(?lstr1_MPU6050+0)
MOVT	R0, #hi_addr(?lstr1_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,272 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;MPU6050.c,275 :: 		MPU6050_Init();
BL	_MPU6050_Init+0
;MPU6050.c,277 :: 		info = MPU6050_Test();
BL	_MPU6050_Test+0
MOVW	R1, #lo_addr(_info+0)
MOVT	R1, #hi_addr(_info+0)
STRH	R0, [R1, #0]
;MPU6050.c,279 :: 		if (info == 1)
CMP	R0, #1
IT	NE
BNE	L_main24
;MPU6050.c,281 :: 		UART1_Write_Text("MPU6050 OK");
MOVW	R0, #lo_addr(?lstr2_MPU6050+0)
MOVT	R0, #hi_addr(?lstr2_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,282 :: 		UART1_Write(0x0A); //Line Feed LF
MOVS	R0, #10
BL	_UART1_Write+0
;MPU6050.c,283 :: 		UART1_Write(0x0D); //Return Car CR
MOVS	R0, #13
BL	_UART1_Write+0
;MPU6050.c,284 :: 		}
IT	AL
BAL	L_main25
L_main24:
;MPU6050.c,288 :: 		UART1_Write_Text("MPU6050 Failed");
MOVW	R0, #lo_addr(?lstr3_MPU6050+0)
MOVT	R0, #hi_addr(?lstr3_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,289 :: 		UART1_Write(0x0A); //Line Feed LF
MOVS	R0, #10
BL	_UART1_Write+0
;MPU6050.c,290 :: 		UART1_Write(0x0D); //Return Car CR
MOVS	R0, #13
BL	_UART1_Write+0
;MPU6050.c,291 :: 		}
L_main25:
;MPU6050.c,294 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main26:
SUBS	R7, R7, #1
BNE	L_main26
NOP
NOP
NOP
;MPU6050.c,297 :: 		for (cal_var = 0; cal_var <= 64; cal_var++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_cal_var+0)
MOVT	R0, #hi_addr(_cal_var+0)
STRH	R1, [R0, #0]
L_main28:
MOVW	R0, #lo_addr(_cal_var+0)
MOVT	R0, #hi_addr(_cal_var+0)
LDRSH	R0, [R0, #0]
CMP	R0, #64
IT	GT
BGT	L_main29
;MPU6050.c,299 :: 		gyro_x_offset += MPU6050_Gyro_Raw('X');
MOVS	R0, #88
BL	_MPU6050_Gyro_Raw+0
BL	__SignedIntegralToFloat+0
MOVW	R1, #lo_addr(_gyro_x_offset+0)
MOVT	R1, #hi_addr(_gyro_x_offset+0)
STR	R1, [SP, #0]
LDR	R2, [R1, #0]
BL	__Add_FP+0
LDR	R1, [SP, #0]
STR	R0, [R1, #0]
;MPU6050.c,300 :: 		gyro_y_offset += MPU6050_Gyro_Raw('Y');
MOVS	R0, #89
BL	_MPU6050_Gyro_Raw+0
BL	__SignedIntegralToFloat+0
MOVW	R1, #lo_addr(_gyro_y_offset+0)
MOVT	R1, #hi_addr(_gyro_y_offset+0)
STR	R1, [SP, #0]
LDR	R2, [R1, #0]
BL	__Add_FP+0
LDR	R1, [SP, #0]
STR	R0, [R1, #0]
;MPU6050.c,301 :: 		gyro_z_offset += MPU6050_Gyro_Raw('Z');
MOVS	R0, #90
BL	_MPU6050_Gyro_Raw+0
BL	__SignedIntegralToFloat+0
MOVW	R1, #lo_addr(_gyro_z_offset+0)
MOVT	R1, #hi_addr(_gyro_z_offset+0)
STR	R1, [SP, #0]
LDR	R2, [R1, #0]
BL	__Add_FP+0
LDR	R1, [SP, #0]
STR	R0, [R1, #0]
;MPU6050.c,303 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main31:
SUBS	R7, R7, #1
BNE	L_main31
NOP
NOP
NOP
;MPU6050.c,297 :: 		for (cal_var = 0; cal_var <= 64; cal_var++)
MOVW	R1, #lo_addr(_cal_var+0)
MOVT	R1, #hi_addr(_cal_var+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;MPU6050.c,304 :: 		}
IT	AL
BAL	L_main28
L_main29:
;MPU6050.c,307 :: 		gyro_x_offset /= 64;
MOVW	R0, #lo_addr(_gyro_x_offset+0)
MOVT	R0, #hi_addr(_gyro_x_offset+0)
STR	R0, [SP, #0]
LDR	R0, [R0, #0]
MOV	R2, #1115684864
BL	__Div_FP+0
LDR	R1, [SP, #0]
STR	R0, [R1, #0]
;MPU6050.c,308 :: 		gyro_y_offset /= 64;
MOVW	R0, #lo_addr(_gyro_y_offset+0)
MOVT	R0, #hi_addr(_gyro_y_offset+0)
STR	R0, [SP, #0]
LDR	R0, [R0, #0]
MOV	R2, #1115684864
BL	__Div_FP+0
LDR	R1, [SP, #0]
STR	R0, [R1, #0]
;MPU6050.c,309 :: 		gyro_z_offset /= 64;
MOVW	R0, #lo_addr(_gyro_z_offset+0)
MOVT	R0, #hi_addr(_gyro_z_offset+0)
STR	R0, [SP, #0]
LDR	R0, [R0, #0]
MOV	R2, #1115684864
BL	__Div_FP+0
LDR	R1, [SP, #0]
STR	R0, [R1, #0]
;MPU6050.c,311 :: 		while(1)
L_main33:
;MPU6050.c,314 :: 		gyro_x  =  (MPU6050_Gyro_Raw('X')  - gyro_x_offset)  / 939.650784f;
MOVS	R0, #88
BL	_MPU6050_Gyro_Raw+0
BL	__SignedIntegralToFloat+0
MOVW	R1, #lo_addr(_gyro_x_offset+0)
MOVT	R1, #hi_addr(_gyro_x_offset+0)
LDR	R2, [R1, #0]
BL	__Sub_FP+0
MOVW	R2, #59814
MOVT	R2, #17514
BL	__Div_FP+0
MOVW	R1, #lo_addr(_gyro_x+0)
MOVT	R1, #hi_addr(_gyro_x+0)
STR	R0, [R1, #0]
;MPU6050.c,315 :: 		gyro_y  =  (MPU6050_Gyro_Raw('Y')  - gyro_y_offset)  / 939.650784f;
MOVS	R0, #89
BL	_MPU6050_Gyro_Raw+0
BL	__SignedIntegralToFloat+0
MOVW	R1, #lo_addr(_gyro_y_offset+0)
MOVT	R1, #hi_addr(_gyro_y_offset+0)
LDR	R2, [R1, #0]
BL	__Sub_FP+0
MOVW	R2, #59814
MOVT	R2, #17514
BL	__Div_FP+0
MOVW	R1, #lo_addr(_gyro_y+0)
MOVT	R1, #hi_addr(_gyro_y+0)
STR	R0, [R1, #0]
;MPU6050.c,316 :: 		gyro_z  =  (MPU6050_Gyro_Raw('Z')  - gyro_z_offset)  / 939.650784f;
MOVS	R0, #90
BL	_MPU6050_Gyro_Raw+0
BL	__SignedIntegralToFloat+0
MOVW	R1, #lo_addr(_gyro_z_offset+0)
MOVT	R1, #hi_addr(_gyro_z_offset+0)
LDR	R2, [R1, #0]
BL	__Sub_FP+0
MOVW	R2, #59814
MOVT	R2, #17514
BL	__Div_FP+0
MOVW	R1, #lo_addr(_gyro_z+0)
MOVT	R1, #hi_addr(_gyro_z+0)
STR	R0, [R1, #0]
;MPU6050.c,319 :: 		acc_x = MPU6050_Read_Accel('X') / 2.0f;
MOVS	R0, #88
BL	_MPU6050_Read_Accel+0
MOV	R2, #1073741824
BL	__Div_FP+0
MOVW	R1, #lo_addr(_acc_x+0)
MOVT	R1, #hi_addr(_acc_x+0)
STR	R0, [R1, #0]
;MPU6050.c,320 :: 		acc_y = MPU6050_Read_Accel('Y') / 2.0f;
MOVS	R0, #89
BL	_MPU6050_Read_Accel+0
MOV	R2, #1073741824
BL	__Div_FP+0
MOVW	R1, #lo_addr(_acc_y+0)
MOVT	R1, #hi_addr(_acc_y+0)
STR	R0, [R1, #0]
;MPU6050.c,321 :: 		acc_z = MPU6050_Read_Accel('Z') / 2.0f;
MOVS	R0, #90
BL	_MPU6050_Read_Accel+0
MOV	R2, #1073741824
BL	__Div_FP+0
MOVW	R1, #lo_addr(_acc_z+0)
MOVT	R1, #hi_addr(_acc_z+0)
STR	R0, [R1, #0]
;MPU6050.c,326 :: 		UART1_Write_Text("  AccelX: ");
MOVW	R0, #lo_addr(?lstr4_MPU6050+0)
MOVT	R0, #hi_addr(?lstr4_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,327 :: 		sprintf(accel_x_out, "%7.2f", acc_x);
MOVW	R0, #lo_addr(_acc_x+0)
MOVT	R0, #hi_addr(_acc_x+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_5_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_5_MPU6050+0)
MOVW	R0, #lo_addr(_accel_x_out+0)
MOVT	R0, #hi_addr(_accel_x_out+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,328 :: 		UART1_Write_Text(accel_x_out);
MOVW	R0, #lo_addr(_accel_x_out+0)
MOVT	R0, #hi_addr(_accel_x_out+0)
BL	_UART1_Write_Text+0
;MPU6050.c,330 :: 		UART1_Write_Text("  AccelY: ");
MOVW	R0, #lo_addr(?lstr6_MPU6050+0)
MOVT	R0, #hi_addr(?lstr6_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,331 :: 		sprintf(accel_y_out, "%7.2f", acc_y);
MOVW	R0, #lo_addr(_acc_y+0)
MOVT	R0, #hi_addr(_acc_y+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_7_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_7_MPU6050+0)
MOVW	R0, #lo_addr(_accel_y_out+0)
MOVT	R0, #hi_addr(_accel_y_out+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,332 :: 		UART1_Write_Text(accel_y_out);
MOVW	R0, #lo_addr(_accel_y_out+0)
MOVT	R0, #hi_addr(_accel_y_out+0)
BL	_UART1_Write_Text+0
;MPU6050.c,334 :: 		UART1_Write_Text("  AccelZ: ");
MOVW	R0, #lo_addr(?lstr8_MPU6050+0)
MOVT	R0, #hi_addr(?lstr8_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,335 :: 		sprintf(accel_z_out, "%7.2f", acc_z);
MOVW	R0, #lo_addr(_acc_z+0)
MOVT	R0, #hi_addr(_acc_z+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_9_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_9_MPU6050+0)
MOVW	R0, #lo_addr(_accel_z_out+0)
MOVT	R0, #hi_addr(_accel_z_out+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,336 :: 		UART1_Write_Text(accel_z_out);
MOVW	R0, #lo_addr(_accel_z_out+0)
MOVT	R0, #hi_addr(_accel_z_out+0)
BL	_UART1_Write_Text+0
;MPU6050.c,338 :: 		UART1_Write(0x0A); //Line Feed LF
MOVS	R0, #10
BL	_UART1_Write+0
;MPU6050.c,339 :: 		UART1_Write(0x0D); //Return Car CR
MOVS	R0, #13
BL	_UART1_Write+0
;MPU6050.c,344 :: 		UART1_Write_Text("  GyroX: ");
MOVW	R0, #lo_addr(?lstr10_MPU6050+0)
MOVT	R0, #hi_addr(?lstr10_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,345 :: 		sprintf(gyro_x_out, "%7.2f", gyro_x);
MOVW	R0, #lo_addr(_gyro_x+0)
MOVT	R0, #hi_addr(_gyro_x+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_11_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_11_MPU6050+0)
MOVW	R0, #lo_addr(_gyro_x_out+0)
MOVT	R0, #hi_addr(_gyro_x_out+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,346 :: 		UART1_Write_Text(gyro_x_out);
MOVW	R0, #lo_addr(_gyro_x_out+0)
MOVT	R0, #hi_addr(_gyro_x_out+0)
BL	_UART1_Write_Text+0
;MPU6050.c,348 :: 		UART1_Write_Text("  GyroY: ");
MOVW	R0, #lo_addr(?lstr12_MPU6050+0)
MOVT	R0, #hi_addr(?lstr12_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,349 :: 		sprintf(gyro_y_out, "%7.2f", gyro_y);
MOVW	R0, #lo_addr(_gyro_y+0)
MOVT	R0, #hi_addr(_gyro_y+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_13_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_13_MPU6050+0)
MOVW	R0, #lo_addr(_gyro_y_out+0)
MOVT	R0, #hi_addr(_gyro_y_out+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,350 :: 		UART1_Write_Text(gyro_y_out);
MOVW	R0, #lo_addr(_gyro_y_out+0)
MOVT	R0, #hi_addr(_gyro_y_out+0)
BL	_UART1_Write_Text+0
;MPU6050.c,352 :: 		UART1_Write_Text("  GyroZ: ");
MOVW	R0, #lo_addr(?lstr14_MPU6050+0)
MOVT	R0, #hi_addr(?lstr14_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,353 :: 		sprintf(gyro_z_out, "%7.2f", gyro_z);
MOVW	R0, #lo_addr(_gyro_z+0)
MOVT	R0, #hi_addr(_gyro_z+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_15_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_15_MPU6050+0)
MOVW	R0, #lo_addr(_gyro_z_out+0)
MOVT	R0, #hi_addr(_gyro_z_out+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,354 :: 		UART1_Write_Text(gyro_z_out);
MOVW	R0, #lo_addr(_gyro_z_out+0)
MOVT	R0, #hi_addr(_gyro_z_out+0)
BL	_UART1_Write_Text+0
;MPU6050.c,356 :: 		UART1_Write(0x0A); //Line Feed LF
MOVS	R0, #10
BL	_UART1_Write+0
;MPU6050.c,357 :: 		UART1_Write(0x0D); //Return Car CR
MOVS	R0, #13
BL	_UART1_Write+0
;MPU6050.c,362 :: 		MadgwickAHRSupdateIMU(gyro_x, gyro_y, gyro_z, acc_x, acc_y, acc_z);
MOVW	R0, #lo_addr(_acc_z+0)
MOVT	R0, #hi_addr(_acc_z+0)
LDR	R5, [R0, #0]
MOVW	R0, #lo_addr(_acc_y+0)
MOVT	R0, #hi_addr(_acc_y+0)
LDR	R4, [R0, #0]
MOVW	R0, #lo_addr(_acc_x+0)
MOVT	R0, #hi_addr(_acc_x+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(_gyro_z+0)
MOVT	R0, #hi_addr(_gyro_z+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(_gyro_y+0)
MOVT	R0, #hi_addr(_gyro_y+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_gyro_x+0)
MOVT	R0, #hi_addr(_gyro_x+0)
LDR	R0, [R0, #0]
PUSH	(R5)
PUSH	(R4)
BL	_MadgwickAHRSupdateIMU+0
ADD	SP, SP, #8
;MPU6050.c,367 :: 		UART1_Write_Text("  Q0: ");
MOVW	R0, #lo_addr(?lstr16_MPU6050+0)
MOVT	R0, #hi_addr(?lstr16_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,368 :: 		sprintf(q0_t, "%7.2f", q0);
MOVW	R0, #lo_addr(_q0+0)
MOVT	R0, #hi_addr(_q0+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_17_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_17_MPU6050+0)
MOVW	R0, #lo_addr(_q0_t+0)
MOVT	R0, #hi_addr(_q0_t+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,369 :: 		UART1_Write_Text(q0_t);
MOVW	R0, #lo_addr(_q0_t+0)
MOVT	R0, #hi_addr(_q0_t+0)
BL	_UART1_Write_Text+0
;MPU6050.c,371 :: 		UART1_Write_Text("  Q1: ");
MOVW	R0, #lo_addr(?lstr18_MPU6050+0)
MOVT	R0, #hi_addr(?lstr18_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,372 :: 		sprintf(q1_t, "%7.2f", q1);
MOVW	R0, #lo_addr(_q1+0)
MOVT	R0, #hi_addr(_q1+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_19_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_19_MPU6050+0)
MOVW	R0, #lo_addr(_q1_t+0)
MOVT	R0, #hi_addr(_q1_t+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,373 :: 		UART1_Write_Text(q1_t);
MOVW	R0, #lo_addr(_q1_t+0)
MOVT	R0, #hi_addr(_q1_t+0)
BL	_UART1_Write_Text+0
;MPU6050.c,375 :: 		UART1_Write_Text("  Q2: ");
MOVW	R0, #lo_addr(?lstr20_MPU6050+0)
MOVT	R0, #hi_addr(?lstr20_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,376 :: 		sprintf(q2_t, "%7.2f", q2);
MOVW	R0, #lo_addr(_q2+0)
MOVT	R0, #hi_addr(_q2+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_21_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_21_MPU6050+0)
MOVW	R0, #lo_addr(_q2_t+0)
MOVT	R0, #hi_addr(_q2_t+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,377 :: 		UART1_Write_Text(q2_t);
MOVW	R0, #lo_addr(_q2_t+0)
MOVT	R0, #hi_addr(_q2_t+0)
BL	_UART1_Write_Text+0
;MPU6050.c,379 :: 		UART1_Write_Text("  Q3: ");
MOVW	R0, #lo_addr(?lstr22_MPU6050+0)
MOVT	R0, #hi_addr(?lstr22_MPU6050+0)
BL	_UART1_Write_Text+0
;MPU6050.c,380 :: 		sprintf(q3_t, "%7.2f", q3);
MOVW	R0, #lo_addr(_q3+0)
MOVT	R0, #hi_addr(_q3+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_23_MPU6050+0)
MOVT	R1, #hi_addr(?lstr_23_MPU6050+0)
MOVW	R0, #lo_addr(_q3_t+0)
MOVT	R0, #hi_addr(_q3_t+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;MPU6050.c,381 :: 		UART1_Write_Text(q3_t);
MOVW	R0, #lo_addr(_q3_t+0)
MOVT	R0, #hi_addr(_q3_t+0)
BL	_UART1_Write_Text+0
;MPU6050.c,383 :: 		UART1_Write(0x0A); //Line Feed LF
MOVS	R0, #10
BL	_UART1_Write+0
;MPU6050.c,384 :: 		UART1_Write(0x0D); //Return Car CR
MOVS	R0, #13
BL	_UART1_Write+0
;MPU6050.c,386 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main35:
SUBS	R7, R7, #1
BNE	L_main35
NOP
NOP
NOP
;MPU6050.c,387 :: 		}
IT	AL
BAL	L_main33
;MPU6050.c,389 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
