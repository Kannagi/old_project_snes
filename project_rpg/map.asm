
.MACRO load_map
    
    ;-------------
	ldx #\1
	stx s_map+_bg1
	
	lda #:\1
	sta s_map+_bg1+2
	
	;-------------
	ldx #\2
	stx s_map+_bg2
	
	lda #:\2
	sta s_map+_bg2+2
	
	;-------------
	ldx #\3
	stx s_map+_mapc
	
	lda #:\3
	sta s_map+_mapc+2
	
.ENDM

Map_Character_init

	rep #$20
	ldx #3*$40
	ldy #0
	-:
		lda #$7000
		sta s_perso+_y,x
		
		txa
		clc
		adc #$40
		tax
		
		iny
		cpy #$40
	bne -
	sep #$20
	
	rts
	
Map_Load:

	

	jsr Map_Character_init

	
	ldx #$800
	stx LKS_BG+_bgaddy
	ldx #$400
	stx LKS_BG+_bglimitex
	ldx #$400
	stx LKS_BG+_bglimitey
	
	
	lda s_map+_mlevel
	sta WRMPYA
	
	lda #5
	sta WRMPYB
	ora 0
	ora 0

	rep #$20
	
	lda RDMPYL
	clc
	adc #Map_Level
	sta MEM_TEMP
	
	sep #$20
	
	ldx #0
	jsr (MEM_TEMP,x)
	
	rep #$20
	
	
	lda LKS_BG+_bgaddy
	lsr
	lsr
	lsr
	lsr
	sta LKS_BG+_bgaddyr
	
	sep #$20
	
	rts
	
	
Map_Level:

	jsl Map_Level1
	rts
	
	jsl Map_Level2
	rts
	
	jsl Map_Level3
	rts
Map_Out:

	lda s_perso+_tag
	sec
	sbc #31
	sta MEM_TEMPFUNC
	
	stz s_map+_beginp
	
	lda s_map+_mlevel
	sta WRMPYA
	
	lda #5
	sta WRMPYB
	ora 0
	ora 0

	rep #$20
	
	lda RDMPYL
	clc
	adc #Map_Level_out
	sta MEM_TEMP
	
	sep #$20
	
	ldx #0
	jsr (MEM_TEMP,x)
	
	rts
	
Map_Level_out:

	jsl Map_Level1_out
	rts
	
	jsl Map_Level2_out
	rts
	
	jsl Map_Level3_out
	rts
