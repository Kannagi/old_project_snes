
LKS_printfs:

	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP

	lda $00,y
	-:
		sta LKS_BUF_BG3+0,x

		lda MEM_TEMP
		sta LKS_BUF_BG3+1,x
		
		inx
		inx
		iny
		
		lda $00,y
	bne -
	
	rtl


	
LKS_printh16_draw:

	rep #$20
	tya
	
	
	sta MEM_TEMP
	lsr a
	lsr a
	lsr a
	lsr a
	sta MEM_TEMP+1
	lsr a
	lsr a
	lsr a
	lsr a
	sta MEM_TEMP+2
	lsr a
	lsr a
	lsr a
	lsr a
	sta MEM_TEMP+3
	
	ldx MEM_TEMPFUNC
	
	sep #$20
	
	
	
	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP+6	
	
	lda MEM_TEMP+3
	jsl LKS_printhexa
	
	lda MEM_TEMP+2
	jsl LKS_printhexa
	
	lda MEM_TEMP+1
	jsl LKS_printhexa
	
	lda MEM_TEMP
	jsl LKS_printhexa
	
	
	
	
	rtl
	
LKS_printh8_draw:

	sta MEM_TEMP
	lsr a
	lsr a
	lsr a
	lsr a
	sta MEM_TEMP+1

	ldx MEM_TEMPFUNC
	
	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP+6	
	
	lda MEM_TEMP+1
	jsl LKS_printhexa
	
	lda MEM_TEMP
	jsl LKS_printhexa
	
	rtl
	
LKS_printhexa:

	
	and #$F
	cmp #$A
	bmi +
		clc
		adc #$7
	+:
	clc
	adc #$50
	sta LKS_BUF_BG3+0,x
	lda MEM_TEMP+6	
	sta LKS_BUF_BG3+1,x
	inx
	inx
	rtl
	
LKS_printf16_draw:

	rep #$20
	tya
	
	stz MEM_TEMP + 6
	cmp #0
	bpl +	
		dea
		eor #$ffff
		
		pha
		lda #1
		sta MEM_TEMP + 6
		pla
	+:
	
	compute_digit_for_base16 10000
	stx MEM_TEMP
	compute_digit_for_base16  1000
	stx MEM_TEMP + 1
	compute_digit_for_base16   100
	stx MEM_TEMP + 2
	compute_digit_for_base16	10
	stx MEM_TEMP + 3
	sta MEM_TEMP + 4
	
	ldx MEM_TEMPFUNC
	;clean
	lda #0
	sta LKS_BUF_BG3+0,x
	sta LKS_BUF_BG3+2,x
	sta LKS_BUF_BG3+4,x
	sta LKS_BUF_BG3+6,x
	sta LKS_BUF_BG3+8,x
	sta LKS_BUF_BG3+10,x
	
	sep #$20
	
	
	
	
	lda MEM_TEMP + 6
	cmp #0
	beq +
		;SNES_VMDATA $200D ;signe -
		rep #$20
		lda #$200D
		sta LKS_BUF_BG3+0,x
		inx
		inx
		sep #$20
	+:
	
	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP+6	
	clc
	lda MEM_TEMP
	adc #$50
	sta LKS_BUF_BG3+0,x
	lda MEM_TEMP+6	
	sta LKS_BUF_BG3+1,x
	
	lda MEM_TEMP + 1
	adc #$50
	sta LKS_BUF_BG3+2,x
	lda MEM_TEMP+6	
	sta LKS_BUF_BG3+3,x
	
	lda MEM_TEMP + 2
	adc #$50
	sta LKS_BUF_BG3+4,x
	lda MEM_TEMP+6	
	sta LKS_BUF_BG3+5,x
	
	lda MEM_TEMP + 3
	adc #$50
	sta LKS_BUF_BG3+6,x
	lda MEM_TEMP+6	
	sta LKS_BUF_BG3+7,x
	
	lda MEM_TEMP + 4
	adc #$50
	sta LKS_BUF_BG3+8,x
	lda MEM_TEMP+6	
	sta LKS_BUF_BG3+9,x
	
	
	
	rtl
	
LKS_printfu16_draw:

	rep #$20
	tya
	
	compute_digit_for_base16 10000
	stx MEM_TEMP
	compute_digit_for_base16  1000
	stx MEM_TEMP + 1
	compute_digit_for_base16   100
	stx MEM_TEMP + 2
	compute_digit_for_base16	10
	stx MEM_TEMP + 3
	sta MEM_TEMP + 4
	
	ldx MEM_TEMPFUNC

	
	sep #$20
	
	clc
	lda MEM_TEMP
	adc #$50
	sta LKS_BUF_BG3+0,x
	
	lda MEM_TEMP + 1
	adc #$50
	sta LKS_BUF_BG3+2,x
	
	lda MEM_TEMP + 2
	adc #$50
	sta LKS_BUF_BG3+4,x

	lda MEM_TEMP + 3
	adc #$50
	sta LKS_BUF_BG3+6,x
	
	lda MEM_TEMP + 4
	adc #$50
	sta LKS_BUF_BG3+8,x

	lda #$20
	adc LKS.printpal
	sta LKS_BUF_BG3+1,x
	sta LKS_BUF_BG3+3,x
	sta LKS_BUF_BG3+5,x
	sta LKS_BUF_BG3+7,x
	sta LKS_BUF_BG3+9,x

	rtl
	
