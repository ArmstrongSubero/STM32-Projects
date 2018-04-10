_USB0Interrupt:
;USB.c,6 :: 		void USB0Interrupt() iv IVT_INT_USB_LP_CAN_RX0
SUB	SP, SP, #4
STR	LR, [SP, #0]
;USB.c,8 :: 		USB_Interrupt_Proc();
BL	_USB_Interrupt_Proc+0
;USB.c,9 :: 		}
L_end_USB0Interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _USB0Interrupt
_main:
;USB.c,11 :: 		void main(void){
;USB.c,15 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_9);
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;USB.c,16 :: 		GPIOA_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;USB.c,19 :: 		HID_Enable(&readbuff,&writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;USB.c,21 :: 		while(1)
L_main0:
;USB.c,24 :: 		n_byte= HID_Read();
BL	_HID_Read+0
;USB.c,25 :: 		if(n_byte !=0)         // packet received !
CMP	R0, #0
IT	EQ
BEQ	L_main2
;USB.c,28 :: 		if(readbuff[0]=='b')
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
LDRB	R0, [R0, #0]
CMP	R0, #98
IT	NE
BNE	L_main3
;USB.c,30 :: 		GPIOA_ODR.B9=1; // turn on led
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;USB.c,31 :: 		}
L_main3:
;USB.c,34 :: 		if(readbuff[0]=='t')
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
LDRB	R0, [R0, #0]
CMP	R0, #116
IT	NE
BNE	L_main4
;USB.c,36 :: 		GPIOA_ODR.B9=0; // turn off led
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;USB.c,37 :: 		}
L_main4:
;USB.c,40 :: 		writebuff[0]=count;
MOVW	R0, #lo_addr(_count+0)
MOVT	R0, #hi_addr(_count+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;USB.c,41 :: 		HID_Write(&writebuff,64);
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
;USB.c,44 :: 		count++;
MOVW	R1, #lo_addr(_count+0)
MOVT	R1, #hi_addr(_count+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;USB.c,47 :: 		if (count == 255)
CMP	R0, #255
IT	NE
BNE	L_main5
;USB.c,49 :: 		count = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_count+0)
MOVT	R0, #hi_addr(_count+0)
STRH	R1, [R0, #0]
;USB.c,50 :: 		}
L_main5:
;USB.c,51 :: 		}
L_main2:
;USB.c,52 :: 		}
IT	AL
BAL	L_main0
;USB.c,53 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
