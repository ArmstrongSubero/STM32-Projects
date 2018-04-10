_ST7735_WriteCommand:
;ST7735.c,139 :: 		void ST7735_WriteCommand(int i)
; i start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; i end address is: 0 (R0)
; i start address is: 0 (R0)
;ST7735.c,142 :: 		ST7735_RS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,145 :: 		ST7735_CS = 0;
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,148 :: 		SPI1_Write(i);
UXTH	R0, R0
; i end address is: 0 (R0)
BL	_SPI1_Write+0
;ST7735.c,151 :: 		ST7735_CS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,152 :: 		}
L_end_ST7735_WriteCommand:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_WriteCommand
_ST7735_WriteData:
;ST7735.c,161 :: 		void ST7735_WriteData(int i)
; i start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; i end address is: 0 (R0)
; i start address is: 0 (R0)
;ST7735.c,164 :: 		ST7735_RS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,167 :: 		ST7735_CS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,170 :: 		SPI1_Write(i);
UXTH	R0, R0
; i end address is: 0 (R0)
BL	_SPI1_Write+0
;ST7735.c,173 :: 		ST7735_CS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,174 :: 		}
L_end_ST7735_WriteData:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_WriteData
_ST7735_Init:
;ST7735.c,183 :: 		void ST7735_Init(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;ST7735.c,185 :: 		ST7735_RESET = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,186 :: 		Delay_us(500);
MOVW	R7, #5999
MOVT	R7, #0
NOP
NOP
L_ST7735_Init0:
SUBS	R7, R7, #1
BNE	L_ST7735_Init0
NOP
NOP
NOP
;ST7735.c,187 :: 		ST7735_RESET = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,188 :: 		Delay_us(500);
MOVW	R7, #5999
MOVT	R7, #0
NOP
NOP
L_ST7735_Init2:
SUBS	R7, R7, #1
BNE	L_ST7735_Init2
NOP
NOP
NOP
;ST7735.c,189 :: 		ST7735_RESET = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,190 :: 		Delay_us(500);
MOVW	R7, #5999
MOVT	R7, #0
NOP
NOP
L_ST7735_Init4:
SUBS	R7, R7, #1
BNE	L_ST7735_Init4
NOP
NOP
NOP
;ST7735.c,192 :: 		ST7735_CS = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,194 :: 		ST7735_WriteCommand(ST7735_SWRESET); // software reset
MOVS	R0, #1
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,195 :: 		Delay_us(150);
MOVW	R7, #1799
MOVT	R7, #0
NOP
NOP
L_ST7735_Init6:
SUBS	R7, R7, #1
BNE	L_ST7735_Init6
NOP
NOP
NOP
;ST7735.c,197 :: 		ST7735_WriteCommand(ST7735_SLPOUT);  // out of sleep mode
MOVS	R0, #17
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,198 :: 		Delay_us(500);
MOVW	R7, #5999
MOVT	R7, #0
NOP
NOP
L_ST7735_Init8:
SUBS	R7, R7, #1
BNE	L_ST7735_Init8
NOP
NOP
NOP
;ST7735.c,200 :: 		ST7735_WriteCommand(ST7735_COLMOD);  // set color mode
MOVS	R0, #58
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,201 :: 		ST7735_WriteData(0x05);        // 16-bit color
MOVS	R0, #5
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,202 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_ST7735_Init10:
SUBS	R7, R7, #1
BNE	L_ST7735_Init10
NOP
NOP
NOP
;ST7735.c,204 :: 		ST7735_WriteCommand(ST7735_FRMCTR1);  // frame rate control - normal mode
MOVS	R0, #177
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,205 :: 		ST7735_WriteData(0x01);  // frame rate = fosc / (1 x 2 + 40) * (LINE + 2C + 2D)
MOVS	R0, #1
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,206 :: 		ST7735_WriteData(0x2C);
MOVS	R0, #44
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,207 :: 		ST7735_WriteData(0x2D);
MOVS	R0, #45
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,209 :: 		ST7735_WriteCommand(ST7735_FRMCTR2);  // frame rate control - idle mode
MOVS	R0, #178
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,210 :: 		ST7735_WriteData(0x01);  // frame rate = fosc / (1 x 2 + 40) * (LINE + 2C + 2D)
MOVS	R0, #1
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,211 :: 		ST7735_WriteData(0x2C);
MOVS	R0, #44
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,212 :: 		ST7735_WriteData(0x2D);
MOVS	R0, #45
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,214 :: 		ST7735_WriteCommand(ST7735_FRMCTR3);  // frame rate control - partial mode
MOVS	R0, #179
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,215 :: 		ST7735_WriteData(0x01); // dot inversion mode
MOVS	R0, #1
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,216 :: 		ST7735_WriteData(0x2C);
MOVS	R0, #44
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,217 :: 		ST7735_WriteData(0x2D);
MOVS	R0, #45
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,218 :: 		ST7735_WriteData(0x01); // line inversion mode
MOVS	R0, #1
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,219 :: 		ST7735_WriteData(0x2C);
MOVS	R0, #44
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,220 :: 		ST7735_WriteData(0x2D);
MOVS	R0, #45
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,222 :: 		ST7735_WriteCommand(ST7735_INVCTR);  // display inversion control
MOVS	R0, #180
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,223 :: 		ST7735_WriteData(0x07);  // no inversion
MOVS	R0, #7
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,225 :: 		ST7735_WriteCommand(ST7735_PWCTR1);  // power control
MOVS	R0, #192
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,226 :: 		ST7735_WriteData(0xA2);
MOVS	R0, #162
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,227 :: 		ST7735_WriteData(0x02);      // -4.6V
MOVS	R0, #2
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,228 :: 		ST7735_WriteData(0x84);      // AUTO mode
MOVS	R0, #132
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,230 :: 		ST7735_WriteCommand(ST7735_PWCTR2);  // power control
MOVS	R0, #193
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,231 :: 		ST7735_WriteData(0xC5);      // VGH25 = 2.4C VGSEL = -10 VGH = 3 * AVDD
MOVS	R0, #197
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,233 :: 		ST7735_WriteCommand(ST7735_PWCTR3);  // power control
MOVS	R0, #194
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,234 :: 		ST7735_WriteData(0x0A);      // Opamp current small
MOVS	R0, #10
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,235 :: 		ST7735_WriteData(0x00);      // Boost frequency
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,237 :: 		ST7735_WriteCommand(ST7735_PWCTR4);  // power control
MOVS	R0, #195
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,238 :: 		ST7735_WriteData(0x8A);      // BCLK/2, Opamp current small & Medium low
MOVS	R0, #138
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,239 :: 		ST7735_WriteData(0x2A);
MOVS	R0, #42
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,241 :: 		ST7735_WriteCommand(ST7735_PWCTR5);  // power control
MOVS	R0, #196
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,242 :: 		ST7735_WriteData(0x8A);
MOVS	R0, #138
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,243 :: 		ST7735_WriteData(0xEE);
MOVS	R0, #238
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,245 :: 		ST7735_WriteCommand(ST7735_VMCTR1);  // power control
MOVS	R0, #197
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,246 :: 		ST7735_WriteData(0x0E);
MOVS	R0, #14
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,248 :: 		ST7735_WriteCommand(ST7735_INVOFF);    // don't invert display
MOVS	R0, #32
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,250 :: 		ST7735_WriteCommand(ST7735_MADCTL);  // memory access control (directions)
MOVS	R0, #54
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,253 :: 		madctl = 0xC0;
MOVS	R1, #192
MOVW	R0, #lo_addr(_madctl+0)
MOVT	R0, #hi_addr(_madctl+0)
STRB	R1, [R0, #0]
;ST7735.c,254 :: 		ST7735_WriteData(madctl);  // row address/col address, bottom to top refresh
MOVS	R0, #192
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,256 :: 		ST7735_WriteCommand(ST7735_COLMOD);  // set color mode
MOVS	R0, #58
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,257 :: 		ST7735_WriteData(0x05);        // 16-bit color
MOVS	R0, #5
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,259 :: 		ST7735_WriteCommand(ST7735_CASET);  // column addr set
MOVS	R0, #42
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,260 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,261 :: 		ST7735_WriteData(0x00);   // XSTART = 0
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,262 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,263 :: 		ST7735_WriteData(0x7F);   // XEND = 127
MOVS	R0, #127
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,265 :: 		ST7735_WriteCommand(ST7735_RASET);  // row addr set
MOVS	R0, #43
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,266 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,267 :: 		ST7735_WriteData(0x00);    // XSTART = 0
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,268 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,269 :: 		ST7735_WriteData(0x9F);    // XEND = 159
MOVS	R0, #159
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,271 :: 		ST7735_WriteCommand(ST7735_GMCTRP1);
MOVS	R0, #224
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,272 :: 		ST7735_WriteData(0x0f);
MOVS	R0, #15
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,273 :: 		ST7735_WriteData(0x1a);
MOVS	R0, #26
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,274 :: 		ST7735_WriteData(0x0f);
MOVS	R0, #15
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,275 :: 		ST7735_WriteData(0x18);
MOVS	R0, #24
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,276 :: 		ST7735_WriteData(0x2f);
MOVS	R0, #47
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,277 :: 		ST7735_WriteData(0x28);
MOVS	R0, #40
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,278 :: 		ST7735_WriteData(0x20);
MOVS	R0, #32
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,279 :: 		ST7735_WriteData(0x22);
MOVS	R0, #34
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,280 :: 		ST7735_WriteData(0x1f);
MOVS	R0, #31
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,281 :: 		ST7735_WriteData(0x1b);
MOVS	R0, #27
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,282 :: 		ST7735_WriteData(0x23);
MOVS	R0, #35
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,283 :: 		ST7735_WriteData(0x37);
MOVS	R0, #55
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,284 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,285 :: 		ST7735_WriteData(0x07);
MOVS	R0, #7
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,286 :: 		ST7735_WriteData(0x02);
MOVS	R0, #2
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,287 :: 		ST7735_WriteData(0x10);
MOVS	R0, #16
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,288 :: 		ST7735_WriteCommand(ST7735_GMCTRN1);
MOVS	R0, #225
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,289 :: 		ST7735_WriteData(0x0f);
MOVS	R0, #15
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,290 :: 		ST7735_WriteData(0x1b);
MOVS	R0, #27
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,291 :: 		ST7735_WriteData(0x0f);
MOVS	R0, #15
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,292 :: 		ST7735_WriteData(0x17);
MOVS	R0, #23
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,293 :: 		ST7735_WriteData(0x33);
MOVS	R0, #51
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,294 :: 		ST7735_WriteData(0x2c);
MOVS	R0, #44
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,295 :: 		ST7735_WriteData(0x29);
MOVS	R0, #41
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,296 :: 		ST7735_WriteData(0x2e);
MOVS	R0, #46
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,297 :: 		ST7735_WriteData(0x30);
MOVS	R0, #48
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,298 :: 		ST7735_WriteData(0x30);
MOVS	R0, #48
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,299 :: 		ST7735_WriteData(0x39);
MOVS	R0, #57
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,300 :: 		ST7735_WriteData(0x3f);
MOVS	R0, #63
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,301 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,302 :: 		ST7735_WriteData(0x07);
MOVS	R0, #7
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,303 :: 		ST7735_WriteData(0x03);
MOVS	R0, #3
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,304 :: 		ST7735_WriteData(0x10);
MOVS	R0, #16
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,306 :: 		ST7735_WriteCommand(0xF6); //Disable ram power save mode
MOVS	R0, #246
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,307 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,309 :: 		ST7735_WriteCommand(ST7735_DISPON);
MOVS	R0, #41
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,310 :: 		Delay_us(100);
MOVW	R7, #1199
MOVT	R7, #0
NOP
NOP
L_ST7735_Init12:
SUBS	R7, R7, #1
BNE	L_ST7735_Init12
NOP
NOP
NOP
;ST7735.c,312 :: 		ST7735_WriteCommand(ST7735_NORON);  // normal display on
MOVS	R0, #19
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,313 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_ST7735_Init14:
SUBS	R7, R7, #1
BNE	L_ST7735_Init14
NOP
NOP
NOP
;ST7735.c,315 :: 		ST7735_CS = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
_SX	[R0, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,316 :: 		}
L_end_ST7735_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_Init
_ST7735_test:
;ST7735.c,325 :: 		void ST7735_test(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;ST7735.c,327 :: 		ST7735_fillScreen(colWhite);
MOVW	R0, #65535
BL	_ST7735_fillScreen+0
;ST7735.c,330 :: 		for (x = 0; x <= 500; x += 50){
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #4]
L_ST7735_test16:
LDRSH	R0, [SP, #4]
CMP	R0, #500
IT	GT
BGT	L_ST7735_test17
;ST7735.c,331 :: 		ST7735_drawCircle(60, (SCREEN_WIDTH/2) + 15 , 42, colMagenta);
MOVW	R3, #63519
MOVS	R2, #42
MOVS	R1, #79
MOVS	R0, #60
BL	_ST7735_drawCircle+0
;ST7735.c,332 :: 		ST7735_writeInteger(25,  SCREEN_WIDTH/2, x, colCyan, 2);
MOVS	R0, #2
SXTH	R0, R0
PUSH	(R0)
MOVW	R3, #2047
LDRSH	R2, [SP, #8]
MOVW	R1, #64
SXTH	R1, R1
MOVS	R0, #25
SXTH	R0, R0
BL	_ST7735_writeInteger+0
ADD	SP, SP, #4
;ST7735.c,333 :: 		ST7735_drawString(1, 1, "Reading", colMediumOrchid, 3);
MOVS	R1, #3
MOVW	R0, #lo_addr(?lstr1_ST7735+0)
MOVT	R0, #hi_addr(?lstr1_ST7735+0)
PUSH	(R1)
MOVW	R3, #47802
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #1
BL	_ST7735_drawString+0
ADD	SP, SP, #4
;ST7735.c,334 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_ST7735_test19:
SUBS	R7, R7, #1
BNE	L_ST7735_test19
NOP
NOP
NOP
;ST7735.c,335 :: 		ST7735_writeInteger(25,  SCREEN_WIDTH/2, x, colWhite, 2);
MOVS	R0, #2
SXTH	R0, R0
PUSH	(R0)
MOVW	R3, #65535
LDRSH	R2, [SP, #8]
MOVW	R1, #64
SXTH	R1, R1
MOVS	R0, #25
SXTH	R0, R0
BL	_ST7735_writeInteger+0
ADD	SP, SP, #4
;ST7735.c,336 :: 		if (x >= 500){
LDRSH	R0, [SP, #4]
CMP	R0, #500
IT	LT
BLT	L_ST7735_test21
;ST7735.c,337 :: 		break;
IT	AL
BAL	L_ST7735_test17
;ST7735.c,338 :: 		}
L_ST7735_test21:
;ST7735.c,330 :: 		for (x = 0; x <= 500; x += 50){
LDRSH	R0, [SP, #4]
ADDS	R0, #50
STRH	R0, [SP, #4]
;ST7735.c,339 :: 		}
IT	AL
BAL	L_ST7735_test16
L_ST7735_test17:
;ST7735.c,340 :: 		}
L_end_ST7735_test:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _ST7735_test
_ST7735_writeInteger:
;ST7735.c,349 :: 		void ST7735_writeInteger(int x, int y, int v, unsigned int colour, int size)
; colour start address is: 12 (R3)
; v start address is: 8 (R2)
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
SXTH	R8, R0
SXTH	R9, R1
UXTH	R10, R3
; colour end address is: 12 (R3)
; v end address is: 8 (R2)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 32 (R8)
; y start address is: 36 (R9)
; v start address is: 8 (R2)
; colour start address is: 40 (R10)
; size start address is: 44 (R11)
LDRSH	R11, [SP, #12]
;ST7735.c,354 :: 		IntToStr(v, buf);
ADD	R4, SP, #4
MOV	R1, R4
SXTH	R0, R2
; v end address is: 8 (R2)
BL	_IntToStr+0
;ST7735.c,356 :: 		ST7735_drawString(x, y, buf, colour, size);
UXTB	R5, R11
; size end address is: 44 (R11)
ADD	R4, SP, #4
UXTH	R3, R10
; colour end address is: 40 (R10)
MOV	R2, R4
UXTB	R1, R9
; y end address is: 36 (R9)
UXTB	R0, R8
; x end address is: 32 (R8)
PUSH	(R5)
BL	_ST7735_drawString+0
ADD	SP, SP, #4
;ST7735.c,358 :: 		}
L_end_ST7735_writeInteger:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _ST7735_writeInteger
_setAddrWindow:
;ST7735.c,365 :: 		void setAddrWindow(unsigned char x0, unsigned char y0, unsigned char x1, unsigned char y1)
; y1 start address is: 12 (R3)
; x1 start address is: 8 (R2)
; y0 start address is: 4 (R1)
; x0 start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
UXTB	R6, R1
UXTB	R7, R2
UXTB	R8, R3
; y1 end address is: 12 (R3)
; x1 end address is: 8 (R2)
; y0 end address is: 4 (R1)
; x0 end address is: 0 (R0)
; x0 start address is: 20 (R5)
; y0 start address is: 24 (R6)
; x1 start address is: 28 (R7)
; y1 start address is: 32 (R8)
;ST7735.c,367 :: 		ST7735_WriteCommand(ST7735_CASET);  // column addr set
MOVS	R0, #42
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,368 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,369 :: 		ST7735_WriteData(x0+0);   // XSTART
UXTB	R4, R5
; x0 end address is: 20 (R5)
SXTH	R0, R4
BL	_ST7735_WriteData+0
;ST7735.c,370 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,371 :: 		ST7735_WriteData(x1+0);   // XEND
UXTB	R4, R7
; x1 end address is: 28 (R7)
SXTH	R0, R4
BL	_ST7735_WriteData+0
;ST7735.c,373 :: 		ST7735_WriteCommand(ST7735_RASET);  // row addr set
MOVS	R0, #43
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,374 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,375 :: 		ST7735_WriteData(y0+0);    // YSTART
UXTB	R4, R6
; y0 end address is: 24 (R6)
SXTH	R0, R4
BL	_ST7735_WriteData+0
;ST7735.c,376 :: 		ST7735_WriteData(0x00);
MOVS	R0, #0
SXTH	R0, R0
BL	_ST7735_WriteData+0
;ST7735.c,377 :: 		ST7735_WriteData(y1+0);    // YEND
UXTB	R4, R8
; y1 end address is: 32 (R8)
SXTH	R0, R4
BL	_ST7735_WriteData+0
;ST7735.c,379 :: 		ST7735_WriteCommand(ST7735_RAMWR);  // write to RAM
MOVS	R0, #44
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,380 :: 		}
L_end_setAddrWindow:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _setAddrWindow
_ST7735_pushColor:
;ST7735.c,382 :: 		void ST7735_pushColor(unsigned int color)
; color start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R4, R0
; color end address is: 0 (R0)
; color start address is: 16 (R4)
;ST7735.c,384 :: 		ST7735_RS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,385 :: 		ST7735_CS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,386 :: 		SPI1_Write(color >> 8);
LSRS	R1, R4, #8
UXTH	R0, R1
BL	_SPI1_Write+0
;ST7735.c,387 :: 		SPI1_Write(color);
UXTH	R0, R4
; color end address is: 16 (R4)
BL	_SPI1_Write+0
;ST7735.c,388 :: 		ST7735_CS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,389 :: 		}
L_end_ST7735_pushColor:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_pushColor
_ST7735_drawPixel:
;ST7735.c,391 :: 		void ST7735_drawPixel(unsigned char x, unsigned char y, unsigned int color)
; color start address is: 8 (R2)
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R9, R2
; color end address is: 8 (R2)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 0 (R0)
; y start address is: 4 (R1)
; color start address is: 36 (R9)
;ST7735.c,393 :: 		setAddrWindow(x, y, x+1, y+1);
ADDS	R4, R1, #1
ADDS	R3, R0, #1
UXTB	R2, R3
UXTB	R3, R4
; y end address is: 4 (R1)
; x end address is: 0 (R0)
BL	_setAddrWindow+0
;ST7735.c,395 :: 		ST7735_RS = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,396 :: 		ST7735_CS = 0;
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,398 :: 		SPI1_Write(color >> 8);
LSR	R3, R9, #8
UXTH	R0, R3
BL	_SPI1_Write+0
;ST7735.c,399 :: 		SPI1_Write(color);
UXTH	R0, R9
; color end address is: 36 (R9)
BL	_SPI1_Write+0
;ST7735.c,401 :: 		ST7735_CS = 1;
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIOB_ODR+0)
MOVT	R3, #hi_addr(GPIOB_ODR+0)
_SX	[R3, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,402 :: 		}
L_end_ST7735_drawPixel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_drawPixel
_ST7735_fillScreen:
;ST7735.c,404 :: 		void ST7735_fillScreen(unsigned int color)
; color start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R9, R0
; color end address is: 0 (R0)
; color start address is: 36 (R9)
;ST7735.c,409 :: 		setAddrWindow(0, 0, SCREEN_WIDTH-1, SCREEN_HEIGHT-1);
MOVS	R3, #159
MOVS	R2, #127
MOVS	R1, #0
MOVS	R0, #0
BL	_setAddrWindow+0
;ST7735.c,412 :: 		ST7735_RS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,413 :: 		ST7735_CS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,415 :: 		colorB = color >> 8;
LSR	R2, R9, #8
MOVW	R1, #lo_addr(_colorB+0)
MOVT	R1, #hi_addr(_colorB+0)
STRB	R2, [R1, #0]
;ST7735.c,417 :: 		for (x=0; x < SCREEN_WIDTH; x++) {
; x start address is: 0 (R0)
MOVS	R0, #0
; color end address is: 36 (R9)
; x end address is: 0 (R0)
UXTH	R4, R9
L_ST7735_fillScreen22:
; x start address is: 0 (R0)
; color start address is: 16 (R4)
CMP	R0, #128
IT	CS
BCS	L_ST7735_fillScreen23
;ST7735.c,418 :: 		for (y=0; y < SCREEN_HEIGHT; y++) {
; y start address is: 24 (R6)
MOVS	R6, #0
; color end address is: 16 (R4)
; y end address is: 24 (R6)
; x end address is: 0 (R0)
UXTB	R5, R0
L_ST7735_fillScreen25:
; y start address is: 24 (R6)
; color start address is: 16 (R4)
; x start address is: 20 (R5)
CMP	R6, #160
IT	CS
BCS	L_ST7735_fillScreen26
;ST7735.c,419 :: 		SPI1_Write(colorB);
MOVW	R1, #lo_addr(_colorB+0)
MOVT	R1, #hi_addr(_colorB+0)
LDRB	R1, [R1, #0]
UXTH	R0, R1
BL	_SPI1_Write+0
;ST7735.c,420 :: 		SPI1_Write(color);
UXTH	R0, R4
BL	_SPI1_Write+0
;ST7735.c,418 :: 		for (y=0; y < SCREEN_HEIGHT; y++) {
ADDS	R6, R6, #1
UXTB	R6, R6
;ST7735.c,421 :: 		}
; y end address is: 24 (R6)
IT	AL
BAL	L_ST7735_fillScreen25
L_ST7735_fillScreen26:
;ST7735.c,417 :: 		for (x=0; x < SCREEN_WIDTH; x++) {
ADDS	R1, R5, #1
; x end address is: 20 (R5)
; x start address is: 0 (R0)
UXTB	R0, R1
;ST7735.c,422 :: 		}
; color end address is: 16 (R4)
; x end address is: 0 (R0)
IT	AL
BAL	L_ST7735_fillScreen22
L_ST7735_fillScreen23:
;ST7735.c,424 :: 		ST7735_CS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
_SX	[R1, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,425 :: 		}
L_end_ST7735_fillScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_fillScreen
_ST7735_drawChar:
;ST7735.c,427 :: 		void ST7735_drawChar(unsigned char x, unsigned char y, char c, unsigned int color, unsigned char size)
SUB	SP, SP, #28
STR	LR, [SP, #0]
STRB	R0, [SP, #12]
STRB	R1, [SP, #16]
STRB	R2, [SP, #20]
STRH	R3, [SP, #24]
; size start address is: 0 (R0)
LDRB	R0, [SP, #28]
;ST7735.c,431 :: 		unsigned char letter = c < 0x52 ? c - 0x20 : c - 0x52;
LDRB	R4, [SP, #20]
CMP	R4, #82
IT	CS
BCS	L_ST7735_drawChar28
LDRB	R4, [SP, #20]
SUBW	R6, R4, #32
SXTH	R6, R6
; ?FLOC___ST7735_drawChar?T28 start address is: 24 (R6)
SXTH	R1, R6
; ?FLOC___ST7735_drawChar?T28 end address is: 24 (R6)
IT	AL
BAL	L_ST7735_drawChar29
L_ST7735_drawChar28:
LDRB	R4, [SP, #20]
SUBS	R4, #82
; ?FLOC___ST7735_drawChar?T28 start address is: 24 (R6)
SXTH	R6, R4
; ?FLOC___ST7735_drawChar?T28 end address is: 24 (R6)
SXTH	R1, R6
L_ST7735_drawChar29:
; ?FLOC___ST7735_drawChar?T28 start address is: 4 (R1)
STRB	R1, [SP, #11]
; ?FLOC___ST7735_drawChar?T28 end address is: 4 (R1)
;ST7735.c,432 :: 		for (i =0; i<5; i++ ) {
MOVS	R4, #0
STRB	R4, [SP, #9]
; size end address is: 0 (R0)
UXTB	R10, R0
L_ST7735_drawChar30:
; size start address is: 40 (R10)
LDRB	R4, [SP, #9]
CMP	R4, #5
IT	CS
BCS	L_ST7735_drawChar31
;ST7735.c,433 :: 		unsigned char line = c < 0x52 ? Alpha1[letter*5+i] : Alpha2[letter*5+i];
LDRB	R4, [SP, #20]
CMP	R4, #82
IT	CS
BCS	L_ST7735_drawChar33
LDRB	R5, [SP, #11]
MOVS	R4, #5
SXTH	R4, R4
MULS	R5, R4, R5
SXTH	R5, R5
LDRB	R4, [SP, #9]
ADDS	R5, R5, R4
SXTH	R5, R5
MOVW	R4, #lo_addr(ST7735_Alpha1+0)
MOVT	R4, #hi_addr(ST7735_Alpha1+0)
ADDS	R4, R4, R5
LDRB	R5, [R4, #0]
; ?FLOC___ST7735_drawChar?T39 start address is: 20 (R5)
UXTB	R0, R5
; ?FLOC___ST7735_drawChar?T39 end address is: 20 (R5)
IT	AL
BAL	L_ST7735_drawChar34
L_ST7735_drawChar33:
LDRB	R5, [SP, #11]
MOVS	R4, #5
SXTH	R4, R4
MULS	R5, R4, R5
SXTH	R5, R5
LDRB	R4, [SP, #9]
ADDS	R5, R5, R4
SXTH	R5, R5
MOVW	R4, #lo_addr(ST7735_Alpha2+0)
MOVT	R4, #hi_addr(ST7735_Alpha2+0)
ADDS	R4, R4, R5
LDRB	R4, [R4, #0]
; ?FLOC___ST7735_drawChar?T39 start address is: 20 (R5)
UXTB	R5, R4
; ?FLOC___ST7735_drawChar?T39 end address is: 20 (R5)
UXTB	R0, R5
L_ST7735_drawChar34:
; ?FLOC___ST7735_drawChar?T39 start address is: 0 (R0)
STRB	R0, [SP, #8]
; ?FLOC___ST7735_drawChar?T39 end address is: 0 (R0)
;ST7735.c,435 :: 		for (j = 0; j<8; j++) {
MOVS	R4, #0
STRB	R4, [SP, #10]
; size end address is: 40 (R10)
UXTB	R11, R10
L_ST7735_drawChar35:
; size start address is: 44 (R11)
LDRB	R4, [SP, #10]
CMP	R4, #8
IT	CS
BCS	L_ST7735_drawChar36
;ST7735.c,436 :: 		if (line & 0x1) {
LDRB	R4, [SP, #8]
AND	R4, R4, #1
UXTB	R4, R4
CMP	R4, #0
IT	EQ
BEQ	L_ST7735_drawChar38
;ST7735.c,437 :: 		if (size == 1) // default size
CMP	R11, #1
IT	NE
BNE	L_ST7735_drawChar39
;ST7735.c,438 :: 		ST7735_drawPixel(x+i, y+j, color);
LDRB	R5, [SP, #10]
LDRB	R4, [SP, #16]
ADDS	R6, R4, R5
LDRB	R5, [SP, #9]
LDRB	R4, [SP, #12]
ADDS	R4, R4, R5
LDRH	R2, [SP, #24]
UXTB	R1, R6
UXTB	R0, R4
BL	_ST7735_drawPixel+0
IT	AL
BAL	L_ST7735_drawChar40
L_ST7735_drawChar39:
;ST7735.c,440 :: 		ST7735_fillRect(x+i*size, y+j*size, size, size, color);
LDRB	R4, [SP, #10]
MUL	R5, R4, R11
SXTH	R5, R5
LDRB	R4, [SP, #16]
ADDS	R6, R4, R5
LDRB	R4, [SP, #9]
MUL	R5, R4, R11
SXTH	R5, R5
LDRB	R4, [SP, #12]
ADDS	R5, R4, R5
LDRH	R4, [SP, #24]
STRB	R11, [SP, #4]
UXTB	R3, R11
UXTB	R2, R11
UXTB	R1, R6
UXTB	R0, R5
PUSH	(R4)
BL	_ST7735_fillRect+0
ADD	SP, SP, #4
LDRB	R11, [SP, #4]
;ST7735.c,441 :: 		}
L_ST7735_drawChar40:
;ST7735.c,442 :: 		}
L_ST7735_drawChar38:
;ST7735.c,443 :: 		line >>= 1;
LDRB	R4, [SP, #8]
LSRS	R4, R4, #1
STRB	R4, [SP, #8]
;ST7735.c,435 :: 		for (j = 0; j<8; j++) {
LDRB	R4, [SP, #10]
ADDS	R4, R4, #1
STRB	R4, [SP, #10]
;ST7735.c,444 :: 		}
IT	AL
BAL	L_ST7735_drawChar35
L_ST7735_drawChar36:
;ST7735.c,432 :: 		for (i =0; i<5; i++ ) {
LDRB	R4, [SP, #9]
ADDS	R4, R4, #1
STRB	R4, [SP, #9]
;ST7735.c,445 :: 		}
UXTB	R10, R11
; size end address is: 44 (R11)
IT	AL
BAL	L_ST7735_drawChar30
L_ST7735_drawChar31:
;ST7735.c,446 :: 		}
L_end_ST7735_drawChar:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _ST7735_drawChar
_ST7735_drawString:
;ST7735.c,448 :: 		void ST7735_drawString(unsigned char x, unsigned char y, char *c, unsigned int color, unsigned char size)
; c start address is: 8 (R2)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R0, [SP, #8]
STRB	R1, [SP, #12]
STRH	R3, [SP, #16]
; c end address is: 8 (R2)
; c start address is: 8 (R2)
; size start address is: 16 (R4)
LDRB	R4, [SP, #20]
MOV	R0, R2
; c end address is: 8 (R2)
; size end address is: 16 (R4)
UXTB	R12, R4
;ST7735.c,450 :: 		while (c[0] != 0) {
L_ST7735_drawString41:
; size start address is: 48 (R12)
; size start address is: 48 (R12)
; size end address is: 48 (R12)
; c start address is: 0 (R0)
LDRB	R4, [R0, #0]
CMP	R4, #0
IT	EQ
BEQ	L_ST7735_drawString42
; size end address is: 48 (R12)
;ST7735.c,451 :: 		ST7735_drawChar(x, y, c[0], color, size);
; size start address is: 48 (R12)
UXTB	R5, R12
LDRB	R4, [R0, #0]
STR	R0, [SP, #4]
LDRH	R3, [SP, #16]
UXTB	R2, R4
LDRB	R1, [SP, #12]
LDRB	R0, [SP, #8]
PUSH	(R5)
BL	_ST7735_drawChar+0
ADD	SP, SP, #4
LDR	R0, [SP, #4]
;ST7735.c,452 :: 		x += size*6;
MOVS	R4, #6
SXTH	R4, R4
MUL	R5, R12, R4
SXTH	R5, R5
LDRB	R4, [SP, #8]
ADDS	R5, R4, R5
STRB	R5, [SP, #8]
;ST7735.c,453 :: 		c++;
ADDS	R4, R0, #1
; c end address is: 0 (R0)
; c start address is: 12 (R3)
MOV	R3, R4
;ST7735.c,454 :: 		if (x + 5 >= SCREEN_WIDTH) {
UXTB	R4, R5
ADDS	R4, R4, #5
SXTH	R4, R4
CMP	R4, #128
IT	LT
BLT	L_ST7735_drawString43
;ST7735.c,455 :: 		y += 10;
LDRB	R4, [SP, #12]
ADDS	R4, #10
STRB	R4, [SP, #12]
;ST7735.c,456 :: 		x = 0;
MOVS	R4, #0
STRB	R4, [SP, #8]
;ST7735.c,457 :: 		}
L_ST7735_drawString43:
;ST7735.c,458 :: 		}
MOV	R0, R3
; size end address is: 48 (R12)
; c end address is: 12 (R3)
IT	AL
BAL	L_ST7735_drawString41
L_ST7735_drawString42:
;ST7735.c,459 :: 		}
L_end_ST7735_drawString:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _ST7735_drawString
_ST7735_fillCircle:
;ST7735.c,463 :: 		void ST7735_fillCircle(unsigned char x0, unsigned char y0, unsigned char r, unsigned int color) {
; r start address is: 8 (R2)
SUB	SP, SP, #28
STR	LR, [SP, #0]
STRB	R0, [SP, #16]
UXTB	R0, R2
STRB	R1, [SP, #20]
STRH	R3, [SP, #24]
; r end address is: 8 (R2)
; r start address is: 0 (R0)
;ST7735.c,464 :: 		int f = 1 - r;
RSB	R4, R0, #1
STRH	R4, [SP, #4]
;ST7735.c,465 :: 		int ddF_x = 1;
MOVW	R4, #1
STRH	R4, [SP, #10]
;ST7735.c,466 :: 		int ddF_y = -2 * r;
MOVW	R4, #65534
SXTH	R4, R4
MULS	R4, R0, R4
STRH	R4, [SP, #6]
;ST7735.c,467 :: 		int x = 0;
MOVW	R4, #0
STRH	R4, [SP, #12]
;ST7735.c,468 :: 		int y = r;
STRH	R0, [SP, #8]
;ST7735.c,470 :: 		ST7735_drawVerticalLine(x0, y0-r, 2*r+1, color);
LSLS	R4, R0, #1
SXTH	R4, R4
ADDS	R5, R4, #1
LDRB	R4, [SP, #20]
SUB	R4, R4, R0
; r end address is: 0 (R0)
LDRH	R3, [SP, #24]
UXTB	R2, R5
UXTB	R1, R4
LDRB	R0, [SP, #16]
BL	_ST7735_drawVerticalLine+0
;ST7735.c,472 :: 		while (x<y) {
L_ST7735_fillCircle44:
LDRSH	R5, [SP, #8]
LDRSH	R4, [SP, #12]
CMP	R4, R5
IT	GE
BGE	L_ST7735_fillCircle45
;ST7735.c,473 :: 		if (f >= 0) {
LDRSH	R4, [SP, #4]
CMP	R4, #0
IT	LT
BLT	L_ST7735_fillCircle46
;ST7735.c,474 :: 		y--;
LDRSH	R4, [SP, #8]
SUBS	R4, R4, #1
STRH	R4, [SP, #8]
;ST7735.c,475 :: 		ddF_y += 2;
LDRSH	R4, [SP, #6]
ADDS	R5, R4, #2
SXTH	R5, R5
STRH	R5, [SP, #6]
;ST7735.c,476 :: 		f += ddF_y;
LDRSH	R4, [SP, #4]
ADDS	R4, R4, R5
STRH	R4, [SP, #4]
;ST7735.c,477 :: 		}
L_ST7735_fillCircle46:
;ST7735.c,478 :: 		x++;
LDRSH	R4, [SP, #12]
ADDS	R7, R4, #1
SXTH	R7, R7
STRH	R7, [SP, #12]
;ST7735.c,479 :: 		ddF_x += 2;
LDRSH	R4, [SP, #10]
ADDS	R5, R4, #2
SXTH	R5, R5
STRH	R5, [SP, #10]
;ST7735.c,480 :: 		f += ddF_x;
LDRSH	R4, [SP, #4]
ADDS	R4, R4, R5
STRH	R4, [SP, #4]
;ST7735.c,482 :: 		ST7735_drawVerticalLine(x0+x, y0-y, 2*y+1, color);
LDRSH	R4, [SP, #8]
LSLS	R4, R4, #1
SXTH	R4, R4
ADDS	R6, R4, #1
LDRSH	R5, [SP, #8]
LDRB	R4, [SP, #20]
SUB	R5, R4, R5
LDRB	R4, [SP, #16]
ADDS	R4, R4, R7
LDRH	R3, [SP, #24]
UXTB	R2, R6
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawVerticalLine+0
;ST7735.c,483 :: 		ST7735_drawVerticalLine(x0-x, y0-y, 2*y+1, color);
LDRSH	R4, [SP, #8]
LSLS	R4, R4, #1
SXTH	R4, R4
ADDS	R7, R4, #1
LDRSH	R5, [SP, #8]
LDRB	R4, [SP, #20]
SUB	R6, R4, R5
LDRSH	R5, [SP, #12]
LDRB	R4, [SP, #16]
SUB	R4, R4, R5
LDRH	R3, [SP, #24]
UXTB	R2, R7
UXTB	R1, R6
UXTB	R0, R4
BL	_ST7735_drawVerticalLine+0
;ST7735.c,484 :: 		ST7735_drawVerticalLine(x0+y, y0-x, 2*x+1, color);
LDRSH	R4, [SP, #12]
LSLS	R4, R4, #1
SXTH	R4, R4
ADDS	R7, R4, #1
LDRSH	R5, [SP, #12]
LDRB	R4, [SP, #20]
SUB	R6, R4, R5
LDRSH	R5, [SP, #8]
LDRB	R4, [SP, #16]
ADDS	R4, R4, R5
LDRH	R3, [SP, #24]
UXTB	R2, R7
UXTB	R1, R6
UXTB	R0, R4
BL	_ST7735_drawVerticalLine+0
;ST7735.c,485 :: 		ST7735_drawVerticalLine(x0-y, y0-x, 2*x+1, color);
LDRSH	R4, [SP, #12]
LSLS	R4, R4, #1
SXTH	R4, R4
ADDS	R7, R4, #1
LDRSH	R5, [SP, #12]
LDRB	R4, [SP, #20]
SUB	R6, R4, R5
LDRSH	R5, [SP, #8]
LDRB	R4, [SP, #16]
SUB	R4, R4, R5
LDRH	R3, [SP, #24]
UXTB	R2, R7
UXTB	R1, R6
UXTB	R0, R4
BL	_ST7735_drawVerticalLine+0
;ST7735.c,486 :: 		}
IT	AL
BAL	L_ST7735_fillCircle44
L_ST7735_fillCircle45:
;ST7735.c,487 :: 		}
L_end_ST7735_fillCircle:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _ST7735_fillCircle
_ST7735_drawCircle:
;ST7735.c,490 :: 		void ST7735_drawCircle(unsigned char x0, unsigned char y0, unsigned char r, unsigned int color) {
; color start address is: 12 (R3)
; r start address is: 8 (R2)
; y0 start address is: 4 (R1)
; x0 start address is: 0 (R0)
SUB	SP, SP, #20
STR	LR, [SP, #0]
UXTB	R12, R0
UXTH	R0, R3
UXTB	R11, R1
UXTB	R10, R2
; color end address is: 12 (R3)
; r end address is: 8 (R2)
; y0 end address is: 4 (R1)
; x0 end address is: 0 (R0)
; x0 start address is: 48 (R12)
; y0 start address is: 44 (R11)
; r start address is: 40 (R10)
; color start address is: 0 (R0)
;ST7735.c,491 :: 		int f = 1 - r;
RSB	R4, R10, #1
STRH	R4, [SP, #8]
;ST7735.c,492 :: 		int ddF_x = 1;
MOVW	R4, #1
STRH	R4, [SP, #14]
;ST7735.c,493 :: 		int ddF_y = -2 * r;
MOVW	R4, #65534
SXTH	R4, R4
MUL	R4, R10, R4
STRH	R4, [SP, #10]
;ST7735.c,494 :: 		int x = 0;
MOVW	R4, #0
STRH	R4, [SP, #16]
;ST7735.c,495 :: 		int y = r;
STRH	R10, [SP, #12]
;ST7735.c,497 :: 		ST7735_drawPixel(x0, y0+r, color);
ADD	R4, R11, R10, LSL #0
STRH	R0, [SP, #4]
UXTH	R2, R0
UXTB	R1, R4
UXTB	R0, R12
BL	_ST7735_drawPixel+0
LDRH	R0, [SP, #4]
;ST7735.c,498 :: 		ST7735_drawPixel(x0, y0-r, color);
SUB	R4, R11, R10, LSL #0
STRH	R0, [SP, #4]
UXTH	R2, R0
UXTB	R1, R4
UXTB	R0, R12
BL	_ST7735_drawPixel+0
LDRH	R0, [SP, #4]
;ST7735.c,499 :: 		ST7735_drawPixel(x0+r, y0, color);
ADD	R4, R12, R10, LSL #0
STRH	R0, [SP, #4]
UXTH	R2, R0
UXTB	R1, R11
UXTB	R0, R4
BL	_ST7735_drawPixel+0
LDRH	R0, [SP, #4]
;ST7735.c,500 :: 		ST7735_drawPixel(x0-r, y0, color);
SUB	R4, R12, R10, LSL #0
; r end address is: 40 (R10)
STRH	R0, [SP, #4]
UXTH	R2, R0
UXTB	R1, R11
UXTB	R0, R4
BL	_ST7735_drawPixel+0
; color end address is: 0 (R0)
LDRH	R0, [SP, #4]
UXTH	R10, R0
;ST7735.c,502 :: 		while (x<y) {
L_ST7735_drawCircle47:
; color start address is: 40 (R10)
; color start address is: 40 (R10)
; color end address is: 40 (R10)
; y0 start address is: 44 (R11)
; y0 end address is: 44 (R11)
; x0 start address is: 48 (R12)
; x0 end address is: 48 (R12)
LDRSH	R5, [SP, #12]
LDRSH	R4, [SP, #16]
CMP	R4, R5
IT	GE
BGE	L_ST7735_drawCircle48
; color end address is: 40 (R10)
; y0 end address is: 44 (R11)
; x0 end address is: 48 (R12)
;ST7735.c,503 :: 		if (f >= 0) {
; x0 start address is: 48 (R12)
; y0 start address is: 44 (R11)
; color start address is: 40 (R10)
LDRSH	R4, [SP, #8]
CMP	R4, #0
IT	LT
BLT	L_ST7735_drawCircle49
;ST7735.c,504 :: 		y--;
LDRSH	R4, [SP, #12]
SUBS	R4, R4, #1
STRH	R4, [SP, #12]
;ST7735.c,505 :: 		ddF_y += 2;
LDRSH	R4, [SP, #10]
ADDS	R5, R4, #2
SXTH	R5, R5
STRH	R5, [SP, #10]
;ST7735.c,506 :: 		f += ddF_y;
LDRSH	R4, [SP, #8]
ADDS	R4, R4, R5
STRH	R4, [SP, #8]
;ST7735.c,507 :: 		}
L_ST7735_drawCircle49:
;ST7735.c,508 :: 		x++;
LDRSH	R4, [SP, #16]
ADDS	R6, R4, #1
SXTH	R6, R6
STRH	R6, [SP, #16]
;ST7735.c,509 :: 		ddF_x += 2;
LDRSH	R4, [SP, #14]
ADDS	R5, R4, #2
SXTH	R5, R5
STRH	R5, [SP, #14]
;ST7735.c,510 :: 		f += ddF_x;
LDRSH	R4, [SP, #8]
ADDS	R4, R4, R5
STRH	R4, [SP, #8]
;ST7735.c,512 :: 		ST7735_drawPixel(x0 + x, y0 + y, color);
LDRSH	R4, [SP, #12]
ADD	R5, R11, R4, LSL #0
ADD	R4, R12, R6, LSL #0
UXTH	R2, R10
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawPixel+0
;ST7735.c,513 :: 		ST7735_drawPixel(x0 - x, y0 + y, color);
LDRSH	R4, [SP, #12]
ADD	R5, R11, R4, LSL #0
LDRSH	R4, [SP, #16]
SUB	R4, R12, R4, LSL #0
UXTH	R2, R10
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawPixel+0
;ST7735.c,514 :: 		ST7735_drawPixel(x0 + x, y0 - y, color);
LDRSH	R4, [SP, #12]
SUB	R5, R11, R4, LSL #0
LDRSH	R4, [SP, #16]
ADD	R4, R12, R4, LSL #0
UXTH	R2, R10
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawPixel+0
;ST7735.c,515 :: 		ST7735_drawPixel(x0 - x, y0 - y, color);
LDRSH	R4, [SP, #12]
SUB	R5, R11, R4, LSL #0
LDRSH	R4, [SP, #16]
SUB	R4, R12, R4, LSL #0
UXTH	R2, R10
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawPixel+0
;ST7735.c,517 :: 		ST7735_drawPixel(x0 + y, y0 + x, color);
LDRSH	R4, [SP, #16]
ADD	R5, R11, R4, LSL #0
LDRSH	R4, [SP, #12]
ADD	R4, R12, R4, LSL #0
UXTH	R2, R10
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawPixel+0
;ST7735.c,518 :: 		ST7735_drawPixel(x0 - y, y0 + x, color);
LDRSH	R4, [SP, #16]
ADD	R5, R11, R4, LSL #0
LDRSH	R4, [SP, #12]
SUB	R4, R12, R4, LSL #0
UXTH	R2, R10
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawPixel+0
;ST7735.c,519 :: 		ST7735_drawPixel(x0 + y, y0 - x, color);
LDRSH	R4, [SP, #16]
SUB	R5, R11, R4, LSL #0
LDRSH	R4, [SP, #12]
ADD	R4, R12, R4, LSL #0
UXTH	R2, R10
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawPixel+0
;ST7735.c,520 :: 		ST7735_drawPixel(x0 - y, y0 - x, color);
LDRSH	R4, [SP, #16]
SUB	R5, R11, R4, LSL #0
LDRSH	R4, [SP, #12]
SUB	R4, R12, R4, LSL #0
UXTH	R2, R10
UXTB	R1, R5
UXTB	R0, R4
BL	_ST7735_drawPixel+0
;ST7735.c,522 :: 		}
; color end address is: 40 (R10)
; y0 end address is: 44 (R11)
; x0 end address is: 48 (R12)
IT	AL
BAL	L_ST7735_drawCircle47
L_ST7735_drawCircle48:
;ST7735.c,523 :: 		}
L_end_ST7735_drawCircle:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _ST7735_drawCircle
_ST7735_getRotation:
;ST7735.c,525 :: 		unsigned char ST7735_getRotation() {
;ST7735.c,526 :: 		return madctl;
MOVW	R0, #lo_addr(_madctl+0)
MOVT	R0, #hi_addr(_madctl+0)
LDRB	R0, [R0, #0]
;ST7735.c,527 :: 		}
L_end_ST7735_getRotation:
BX	LR
; end of _ST7735_getRotation
_ST7735_setRotation:
;ST7735.c,529 :: 		void ST7735_setRotation(unsigned char m) {
; m start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; m end address is: 0 (R0)
; m start address is: 0 (R0)
;ST7735.c,530 :: 		madctl = m;
MOVW	R1, #lo_addr(_madctl+0)
MOVT	R1, #hi_addr(_madctl+0)
STRB	R0, [R1, #0]
; m end address is: 0 (R0)
;ST7735.c,531 :: 		ST7735_WriteCommand(ST7735_MADCTL);  // memory access control (directions)
MOVS	R0, #54
SXTH	R0, R0
BL	_ST7735_WriteCommand+0
;ST7735.c,532 :: 		ST7735_WriteData(madctl);  // row address/col address, bottom to top refresh
MOVW	R1, #lo_addr(_madctl+0)
MOVT	R1, #hi_addr(_madctl+0)
LDRB	R1, [R1, #0]
SXTH	R0, R1
BL	_ST7735_WriteData+0
;ST7735.c,533 :: 		}
L_end_ST7735_setRotation:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_setRotation
_ST7735_drawRect:
;ST7735.c,537 :: 		unsigned int color) {
SUB	SP, SP, #20
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STRB	R1, [SP, #8]
STRB	R2, [SP, #12]
STRB	R3, [SP, #16]
LDRH	R4, [SP, #20]
STRH	R4, [SP, #20]
;ST7735.c,539 :: 		ST7735_drawHorizontalLine(x, y, w, color);
LDRH	R3, [SP, #20]
LDRB	R2, [SP, #12]
LDRB	R1, [SP, #8]
LDRB	R0, [SP, #4]
BL	_ST7735_drawHorizontalLine+0
;ST7735.c,540 :: 		ST7735_drawHorizontalLine(x, y+h-1, w, color);
LDRB	R5, [SP, #16]
LDRB	R4, [SP, #8]
ADDS	R4, R4, R5
SXTH	R4, R4
SUBS	R4, R4, #1
LDRH	R3, [SP, #20]
LDRB	R2, [SP, #12]
UXTB	R1, R4
LDRB	R0, [SP, #4]
BL	_ST7735_drawHorizontalLine+0
;ST7735.c,541 :: 		ST7735_drawVerticalLine(x, y, h, color);
LDRH	R3, [SP, #20]
LDRB	R2, [SP, #16]
LDRB	R1, [SP, #8]
LDRB	R0, [SP, #4]
BL	_ST7735_drawVerticalLine+0
;ST7735.c,542 :: 		ST7735_drawVerticalLine(x+w-1, y, h, color);
LDRB	R5, [SP, #12]
LDRB	R4, [SP, #4]
ADDS	R4, R4, R5
SXTH	R4, R4
SUBS	R4, R4, #1
LDRH	R3, [SP, #20]
LDRB	R2, [SP, #16]
LDRB	R1, [SP, #8]
UXTB	R0, R4
BL	_ST7735_drawVerticalLine+0
;ST7735.c,543 :: 		}
L_end_ST7735_drawRect:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _ST7735_drawRect
_ST7735_fillRect:
;ST7735.c,546 :: 		unsigned int color) {
; h start address is: 12 (R3)
; w start address is: 8 (R2)
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R9, R2
UXTB	R10, R3
; h end address is: 12 (R3)
; w end address is: 8 (R2)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 0 (R0)
; y start address is: 4 (R1)
; w start address is: 36 (R9)
; h start address is: 40 (R10)
; color start address is: 44 (R11)
LDRH	R11, [SP, #4]
;ST7735.c,549 :: 		setAddrWindow(x, y, x+w-1, y+h-1);
ADD	R4, R1, R10, LSL #0
SXTH	R4, R4
SUBS	R5, R4, #1
ADD	R4, R0, R9, LSL #0
SXTH	R4, R4
SUBS	R4, R4, #1
UXTB	R3, R5
UXTB	R2, R4
; y end address is: 4 (R1)
; x end address is: 0 (R0)
BL	_setAddrWindow+0
;ST7735.c,552 :: 		ST7735_RS = 1;
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOB_ODR+0)
MOVT	R4, #hi_addr(GPIOB_ODR+0)
_SX	[R4, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,553 :: 		ST7735_CS = 0;
MOVS	R5, #0
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOB_ODR+0)
MOVT	R4, #hi_addr(GPIOB_ODR+0)
_SX	[R4, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,555 :: 		colorB = color >> 8;
LSR	R5, R11, #8
MOVW	R4, #lo_addr(_colorB+0)
MOVT	R4, #hi_addr(_colorB+0)
STRB	R5, [R4, #0]
;ST7735.c,556 :: 		for (x=0; x < w; x++) {
; x start address is: 0 (R0)
MOVS	R0, #0
; w end address is: 36 (R9)
; h end address is: 40 (R10)
; color end address is: 44 (R11)
; x end address is: 0 (R0)
UXTB	R5, R9
UXTB	R6, R10
UXTH	R1, R11
L_ST7735_fillRect50:
; x start address is: 0 (R0)
; color start address is: 4 (R1)
; h start address is: 24 (R6)
; w start address is: 20 (R5)
CMP	R0, R5
IT	CS
BCS	L_ST7735_fillRect51
;ST7735.c,557 :: 		for (y=0; y < h; y++) {
; y start address is: 8 (R2)
MOVS	R2, #0
; color end address is: 4 (R1)
; y end address is: 8 (R2)
; w end address is: 20 (R5)
; h end address is: 24 (R6)
; x end address is: 0 (R0)
UXTB	R8, R0
UXTH	R7, R1
UXTB	R9, R2
L_ST7735_fillRect53:
; y start address is: 36 (R9)
; w start address is: 20 (R5)
; h start address is: 24 (R6)
; color start address is: 28 (R7)
; x start address is: 32 (R8)
CMP	R9, R6
IT	CS
BCS	L_ST7735_fillRect54
;ST7735.c,558 :: 		SPI1_Write(colorB);
MOVW	R4, #lo_addr(_colorB+0)
MOVT	R4, #hi_addr(_colorB+0)
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_SPI1_Write+0
;ST7735.c,559 :: 		SPI1_Write(color);
UXTH	R0, R7
BL	_SPI1_Write+0
;ST7735.c,557 :: 		for (y=0; y < h; y++) {
ADD	R9, R9, #1
UXTB	R9, R9
;ST7735.c,560 :: 		}
; y end address is: 36 (R9)
IT	AL
BAL	L_ST7735_fillRect53
L_ST7735_fillRect54:
;ST7735.c,556 :: 		for (x=0; x < w; x++) {
ADD	R4, R8, #1
; x end address is: 32 (R8)
; x start address is: 0 (R0)
UXTB	R0, R4
;ST7735.c,561 :: 		}
; w end address is: 20 (R5)
; h end address is: 24 (R6)
; color end address is: 28 (R7)
; x end address is: 0 (R0)
UXTH	R1, R7
IT	AL
BAL	L_ST7735_fillRect50
L_ST7735_fillRect51:
;ST7735.c,563 :: 		ST7735_CS = 1;
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOB_ODR+0)
MOVT	R4, #hi_addr(GPIOB_ODR+0)
_SX	[R4, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,564 :: 		}
L_end_ST7735_fillRect:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_fillRect
_ST7735_drawVerticalLine:
;ST7735.c,566 :: 		void ST7735_drawVerticalLine(unsigned char x, unsigned char y, unsigned char length, unsigned int color)
; color start address is: 12 (R3)
; length start address is: 8 (R2)
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; color end address is: 12 (R3)
; length end address is: 8 (R2)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 0 (R0)
; y start address is: 4 (R1)
; length start address is: 8 (R2)
; color start address is: 12 (R3)
;ST7735.c,568 :: 		if (x >= SCREEN_WIDTH) return;
CMP	R0, #128
IT	CC
BCC	L_ST7735_drawVerticalLine56
; x end address is: 0 (R0)
; y end address is: 4 (R1)
; color end address is: 12 (R3)
; length end address is: 8 (R2)
IT	AL
BAL	L_end_ST7735_drawVerticalLine
L_ST7735_drawVerticalLine56:
;ST7735.c,569 :: 		if (y+length >= SCREEN_HEIGHT) length = SCREEN_HEIGHT-y-1;
; length start address is: 8 (R2)
; color start address is: 12 (R3)
; y start address is: 4 (R1)
; x start address is: 0 (R0)
ADDS	R4, R1, R2
SXTH	R4, R4
CMP	R4, #160
IT	LT
BLT	L__ST7735_drawVerticalLine76
; length end address is: 8 (R2)
RSB	R4, R1, #160
SXTH	R4, R4
SUBS	R4, R4, #1
; length start address is: 8 (R2)
UXTB	R2, R4
; length end address is: 8 (R2)
IT	AL
BAL	L_ST7735_drawVerticalLine57
L__ST7735_drawVerticalLine76:
L_ST7735_drawVerticalLine57:
;ST7735.c,571 :: 		ST7735_drawFastLine(x,y,length,color,1);
; length start address is: 8 (R2)
MOVS	R4, #1
; color end address is: 12 (R3)
; length end address is: 8 (R2)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
PUSH	(R4)
BL	_ST7735_drawFastLine+0
ADD	SP, SP, #4
;ST7735.c,572 :: 		}
L_end_ST7735_drawVerticalLine:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_drawVerticalLine
_ST7735_drawHorizontalLine:
;ST7735.c,574 :: 		void ST7735_drawHorizontalLine(unsigned char x, unsigned char y, unsigned char length, unsigned int color)
; color start address is: 12 (R3)
; length start address is: 8 (R2)
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; color end address is: 12 (R3)
; length end address is: 8 (R2)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 0 (R0)
; y start address is: 4 (R1)
; length start address is: 8 (R2)
; color start address is: 12 (R3)
;ST7735.c,576 :: 		if (y >= SCREEN_HEIGHT) return;
CMP	R1, #160
IT	CC
BCC	L_ST7735_drawHorizontalLine58
; x end address is: 0 (R0)
; y end address is: 4 (R1)
; color end address is: 12 (R3)
; length end address is: 8 (R2)
IT	AL
BAL	L_end_ST7735_drawHorizontalLine
L_ST7735_drawHorizontalLine58:
;ST7735.c,577 :: 		if (x+length >= SCREEN_WIDTH) length = SCREEN_WIDTH-x-1;
; length start address is: 8 (R2)
; color start address is: 12 (R3)
; y start address is: 4 (R1)
; x start address is: 0 (R0)
ADDS	R4, R0, R2
SXTH	R4, R4
CMP	R4, #128
IT	LT
BLT	L__ST7735_drawHorizontalLine77
; length end address is: 8 (R2)
RSB	R4, R0, #128
SXTH	R4, R4
SUBS	R4, R4, #1
; length start address is: 8 (R2)
UXTB	R2, R4
; length end address is: 8 (R2)
IT	AL
BAL	L_ST7735_drawHorizontalLine59
L__ST7735_drawHorizontalLine77:
L_ST7735_drawHorizontalLine59:
;ST7735.c,579 :: 		ST7735_drawFastLine(x,y,length,color,0);
; length start address is: 8 (R2)
MOVS	R4, #0
; color end address is: 12 (R3)
; length end address is: 8 (R2)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
PUSH	(R4)
BL	_ST7735_drawFastLine+0
ADD	SP, SP, #4
;ST7735.c,580 :: 		}
L_end_ST7735_drawHorizontalLine:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_drawHorizontalLine
_ST7735_drawFastLine:
;ST7735.c,583 :: 		unsigned int color, unsigned char rotflag)
; color start address is: 12 (R3)
; length start address is: 8 (R2)
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R11, R0
UXTB	R12, R1
UXTB	R9, R2
UXTH	R10, R3
; color end address is: 12 (R3)
; length end address is: 8 (R2)
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 44 (R11)
; y start address is: 48 (R12)
; length start address is: 36 (R9)
; color start address is: 40 (R10)
; rotflag start address is: 16 (R4)
LDRB	R4, [SP, #4]
;ST7735.c,585 :: 		if (rotflag) {
CMP	R4, #0
IT	EQ
BEQ	L_ST7735_drawFastLine60
; rotflag end address is: 16 (R4)
;ST7735.c,586 :: 		setAddrWindow(x, y, x, y+length);
ADD	R4, R12, R9, LSL #0
UXTB	R3, R4
UXTB	R2, R11
UXTB	R1, R12
; y end address is: 48 (R12)
UXTB	R0, R11
; x end address is: 44 (R11)
BL	_setAddrWindow+0
;ST7735.c,587 :: 		} else {
IT	AL
BAL	L_ST7735_drawFastLine61
L_ST7735_drawFastLine60:
;ST7735.c,588 :: 		setAddrWindow(x, y, x+length, y+1);
; y start address is: 48 (R12)
; x start address is: 44 (R11)
ADD	R5, R12, #1
ADD	R4, R11, R9, LSL #0
UXTB	R3, R5
UXTB	R2, R4
UXTB	R1, R12
; y end address is: 48 (R12)
UXTB	R0, R11
; x end address is: 44 (R11)
BL	_setAddrWindow+0
;ST7735.c,589 :: 		}
L_ST7735_drawFastLine61:
;ST7735.c,591 :: 		ST7735_RS = 1;
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOB_ODR+0)
MOVT	R4, #hi_addr(GPIOB_ODR+0)
_SX	[R4, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,592 :: 		ST7735_CS = 0;
MOVS	R5, #0
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOB_ODR+0)
MOVT	R4, #hi_addr(GPIOB_ODR+0)
_SX	[R4, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,594 :: 		colorB = color >> 8;
LSR	R5, R10, #8
MOVW	R4, #lo_addr(_colorB+0)
MOVT	R4, #hi_addr(_colorB+0)
STRB	R5, [R4, #0]
; length end address is: 36 (R9)
; color end address is: 40 (R10)
UXTB	R0, R9
UXTH	R6, R10
;ST7735.c,595 :: 		while (length--) {
L_ST7735_drawFastLine62:
; length start address is: 28 (R7)
; color start address is: 24 (R6)
; color start address is: 24 (R6)
; color end address is: 24 (R6)
; length start address is: 0 (R0)
UXTB	R5, R0
SUBS	R4, R0, #1
; length end address is: 0 (R0)
; length start address is: 28 (R7)
UXTB	R7, R4
; length end address is: 28 (R7)
CMP	R5, #0
IT	EQ
BEQ	L_ST7735_drawFastLine63
; color end address is: 24 (R6)
; length end address is: 28 (R7)
;ST7735.c,596 :: 		SPI1_Write(colorB);
; length start address is: 28 (R7)
; color start address is: 24 (R6)
MOVW	R4, #lo_addr(_colorB+0)
MOVT	R4, #hi_addr(_colorB+0)
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_SPI1_Write+0
;ST7735.c,597 :: 		SPI1_Write(color);
UXTH	R0, R6
BL	_SPI1_Write+0
;ST7735.c,598 :: 		}
UXTB	R0, R7
; color end address is: 24 (R6)
; length end address is: 28 (R7)
IT	AL
BAL	L_ST7735_drawFastLine62
L_ST7735_drawFastLine63:
;ST7735.c,599 :: 		ST7735_CS = 1;
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(GPIOB_ODR+0)
MOVT	R4, #hi_addr(GPIOB_ODR+0)
_SX	[R4, ByteOffset(GPIOB_ODR+0)]
;ST7735.c,600 :: 		}
L_end_ST7735_drawFastLine:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ST7735_drawFastLine
_abs:
;ST7735.c,602 :: 		int abs(int val)
; val start address is: 0 (R0)
; val end address is: 0 (R0)
; val start address is: 0 (R0)
;ST7735.c,604 :: 		return (val > 0) ? val : -val;
CMP	R0, #0
IT	LE
BLE	L_abs64
; ?FLOC___abs?T166 start address is: 4 (R1)
SXTH	R1, R0
; val end address is: 0 (R0)
SXTH	R0, R1
; ?FLOC___abs?T166 end address is: 4 (R1)
IT	AL
BAL	L_abs65
L_abs64:
; val start address is: 0 (R0)
RSBS	R0, R0, #0
SXTH	R0, R0
; val end address is: 0 (R0)
; ?FLOC___abs?T166 start address is: 0 (R0)
; ?FLOC___abs?T166 end address is: 0 (R0)
L_abs65:
; ?FLOC___abs?T166 start address is: 0 (R0)
; ?FLOC___abs?T166 end address is: 0 (R0)
;ST7735.c,605 :: 		}
L_end_abs:
BX	LR
; end of _abs
_ST7735_drawLine:
;ST7735.c,609 :: 		unsigned int color) {
; y1 start address is: 12 (R3)
; x1 start address is: 8 (R2)
; y0 start address is: 4 (R1)
; x0 start address is: 0 (R0)
SUB	SP, SP, #20
STR	LR, [SP, #0]
SXTH	R7, R0
SXTH	R8, R1
SXTH	R5, R2
SXTH	R6, R3
; y1 end address is: 12 (R3)
; x1 end address is: 8 (R2)
; y0 end address is: 4 (R1)
; x0 end address is: 0 (R0)
; x0 start address is: 28 (R7)
; y0 start address is: 32 (R8)
; x1 start address is: 20 (R5)
; y1 start address is: 24 (R6)
; color start address is: 8 (R2)
LDRH	R2, [SP, #20]
;ST7735.c,610 :: 		unsigned int steep = abs(y1 - y0) > abs(x1 - x0);
SUB	R4, R6, R8, LSL #0
SXTH	R0, R4
BL	_abs+0
STRH	R0, [SP, #16]
SUB	R4, R5, R7
SXTH	R0, R4
BL	_abs+0
LDRSH	R4, [SP, #16]
CMP	R4, R0
MOVW	R4, #0
BLE	L__ST7735_drawLine103
MOVS	R4, #1
L__ST7735_drawLine103:
; steep start address is: 12 (R3)
UXTH	R3, R4
;ST7735.c,611 :: 		if (steep) {
UXTH	R4, R4
CMP	R4, #0
IT	EQ
BEQ	L__ST7735_drawLine78
;ST7735.c,612 :: 		swap(x0, y0);
; t start address is: 4 (R1)
SXTH	R1, R7
; x0 end address is: 28 (R7)
; x0 start address is: 0 (R0)
SXTH	R0, R8
; y0 end address is: 32 (R8)
; y0 start address is: 16 (R4)
SXTH	R4, R1
; t end address is: 4 (R1)
;ST7735.c,613 :: 		swap(x1, y1);
; t start address is: 4 (R1)
SXTH	R1, R5
SXTH	R5, R6
SXTH	R6, R1
; y0 end address is: 16 (R4)
; t end address is: 4 (R1)
; y1 end address is: 24 (R6)
; x1 end address is: 20 (R5)
; x0 end address is: 0 (R0)
STRH	R6, [SP, #4]
SXTH	R6, R0
SXTH	R1, R4
LDRSH	R0, [SP, #4]
;ST7735.c,614 :: 		}
IT	AL
BAL	L_ST7735_drawLine66
L__ST7735_drawLine78:
;ST7735.c,611 :: 		if (steep) {
SXTH	R0, R6
SXTH	R6, R7
SXTH	R1, R8
;ST7735.c,614 :: 		}
L_ST7735_drawLine66:
;ST7735.c,616 :: 		if (x0 > x1) {
; y1 start address is: 0 (R0)
; x1 start address is: 20 (R5)
; y0 start address is: 4 (R1)
; x0 start address is: 24 (R6)
CMP	R6, R5
IT	LE
BLE	L__ST7735_drawLine79
;ST7735.c,617 :: 		swap(x0, x1);
; t start address is: 28 (R7)
SXTH	R7, R6
; x0 end address is: 24 (R6)
; x0 start address is: 16 (R4)
SXTH	R4, R5
; x1 end address is: 20 (R5)
; x1 start address is: 40 (R10)
SXTH	R10, R7
; t end address is: 28 (R7)
;ST7735.c,618 :: 		swap(y0, y1);
; t start address is: 20 (R5)
SXTH	R5, R1
; y0 end address is: 4 (R1)
; y0 start address is: 32 (R8)
SXTH	R8, R0
; y1 end address is: 0 (R0)
; y1 start address is: 28 (R7)
SXTH	R7, R5
; x0 end address is: 16 (R4)
; t end address is: 20 (R5)
; y1 end address is: 28 (R7)
; y0 end address is: 32 (R8)
; x1 end address is: 40 (R10)
SXTH	R6, R4
;ST7735.c,619 :: 		}
IT	AL
BAL	L_ST7735_drawLine67
L__ST7735_drawLine79:
;ST7735.c,616 :: 		if (x0 > x1) {
SXTH	R7, R0
SXTH	R8, R1
SXTH	R10, R5
;ST7735.c,619 :: 		}
L_ST7735_drawLine67:
;ST7735.c,622 :: 		dx = x1 - x0;
; y1 start address is: 28 (R7)
; y0 start address is: 32 (R8)
; x1 start address is: 40 (R10)
; x0 start address is: 24 (R6)
SUB	R5, R10, R6, LSL #0
MOVW	R4, #lo_addr(_dx+0)
MOVT	R4, #hi_addr(_dx+0)
STRH	R5, [R4, #0]
;ST7735.c,623 :: 		dy = abs(y1 - y0);
SUB	R4, R7, R8, LSL #0
SXTH	R0, R4
BL	_abs+0
MOVW	R4, #lo_addr(_dy+0)
MOVT	R4, #hi_addr(_dy+0)
STRH	R0, [R4, #0]
;ST7735.c,625 :: 		err = dx / 2;
MOVW	R4, #lo_addr(_dx+0)
MOVT	R4, #hi_addr(_dx+0)
LDRH	R4, [R4, #0]
LSRS	R5, R4, #1
MOVW	R4, #lo_addr(_err+0)
MOVT	R4, #hi_addr(_err+0)
STRH	R5, [R4, #0]
;ST7735.c,628 :: 		if (y0 < y1) {
CMP	R8, R7
IT	GE
BGE	L_ST7735_drawLine68
; y1 end address is: 28 (R7)
;ST7735.c,629 :: 		ystep = 1;
MOVS	R5, #1
SXTH	R5, R5
MOVW	R4, #lo_addr(_ystep+0)
MOVT	R4, #hi_addr(_ystep+0)
STRH	R5, [R4, #0]
;ST7735.c,630 :: 		} else {
IT	AL
BAL	L_ST7735_drawLine69
L_ST7735_drawLine68:
;ST7735.c,631 :: 		ystep = -1;}
MOVW	R5, #65535
SXTH	R5, R5
MOVW	R4, #lo_addr(_ystep+0)
MOVT	R4, #hi_addr(_ystep+0)
STRH	R5, [R4, #0]
L_ST7735_drawLine69:
;ST7735.c,633 :: 		for (; x0<=x1; x0++) {
UXTH	R12, R2
; steep end address is: 12 (R3)
; y0 end address is: 32 (R8)
; x0 end address is: 24 (R6)
; x1 end address is: 40 (R10)
UXTH	R11, R3
SXTH	R1, R8
SXTH	R0, R6
L_ST7735_drawLine70:
; color end address is: 8 (R2)
; x0 start address is: 0 (R0)
; color start address is: 48 (R12)
; steep start address is: 44 (R11)
; x1 start address is: 40 (R10)
; y0 start address is: 4 (R1)
; steep start address is: 44 (R11)
; steep end address is: 44 (R11)
; color start address is: 48 (R12)
; color end address is: 48 (R12)
CMP	R0, R10
IT	GT
BGT	L_ST7735_drawLine71
; steep end address is: 44 (R11)
; color end address is: 48 (R12)
;ST7735.c,634 :: 		if (steep) {
; color start address is: 48 (R12)
; steep start address is: 44 (R11)
CMP	R11, #0
IT	EQ
BEQ	L_ST7735_drawLine73
;ST7735.c,635 :: 		ST7735_drawPixel(y0, x0, color);
STRH	R1, [SP, #4]
STRH	R0, [SP, #8]
STRH	R1, [SP, #12]
UXTH	R2, R12
UXTB	R1, R0
LDRB	R0, [SP, #12]
BL	_ST7735_drawPixel+0
LDRSH	R0, [SP, #8]
LDRSH	R1, [SP, #4]
;ST7735.c,636 :: 		} else {
IT	AL
BAL	L_ST7735_drawLine74
L_ST7735_drawLine73:
;ST7735.c,637 :: 		ST7735_drawPixel(x0, y0, color);
STRH	R1, [SP, #4]
STRH	R0, [SP, #8]
UXTH	R2, R12
UXTB	R1, R1
UXTB	R0, R0
BL	_ST7735_drawPixel+0
LDRSH	R0, [SP, #8]
LDRSH	R1, [SP, #4]
;ST7735.c,638 :: 		}
L_ST7735_drawLine74:
;ST7735.c,639 :: 		err -= dy;
MOVW	R4, #lo_addr(_dy+0)
MOVT	R4, #hi_addr(_dy+0)
LDRH	R6, [R4, #0]
MOVW	R5, #lo_addr(_err+0)
MOVT	R5, #hi_addr(_err+0)
LDRSH	R4, [R5, #0]
SUB	R4, R4, R6
STRH	R4, [R5, #0]
;ST7735.c,640 :: 		if (err < 0) {
SXTH	R4, R4
CMP	R4, #0
IT	GE
BGE	L__ST7735_drawLine80
;ST7735.c,641 :: 		y0 += ystep;
MOVW	R4, #lo_addr(_ystep+0)
MOVT	R4, #hi_addr(_ystep+0)
LDRSH	R4, [R4, #0]
ADDS	R1, R1, R4
SXTH	R1, R1
;ST7735.c,642 :: 		err += dx;
MOVW	R4, #lo_addr(_dx+0)
MOVT	R4, #hi_addr(_dx+0)
LDRH	R6, [R4, #0]
MOVW	R5, #lo_addr(_err+0)
MOVT	R5, #hi_addr(_err+0)
LDRSH	R4, [R5, #0]
ADDS	R4, R4, R6
STRH	R4, [R5, #0]
; y0 end address is: 4 (R1)
;ST7735.c,643 :: 		}
IT	AL
BAL	L_ST7735_drawLine75
L__ST7735_drawLine80:
;ST7735.c,640 :: 		if (err < 0) {
;ST7735.c,643 :: 		}
L_ST7735_drawLine75:
;ST7735.c,633 :: 		for (; x0<=x1; x0++) {
; y0 start address is: 4 (R1)
ADDS	R0, R0, #1
SXTH	R0, R0
;ST7735.c,644 :: 		}
; x1 end address is: 40 (R10)
; steep end address is: 44 (R11)
; color end address is: 48 (R12)
; y0 end address is: 4 (R1)
; x0 end address is: 0 (R0)
IT	AL
BAL	L_ST7735_drawLine70
L_ST7735_drawLine71:
;ST7735.c,645 :: 		}
L_end_ST7735_drawLine:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _ST7735_drawLine
