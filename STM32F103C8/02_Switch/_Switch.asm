_main:
;_Switch.c,20 :: 		void main() {
;_Switch.c,21 :: 		GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);        // Set PORTC13 as digital output
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
BL	_GPIO_Digital_Output+0
;_Switch.c,22 :: 		GPIO_Digital_Input (&GPIOB_IDR,  _GPIO_PINMASK_15);       // Set PB15 as digital input
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
BL	_GPIO_Digital_Input+0
;_Switch.c,24 :: 		oldstate = 0;                                            // set oldstate false
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate+0)
MOVT	R0, #hi_addr(_oldstate+0)
STRH	R1, [R0, #0]
;_Switch.c,26 :: 		while(1)
L_main0:
;_Switch.c,28 :: 		if (Button(&GPIOB_IDR, 15, 1, 1))                      // detect logical one on PB15 pin
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #15
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main2
;_Switch.c,30 :: 		GPIOC_ODR.B13 = 1;                                  // turn LED on
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;_Switch.c,31 :: 		oldstate = 1;                                       // oldstate  is true
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate+0)
MOVT	R0, #hi_addr(_oldstate+0)
STRH	R1, [R0, #0]
;_Switch.c,32 :: 		}
L_main2:
;_Switch.c,33 :: 		if (oldstate && Button(&GPIOB_IDR, 15, 1, 0))          // else
MOVW	R0, #lo_addr(_oldstate+0)
MOVT	R0, #hi_addr(_oldstate+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main8
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #15
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main7
L__main6:
;_Switch.c,35 :: 		GPIOC_ODR.B13 = 0;                                   // turn LED off
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;_Switch.c,36 :: 		oldstate = 0;                                        // oldstate is false
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate+0)
MOVT	R0, #hi_addr(_oldstate+0)
STRH	R1, [R0, #0]
;_Switch.c,33 :: 		if (oldstate && Button(&GPIOB_IDR, 15, 1, 0))          // else
L__main8:
L__main7:
;_Switch.c,38 :: 		}
IT	AL
BAL	L_main0
;_Switch.c,39 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
