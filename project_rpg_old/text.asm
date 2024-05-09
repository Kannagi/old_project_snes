
.define TOFFSET $060000

Defilement_text_ligne:

	lda MEM_TEXT + 2
	cmp MEM_TEXT + 6
	bne +
		stz MEM_TEXT + 2
		stz MEM_TEXT + 4
		inc MEM_TEXT + 1
		rts
	+:
	
	ldx MEM_TEXT + 10
	
	rep #$20
	
	txa
	clc
	adc MEM_TEXT + 2
	tax
	
	;haut
	lda #$5800 + $42
	clc
	adc MEM_TEXT + 4
	adc MEM_TEXT + 8
	sta VMADDL
	
	lda TOFFSET,X
	sta VMDATAL
	
	
	;bas
	txa
	clc
	adc MEM_TEXT + 6
	tax
	
	
	lda #$5800 + $42 + $20
	clc
	adc MEM_TEXT + 4
	adc MEM_TEXT + 8
	sta VMADDL
	
	lda TOFFSET,X
	sta VMDATAL
	
	sep #$20
	
	inc MEM_TEXT + 0
	
	lda MEM_TEXT + 0
	cmp #1 ;vitesse texte
	bne +
		stz MEM_TEXT + 0
		inc MEM_TEXT + 4
		
		inc MEM_TEXT + 2
		inc MEM_TEXT + 2
	+:

	rts
	
Effacement_Text:
	SNES_VMADD $5800 + $42
	SNES_DMA0_ADD Vide $0038
	SNES_MDMAEN $01
	
	SNES_VMADD $5800 + $62
	SNES_DMA0_ADD Vide $0038
	SNES_MDMAEN $01
	
	SNES_VMADD $5800 + $82
	SNES_DMA0_ADD Vide $0038
	SNES_MDMAEN $01
	
	SNES_VMADD $5800 + $A2
	SNES_DMA0_ADD Vide $0038
	SNES_MDMAEN $01
	
	SNES_VMADD $5800 + $C2
	SNES_DMA0_ADD Vide $0038
	SNES_MDMAEN $01
	
	SNES_VMADD $5800 + $E2
	SNES_DMA0_ADD Vide $0038
	
	SNES_MDMAEN $01
	rts
Defilement_text:

	lda MEM_TEXT + 15
	cmp #2
	beq +
		rts
	+:
	
	;suivant texte
	lda MEM_TEXT + 1
	cmp #8
	bne +
		lda MEM_TEXT + 14
		and #$F0
		cmp #$10
		bne ++
			stz MEM_TEXT + 1
			stz MEM_TEXT + 8
			
			rep #$20
			lda MEM_TEXT + 10
			clc
			adc MEM_TEXT + 6
			adc MEM_TEXT + 6
			inc A
			inc A
			sta MEM_TEXT + 10
			sep #$20
			
			jsr Effacement_Text
			
			add_DMA $0180
	+:
	
	;end
	lda MEM_TEXT + 1
	cmp #6
	bne +
		lda MEM_TEXT + 14
		and #$F0
		cmp #$10
		bne ++
			lda #7
			sta MEM_TEXT + 1
			
			bra +
		++:
		
		lda #3
		sta MEM_TEXT + 15
		
		stz MEM_TEXT + 0
		stz MEM_TEXT + 1
		stz MEM_TEXT + 2
		stz MEM_TEXT + 3
		stz MEM_TEXT + 4
		stz MEM_TEXT + 5
		
		rts
	+:
	
	add_DMA $0080

	;init text
	lda MEM_TEXT + 1
	cmp #0
	bne +
		inc MEM_TEXT + 1
		
		ldx MEM_TEXT + 10
		
		dex
		lda TOFFSET,X
		sta MEM_TEXT + 6
		
		dex
		lda TOFFSET,X
		sta MEM_TEXT + 14
	
		rts
	+:
	
	lda MEM_TEXT + 14
	and #$0F
	cmp MEM_TEXT + 1
	bne +
		lda #6
		sta MEM_TEXT + 1
	+:

	;ligne 1
	lda MEM_TEXT + 1
	cmp #1
	bne +
		jsr Defilement_text_ligne
		rts
	+:
	
	;init text ligne 2
	lda MEM_TEXT + 1
	cmp #2
	bne +
		inc MEM_TEXT + 1
		
		lda #$40
		sta MEM_TEXT + 8
		
		rep #$20
		lda MEM_TEXT + 10
		clc
		adc MEM_TEXT + 6
		adc MEM_TEXT + 6
		inc A
		sta MEM_TEXT + 10
		sep #$20
		
		
		ldx MEM_TEXT + 10
		dex
		lda TOFFSET,X
		sta MEM_TEXT + 6
		
		rts
	+:

	;ligne 2
	lda MEM_TEXT + 1
	cmp #3
	bne +
		jsr Defilement_text_ligne
		rts
	+:
	
	;init text ligne 3
	lda MEM_TEXT + 1
	cmp #4
	bne +
		inc MEM_TEXT + 1
		
		lda #$80
		sta MEM_TEXT + 8
		
		rep #$20
		lda MEM_TEXT + 10
		clc
		adc MEM_TEXT + 6
		adc MEM_TEXT + 6
		inc A
		sta MEM_TEXT + 10
		sep #$20
		
		
		ldx MEM_TEXT + 10
		dex
		lda TOFFSET,X
		sta MEM_TEXT + 6
		
		rts
	+:

	;ligne 3
	lda MEM_TEXT + 1
	cmp #5
	bne +
		jsr Defilement_text_ligne
		rts
	+:
	
	
	rts
	
