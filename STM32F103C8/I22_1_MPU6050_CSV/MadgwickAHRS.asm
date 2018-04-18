_MadgwickAHRSupdate:
;MadgwickAHRS.c,44 :: 		void MadgwickAHRSupdate(float gx, float gy, float gz, float ax, float ay, float az, float mx, float my, float mz) {
; gx start address is: 0 (R0)
SUB	SP, SP, #240
STR	LR, [SP, #0]
MOV	R9, R0
STR	R1, [SP, #128]
STR	R2, [SP, #132]
STR	R3, [SP, #136]
; gx end address is: 0 (R0)
; gx start address is: 36 (R9)
LDR	R4, [SP, #240]
STR	R4, [SP, #240]
LDR	R4, [SP, #244]
STR	R4, [SP, #244]
LDR	R4, [SP, #248]
STR	R4, [SP, #248]
LDR	R4, [SP, #252]
STR	R4, [SP, #252]
LDR	R4, [SP, #256]
STR	R4, [SP, #256]
;MadgwickAHRS.c,52 :: 		if((mx == 0.0f) && (my == 0.0f) && (mz == 0.0f)) {
LDR	R2, [SP, #248]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdate16
MOVS	R0, #1
L__MadgwickAHRSupdate16:
CMP	R0, #0
IT	EQ
BEQ	L__MadgwickAHRSupdate13
LDR	R2, [SP, #252]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdate17
MOVS	R0, #1
L__MadgwickAHRSupdate17:
CMP	R0, #0
IT	EQ
BEQ	L__MadgwickAHRSupdate12
LDR	R2, [SP, #256]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdate18
MOVS	R0, #1
L__MadgwickAHRSupdate18:
CMP	R0, #0
IT	EQ
BEQ	L__MadgwickAHRSupdate11
L__MadgwickAHRSupdate10:
;MadgwickAHRS.c,53 :: 		MadgwickAHRSupdateIMU(gx, gy, gz, ax, ay, az);
LDR	R5, [SP, #244]
LDR	R4, [SP, #240]
LDR	R3, [SP, #136]
LDR	R2, [SP, #132]
LDR	R1, [SP, #128]
MOV	R0, R9
; gx end address is: 36 (R9)
PUSH	(R5)
PUSH	(R4)
BL	_MadgwickAHRSupdateIMU+0
ADD	SP, SP, #8
;MadgwickAHRS.c,54 :: 		return;
IT	AL
BAL	L_end_MadgwickAHRSupdate
;MadgwickAHRS.c,52 :: 		if((mx == 0.0f) && (my == 0.0f) && (mz == 0.0f)) {
L__MadgwickAHRSupdate13:
; gx start address is: 36 (R9)
L__MadgwickAHRSupdate12:
L__MadgwickAHRSupdate11:
;MadgwickAHRS.c,58 :: 		qDot1 = 0.5f * (-q1 * gx - q2 * gy - q3 * gz);
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R4, [R4, #0]
EOR	R0, R4, #-2147483648
MOV	R2, R9
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #128]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #132]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
MOV	R2, #1056964608
BL	__Mul_FP+0
; qDot1 start address is: 48 (R12)
MOV	R12, R0
;MadgwickAHRS.c,59 :: 		qDot2 = 0.5f * (q0 * gx + q2 * gz - q3 * gy);
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
MOV	R2, R9
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #132]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #128]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
MOV	R2, #1056964608
BL	__Mul_FP+0
STR	R0, [SP, #16]
;MadgwickAHRS.c,60 :: 		qDot3 = 0.5f * (q0 * gy - q1 * gz + q3 * gx);
LDR	R2, [SP, #128]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #132]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
MOV	R2, R9
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
MOV	R2, #1056964608
BL	__Mul_FP+0
STR	R0, [SP, #20]
;MadgwickAHRS.c,61 :: 		qDot4 = 0.5f * (q0 * gz + q1 * gy - q2 * gx);
LDR	R2, [SP, #132]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #128]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
MOV	R2, R9
BL	__Mul_FP+0
; gx end address is: 36 (R9)
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
MOV	R2, #1056964608
BL	__Mul_FP+0
STR	R0, [SP, #24]
;MadgwickAHRS.c,64 :: 		if(!((ax == 0.0f) && (ay == 0.0f) && (az == 0.0f))) {
LDR	R2, [SP, #136]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdate19
MOVS	R0, #1
L__MadgwickAHRSupdate19:
CMP	R0, #0
IT	EQ
BEQ	L_MadgwickAHRSupdate4
LDR	R2, [SP, #240]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdate20
MOVS	R0, #1
L__MadgwickAHRSupdate20:
CMP	R0, #0
IT	EQ
BEQ	L_MadgwickAHRSupdate4
LDR	R2, [SP, #244]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdate21
MOVS	R0, #1
L__MadgwickAHRSupdate21:
CMP	R0, #0
IT	EQ
BEQ	L_MadgwickAHRSupdate4
MOVS	R4, #1
IT	AL
BAL	L_MadgwickAHRSupdate3
L_MadgwickAHRSupdate4:
MOVS	R4, #0
L_MadgwickAHRSupdate3:
CMP	R4, #0
IT	NE
BNE	L__MadgwickAHRSupdate14
;MadgwickAHRS.c,67 :: 		recipNorm = invSqrt(ax * ax + ay * ay + az * az);
LDR	R2, [SP, #136]
LDR	R0, [SP, #136]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #240]
LDR	R0, [SP, #240]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #244]
LDR	R0, [SP, #244]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
BL	_invSqrt+0
; recipNorm start address is: 32 (R8)
MOV	R8, R0
;MadgwickAHRS.c,68 :: 		ax *= recipNorm;
LDR	R2, [SP, #136]
BL	__Mul_FP+0
STR	R0, [SP, #136]
;MadgwickAHRS.c,69 :: 		ay *= recipNorm;
LDR	R0, [SP, #240]
MOV	R2, R8
BL	__Mul_FP+0
STR	R0, [SP, #240]
;MadgwickAHRS.c,70 :: 		az *= recipNorm;
LDR	R0, [SP, #244]
MOV	R2, R8
BL	__Mul_FP+0
; recipNorm end address is: 32 (R8)
STR	R0, [SP, #244]
;MadgwickAHRS.c,73 :: 		recipNorm = invSqrt(mx * mx + my * my + mz * mz);
LDR	R2, [SP, #248]
LDR	R0, [SP, #248]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #252]
LDR	R0, [SP, #252]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #256]
LDR	R0, [SP, #256]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
BL	_invSqrt+0
; recipNorm start address is: 32 (R8)
MOV	R8, R0
;MadgwickAHRS.c,74 :: 		mx *= recipNorm;
LDR	R2, [SP, #248]
BL	__Mul_FP+0
STR	R0, [SP, #248]
;MadgwickAHRS.c,75 :: 		my *= recipNorm;
LDR	R0, [SP, #252]
MOV	R2, R8
BL	__Mul_FP+0
STR	R0, [SP, #252]
;MadgwickAHRS.c,76 :: 		mz *= recipNorm;
LDR	R0, [SP, #256]
MOV	R2, R8
BL	__Mul_FP+0
; recipNorm end address is: 32 (R8)
STR	R0, [SP, #256]
;MadgwickAHRS.c,79 :: 		_2q0mx = 2.0f * q0 * mx;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #248]
BL	__Mul_FP+0
STR	R0, [SP, #32]
;MadgwickAHRS.c,80 :: 		_2q0my = 2.0f * q0 * my;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #252]
BL	__Mul_FP+0
STR	R0, [SP, #36]
;MadgwickAHRS.c,81 :: 		_2q0mz = 2.0f * q0 * mz;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #256]
BL	__Mul_FP+0
STR	R0, [SP, #40]
;MadgwickAHRS.c,82 :: 		_2q1mx = 2.0f * q1 * mx;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #248]
BL	__Mul_FP+0
STR	R0, [SP, #44]
;MadgwickAHRS.c,83 :: 		_2q0 = 2.0f * q0;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #64]
;MadgwickAHRS.c,84 :: 		_2q1 = 2.0f * q1;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #68]
;MadgwickAHRS.c,85 :: 		_2q2 = 2.0f * q2;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #72]
;MadgwickAHRS.c,86 :: 		_2q3 = 2.0f * q3;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #76]
;MadgwickAHRS.c,87 :: 		_2q0q2 = 2.0f * q0 * q2;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #80]
;MadgwickAHRS.c,88 :: 		_2q2q3 = 2.0f * q2 * q3;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #84]
;MadgwickAHRS.c,89 :: 		q0q0 = q0 * q0;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #88]
;MadgwickAHRS.c,90 :: 		q0q1 = q0 * q1;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #92]
;MadgwickAHRS.c,91 :: 		q0q2 = q0 * q2;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
;MadgwickAHRS.c,92 :: 		q0q3 = q0 * q3;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #100]
;MadgwickAHRS.c,93 :: 		q1q1 = q1 * q1;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #104]
;MadgwickAHRS.c,94 :: 		q1q2 = q1 * q2;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #108]
;MadgwickAHRS.c,95 :: 		q1q3 = q1 * q3;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #112]
;MadgwickAHRS.c,96 :: 		q2q2 = q2 * q2;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #116]
;MadgwickAHRS.c,97 :: 		q2q3 = q2 * q3;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #120]
;MadgwickAHRS.c,98 :: 		q3q3 = q3 * q3;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #124]
;MadgwickAHRS.c,101 :: 		hx = mx * q0q0 - _2q0my * q3 + _2q0mz * q2 + mx * q1q1 + _2q1 * my * q2 + _2q1 * mz * q3 - mx * q2q2 - mx * q3q3;
LDR	R2, [SP, #88]
LDR	R0, [SP, #248]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #36]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #40]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #104]
LDR	R0, [SP, #248]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #252]
LDR	R0, [SP, #68]
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #256]
LDR	R0, [SP, #68]
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #116]
LDR	R0, [SP, #248]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #124]
LDR	R0, [SP, #248]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #28]
;MadgwickAHRS.c,102 :: 		hy = _2q0mx * q3 + my * q0q0 - _2q0mz * q1 + _2q1mx * q2 - my * q1q1 + my * q2q2 + _2q2 * mz * q3 - my * q3q3;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #32]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #88]
LDR	R0, [SP, #252]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #40]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #44]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #104]
LDR	R0, [SP, #252]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #116]
LDR	R0, [SP, #252]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #256]
LDR	R0, [SP, #72]
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #124]
LDR	R0, [SP, #252]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
; hy start address is: 32 (R8)
MOV	R8, R0
;MadgwickAHRS.c,103 :: 		_2bx = sqrt(hx * hx + hy * hy);
LDR	R2, [SP, #28]
LDR	R0, [SP, #28]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOV	R0, R8
MOV	R2, R8
BL	__Mul_FP+0
; hy end address is: 32 (R8)
LDR	R2, [SP, #216]
BL	__Add_FP+0
BL	_sqrt+0
STR	R0, [SP, #48]
;MadgwickAHRS.c,104 :: 		_2bz = -_2q0mx * q2 + _2q0my * q1 + mz * q0q0 + _2q1mx * q3 - mz * q1q1 + _2q2 * my * q3 - mz * q2q2 + mz * q3q3;
LDR	R4, [SP, #32]
EOR	R2, R4, #-2147483648
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #36]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #88]
LDR	R0, [SP, #256]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #44]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #104]
LDR	R0, [SP, #256]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #252]
LDR	R0, [SP, #72]
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #116]
LDR	R0, [SP, #256]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #124]
LDR	R0, [SP, #256]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #52]
;MadgwickAHRS.c,105 :: 		_4bx = 2.0f * _2bx;
LDR	R2, [SP, #48]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #56]
;MadgwickAHRS.c,106 :: 		_4bz = 2.0f * _2bz;
LDR	R2, [SP, #52]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #60]
;MadgwickAHRS.c,109 :: 		s0 = -_2q2 * (2.0f * q1q3 - _2q0q2 - ax) + _2q1 * (2.0f * q0q1 + _2q2q3 - ay) - _2bz * q2 * (_2bx * (0.5f - q2q2 - q3q3) + _2bz * (q1q3 - q0q2) - mx) + (-_2bx * q3 + _2bz * q1) * (_2bx * (q1q2 - q0q3) + _2bz * (q0q1 + q2q3) - my) + _2bx * q2 * (_2bx * (q0q2 + q1q3) + _2bz * (0.5f - q1q1 - q2q2) - mz);
LDR	R4, [SP, #72]
EOR	R4, R4, #-2147483648
STR	R4, [SP, #216]
LDR	R2, [SP, #112]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #80]
BL	__Sub_FP+0
LDR	R2, [SP, #136]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #92]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #84]
BL	__Add_FP+0
LDR	R2, [SP, #240]
BL	__Sub_FP+0
LDR	R2, [SP, #68]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #224]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
STR	R0, [SP, #220]
LDR	R2, [SP, #116]
MOV	R0, #1056964608
BL	__Sub_FP+0
LDR	R2, [SP, #124]
BL	__Sub_FP+0
LDR	R2, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #96]
LDR	R0, [SP, #112]
BL	__Sub_FP+0
LDR	R2, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
STR	R0, [SP, #236]
BL	__Add_FP+0
LDR	R2, [SP, #248]
BL	__Sub_FP+0
LDR	R2, [SP, #220]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #224]
BL	__Sub_FP+0
STR	R0, [SP, #224]
LDR	R4, [SP, #48]
EOR	R2, R4, #-2147483648
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #220]
LDR	R2, [SP, #100]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
LDR	R2, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #120]
LDR	R0, [SP, #92]
BL	__Add_FP+0
LDR	R2, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #232]
LDR	R2, [SP, #252]
BL	__Sub_FP+0
LDR	R2, [SP, #220]
BL	__Mul_FP+0
LDR	R2, [SP, #224]
BL	__Add_FP+0
STR	R0, [SP, #220]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #112]
LDR	R0, [SP, #96]
BL	__Add_FP+0
LDR	R2, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #228]
LDR	R2, [SP, #104]
MOV	R0, #1056964608
BL	__Sub_FP+0
LDR	R2, [SP, #116]
BL	__Sub_FP+0
LDR	R2, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #228]
BL	__Add_FP+0
LDR	R2, [SP, #256]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
LDR	R2, [SP, #220]
BL	__Add_FP+0
STR	R0, [SP, #4]
;MadgwickAHRS.c,110 :: 		s1 = _2q3 * (2.0f * q1q3 - _2q0q2 - ax) + _2q0 * (2.0f * q0q1 + _2q2q3 - ay) - 4.0f * q1 * (1 - 2.0f * q1q1 - 2.0f * q2q2 - az) + _2bz * q3 * (_2bx * (0.5f - q2q2 - q3q3) + _2bz * (q1q3 - q0q2) - mx) + (_2bx * q2 + _2bz * q0) * (_2bx * (q1q2 - q0q3) + _2bz * (q0q1 + q2q3) - my) + (_2bx * q3 - _4bz * q1) * (_2bx * (q0q2 + q1q3) + _2bz * (0.5f - q1q1 - q2q2) - mz);
LDR	R2, [SP, #112]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #80]
BL	__Sub_FP+0
LDR	R2, [SP, #136]
BL	__Sub_FP+0
LDR	R2, [SP, #76]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #92]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #84]
BL	__Add_FP+0
LDR	R2, [SP, #240]
BL	__Sub_FP+0
LDR	R2, [SP, #64]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #224]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOV	R0, #1082130432
BL	__Mul_FP+0
STR	R0, [SP, #220]
LDR	R2, [SP, #104]
MOV	R0, #1073741824
BL	__Mul_FP+0
MOV	R2, R0
MOV	R0, #1065353216
BL	__Sub_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #116]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
LDR	R2, [SP, #244]
BL	__Sub_FP+0
LDR	R2, [SP, #220]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #224]
BL	__Sub_FP+0
STR	R0, [SP, #220]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #116]
MOV	R0, #1056964608
BL	__Sub_FP+0
LDR	R2, [SP, #124]
BL	__Sub_FP+0
LDR	R2, [SP, #48]
BL	__Mul_FP+0
LDR	R2, [SP, #236]
BL	__Add_FP+0
LDR	R2, [SP, #248]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
LDR	R2, [SP, #220]
BL	__Add_FP+0
STR	R0, [SP, #220]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #252]
LDR	R0, [SP, #232]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
LDR	R2, [SP, #220]
BL	__Add_FP+0
STR	R0, [SP, #224]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #60]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
LDR	R4, [SP, #228]
STR	R0, [SP, #220]
STR	R4, [SP, #216]
LDR	R2, [SP, #104]
MOV	R0, #1056964608
BL	__Sub_FP+0
LDR	R2, [SP, #116]
BL	__Sub_FP+0
LDR	R2, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
LDR	R2, [SP, #256]
BL	__Sub_FP+0
LDR	R2, [SP, #220]
BL	__Mul_FP+0
LDR	R2, [SP, #224]
BL	__Add_FP+0
STR	R0, [SP, #8]
;MadgwickAHRS.c,111 :: 		s2 = -_2q0 * (2.0f * q1q3 - _2q0q2 - ax) + _2q3 * (2.0f * q0q1 + _2q2q3 - ay) - 4.0f * q2 * (1 - 2.0f * q1q1 - 2.0f * q2q2 - az) + (-_4bx * q2 - _2bz * q0) * (_2bx * (0.5f - q2q2 - q3q3) + _2bz * (q1q3 - q0q2) - mx) + (_2bx * q1 + _2bz * q3) * (_2bx * (q1q2 - q0q3) + _2bz * (q0q1 + q2q3) - my) + (_2bx * q0 - _4bz * q2) * (_2bx * (q0q2 + q1q3) + _2bz * (0.5f - q1q1 - q2q2) - mz);
LDR	R4, [SP, #64]
EOR	R4, R4, #-2147483648
STR	R4, [SP, #216]
LDR	R2, [SP, #112]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #80]
BL	__Sub_FP+0
LDR	R2, [SP, #136]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #92]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #84]
BL	__Add_FP+0
LDR	R2, [SP, #240]
BL	__Sub_FP+0
LDR	R2, [SP, #76]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #224]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOV	R0, #1082130432
BL	__Mul_FP+0
STR	R0, [SP, #220]
LDR	R2, [SP, #104]
MOV	R0, #1073741824
BL	__Mul_FP+0
MOV	R2, R0
MOV	R0, #1065353216
BL	__Sub_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #116]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
LDR	R2, [SP, #244]
BL	__Sub_FP+0
LDR	R2, [SP, #220]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #224]
BL	__Sub_FP+0
STR	R0, [SP, #220]
LDR	R4, [SP, #56]
EOR	R2, R4, #-2147483648
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #116]
MOV	R0, #1056964608
BL	__Sub_FP+0
LDR	R2, [SP, #124]
BL	__Sub_FP+0
LDR	R2, [SP, #48]
BL	__Mul_FP+0
LDR	R2, [SP, #236]
BL	__Add_FP+0
LDR	R2, [SP, #248]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
LDR	R2, [SP, #220]
BL	__Add_FP+0
STR	R0, [SP, #220]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #252]
LDR	R0, [SP, #232]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
LDR	R2, [SP, #220]
BL	__Add_FP+0
STR	R0, [SP, #224]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #60]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #216]
BL	__Sub_FP+0
LDR	R4, [SP, #228]
STR	R0, [SP, #220]
STR	R4, [SP, #216]
LDR	R2, [SP, #104]
MOV	R0, #1056964608
BL	__Sub_FP+0
LDR	R2, [SP, #116]
BL	__Sub_FP+0
LDR	R2, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
LDR	R2, [SP, #256]
BL	__Sub_FP+0
LDR	R2, [SP, #220]
BL	__Mul_FP+0
LDR	R2, [SP, #224]
BL	__Add_FP+0
; s2 start address is: 36 (R9)
MOV	R9, R0
;MadgwickAHRS.c,112 :: 		s3 = _2q1 * (2.0f * q1q3 - _2q0q2 - ax) + _2q2 * (2.0f * q0q1 + _2q2q3 - ay) + (-_4bx * q3 + _2bz * q1) * (_2bx * (0.5f - q2q2 - q3q3) + _2bz * (q1q3 - q0q2) - mx) + (-_2bx * q0 + _2bz * q2) * (_2bx * (q1q2 - q0q3) + _2bz * (q0q1 + q2q3) - my) + _2bx * q1 * (_2bx * (q0q2 + q1q3) + _2bz * (0.5f - q1q1 - q2q2) - mz);
LDR	R2, [SP, #112]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #80]
BL	__Sub_FP+0
LDR	R2, [SP, #136]
BL	__Sub_FP+0
LDR	R2, [SP, #68]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #92]
MOV	R0, #1073741824
BL	__Mul_FP+0
LDR	R2, [SP, #84]
BL	__Add_FP+0
LDR	R2, [SP, #240]
BL	__Sub_FP+0
LDR	R2, [SP, #72]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #220]
LDR	R4, [SP, #56]
EOR	R2, R4, #-2147483648
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #116]
MOV	R0, #1056964608
BL	__Sub_FP+0
LDR	R2, [SP, #124]
BL	__Sub_FP+0
LDR	R2, [SP, #48]
BL	__Mul_FP+0
LDR	R2, [SP, #236]
BL	__Add_FP+0
LDR	R2, [SP, #248]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
LDR	R2, [SP, #220]
BL	__Add_FP+0
STR	R0, [SP, #220]
LDR	R4, [SP, #48]
EOR	R2, R4, #-2147483648
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #252]
LDR	R0, [SP, #232]
BL	__Sub_FP+0
LDR	R2, [SP, #216]
BL	__Mul_FP+0
LDR	R2, [SP, #220]
BL	__Add_FP+0
STR	R0, [SP, #224]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
LDR	R0, [SP, #48]
BL	__Mul_FP+0
LDR	R4, [SP, #228]
STR	R0, [SP, #220]
STR	R4, [SP, #216]
LDR	R2, [SP, #104]
MOV	R0, #1056964608
BL	__Sub_FP+0
LDR	R2, [SP, #116]
BL	__Sub_FP+0
LDR	R2, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
LDR	R2, [SP, #256]
BL	__Sub_FP+0
LDR	R2, [SP, #220]
BL	__Mul_FP+0
LDR	R2, [SP, #224]
BL	__Add_FP+0
STR	R0, [SP, #12]
;MadgwickAHRS.c,113 :: 		recipNorm = invSqrt(s0 * s0 + s1 * s1 + s2 * s2 + s3 * s3); // normalise step magnitude
LDR	R2, [SP, #4]
LDR	R0, [SP, #4]
BL	__Mul_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #8]
LDR	R0, [SP, #8]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
MOV	R0, R9
MOV	R2, R9
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
LDR	R2, [SP, #12]
LDR	R0, [SP, #12]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
BL	_invSqrt+0
; recipNorm start address is: 32 (R8)
MOV	R8, R0
;MadgwickAHRS.c,114 :: 		s0 *= recipNorm;
LDR	R2, [SP, #4]
BL	__Mul_FP+0
STR	R0, [SP, #4]
;MadgwickAHRS.c,115 :: 		s1 *= recipNorm;
LDR	R0, [SP, #8]
MOV	R2, R8
BL	__Mul_FP+0
STR	R0, [SP, #8]
;MadgwickAHRS.c,116 :: 		s2 *= recipNorm;
MOV	R0, R8
MOV	R2, R9
BL	__Mul_FP+0
MOV	R9, R0
;MadgwickAHRS.c,117 :: 		s3 *= recipNorm;
LDR	R0, [SP, #12]
MOV	R2, R8
BL	__Mul_FP+0
; recipNorm end address is: 32 (R8)
STR	R0, [SP, #12]
;MadgwickAHRS.c,120 :: 		qDot1 -= beta * s0;
LDR	R2, [SP, #4]
MOVW	R4, #lo_addr(_beta+0)
MOVT	R4, #hi_addr(_beta+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
MOV	R0, R12
BL	__Sub_FP+0
; qDot1 end address is: 48 (R12)
; qDot1 start address is: 40 (R10)
MOV	R10, R0
;MadgwickAHRS.c,121 :: 		qDot2 -= beta * s1;
LDR	R2, [SP, #8]
MOVW	R4, #lo_addr(_beta+0)
MOVT	R4, #hi_addr(_beta+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #16]
BL	__Sub_FP+0
STR	R0, [SP, #16]
;MadgwickAHRS.c,122 :: 		qDot3 -= beta * s2;
MOVW	R4, #lo_addr(_beta+0)
MOVT	R4, #hi_addr(_beta+0)
LDR	R0, [R4, #0]
MOV	R2, R9
BL	__Mul_FP+0
; s2 end address is: 36 (R9)
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #20]
BL	__Sub_FP+0
STR	R0, [SP, #20]
;MadgwickAHRS.c,123 :: 		qDot4 -= beta * s3;
LDR	R2, [SP, #12]
MOVW	R4, #lo_addr(_beta+0)
MOVT	R4, #hi_addr(_beta+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #140]
LDR	R2, [SP, #140]
LDR	R0, [SP, #24]
BL	__Sub_FP+0
STR	R0, [SP, #24]
; qDot1 end address is: 40 (R10)
MOV	R1, R10
;MadgwickAHRS.c,124 :: 		}
IT	AL
BAL	L_MadgwickAHRSupdate5
L__MadgwickAHRSupdate14:
;MadgwickAHRS.c,64 :: 		if(!((ax == 0.0f) && (ay == 0.0f) && (az == 0.0f))) {
MOV	R1, R12
;MadgwickAHRS.c,124 :: 		}
L_MadgwickAHRSupdate5:
;MadgwickAHRS.c,127 :: 		q0 += qDot1 * (1.0f / sampleFreq);
; qDot1 start address is: 4 (R1)
MOVW	R0, #23889
MOVT	R0, #15457
MOV	R2, R1
BL	__Mul_FP+0
; qDot1 end address is: 4 (R1)
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
BL	__Add_FP+0
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,128 :: 		q1 += qDot2 * (1.0f / sampleFreq);
LDR	R2, [SP, #16]
MOVW	R0, #23889
MOVT	R0, #15457
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
BL	__Add_FP+0
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,129 :: 		q2 += qDot3 * (1.0f / sampleFreq);
LDR	R2, [SP, #20]
MOVW	R0, #23889
MOVT	R0, #15457
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
BL	__Add_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,130 :: 		q3 += qDot4 * (1.0f / sampleFreq);
LDR	R2, [SP, #24]
MOVW	R0, #23889
MOVT	R0, #15457
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
BL	__Add_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,133 :: 		recipNorm = invSqrt(q0 * q0 + q1 * q1 + q2 * q2 + q3 * q3);
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
STR	R0, [SP, #216]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #216]
BL	__Add_FP+0
BL	_invSqrt+0
; recipNorm start address is: 32 (R8)
MOV	R8, R0
;MadgwickAHRS.c,134 :: 		q0 *= recipNorm;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,135 :: 		q1 *= recipNorm;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
MOV	R2, R8
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,136 :: 		q2 *= recipNorm;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
MOV	R2, R8
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,137 :: 		q3 *= recipNorm;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
MOV	R2, R8
BL	__Mul_FP+0
; recipNorm end address is: 32 (R8)
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,138 :: 		}
L_end_MadgwickAHRSupdate:
LDR	LR, [SP, #0]
ADD	SP, SP, #240
BX	LR
; end of _MadgwickAHRSupdate
_MadgwickAHRSupdateIMU:
;MadgwickAHRS.c,143 :: 		void MadgwickAHRSupdateIMU(float gx, float gy, float gz, float ax, float ay, float az) {
; gx start address is: 0 (R0)
SUB	SP, SP, #112
STR	LR, [SP, #0]
MOV	R9, R0
STR	R1, [SP, #84]
STR	R2, [SP, #88]
STR	R3, [SP, #92]
; gx end address is: 0 (R0)
; gx start address is: 36 (R9)
LDR	R4, [SP, #112]
STR	R4, [SP, #112]
LDR	R4, [SP, #116]
STR	R4, [SP, #116]
;MadgwickAHRS.c,150 :: 		qDot1 = 0.5f * (-q1 * gx - q2 * gy - q3 * gz);
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R4, [R4, #0]
EOR	R0, R4, #-2147483648
MOV	R2, R9
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #84]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #88]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
MOV	R2, #1056964608
BL	__Mul_FP+0
STR	R0, [SP, #20]
;MadgwickAHRS.c,151 :: 		qDot2 = 0.5f * (q0 * gx + q2 * gz - q3 * gy);
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
MOV	R2, R9
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #88]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #84]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
MOV	R2, #1056964608
BL	__Mul_FP+0
STR	R0, [SP, #24]
;MadgwickAHRS.c,152 :: 		qDot3 = 0.5f * (q0 * gy - q1 * gz + q3 * gx);
LDR	R2, [SP, #84]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #88]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
STR	R0, [SP, #108]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
MOV	R2, R9
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
MOV	R2, #1056964608
BL	__Mul_FP+0
STR	R0, [SP, #28]
;MadgwickAHRS.c,153 :: 		qDot4 = 0.5f * (q0 * gz + q1 * gy - q2 * gx);
LDR	R2, [SP, #88]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #84]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
MOV	R2, R9
BL	__Mul_FP+0
; gx end address is: 36 (R9)
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
MOV	R2, #1056964608
BL	__Mul_FP+0
; qDot4 start address is: 48 (R12)
MOV	R12, R0
;MadgwickAHRS.c,156 :: 		if(!((ax == 0.0f) && (ay == 0.0f) && (az == 0.0f))) {
LDR	R2, [SP, #92]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdateIMU23
MOVS	R0, #1
L__MadgwickAHRSupdateIMU23:
CMP	R0, #0
IT	EQ
BEQ	L_MadgwickAHRSupdateIMU7
LDR	R2, [SP, #112]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdateIMU24
MOVS	R0, #1
L__MadgwickAHRSupdateIMU24:
CMP	R0, #0
IT	EQ
BEQ	L_MadgwickAHRSupdateIMU7
LDR	R2, [SP, #116]
MOV	R0, #0
BL	__Compare_FP+0
MOVW	R0, #0
BNE	L__MadgwickAHRSupdateIMU25
MOVS	R0, #1
L__MadgwickAHRSupdateIMU25:
CMP	R0, #0
IT	EQ
BEQ	L_MadgwickAHRSupdateIMU7
MOVS	R4, #1
IT	AL
BAL	L_MadgwickAHRSupdateIMU6
L_MadgwickAHRSupdateIMU7:
MOVS	R4, #0
L_MadgwickAHRSupdateIMU6:
CMP	R4, #0
IT	NE
BNE	L__MadgwickAHRSupdateIMU9
;MadgwickAHRS.c,159 :: 		recipNorm = invSqrt(ax * ax + ay * ay + az * az);
LDR	R2, [SP, #92]
LDR	R0, [SP, #92]
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #112]
LDR	R0, [SP, #112]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #116]
LDR	R0, [SP, #116]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
BL	_invSqrt+0
; recipNorm start address is: 32 (R8)
MOV	R8, R0
;MadgwickAHRS.c,160 :: 		ax *= recipNorm;
LDR	R2, [SP, #92]
BL	__Mul_FP+0
STR	R0, [SP, #92]
;MadgwickAHRS.c,161 :: 		ay *= recipNorm;
LDR	R0, [SP, #112]
MOV	R2, R8
BL	__Mul_FP+0
STR	R0, [SP, #112]
;MadgwickAHRS.c,162 :: 		az *= recipNorm;
LDR	R0, [SP, #116]
MOV	R2, R8
BL	__Mul_FP+0
; recipNorm end address is: 32 (R8)
STR	R0, [SP, #116]
;MadgwickAHRS.c,165 :: 		_2q0 = 2.0f * q0;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #32]
;MadgwickAHRS.c,166 :: 		_2q1 = 2.0f * q1;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #36]
;MadgwickAHRS.c,167 :: 		_2q2 = 2.0f * q2;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #40]
;MadgwickAHRS.c,168 :: 		_2q3 = 2.0f * q3;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOV	R0, #1073741824
BL	__Mul_FP+0
STR	R0, [SP, #44]
;MadgwickAHRS.c,169 :: 		_4q0 = 4.0f * q0;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOV	R0, #1082130432
BL	__Mul_FP+0
STR	R0, [SP, #48]
;MadgwickAHRS.c,170 :: 		_4q1 = 4.0f * q1;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOV	R0, #1082130432
BL	__Mul_FP+0
STR	R0, [SP, #52]
;MadgwickAHRS.c,171 :: 		_4q2 = 4.0f * q2;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOV	R0, #1082130432
BL	__Mul_FP+0
STR	R0, [SP, #56]
;MadgwickAHRS.c,172 :: 		_8q1 = 8.0f * q1;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOV	R0, #1090519040
BL	__Mul_FP+0
STR	R0, [SP, #60]
;MadgwickAHRS.c,173 :: 		_8q2 = 8.0f * q2;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOV	R0, #1090519040
BL	__Mul_FP+0
STR	R0, [SP, #64]
;MadgwickAHRS.c,174 :: 		q0q0 = q0 * q0;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #68]
;MadgwickAHRS.c,175 :: 		q1q1 = q1 * q1;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #72]
;MadgwickAHRS.c,176 :: 		q2q2 = q2 * q2;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #76]
;MadgwickAHRS.c,177 :: 		q3q3 = q3 * q3;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #80]
;MadgwickAHRS.c,180 :: 		s0 = _4q0 * q2q2 + _2q2 * ax + _4q0 * q1q1 - _2q1 * ay;
LDR	R2, [SP, #76]
LDR	R0, [SP, #48]
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #92]
LDR	R0, [SP, #40]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #72]
LDR	R0, [SP, #48]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #112]
LDR	R0, [SP, #36]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
STR	R0, [SP, #4]
;MadgwickAHRS.c,181 :: 		s1 = _4q1 * q3q3 - _2q3 * ax + 4.0f * q0q0 * q1 - _2q0 * ay - _4q1 + _8q1 * q1q1 + _8q1 * q2q2 + _4q1 * az;
LDR	R2, [SP, #80]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #92]
LDR	R0, [SP, #44]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #68]
MOV	R0, #1082130432
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #112]
LDR	R0, [SP, #32]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
LDR	R2, [SP, #52]
BL	__Sub_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #72]
LDR	R0, [SP, #60]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #76]
LDR	R0, [SP, #60]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #116]
LDR	R0, [SP, #52]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #8]
;MadgwickAHRS.c,182 :: 		s2 = 4.0f * q0q0 * q2 + _2q0 * ax + _4q2 * q3q3 - _2q3 * ay - _4q2 + _8q2 * q1q1 + _8q2 * q2q2 + _4q2 * az;
LDR	R2, [SP, #68]
MOV	R0, #1082130432
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #92]
LDR	R0, [SP, #32]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #80]
LDR	R0, [SP, #56]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #112]
LDR	R0, [SP, #44]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
LDR	R2, [SP, #56]
BL	__Sub_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #72]
LDR	R0, [SP, #64]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #76]
LDR	R0, [SP, #64]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #116]
LDR	R0, [SP, #56]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #12]
;MadgwickAHRS.c,183 :: 		s3 = 4.0f * q1q1 * q3 - _2q1 * ax + 4.0f * q2q2 * q3 - _2q2 * ay;
LDR	R2, [SP, #72]
MOV	R0, #1082130432
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #92]
LDR	R0, [SP, #36]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #76]
MOV	R0, #1082130432
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #112]
LDR	R0, [SP, #40]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #108]
BL	__Sub_FP+0
STR	R0, [SP, #16]
;MadgwickAHRS.c,184 :: 		recipNorm = invSqrt(s0 * s0 + s1 * s1 + s2 * s2 + s3 * s3); // normalise step magnitude
LDR	R2, [SP, #4]
LDR	R0, [SP, #4]
BL	__Mul_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #8]
LDR	R0, [SP, #8]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #12]
LDR	R0, [SP, #12]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
LDR	R2, [SP, #16]
LDR	R0, [SP, #16]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
BL	_invSqrt+0
; recipNorm start address is: 32 (R8)
MOV	R8, R0
;MadgwickAHRS.c,185 :: 		s0 *= recipNorm;
LDR	R2, [SP, #4]
BL	__Mul_FP+0
STR	R0, [SP, #4]
;MadgwickAHRS.c,186 :: 		s1 *= recipNorm;
LDR	R0, [SP, #8]
MOV	R2, R8
BL	__Mul_FP+0
STR	R0, [SP, #8]
;MadgwickAHRS.c,187 :: 		s2 *= recipNorm;
LDR	R0, [SP, #12]
MOV	R2, R8
BL	__Mul_FP+0
STR	R0, [SP, #12]
;MadgwickAHRS.c,188 :: 		s3 *= recipNorm;
LDR	R0, [SP, #16]
MOV	R2, R8
BL	__Mul_FP+0
; recipNorm end address is: 32 (R8)
STR	R0, [SP, #16]
;MadgwickAHRS.c,191 :: 		qDot1 -= beta * s0;
LDR	R2, [SP, #4]
MOVW	R4, #lo_addr(_beta+0)
MOVT	R4, #hi_addr(_beta+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #20]
BL	__Sub_FP+0
STR	R0, [SP, #20]
;MadgwickAHRS.c,192 :: 		qDot2 -= beta * s1;
LDR	R2, [SP, #8]
MOVW	R4, #lo_addr(_beta+0)
MOVT	R4, #hi_addr(_beta+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #24]
BL	__Sub_FP+0
STR	R0, [SP, #24]
;MadgwickAHRS.c,193 :: 		qDot3 -= beta * s2;
LDR	R2, [SP, #12]
MOVW	R4, #lo_addr(_beta+0)
MOVT	R4, #hi_addr(_beta+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
LDR	R0, [SP, #28]
BL	__Sub_FP+0
STR	R0, [SP, #28]
;MadgwickAHRS.c,194 :: 		qDot4 -= beta * s3;
LDR	R2, [SP, #16]
MOVW	R4, #lo_addr(_beta+0)
MOVT	R4, #hi_addr(_beta+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #96]
LDR	R2, [SP, #96]
MOV	R0, R12
BL	__Sub_FP+0
; qDot4 end address is: 48 (R12)
; qDot4 start address is: 36 (R9)
MOV	R9, R0
; qDot4 end address is: 36 (R9)
;MadgwickAHRS.c,195 :: 		}
IT	AL
BAL	L_MadgwickAHRSupdateIMU8
L__MadgwickAHRSupdateIMU9:
;MadgwickAHRS.c,156 :: 		if(!((ax == 0.0f) && (ay == 0.0f) && (az == 0.0f))) {
MOV	R9, R12
;MadgwickAHRS.c,195 :: 		}
L_MadgwickAHRSupdateIMU8:
;MadgwickAHRS.c,198 :: 		q0 += qDot1 * (1.0f / sampleFreq);
; qDot4 start address is: 36 (R9)
LDR	R2, [SP, #20]
MOVW	R0, #23889
MOVT	R0, #15457
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
BL	__Add_FP+0
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,199 :: 		q1 += qDot2 * (1.0f / sampleFreq);
LDR	R2, [SP, #24]
MOVW	R0, #23889
MOVT	R0, #15457
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
BL	__Add_FP+0
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,200 :: 		q2 += qDot3 * (1.0f / sampleFreq);
LDR	R2, [SP, #28]
MOVW	R0, #23889
MOVT	R0, #15457
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
BL	__Add_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,201 :: 		q3 += qDot4 * (1.0f / sampleFreq);
MOVW	R0, #23889
MOVT	R0, #15457
MOV	R2, R9
BL	__Mul_FP+0
; qDot4 end address is: 36 (R9)
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
BL	__Add_FP+0
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,204 :: 		recipNorm = invSqrt(q0 * q0 + q1 * q1 + q2 * q2 + q3 * q3);
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
STR	R0, [SP, #108]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
STR	R0, [SP, #108]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R2, [R4, #0]
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
BL	__Mul_FP+0
LDR	R2, [SP, #108]
BL	__Add_FP+0
BL	_invSqrt+0
; recipNorm start address is: 32 (R8)
MOV	R8, R0
;MadgwickAHRS.c,205 :: 		q0 *= recipNorm;
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
LDR	R2, [R4, #0]
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q0+0)
MOVT	R4, #hi_addr(_q0+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,206 :: 		q1 *= recipNorm;
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
LDR	R0, [R4, #0]
MOV	R2, R8
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q1+0)
MOVT	R4, #hi_addr(_q1+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,207 :: 		q2 *= recipNorm;
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
LDR	R0, [R4, #0]
MOV	R2, R8
BL	__Mul_FP+0
MOVW	R4, #lo_addr(_q2+0)
MOVT	R4, #hi_addr(_q2+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,208 :: 		q3 *= recipNorm;
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
LDR	R0, [R4, #0]
MOV	R2, R8
BL	__Mul_FP+0
; recipNorm end address is: 32 (R8)
MOVW	R4, #lo_addr(_q3+0)
MOVT	R4, #hi_addr(_q3+0)
STR	R0, [R4, #0]
;MadgwickAHRS.c,209 :: 		}
L_end_MadgwickAHRSupdateIMU:
LDR	LR, [SP, #0]
ADD	SP, SP, #112
BX	LR
; end of _MadgwickAHRSupdateIMU
_invSqrt:
;MadgwickAHRS.c,215 :: 		float invSqrt(float x) {
; x start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R8, R0
; x end address is: 0 (R0)
; x start address is: 32 (R8)
;MadgwickAHRS.c,216 :: 		float halfx = 0.5f * x;
MOV	R0, #1056964608
MOV	R2, R8
BL	__Mul_FP+0
;MadgwickAHRS.c,217 :: 		float y = x;
STR	R8, [SP, #4]
; x end address is: 32 (R8)
;MadgwickAHRS.c,218 :: 		long i = *(long*)&y;
ADD	R1, SP, #4
LDR	R1, [R1, #0]
STR	R1, [SP, #8]
;MadgwickAHRS.c,219 :: 		i = 0x5f3759df - (i>>1);
ASRS	R2, R1, #1
MOVW	R1, #23007
MOVT	R1, #24375
SUB	R1, R1, R2
STR	R1, [SP, #8]
;MadgwickAHRS.c,220 :: 		y = *(float*)&i;
ADD	R1, SP, #8
LDR	R2, [R1, #0]
STR	R2, [SP, #4]
;MadgwickAHRS.c,221 :: 		y = y * (1.5f - (halfx * y * y));
BL	__Mul_FP+0
LDR	R2, [SP, #4]
BL	__Mul_FP+0
MOV	R2, R0
MOV	R0, #1069547520
BL	__Sub_FP+0
LDR	R2, [SP, #4]
BL	__Mul_FP+0
STR	R0, [SP, #4]
;MadgwickAHRS.c,222 :: 		return y;
MOV	R0, R0
;MadgwickAHRS.c,223 :: 		}
L_end_invSqrt:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _invSqrt
