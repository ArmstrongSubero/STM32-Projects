_main:
;PWM.c,5 :: 		void main() {
;PWM.c,7 :: 		unsigned int ratio = PWM_TIM2_Init(10000);
MOVW	R0, #10000
BL	_PWM_TIM2_Init+0
;PWM.c,8 :: 		PWM_TIM2_Set_Duty(val,_PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;PWM.c,9 :: 		PWM_TIM2_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM2_CH1_PA0);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH1_PA0+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH1_PA0+0)
MOVS	R0, #0
BL	_PWM_TIM2_Start+0
;PWM.c,11 :: 		while(1)
L_main0:
;PWM.c,14 :: 		for (val = 0; val <= 65535; val++)
MOVS	R1, #0
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
STRH	R1, [R0, #0]
L_main2:
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
LDRH	R1, [R0, #0]
MOVW	R0, #65535
CMP	R1, R0
IT	HI
BHI	L_main3
;PWM.c,16 :: 		PWM_TIM2_Set_Duty(val,_PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;PWM.c,17 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main5:
SUBS	R7, R7, #1
BNE	L_main5
NOP
NOP
NOP
;PWM.c,19 :: 		if (val == 65530)
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
LDRH	R1, [R0, #0]
MOVW	R0, #65530
CMP	R1, R0
IT	NE
BNE	L_main7
;PWM.c,21 :: 		val = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_val+0)
MOVT	R0, #hi_addr(_val+0)
STRH	R1, [R0, #0]
;PWM.c,22 :: 		PWM_TIM2_Set_Duty(val,_PWM_NON_INVERTED, _PWM_CHANNEL1);
MOVW	R0, #0
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;PWM.c,23 :: 		}
L_main7:
;PWM.c,14 :: 		for (val = 0; val <= 65535; val++)
MOVW	R1, #lo_addr(_val+0)
MOVT	R1, #hi_addr(_val+0)
LDRH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;PWM.c,24 :: 		}
IT	AL
BAL	L_main2
L_main3:
;PWM.c,27 :: 		}
IT	AL
BAL	L_main0
;PWM.c,28 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