;--------------------------FENETRE---------------------------------------

Fenetre_open:

	SNES_VMADD $5800 + $21
	SNES_DMA0_ADD Vide $0200
	SNES_MDMAEN $01

	inc MEM_TEXT + 2
	
	lda MEM_TEXT + 4
	clc
	adc #4
	sta MEM_TEXT + 4
	
	
	lda MEM_TEXT + 2
	cmp #15
	bpl +
		SNES_DMA0_ADD Fenetre_data3 $0004

		rep #$20
		
		lda #$5800 + $0F + $80
		sec
		sbc MEM_TEXT + 2
		sta VMADDL
		
		lda #$0004
		clc
		adc MEM_TEXT + 4
		sta DMA_SIZEL
		
		sep #$20
		
		SNES_MDMAEN $01
			
		rts
	+:
	
	lda MEM_TEXT + 2
	cmp #15
	bne +
		ldx #$60
		ldy #$80
		bra ++
	+:
	cmp #16
	bne +
		ldx #$40
		ldy #$A0
		bra ++
	+:
	cmp #17
	bne +
		ldx #$20
		ldy #$C0
		bra ++
	+:
	cmp #18
	bne +
		ldx #$00
		ldy #$E0
		bra ++
	+:
	
	++:
	
	stx MEM_TEMP
	sty MEM_TEMP + 2
	
	;fenetre haut
	rep #$20
	
	lda #$5800 + $21
	clc
	adc MEM_TEMP
	sta VMADDL
	
	sep #$20
	
	SNES_DMA0_ADD Fenetre_data $003C
	SNES_MDMAEN $01
	
	
	;fenetre bas
	rep #$20
	
	lda #$5800 + $21
	clc
	adc MEM_TEMP + 2
	sta VMADDL
	
	sep #$20
	
	SNES_DMA0_ADD Fenetre_data2 $003C
	SNES_MDMAEN $01
	
	;fenetre milieu
	lda MEM_TEXT + 2
	cmp #16
	bmi +
		;ligne 1
		SNES_VMADD $5800 + $81
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $81
		SNES_VMDATA $2442
		
		;ligne 2
		SNES_VMADD $5800 + $A1
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $A1
		SNES_VMDATA $2442
	
	+:
	cmp #17
	bmi +
		;ligne 3
		SNES_VMADD $5800 + $61
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $61
		SNES_VMDATA $2442
		
		;ligne 4
		SNES_VMADD $5800 + $C1
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $C1
		SNES_VMDATA $2442
	+:
	cmp #18
	bne +
		;ligne 5
		SNES_VMADD $5800 + $41
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $41
		SNES_VMDATA $2442
		
		;ligne 6
		SNES_VMADD $5800 + $E1
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $E1
		SNES_VMDATA $2442
	+:
	

	lda MEM_TEXT + 2
	cmp #18
	bne +
		stz MEM_TEXT + 0
		stz MEM_TEXT + 1
		stz MEM_TEXT + 2
		stz MEM_TEXT + 3
		stz MEM_TEXT + 4
		stz MEM_TEXT + 5
	
		lda #2
		sta MEM_TEXT + 15
	+:
	
	rts
	
