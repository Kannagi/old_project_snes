



Mode7:
	SNES_INIT
	LKS_Clear_RAM
	
    ;INITIAL SETTINGS
	SNES_INIDISP $8F ; FORCED BLANK , brigtness 15
	
	;object
	SNES_OBJSEL $03 ; 8x8 , $6000 address
	
	;background
	SNES_BGMODE $07 ;  Mode 7
	
	SNES_BG2SC $58 ; address data BG2 $5800
	
	SNES_BGNBA $44 $04; address BG1,2,3,4 (2,1 / 4,3)
	
	SNES_CGSWSEL $02
	SNES_CGADSUB $21
	SNES_COLDATA $E0
	
	;general init
	SNES_SETINI $00 ;$40 ext BG
    SNES_TM $11 ; obj & bg 1 enable
    
    
    ;FORCED BLANK
       

	;Load bg 1
    SNES_VMAINC $00
	SNES_VMADD $0000
    
    SNES_DMA0 $00
	SNES_DMA0_BADD $18
	SNES_DMA0_ADD Map $4000
	
	
	
    SNES_MDMAEN $01

    SNES_VMAINC $80
	SNES_VMADD $0000
    
    SNES_DMA0 $00
	SNES_DMA0_BADD $19
    SNES_DMA0_ADD Tiles $2000
    
    SNES_MDMAEN $01  
    
    
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
    SNES_DMA0_ADD pallette_mode7 $0100
    SNES_MDMAEN $01
    
    ;font 3
    SNES_CGADD $80
       
    SNES_DMA0 $00
	SNES_DMA0_BADD $22
    SNES_DMA0_ADD pallette_fontdgt $0020
    SNES_MDMAEN $01
    
    
    SNES_CGADD $70
    SNES_DMA0_ADD pallette_sky $0020
    SNES_MDMAEN $01
    
    
    SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;Load bg 2
	SNES_VMADD $4000
    
	SNES_DMA0_ADD sky $1800
	
	SNES_MDMAEN $01
	

	;Load BG2 tile
	SNES_VMADD $5800
	
	SNES_DMA0_ADD skytile $200
	
	SNES_MDMAEN $01
    
      
    
    
    
	
	
	

    
    SNES_M7SEL $00
    SNES_M7 $100,$00,$00,$100,$80,$80

	;--------------------------
	


	
	
	
	
	
	
	

	
	
	
	ldx #$00
	ldy #$00
	-:

		lda #1
		sta MODE7A,x
		sta MODE7D,x
		sta MODE7B,x
		sta MODE7C,x
		inx
		
		rep #$20
			
		lda #$100
		sta MODE7A,x
		sta MODE7D,x
		
		lda #$0
		sta MODE7B,x
		sta MODE7C,x
		inx
		inx
		
		sep #$20
		
		iny
		cpy #$F0
	bne -
	lda #0
	sta MODE7A,x
	sta MODE7D,x
	sta MODE7B,x
	sta MODE7C,x
	
	
	
	jsl Init_Rendu_M7
	
	;------------------------------
	ldx #0
	stx s_mode7+_m7an
	
	ldx #$80
	stx s_mode7+_m7x
	
	ldx #$100
	stx s_mode7+_m7y
	
	
	ldx #$00
	stx s_mode7+_m7sy

	;------------------------------
	lda #1
	sta LKS_VBLANK
	
	SNES_BGMODE $31
	SNES_INIDISP $00 ;  brigtness 0
	SNES_NMITIMEN $B1; Enable NMI , enable joypad
	wai
	SNES_INIDISP $0F ;  brigtness 15
	cli
	
	ldy #$00
	sty HTIMEL
	
	ldy #$60
	sty VTIMEL
	
	
	
	
	Game2:	
		jsl LKS_Joypad
		jsl LKS_OAM_Clear
		jsl Debug_M7
		
		lda LKS_STDCTRL+_SELECT
		cmp #1
		bne +
			sei
			jml Reset
		+:

		jsl add_HDMA_M7
		lda LKS_STDCTRL + _L	
		cmp #2
		bne +
			rep #$20
			lda s_mode7+_m7sx
			ina
			cmp #80
			bmi ++
				dea
			++:
			sta s_mode7+_m7sx
			sep #$20
		+:
		
		lda LKS_STDCTRL + _R	
		cmp #2
		bne +
			rep #$20
			lda s_mode7+_m7sx
			dea
			cmp #-60
			bpl ++
				ina
			++:
			sta s_mode7+_m7sx
			sep #$20
		+:
		
		rep #$20
		
		lda s_mode7+_m7sx
		lsr
		lsr
		lsr
		lsr
		sta s_mode7+_m7sy
	
		sep #$20
		
		
		lda LKS_STDCTRL+_LEFT
		cmp #2
		bne +
			dec s_mode7+_m7an
		+:
		
		lda LKS_STDCTRL+_RIGHT
		cmp #2
		bne +
			inc s_mode7+_m7an
		+:
		
		lda LKS_STDCTRL+_UP
		cmp #2
		bne +
			ldx #0
			stx MEM_TEMPFUNC
			
			jsl Move_Mode7
			
		+:
		
		lda LKS_STDCTRL+_DOWN
		cmp #2
		bne +
			ldx #1
			stx MEM_TEMPFUNC
			
			jsl Move_Mode7
		+:
		
		
		LKS_BG1_set s_mode7+_m7px,s_mode7+_m7py
		
		ldx #$20-1
		stx MEM_TEMP
		LKS_BG2_set s_mode7+_m7an,MEM_TEMP
		
		lda #1
		sta LKS_VBLANK
		jsl WaitVBlank
		;stz LKS_VBLANK
		

    jmp Game2
    
