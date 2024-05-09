
Fenetre_Text:

	
	lda s_text+_texton
	cmp #2
	bne +
	
		lda #1
		sta s_text+_tdraw
	+:
	
	lda s_text+_tdraw
	cmp #0
	bne +
		rts
	+:
	
	lda s_text+_phase
	cmp #5
	bne +
		stz s_text+_tdraw
		stz s_text+_phase
		rts
	+:
	
	stz s_lks+_lks_tmpbg3
	
	jsr Fenetre_Text_phase1
	jsr Fenetre_Text_phase2
	
	jsr Fenetre_Text_phase3
	
	
	jsr Fenetre_Text_phase5
	jsr Fenetre_Text_phase4
	
	
	
	
	rts
	
	

Fenetre_Ligne3:

	
	
	cpy #28
	beq +
	sta LKS_BUF_BG3+58,x
	
	
	+:

	rts

Fenetre_Ligne2:
	cpy #14
	beq +
	sta LKS_BUF_BG3+30,x
	
	cpy #15
	beq +
	sta LKS_BUF_BG3+32,x
	
	cpy #16
	beq +
	sta LKS_BUF_BG3+34,x
	
	cpy #17
	beq +
	sta LKS_BUF_BG3+36,x
	
	cpy #18
	beq +
	sta LKS_BUF_BG3+38,x
	
	cpy #19
	beq +
	sta LKS_BUF_BG3+40,x
	
	cpy #20
	beq +
	sta LKS_BUF_BG3+42,x
	
	cpy #21
	beq +
	sta LKS_BUF_BG3+44,x
	
	cpy #22
	beq +
	sta LKS_BUF_BG3+46,x
	
	cpy #23
	beq +
	sta LKS_BUF_BG3+48,x
	
	cpy #24
	beq +
	sta LKS_BUF_BG3+50,x
	
	cpy #25
	beq +
	sta LKS_BUF_BG3+52,x
	
	
	cpy #26
	beq +
	sta LKS_BUF_BG3+54,x
	
	
	cpy #27
	beq +
	sta LKS_BUF_BG3+56,x
	
	jsr Fenetre_Ligne3
	
	
	
	+:
	
	
	rts
	
Fenetre_Ligne:

	
	sta LKS_BUF_BG3,x
	
	
	
	ldy MEM_TEMP
	cpy #0
	beq +
	sta LKS_BUF_BG3+2,x
	
	
	cpy #1
	beq +
	sta LKS_BUF_BG3+4,x
	
	cpy #2
	beq +
	sta LKS_BUF_BG3+6,x
	
	cpy #3
	beq +
	sta LKS_BUF_BG3+8,x
	
	cpy #4
	beq +
	sta LKS_BUF_BG3+10,x
	
	cpy #5
	beq +
	sta LKS_BUF_BG3+12,x
	
	cpy #6
	beq +
	sta LKS_BUF_BG3+14,x
	
	cpy #7
	beq +
	sta LKS_BUF_BG3+16,x
	
	cpy #8
	beq +
	sta LKS_BUF_BG3+18,x
	
	cpy #9
	beq +
	sta LKS_BUF_BG3+20,x
	
	cpy #10
	beq +
	sta LKS_BUF_BG3+22,x
	
	cpy #11
	beq +
	sta LKS_BUF_BG3+24,x
	
	cpy #12
	beq +
	sta LKS_BUF_BG3+26,x
	
	cpy #13
	beq +
	sta LKS_BUF_BG3+28,x
	
	
	jsr Fenetre_Ligne2
	+:
	
	
	
	
	rts
	
.MACRO Fenetre_Ligne

	
	jsr Fenetre_Ligne
	
	
	pha
	txa
	clc
	adc MEM_TEMP
	adc MEM_TEMP
	
	
	tax
	
	pla
	
	
	/*
	
	ldy #0
	-:
		sta LKS_BUF_BG3,x
		inx
		inx
		iny
		

		
		cpy MEM_TEMP
	bne -
	*/
	
.ENDM


