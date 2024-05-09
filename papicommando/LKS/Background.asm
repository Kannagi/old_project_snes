

.MACRO draw_bg_ligne

	ldy #\1
	sty VMADDL

	ldy #$0020

	stx DMA_BANK + $00
	sta DMA_ADDL + $00
	sty DMA_SIZEL + $00

	ldy #$01
	sty MDMAEN

	adc LKS_BG.addyr

.ENDM


.MACRO background ARGS _addsc
	
	rep #$20
	
	clc
	txa
	
	ldx MEM_TEMPFUNC
	
	;colonne 0 
	draw_bg_ligne _addsc + $0
	
	;colonne 1
	draw_bg_ligne _addsc + $20

	;colonne 2
	draw_bg_ligne _addsc + $40
	
	;colonne 3
	draw_bg_ligne _addsc + $60
	
	;colonne 4
	draw_bg_ligne _addsc + $80
	
	;colonne 5
	draw_bg_ligne _addsc + $A0
	
	;colonne 6
	draw_bg_ligne _addsc + $C0
	
	;colonne 7
	draw_bg_ligne _addsc + $E0
	
	;colonne 8
	draw_bg_ligne _addsc + $100
	
	;colonne 9
	draw_bg_ligne _addsc + $120
	
	;colonne 10
	draw_bg_ligne _addsc + $140
	
	;colonne 11
	draw_bg_ligne _addsc + $160
	
	;colonne 12
	draw_bg_ligne _addsc + $180
	
	;colonne 13
	draw_bg_ligne _addsc + $1A0
	
	;colonne 14
	draw_bg_ligne _addsc + $1C0
	
	;colonne 15
	draw_bg_ligne _addsc + $1E0
	
	
	sep #$20
.ENDM

LKS_Background1:
	lda LKS_BG.Address1+2
	sta MEM_TEMPFUNC
	
	ldx	LKS_BG.Address1
	background $5400
	
	rtl
	
LKS_Background2:
	lda LKS_BG.Address2+2
	sta MEM_TEMPFUNC
	
	ldx	LKS_BG.Address2
	background $5800
	
	rtl
	
LKS_Background_Camera:

	stz LKS_BG.EnableX
	stz LKS_BG.EnableY
	
	rep #$20
	stz LKS_BG.VScrollx+1
	stz LKS_BG.VScrolly+1
	
	lda LKS_SPRITE.X,y
	sec
	sbc LKS_BG.x
	sta MEM_TEMP
	
	lda LKS_SPRITE.Y,y
	sec
	sbc LKS_BG.y
	sta MEM_TEMP+2
	
	sep #$20
	
	ldx MEM_TEMP
	cpx #$60
	bpl +
		rep #$20
		lda MEM_TEMP
		sec
		sbc #$60
		sta LKS_BG.VScrollx+1
		clc
		adc LKS_BG.x
		sta LKS_BG.x
		sep #$20
		
		lda LKS_BG.Enablelim
		bit #1
		bne +
		
		inc LKS_BG.EnableX
		inc LKS_BG.EnableX
	+:
	
	
	ldx MEM_TEMP
	cpx #$80
	beq +
	bmi +
		rep #$20
		lda MEM_TEMP
		sec
		sbc #$80
		sta LKS_BG.VScrollx+1
		clc
		adc LKS_BG.x
		sta LKS_BG.x
		sep #$20
		
		lda LKS_BG.Enablelim
		bit #1
		bne +
		
		inc LKS_BG.EnableX
	+:
	
	
	ldx MEM_TEMP+2
	cpx #$50
	bpl +
		rep #$20
		lda MEM_TEMP+2
		sec
		sbc #$50
		sta LKS_BG.VScrolly+1
		clc
		adc LKS_BG.y
		sta LKS_BG.y
		sep #$20
		
		lda LKS_BG.Enablelim
		bit #2
		bne +
		
		inc LKS_BG.EnableY
		inc LKS_BG.EnableY
	+:
	
	ldx MEM_TEMP+2
	cpx #$70
	beq +
	bmi +
		rep #$20
		lda MEM_TEMP+2
		sec
		sbc #$70
		sta LKS_BG.VScrolly+1
		clc
		adc LKS_BG.y
		sta LKS_BG.y
		sep #$20
		
		lda LKS_BG.Enablelim
		bit #2
		bne +
		
		inc LKS_BG.EnableY
	+:
	
	
	lda LKS_BG.EnableX
	cmp #0
	bne +
		stz LKS_BG.VScrollx+1
	+:
	
	lda LKS_BG.EnableY
	cmp #0
	bne +
		stz LKS_BG.VScrolly+1
	+:
	rtl
	


.MACRO Background_bloc

	tay
	pha
	
	lda [LKS_ZP],y
	sta $7E0000+(\1*2),x

	pla
	
	adc LKS_BG.addyr
	
.ENDM