Debug_M7:

	;OAM ADD
	ldx #0
	stx MEM_TEMPFUNC+2
	
	
	;fake zoom
	ldx s_mode7+_m7sx
	stx MEM_TEMPFUNC
	
	LKS_OAM_position 210,160
	jsl Draw_digit
	
	
	; time VBLANK
	ldx LKS_VBLANK+_vbltime
	stx MEM_TEMPFUNC
	
	LKS_OAM_position 210,170
	jsl Draw_digit
	
	
	
	
	rtl
    
Draw_digit:


	

	rep #$20
	
	lda MEM_TEMPFUNC
	and #$7FFF
	compute_digit_for_base16 10000
	stx MEM_TEMP+12
	compute_digit_for_base16 1000
	stx MEM_TEMP+4
	compute_digit_for_base16 100
	stx MEM_TEMP+6
	compute_digit_for_base16 10
	stx MEM_TEMP + 8
	sta MEM_TEMP + 10
	
	sep #$20
	
	ldy MEM_TEMPFUNC+2
	
	lda #$30
	clc
	adc MEM_TEMP+12
	sta LKS_OAM+_sprtile
	jsl Draw_OAM
	
	lda #$30
	clc
	adc MEM_TEMP+4
	sta LKS_OAM+_sprtile
	jsl Draw_OAM
	
	
	lda #$30
	clc
	adc MEM_TEMP+6
	sta LKS_OAM+_sprtile
	jsl Draw_OAM
	
	lda #$30
	clc
	adc MEM_TEMP+8
	sta LKS_OAM+_sprtile
	jsl Draw_OAM
	
	lda #$30
	clc
	adc MEM_TEMP+10
	sta LKS_OAM+_sprtile
	jsl Draw_OAM
	
	rep #$20
	
	lda MEM_TEMPFUNC+2
	clc
	adc #8*5
	sta MEM_TEMPFUNC+2
	
	sep #$20
	
	
	rtl
	
	
Draw_OAM:
	
	lda #$30
	sta LKS_OAM+_sprext
	
	lda #$8
	sta LKS_OAM+_sprsz
	
	jsl LKS_OAM_Draw
	
	rep #$20
	lda LKS_OAM+_sprx
	clc
	adc #$9
	sta LKS_OAM+_sprx
	sep #$20


	rtl
	
Init_Rendu_M7:


	
	ldx #3*$60
	inx
	ldy #$00
	-:

		rep #$20
		
		phx
		tyx
		lda zoom7.l,x
		asl
		sta MODE7S,x
		lsr
		plx
		
		sta MODE7A,x
		sta MODE7D,x
		
		lda #0
		sta MODE7B,x
		sta MODE7C,x
		
		sep #$20
		
		inx
		inx
		inx
		
		iny
		iny
		cpy #$80*2
	bne -
	
	lda #0
	sta MODE7A,x
	sta MODE7D,x
	sta MODE7B,x
	sta MODE7C,x
	
	
	rtl

	

	
	