Fenetre_close:

	SNES_VMADD $5800 + $21
	SNES_DMA0_ADD Vide $0200
	SNES_MDMAEN $01

	
	stz MEM_TEXT + 0
	inc MEM_TEXT + 2
	
	lda MEM_TEXT + 4
	sec
	sbc #4
	sta MEM_TEXT + 4
	
	lda MEM_TEXT + 2
	cmp #18
	bne +
		stz MEM_TEXT + 0
		stz MEM_TEXT + 1
		stz MEM_TEXT + 2
		stz MEM_TEXT + 3
		stz MEM_TEXT + 4
		stz MEM_TEXT + 5
		stz MEM_TEXT + 6
		stz MEM_TEXT + 7
		stz MEM_TEXT + 8
		stz MEM_TEXT + 9
		stz MEM_TEXT + 10
		stz MEM_TEXT + 11
		
		ldy MEM_TEXT + 12
		lda #0
		sta s_pnj + $1F,Y
		
		stz MEM_TEXT + 12
		stz MEM_TEXT + 13
		stz MEM_TEXT + 14
		stz MEM_TEXT + 15
		
		rts
	+:	
	
	
	lda MEM_TEXT + 2
	cmp #4
	bmi +
		
		SNES_DMA0_ADD Fenetre_data3 $0004

		rep #$20
		
		lda #$5800 - $03 + $80
		clc
		adc MEM_TEXT + 2
		sta VMADDL
		
		lda #$0004
		clc
		adc MEM_TEXT + 4
		sta DMA_SIZEL
		
		sep #$20
		
		SNES_MDMAEN $01
			
		rts
	+:
	
	lda #$3C
	sta MEM_TEXT + 4
	
	
	lda MEM_TEXT + 2
	cmp #0
	bne +
		ldx #$00
		ldy #$E0
		bra ++
	+:
	cmp #1
	bne +
		ldx #$20
		ldy #$C0
		bra ++
	+:
	cmp #2
	bne +
		ldx #$40
		ldy #$A0
		bra ++
	+:
	cmp #3
	bne +
		ldx #$60
		ldy #$80
		bra ++
	+:
	
	++:
	
	stx MEM_TEMP
	sty MEM_TEMP + 2
	
	;fenetre haut
	rep #$20
	
	lda #$5800 + $21
	clc
	adc MEM_TEMP
	sta VMADDL
	
	sep #$20
	
	SNES_DMA0_ADD Fenetre_data $003C
	SNES_MDMAEN $01
	
	
	;fenetre bas
	rep #$20
	
	lda #$5800 + $21
	clc
	adc MEM_TEMP + 2
	sta VMADDL
	
	sep #$20
	
	SNES_DMA0_ADD Fenetre_data2 $003C
	SNES_MDMAEN $01
	
	;fenetre milieu
	lda MEM_TEXT + 2
	cmp #3
	bpl +
		;ligne 1
		SNES_VMADD $5800 + $81
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $81
		SNES_VMDATA $2442
		
		;ligne 2
		SNES_VMADD $5800 + $A1
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $A1
		SNES_VMDATA $2442
	
	+:
	cmp #2
	bpl +
		;ligne 3
		SNES_VMADD $5800 + $61
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $61
		SNES_VMDATA $2442
		
		;ligne 4
		SNES_VMADD $5800 + $C1
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $C1
		SNES_VMDATA $2442
	+:
	cmp #1
	bpl +
		;ligne 5
		SNES_VMADD $5800 + $41
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $41
		SNES_VMDATA $2442
		
		;ligne 6
		SNES_VMADD $5800 + $E1
		SNES_VMDATA $2442
		
		SNES_VMADD $5800 + $1D + $E1
		SNES_VMDATA $2442
	+:
	

	rts