Fenetre_Text_phase1:

	lda s_text+_phase
	cmp #0
	beq +
		rts
	+:
	
	
	
	rep #$20
	
	lda s_text+_phasei
	clc
	adc #2
	sta MEM_TEMP
	
	;------
	
	
	lda #$20+$42
	sec
	sbc #2
	sbc MEM_TEMP
	clc
	adc #$40*3
	tax
	
	lda #$2443
	Fenetre_Ligne
	
	;------------
	
	
	inc s_text+_phasei
	inc s_text+_phasei
	lda s_text+_phasei
	cmp #$20-2
	bne +
		inc s_text+_phase
		stz s_text+_phasei
	+:
	
	
	sep #$20
	
	rts
	
	
Fenetre_Text_phase2:

	lda s_text+_phase
	cmp #1
	beq +
		rts
	+:

	rep #$20
	
	lda #$1C
	sta MEM_TEMP
	
	lda #0
	sta MEM_TEMP+2
	
	lda s_text+_phasei
	lsr
	asl
	sta MEM_TEMP+2

	
	
	;------
	lsr
	asl
	asl
	asl
	asl
	asl
	asl
	sta MEM_TEMP+4
	lda #$40*1+2
	sec 
	sbc MEM_TEMP+4
	
	
	clc
	adc #$40*3
	tax
	
	
	;haut
	lda #$2440
	sta LKS_BUF_BG3,x
	inx
	inx

	lda #$2441
	Fenetre_Ligne
	lda #$6440
	sta LKS_BUF_BG3,x
	
	txa
	clc
	adc #6
	tax
	
	lda MEM_TEMP+2
	sta MEM_TEMP+4
	cmp #0
	beq +
	--:
		lda #$2442
		sta LKS_BUF_BG3,x
		inx
		inx
		lda #$0000
		Fenetre_Ligne
		lda #$2442
		sta LKS_BUF_BG3,x
		txa
		clc
		adc #6
		tax
	
		dec MEM_TEMP+4
		lda MEM_TEMP+4
		cmp #0
		bne --
	+:
	
	


	;bas
	lda #$A440
	sta LKS_BUF_BG3,x
	inx
	inx
	lda #$A441
	Fenetre_Ligne
	lda #$E440
	sta LKS_BUF_BG3,x
	
	;------------
	
	inc s_text+_phasei
	lda s_text+_phasei
	cmp #$8
	bne +
		lda #1
		sta s_lks+_lks_tmpbg3
		
		inc s_text+_phase
		lda #$7
		sta s_text+_phasei
	+:
	sep #$20
	
	rts
	
rep #$20
Fenetre_Text_end:

	ldx #0
	lda Texte_4.l,x
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP
	
	ldx #6
	stx s_text+_defr
	
	stz s_text+_texton
		
	
	lda s_text+_defsv
	clc
	adc #2
	tax
	
	
	ldy #$42+$42
	lda #0
	-:
		pha
		lda Texte_4.l,x
		phx
		tyx
		sta LKS_BUF_BG3,x
		
		clc
		adc #$10
		sta LKS_BUF_BG3+$40,x
		cmp #$20
		bpl +
			lda #0
			sta LKS_BUF_BG3+$40,x
		+:
		plx
		pla
		
		inx
		inx
		iny
		iny
		ina
		
		cmp #$1C
	bne -
	
	lda MEM_TEMP
	cmp #1
	bne +
		rts
	+:
	
	lda s_text+_defsv
	clc
	adc #$42
	tax
	
	ldy #$42+$80+$42
	lda #0
	-:
		pha
		lda Texte_4.l,x
		
		phx
		tyx
		sta LKS_BUF_BG3,x
		
		clc
		adc #$10
		sta LKS_BUF_BG3+$40,x
		cmp #$20
		bpl +
			lda #0
			sta LKS_BUF_BG3+$40,x
		+:
		plx
		pla
		
		inx
		inx
		iny
		iny
		ina
		
		cmp #$1C
	bne -
	
	lda MEM_TEMP
	cmp #2
	bne +
		rts
	+:
	
	lda s_text+_defsv
	clc
	adc #$82
	tax
	
	ldy #$42+$80+$80+$42
	lda #0
	-:
		pha
		lda Texte_4.l,x
		
		phx
		tyx
		sta LKS_BUF_BG3,x
		
		clc
		adc #$10
		sta LKS_BUF_BG3+$40,x
		cmp #$20
		bpl +
			lda #0
			sta LKS_BUF_BG3+$40,x
		+:
		plx
		pla
		
		inx
		inx
		iny
		iny
		ina
		
		cmp #$1C
	bne -
	
	
	rts
