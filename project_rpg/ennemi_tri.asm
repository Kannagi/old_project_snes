.MACRO Ennemi_Test_SC_P1
	ldx #$40*\1
	stx MEM_TEMPFUNC
	cpx s_ennemi+_enP1
	beq +
	cpx s_ennemi+_enP2
	beq +
	cpx s_ennemi+_enP3
	beq +
	lda s_perso + _x,x
	cmp #0
	bne ++
		lda s_perso + _y,x
		cmp #0
		beq +
	++:
	
	
	
	jsl Ennemi_Test_SC
	
	lda MEM_TEMPFUNC+4
	cmp #0
	beq +
		ldx #$40*\1
		stx s_ennemi+_enP1
		jsl Ennemi_Test_SCE_P1
		rtl
	+:
	
.ENDM

.MACRO Ennemi_Test_SC_P2
	ldx #$40*\1
	stx MEM_TEMPFUNC
	cpx s_ennemi+_enP1
	beq +
	cpx s_ennemi+_enP2
	beq +
	cpx s_ennemi+_enP3
	beq +
	lda s_perso + _x,x
	cmp #0
	bne ++
		lda s_perso + _y,x
		cmp #0
		beq +
	++:
	
	
	
	jsl Ennemi_Test_SC
	
	lda MEM_TEMPFUNC+4
	cmp #0
	beq +
		ldx #$40*\1
		stx s_ennemi+_enP2
		jsl Ennemi_Test_SCE_P2
		rtl
	+:
	
.ENDM

.MACRO Ennemi_Test_SC_P3
	ldx #$40*\1
	stx MEM_TEMPFUNC
	cpx s_ennemi+_enP1
	beq +
	cpx s_ennemi+_enP2
	beq +
	cpx s_ennemi+_enP3
	beq +
	lda s_perso + _x,x
	cmp #0
	bne ++
		lda s_perso + _y,x
		cmp #0
		beq +
	++:
	
	
	
	jsl Ennemi_Test_SC
	
	lda MEM_TEMPFUNC+4
	cmp #0
	beq +
		ldx #$40*\1
		stx s_ennemi+_enP3
		jsl Ennemi_Test_SCE_P3
		rtl
	+:
	
.ENDM

Ennemi_Tri:

	lda LKS_OAM+_nperso2
	cmp #3
	bne +
		rtl
	+:
	
	jsl Ennemi_TriP1
	jsl Ennemi_TriP2
	jsl Ennemi_TriP3
	
	inc s_ennemi+_enFrame
	lda s_ennemi+_enFrame
	cmp #7
	bne +
		stz s_ennemi+_enFrame
	+:


	rtl
	
;------------------------------------------
	
	
Ennemi_TriP1:

	ldx s_ennemi+_enP1
	
	rep #$20
	
	lda s_perso+_oam,x
	cmp #$1E0
	bne +
		bra ++
	+:
	
	
	sep #$20
	rtl
	++:
	
	sep #$20
	
	jsl Ennemi_TriP1_F

	rtl
	
Ennemi_TriP2:

	ldx s_ennemi+_enP2
	
	rep #$20
	
	lda s_perso+_oam,x
	cmp #$1E0
	bne +
		bra ++
	+:
	
	
	sep #$20
	rtl
	++:
	
	sep #$20
	
	jsl Ennemi_TriP2_F

	rtl	

Ennemi_TriP3:

	ldx s_ennemi+_enP3
	
	rep #$20
	
	lda s_perso+_oam,x
	cmp #$1E0
	bne +
		bra ++
	+:
	
	
	sep #$20
	rtl
	++:
	
	sep #$20
	
	jsl Ennemi_TriP3_F
	
	rtl
;------------------------------------------


Ennemi_Test_SCE_P1:

	
	
	lda s_perso + _tbankadd,x 
	sta s_palette+$10+(3*11)+2
	sta DMA_BANK
	
	rep #$20
	
	lda #$2660
	sta s_perso + _tile,x
	
	lda s_perso + _tadd,x
	sta s_palette+$10+(3*11)
	sta DMA_ADDL
	sep #$20
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$160,0
	 
	ldy #$20
	sty DMA_SIZEL 
	
	SNES_MDMAEN $01
	
	lda #2
	sta s_palette+_pltype
	
	rtl

Ennemi_Test_SCE_P2:

	
	
	lda s_perso + _tbankadd,x 
	sta s_palette+$10+(3*12)+2
	sta DMA_BANK
	
	rep #$20
	
	lda #$2888
	sta s_perso + _tile,x
	
	lda s_perso + _tadd,x
	sta s_palette+$10+(3*12)
	sta DMA_ADDL
	sep #$20
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$180,0
	 
	ldy #$20
	sty DMA_SIZEL 
	
	SNES_MDMAEN $01
	
	lda #2
	sta s_palette+_pltype
	
	rtl
	
Ennemi_Test_SCE_P3:

	
	
	lda s_perso + _tbankadd,x 
	sta s_palette+$10+(3*13)+2
	sta DMA_BANK
	
	rep #$20
	
	lda #$2AC0
	sta s_perso + _tile,x
	
	lda s_perso + _tadd,x
	sta s_palette+$10+(3*13)
	sta DMA_ADDL
	sep #$20
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$1A0,0
	 
	ldy #$20
	sty DMA_SIZEL 
	
	SNES_MDMAEN $01
	
	lda #2
	sta s_palette+_pltype
	
	rtl
;------------------------------------------
	
Ennemi_Test_SC:

	ldx MEM_TEMPFUNC
	rep #$20
	
	stz MEM_TEMPFUNC+4
	
	lda s_perso+_x,x
	sec
	sbc LKS_BG+_bg1x
	sta MEM_TEMPFUNC+$C
	
	cmp #-56
	bpl +
		bra ++
	+:
	cmp #256+56
	bmi +
		bra ++
	+:
	
	lda s_perso+_y,x
	sec
	sbc LKS_BG+_bg1y
	sta MEM_TEMPFUNC+$E
	
	cmp #-56
	bpl +
		bra ++
	+:
	cmp #224+56
	bmi +
		bra ++
	+:
	
	sep #$20
	
	jsl Personnage_limite_ecranSC
	
	rtl
	
	++:
	sep #$20
	rtl

	
Personnage_limite_ecranSC:

	
	stz MEM_TEMPFUNC+4
	
	;Y
	rep #$20
	lda MEM_TEMPFUNC+$E
	clc
	adc #$10
	
	sta MEM_TEMP
	sep #$20
	
	lda MEM_TEMP+1
	cmp #$01
	bmi +
		bra +++
	+:
	
	
	rep #$20
	lda MEM_TEMPFUNC+$E
	sec
	sbc #$10
	sta MEM_TEMPFUNC+$E
	clc
	adc #$30
	sta MEM_TEMP
	sep #$20
	
	lda MEM_TEMP+1
	cmp #$00
	bpl +
		bra +++
	+:
	
	
	
	;X droite
	lda MEM_TEMPFUNC+$C+1
	cmp #$01
	bmi +
		bra +++
	+:
	
	;X gauche
	rep #$20
	lda MEM_TEMPFUNC+$C
	clc
	adc #$30
	sta MEM_TEMP
	sep #$20
		
	lda MEM_TEMP+1
	cmp #$0
	bpl +
		bra +++
	+:
	
	
	
			
	rtl
	
	+++:
	
	inc MEM_TEMPFUNC+4
	
	rtl
