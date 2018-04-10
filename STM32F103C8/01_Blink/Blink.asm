_main:
;Blink.c,17 :: 		void main()
;Blink.c,20 :: 		GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
BL	_GPIO_Digital_Output+0
;Blink.c,23 :: 		while(1)
L_main0:
;Blink.c,25 :: 		GPIOC_ODR.B13 = ~GPIOC_ODR.B13;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_LX	[R0, ByteOffset(GPIOC_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;Blink.c,26 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main2:
SUBS	R7, R7, #1
BNE	L_main2
NOP
NOP
NOP
;Blink.c,27 :: 		}
IT	AL
BAL	L_main0
;Blink.c,28 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
