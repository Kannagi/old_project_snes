
LKS_BULLET_DRAW_BG:
	rep #$20
	clc
	lda LKS_BULLET.X,x
	adc LKS_BULLET.VX,x
	sec 
	sbc LKS_BG.VScrollx
	sta LKS_BULLET.X,x
	and #$F800
	cmp #$F800
	bne +
		lda #0
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		
		lda #$E000
		sta LKS_BULLET.Y,x
	+:
	
	
	lda LKS_BULLET.Y,x
	cmp #$E000
	beq ++
		sec 
		sbc LKS_BG.VScrolly
		clc
		adc LKS_BULLET.VY,x
		sta LKS_BULLET.Y,x
	++:
	
	and #$F000
	cmp #$F000
	bne +
		lda #0
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		
		lda #$E000
		sta LKS_BULLET.Y,x
	+:
	sep #$20
	
	
	rtl

LKS_BULLET_DRAW:
	rep #$20
	clc
	lda LKS_BULLET.X,x
	adc LKS_BULLET.VX,x
	sta LKS_BULLET.X,x
	and #$F800
	cmp #$F800
	bne +
		lda #0
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		
		lda #$E000
		sta LKS_BULLET.Y,x
	+:
	
	
	lda LKS_BULLET.Y,x
	cmp #$E000
	beq ++
		clc
		adc LKS_BULLET.VY,x
		sta LKS_BULLET.Y,x
	++:

	
	and #$F000
	cmp #$F000
	bne +
		lda #0
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		
		lda #$E000
		sta LKS_BULLET.Y,x
	+:
	sep #$20
	
	rtl

.MACRO LKS_BULLET_SORT_INIT1

	tya
	cmp LKS_BULLET.Y+(1)+(2*\1)
	bne +
		lda #(2*\1)
		sta LKS_BULLET.Usable1,x
		inx
	+:
		
.ENDM

.MACRO LKS_BULLET_SORT_INIT2

	tya
	cmp LKS_BULLET.Y+(1)+(2*\1)
	bne +
		lda #(2*\1)
		sta LKS_BULLET.Usable2,x
		inx
	+:
		
.ENDM

rep #$20
LKS_Bullet_Draw_Init

	ldx MEM_TEMP+4
	lda #0
	sta LKS_BULLET.VX,x
	sta LKS_BULLET.VY,x
	sta LKS_BULLET.X,x
		
	lda #$E000
	sta LKS_BULLET.Y,x
	
	rtl
sep #$20

;--------------------------------

.MACRO LKS_BULLET_SORT_ARRAY_INIT1

	ldx #0
	.DEFINE CNT \1

.REPT \2
	LKS_BULLET_SORT_INIT1 CNT

.REDEFINE CNT CNT+1
.ENDR
.UNDEFINE CNT

	lda #$E0
	sta LKS_BULLET.Usable1,x
		
.ENDM

;--------------------------------

.MACRO LKS_BULLET_SORT_ARRAY_INIT2

	
	ldx #0
	.DEFINE CNT \1

.REPT \2
	LKS_BULLET_SORT_INIT2 CNT

.REDEFINE CNT CNT+1
.ENDR
.UNDEFINE CNT

	lda #$E0
	sta LKS_BULLET.Usable2,x
	
	
.ENDM

;--------------------------------

