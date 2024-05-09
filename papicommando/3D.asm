

;Frame 1 general + clear + matrix
;Frame 2 calcul vertex
;Frame 3 calcul vertex + tri
;Frame 4 et 5 fillrate

SNES3D:
	jsl LKS_INIT
	
	;background
	SNES_BGMODE $07 ;  Mode 7

	
	;general init
    SNES_TM $11 ; obj & bg 1 enable
    
    
    ;FORCED BLANK
       
	;Load bg 1
    SNES_VMAINC $00
	
    
    jsl Init_Frame
    
	SNES_VMAINC $80
    ;Load Object
    
    
    SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	SNES_VMADD $6200
	SNES_DMA0_ADD Font3 $400	
	
    SNES_MDMAEN $01
    

    
    ; Load Palette
    SNES_CGADD $00
       
    SNES_DMA0 $00
	SNES_DMA0_BADD $22
    SNES_DMA0_ADD pallette_3D $0100
    SNES_MDMAEN $01
    
    
    ;font 3
    SNES_CGADD $80
       
    SNES_DMA0 $00
	SNES_DMA0_BADD $22
    SNES_DMA0_ADD pallette_fontdgt $0020
    SNES_MDMAEN $01

	
    
    SNES_M7SEL $00
    SNES_M7 $80,$00,$00,$6D,$00,$00

	;--------------------------


	
	lda	RDNMI
	SNES_INIDISP $00 ;  brigtness 0
	SNES_NMITIMEN $81 ; Enable NMI , enable joypad
	wai
	SNES_INIDISP $0F
	
	lda #2
	sta LKS.VBlankType
	jsl LKS_OAM_Clear
	
	Game3D:	
		jsl LKS_Joypad
		;jsl LKS_OAM_Clear
		jsl Debug_M7
		
		;SNES_DMAX $00
		;SNES_DMAX_BADD $80
		
		
		;jsl Draw_Clear
		 
		jsl Draw_Triangle
		
		/*
		ldx #9*3*42
		-:
			
			lda #5 ;2
			sta WRMPYA ;4
			lda #8 ;2
			sta WRMPYB ;4
			
			nop ;2
			nop ;2
			nop ;2
			nop ;2
			
			ldy RDMPYL ;5
			sty MEM_TEMP ;5
			 
			dex
		bne -
		*/
		
		

		jsl WaitVBlank
		
    jmp Game3D


;---------Draw---------

Draw_Clear:
	SNES_DMA0 $08
	SNES_DMA0_BADD $80
	
	ldx #0
	stx WMADDL
	lda #1
	sta WMADDH
	
	ldx #DATA_COLOR_3D
	lda #:DATA_COLOR_3D
	ldy #128*96

	sta DMA_BANK
	stx DMA_ADDL
	sty DMA_SIZEL
	
	ldx #$1
	stx MDMAEN
	
	rtl


.MACRO DRAW_LIGNE

	ldy #$40*\1
	lda #$0505
	ldx #0
	jsr (0,x)

	


.ENDM

Draw_Triangle:

	rep #$20
	
	lda #$20
	sta MEM_TEMPFUNC

	lda MEM_TEMPFUNC
	asl
	asl
	clc
	adc #Draw_Ligne_0
	sta 0	
	
	ldy #$0
	ldx #$1
	-:
		phx
		
		lda #$0505
		ldx #0
		jsr (0,x)
		plx
		
		tya
		clc
		adc #$8
		bit #$40
		beq +
			clc
			adc #$400-$40
		+:
		tay
		
		dex
	bne -

	sep #$20

	rtl
 

;--------Draw_Ligne-------
.include "3D_Draw_Ligne.asm"
;-----Debug_M7-------	

