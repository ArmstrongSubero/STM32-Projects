_Timer2_interrupt:
;Timer.c,17 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {
;Timer.c,18 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;Timer.c,19 :: 		GPIOC_ODR.B13 = ~GPIOC_ODR.B13; // Toggle PIN C13
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_LX	[R0, ByteOffset(GPIOC_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;Timer.c,20 :: 		}
L_end_Timer2_interrupt:
BX	LR
; end of _Timer2_interrupt
_main:
;Timer.c,23 :: 		void main() {
;Timer.c,24 :: 		GPIO_Digital_Output(&GPIOC_ODR, _GPIO_PINMASK_13);       // Set PORTC13 as digital output
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
BL	_GPIO_Digital_Output+0
;Timer.c,26 :: 		RCC_APB1ENR.TIM2EN = 1;       // Enable clock gating for timer module 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;Timer.c,27 :: 		TIM2_CR1.CEN = 0;             // Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;Timer.c,28 :: 		TIM2_PSC = 1098;              // Set timer prescaler.
MOVW	R1, #1098
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;Timer.c,29 :: 		TIM2_ARR = 65514;             // Auto reload register
MOVW	R1, #65514
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;Timer.c,30 :: 		NVIC_IntEnable(IVT_INT_TIM2); // Enable timer interrupt
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;Timer.c,31 :: 		TIM2_DIER.UIE = 1;            // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;Timer.c,32 :: 		TIM2_CR1.CEN = 1;             // Enable timer
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;Timer.c,33 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