sep #$20
	
	
Fenetre_Text_phase3:

	lda s_text+_phase
	cmp #2
	beq +
		rts
	+:
	
	;----------------------

	rep #$20
	
	lda s_text+_texton
	cmp #2
	bne +
		lda s_text+_defr
		cmp #5
		beq +
			jsr Fenetre_Text_end
			bra ++
	+:
	
	lda s_text+_defr
	asl
	asl
	asl
	asl
	asl
	asl
	clc
	adc #$42+$42
	adc s_text+_defi
	tay
	
	;----------------------
	
	ldx s_text+_defsv
	lda Texte_4.l,x
	sta MEM_TEMP
	
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP+2
	
	lda MEM_TEMP
	
	txa
	clc
	adc #2
	adc s_text+_defi
	tax
	;----------------------
	
	
	
	lda Texte_4.l,x
	cmp #$20
	bmi ++
	phx
	tyx
	sta LKS_BUF_BG3,x
	plx
	
	tya
	clc
	adc #$40
	tay
	
	lda Texte_4.l,x
	clc
	adc #$10
	phx
	tyx
	sta LKS_BUF_BG3,x
	plx

	inc s_text+_defl
	lda s_text+_defl
	cmp #3
	bne +
		stz s_text+_defl
		
		inc s_text+_defi
		inc s_text+_defi
	+:
	
	sep #$20
	rts
	
	rep #$20
	++:
	
	
	inc s_text+_defr
	
	ldx s_text+_defr
	
	cpx #1
	bne +
		lda #$40
		sta s_text+_defi
		
		lda MEM_TEMP+2
		cmp #1
		bne +
			ldx #6
			stx s_text+_defr
	+:
	
	cpx #2
	bne +
		lda #$80
		sta s_text+_defi
		
		lda MEM_TEMP+2
		cmp #1
		bne +
			ldx #6
			stx s_text+_defr
	+:
	
	cpx #3
	bne +
		;lda #$0
		;sta s_text+_defi
		
	+:
	
	
	cpx #5
	bmi +
		ldx #5
		stx s_text+_defr
		lda #$40-2
		sta s_text+_defi
		
		
		lda s_text+_texton
		cmp #2
		bne +
		
		lda #$0
		sta s_text+_defi
		sta s_text+_defr
		
		
		
		lda MEM_TEMP
		and #$00FF
		sta MEM_TEMP
		cmp #0
		bne ++
			lda #0
			sta s_text+_defsv
			inc s_text+_phase
			bra +
		++:
		
		lda s_text+_defsv
		clc
		adc MEM_TEMP
		sta s_text+_defsv
		jsr Fenetre_Text_Clear
	+:
	
		
	sep #$20
	rts
	
rep #$20
Fenetre_Text_Clear:

	ldy #$1B
	sty MEM_TEMP
	lda #0
	
	
	ldx #$0084+$40*0
	Fenetre_Ligne
	
	ldx #$0084+$40*1
	Fenetre_Ligne
	
	ldx #$0084+$40*2
	Fenetre_Ligne
	
	ldx #$0084+$40*3
	Fenetre_Ligne
	
	ldx #$0084+$40*4
	Fenetre_Ligne
	
	ldx #$0084+$40*5
	Fenetre_Ligne
	
	rts
	
	