Move_Mode7:

	rep #$20
	lda s_mode7+_m7an
	asl
	tax
	sep #$20
	
	rep #$20
	lda sincos2.l+$00,x
	sta s_mode7+_m7vx
	
	lda sincos2.l+$80,x
	sta s_mode7+_m7vy
	sep #$20
	
	;------------------------
	
	rep #$20
	lda s_mode7+_m7py+2
	and #$FF
	clc
	adc s_mode7+_m7vy
	sta MEM_TEMP
	
	sep #$20
	
	
	lda MEM_TEMP
	sta s_mode7+_m7py+2
	
	rep #$20
	
	lda MEM_TEMP
	lsr
	lsr
	lsr
	lsr
	
	lsr
	lsr
	lsr
	lsr
	
	cmp #$10
	bmi ++
		ora #$FF00
		
	++:
	sta MEM_TEMP
	
	lda MEM_TEMPFUNC
	cmp #0
	bne +
		lda s_mode7+_m7py
		sec
		sbc MEM_TEMP
		and #$3FF
		cmp #$300
		bmi +++
			sec
			sbc #$400
		+++:
		sta s_mode7+_m7py
		
		lda s_mode7+_m7y
		sec
		sbc MEM_TEMP
		and #$3FF
		sta s_mode7+_m7y
		
		bra ++
	+:
		lda s_mode7+_m7py
		clc
		adc MEM_TEMP
		and #$3FF
		cmp #$300
		bmi +++
			sec
			sbc #$400
		+++:
		sta s_mode7+_m7py
		
		lda s_mode7+_m7y
		clc
		adc MEM_TEMP
		and #$3FF
		sta s_mode7+_m7y
	++:
	
	sep #$20
	
	;------------------------
	rep #$20
	lda s_mode7+_m7px+2
	and #$FF
	clc
	adc s_mode7+_m7vx
	sta MEM_TEMP
	
	sep #$20
	
	
	lda MEM_TEMP
	sta s_mode7+_m7px+2
	
	rep #$20
	
	lda MEM_TEMP
	lsr
	lsr
	lsr
	lsr
	
	lsr
	lsr
	lsr
	lsr
	

	
	cmp #$10
	bmi ++
		ora #$FF00
	++:
	sta MEM_TEMP
	
	
	lda MEM_TEMPFUNC
	cmp #0
	bne +
		lda s_mode7+_m7px
		clc
		adc MEM_TEMP
		and #$3FF
		cmp #$380
		bmi +++
			sec
			sbc #$400
		+++:
		sta s_mode7+_m7px
		
		lda s_mode7+_m7x
		clc
		adc MEM_TEMP
		and #$3FF
		sta s_mode7+_m7x
		bra ++
	+:
		lda s_mode7+_m7px
		sec
		sbc MEM_TEMP
		and #$3FF
		cmp #$380
		bmi +++
			sec
			sbc #$400
		+++:
		sta s_mode7+_m7px
		
		lda s_mode7+_m7x
		sec
		sbc MEM_TEMP
		and #$3FF
		sta s_mode7+_m7x
	++:
	
	sep #$20
	;------------------------
	rtl
	
add_HDMA_M7:

	
	ldx #3*$60
	inx
	ldy #$00
	-:

		rep #$20
		
		phx
		tyx
		lda zoom7.l,x
		
		
		asl
		clc
		adc s_mode7+_m7sx
		sta MODE7S,x
		plx
		
		
		
		sep #$20
		
		inx
		inx
		inx
		
		iny
		iny
		cpy #$80*2
	bne -
	
	lda #0
	sta MODE7A,x
	sta MODE7D,x
	sta MODE7B,x
	sta MODE7C,x
	
	
	rtl
	
R1mode7:

	Set_Mode7_line_bloc $00
	Set_Mode7_line_bloc $10
	Set_Mode7_line_bloc $20
	Set_Mode7_line_bloc $30

	rtl
	
	
R2mode7:

	Set_Mode7_line_bloc $40
	Set_Mode7_line_bloc $50
	Set_Mode7_line_bloc $60
	Set_Mode7_line_bloc $70
	
	rtl


sincos:
	.include "rotation/sincos.inc"
	
sincosm7:
	.include "rotation/sincosm7.asm"


	
		

sky:
	.include "DATA/sky.asm"
	
skytile:

	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02

	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	
	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	
	.dw $1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04
	.dw $1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04

	.dw $1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06
	.dw $1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06

	.dw $1C60,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08
	.dw $1C60,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08

	.dw $1C80,$1C82,$1C84,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C2E
	.dw $1C80,$1C82,$1C84,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C2E

	.dw $1CA0,$1CA2,$1CA4,$1CA6,$1CA8,$1CAA,$1CAC,$1CAE,$1C40,$1C42,$1C44,$1C46,$1C48,$1C4A,$1C4C,$1C4E
	.dw $1CA0,$1CA2,$1CA4,$1CA6,$1CA8,$1CAA,$1CAC,$1CAE,$1C40,$1C42,$1C44,$1C46,$1C48,$1C4A,$1C4C,$1C4E