LKS_printfu8_draw:

	ldx MEM_TEMPFUNC
	
	compute_digit_for_base8   100
	stx MEM_TEMP + 0
	compute_digit_for_base8	10
	stx MEM_TEMP + 1
	sta MEM_TEMP + 2
	
	ldx MEM_TEMPFUNC
	
	lda MEM_TEMP + 0
	clc
	adc #$50
	sta LKS_BUF_BG3+0,x
	
	lda MEM_TEMP + 1
	adc #$50
	sta LKS_BUF_BG3+2,x
	
	lda MEM_TEMP + 2
	adc #$50
	sta LKS_BUF_BG3+4,x
	
	lda #$20
	adc LKS.printpal
	sta LKS_BUF_BG3+1,x
	sta LKS_BUF_BG3+3,x
	sta LKS_BUF_BG3+5,x

	rtl
	
LKS_printf8_draw:

	ldx MEM_TEMPFUNC
	
	pha
	lda #0
	sta LKS_BUF_BG3+0,x
	sta LKS_BUF_BG3+1,x
	sta LKS_BUF_BG3+2,x
	sta LKS_BUF_BG3+3,x
	sta LKS_BUF_BG3+4,x
	sta LKS_BUF_BG3+5,x
	pla
	
	stz MEM_TEMP + 6
	cmp #0
	bpl +	
		dea
		eor #$ff
		
		sta MEM_TEMP + 3
		lda #128
		sec
		sbc MEM_TEMP + 3	
		clc
		adc #28	
		
		pha
		ldx #1
		stx MEM_TEMP + 6
		pla
	+:
	
	
	compute_digit_for_base8   100
	stx MEM_TEMP + 0
	compute_digit_for_base8	10
	stx MEM_TEMP + 1
	sta MEM_TEMP + 2
	
	ldx MEM_TEMPFUNC
	
	lda MEM_TEMP + 6
	cmp #0
	beq +
		inc MEM_TEMP + 0
	+:
	
	
	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP+4
	
	lda MEM_TEMP + 0
	cmp #0
	beq +
		clc
		adc #$50
		sta LKS_BUF_BG3+0,x
		lda MEM_TEMP+4
		sta LKS_BUF_BG3+1,x
		inx
		inx
		
		lda MEM_TEMP + 1
		clc
		adc #$50
		sta LKS_BUF_BG3+0,x
		lda MEM_TEMP+4
		sta LKS_BUF_BG3+1,x
		
		lda MEM_TEMP + 2
		clc
		adc #$50
		sta LKS_BUF_BG3+2,x
		lda MEM_TEMP+4
		sta LKS_BUF_BG3+3,x
		
		rtl
	+:
	
	lda MEM_TEMP + 1
	cmp #0
	beq +
		clc
		adc #$50
		sta LKS_BUF_BG3+0,x
		lda MEM_TEMP+4
		sta LKS_BUF_BG3+1,x
		
		lda MEM_TEMP + 2
		clc
		adc #$50
		sta LKS_BUF_BG3+2,x
		lda MEM_TEMP+4
		sta LKS_BUF_BG3+3,x
		rtl
	+:
	
	lda MEM_TEMP + 2
	clc
	adc #$50
	sta LKS_BUF_BG3+2,x
	lda MEM_TEMP+4
	sta LKS_BUF_BG3+3,x

	rtl
	

.MACRO LKS_PRINT_DEC
	
	;------------------------
	lda \1
	lsr
	lsr
	lsr
	lsr
	clc
	adc #$50
	sta LKS_BUF_BG3+0+(4*\2),x
	
	lda \1
	and #$0F
	adc #$50
	sta LKS_BUF_BG3+2+(4*\2),x
	
	
	lda MEM_TEMP+4
	sta LKS_BUF_BG3+1+(4*\2),x
	sta LKS_BUF_BG3+3+(4*\2),x
	
	
		
.ENDM

LKS_printd2:
	
	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP+4
	
	LKS_PRINT_DEC MEM_TEMP + 0,0
	
	
	rtl


LKS_printd4:
	
	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP+4

	;------------------------
	LKS_PRINT_DEC MEM_TEMP + 1,0
	LKS_PRINT_DEC MEM_TEMP + 0,1
	
	rtl
	
LKS_printd6:
	
	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP+4

	;------------------------
	LKS_PRINT_DEC MEM_TEMP + 2,0
	LKS_PRINT_DEC MEM_TEMP + 1,1
	LKS_PRINT_DEC MEM_TEMP + 0,2
	
	rtl

LKS_printd8:
	
	lda #$20
	clc
	adc LKS.printpal
	sta MEM_TEMP+4

	;------------------------
	LKS_PRINT_DEC MEM_TEMP + 3,0
	LKS_PRINT_DEC MEM_TEMP + 2,1
	LKS_PRINT_DEC MEM_TEMP + 1,2
	LKS_PRINT_DEC MEM_TEMP + 0,3
	
	rtl