Debug_M7:

	stz MEM_TEMPFUNC+6
	stz MEM_TEMPFUNC+6+1
	
	lda LKS.cpu
	sta MEM_TEMPFUNC
	stz MEM_TEMPFUNC+1
	
	lda #50
	sta MEM_TEMPFUNC+2
	lda #200
	sta MEM_TEMPFUNC+3
	
	lda #$10
	sta MEM_TEMPFUNC+4
	jsl Draw_digit
	
	
	ldx LKS.VBlankTime
	stx MEM_TEMPFUNC
	
	lda #50
	sta MEM_TEMPFUNC+2
	lda #208
	sta MEM_TEMPFUNC+3
	
	lda #$10
	sta MEM_TEMPFUNC+4
	jsl Draw_digit
	
	
	rtl
	
;-----Init-------

.MACRO Init_FrameM7
	ldx #$80*\1
	stx VMADDL
	
	ldy #$10
	-:
		sta VMDATAL
		ina
		dey
	bne -
.ENDM


	
Init_Frame:

	lda #0
	Init_FrameM7 0
	Init_FrameM7 1
	Init_FrameM7 2
	Init_FrameM7 3
	
	Init_FrameM7 4
	Init_FrameM7 5
	Init_FrameM7 6
	Init_FrameM7 7

	Init_FrameM7 8
	Init_FrameM7 9
	Init_FrameM7 10
	Init_FrameM7 11
	
	Init_FrameM7 12
	Init_FrameM7 13
	Init_FrameM7 14
	Init_FrameM7 15
	
	rtl
    
    
;----Draw Digit Sprite------

.MACRO Draw_Digit_OAM1
	sta LKS_BUF_OAML+2+(4*\1),x
	
.ENDM

.MACRO Draw_Digit_OAM2
	
	lda MEM_TEMPFUNC+4
	sta LKS_BUF_OAML+3+(4*0),x
	sta LKS_BUF_OAML+3+(4*1),x
	sta LKS_BUF_OAML+3+(4*2),x
	sta LKS_BUF_OAML+3+(4*3),x
	sta LKS_BUF_OAML+3+(4*4),x

	lda MEM_TEMPFUNC+2
	sta LKS_BUF_OAML+0+(4*0),x
	adc #$8
	sta LKS_BUF_OAML+0+(4*1),x
	adc #$8
	sta LKS_BUF_OAML+0+(4*2),x
	adc #$8
	sta LKS_BUF_OAML+0+(4*3),x
	adc #$8
	sta LKS_BUF_OAML+0+(4*4),x
	
	lda MEM_TEMPFUNC+3
	sta LKS_BUF_OAML+1+(4*0),x
	sta LKS_BUF_OAML+1+(4*1),x
	sta LKS_BUF_OAML+1+(4*2),x
	sta LKS_BUF_OAML+1+(4*3),x
	sta LKS_BUF_OAML+1+(4*4),x

.ENDM

Draw_digit:

	rep #$20
	
	lda MEM_TEMPFUNC
	and #$7FFF
	compute_digit_for_base16 10000
	stx MEM_TEMP+12
	compute_digit_for_base16 1000
	stx MEM_TEMP+10
	compute_digit_for_base16 100
	stx MEM_TEMP+8
	compute_digit_for_base16 10
	stx MEM_TEMP + 6
	sta MEM_TEMP + 4
	
	sep #$20
	
	ldx MEM_TEMPFUNC+6
	
	lda #$30
	clc
	adc MEM_TEMP+12
	Draw_Digit_OAM1 0

	lda #$30
	adc MEM_TEMP+10
	Draw_Digit_OAM1 1
	
	lda #$30
	adc MEM_TEMP+8
	Draw_Digit_OAM1 2
	
	lda #$30
	adc MEM_TEMP+6
	Draw_Digit_OAM1 3
	
	lda #$30
	adc MEM_TEMP+4
	Draw_Digit_OAM1 4
	
	Draw_Digit_OAM2
	
	rep #$20
	
	txa
	adc #8*5
	sta MEM_TEMPFUNC+6
	
	sep #$20
	
	
	rtl
	
	
	
;----DATA------
DATA_COLOR_3D:
	.db 0,1,2,3,4,5,6,7,8
pallette_3D:
    .dw $3DEF, $1300, $e700, $1200, $fe00,$FF00
	

	

	

	