Fenetre_Clear:


	
	
	ldy #$1E
	sty MEM_TEMP
	
	
	/*
	
	SNES_DMA0 $80
	SNES_DMA0_BADD $80
	
	SNES_VMADD $5C00
    
	lda #$7E
    ldx #$7000
    ldy #$400
    
     
    sta DMA_BANK
    stx DMA_ADDL
    sty DMA_SIZEL 
    
	
	SNES_MDMAEN $01
	*/
	
	lda #0
	ldx #$0042
	Fenetre_Ligne
	
	ldx #$0042+$40*1
	Fenetre_Ligne
	
	ldx #$0042+$40*2
	Fenetre_Ligne
	
	ldx #$0042+$40*3
	Fenetre_Ligne
	
	ldx #$0042+$40*4
	Fenetre_Ligne
	
	ldx #$0042+$40*5
	Fenetre_Ligne
	
	ldx #$0042+$40*6
	Fenetre_Ligne
	
	ldx #$0042+$40*7
	Fenetre_Ligne
	
	rts
	
sep #$20

Fenetre_Text_phase4:

	lda s_text+_phase
	cmp #3
	beq +
		rts
	+:

	rep #$20
	
	jsr Fenetre_Clear
	
	lda #$1C
	sta MEM_TEMP
	
	lda #$0000
	ldx #$02
	Fenetre_Ligne
	
	;jsr Fenetre_Text_Clear
	
	lda s_text+_phasei
	lsr
	asl
	sta MEM_TEMP+2

	
	
	;------
	lsr
	asl
	asl
	asl
	asl
	asl
	asl
	sta MEM_TEMP+4
	lda #$0+$42
	sec 
	sbc MEM_TEMP+4
	
	
	clc
	adc #$40*3
	tax
	
	
	;haut
	lda #$2440
	sta LKS_BUF_BG3,x
	inx
	inx

	lda #$2441
	Fenetre_Ligne
	lda #$6440
	sta LKS_BUF_BG3,x
	
	txa
	clc
	adc #6
	tax
	
	lda MEM_TEMP+2
	sta MEM_TEMP+4
	cmp #0
	beq +
	--:
		lda #$2442
		sta LKS_BUF_BG3,x
		inx
		inx
		lda #$0000
		Fenetre_Ligne
		lda #$2442
		sta LKS_BUF_BG3,x
		txa
		clc
		adc #6
		tax
	
		dec MEM_TEMP+4
		lda MEM_TEMP+4
		cmp #0
		bne --
	+:
	
	


	;bas
	lda #$A440
	sta LKS_BUF_BG3,x
	inx
	inx
	lda #$A441
	Fenetre_Ligne
	lda #$E440
	sta LKS_BUF_BG3,x
	
	;------------
	
	lda s_text+_phasei
	cmp #$4
	bne +
		lda #1
		sta s_lks+_lks_tmpbg3
	+:
	
	dec s_text+_phasei
	lda s_text+_phasei
	cmp #$0
	bne +
		inc s_text+_phase
		
		lda #$20-4
		sta s_text+_phasei
	+:
	sep #$20
	
	rts
	
Fenetre_Text_phase5:

	lda s_text+_phase
	cmp #4
	beq +
		rts
	+:

	rep #$20
	
	ldy #$1E
	sty MEM_TEMP
	lda #0
	
	ldx #$0102
	Fenetre_Ligne
	ldx #$0142
	Fenetre_Ligne
	
	lda s_text+_phasei
	clc
	adc #2
	sta MEM_TEMP
	
	
	
	;------
	
	
	lda #$20+$42
	sec
	sbc #2
	sbc MEM_TEMP
	clc
	adc #$40*3
	tax
	
	lda #$2443
	Fenetre_Ligne
	
	;------------
	
	
	dec s_text+_phasei
	dec s_text+_phasei
	
	
	lda s_text+_phasei
	cmp #$00
	bne +
		inc s_text+_phase
		stz s_text+_phasei
		
		
		ldy #$4
		sty MEM_TEMP
		lda #0
		
		ldx #$40*4+($E*2)
		Fenetre_Ligne
		
		
	+:
	
	
	sep #$20
	
	rts
