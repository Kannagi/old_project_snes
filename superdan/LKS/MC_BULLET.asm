

.MACRO LKS_BULLET_INIT

	lda #$E0
	sta LKS_BULLET.Y+1+(2*\1)
	
	lda #\2
	sta LKS_BULLET.Tile+\1
	sta LKS_BUF_OAML+2+($4*\1)
	
	lda #\3
	sta LKS_BULLET.Flip+\1
	sta LKS_BUF_OAML+3+($4*\1)
.ENDM

.MACRO LKS_BULLET_DRAW_BG_FAST

	rep #$20
	clc
	lda LKS_BULLET.X+(2*\1)
	adc LKS_BULLET.VX+(2*\1)
	sec 
	sbc LKS_BG.VScrollx
	sta LKS_BULLET.X+(2*\1)
	and #$F800
	cmp #$F800
	bne +
		lda #0
		sta LKS_BULLET.VX+(2*\1)
		sta LKS_BULLET.VY+(2*\1)
		
		lda #$E000
		sta LKS_BULLET.Y+(2*\1)
	+:
	
	
	lda LKS_BULLET.Y+(2*\1)
	cmp #$E000
	beq ++
		sec 
		sbc LKS_BG.VScrolly
		clc
		adc LKS_BULLET.VY+(2*\1)
		sta LKS_BULLET.Y+(2*\1)
	++:
	
	and #$F000
	cmp #$F000
	bne +
		lda #0
		sta LKS_BULLET.VX+(2*\1)
		sta LKS_BULLET.VY+(2*\1)
		
		lda #$E000
		sta LKS_BULLET.Y+(2*\1)
	+:
	sep #$20
	
	lda LKS_BULLET.X+1+(2*\1)
	sta LKS_BUF_OAML+($4*\1)

	lda LKS_BULLET.Y+1+(2*\1)
	sta LKS_BUF_OAML+1+($4*\1)
	
	lda LKS_BULLET.Tile+\1
	sta LKS_BUF_OAML+2+($4*\1)
	
	lda LKS_BULLET.Flip+\1
	sta LKS_BUF_OAML+3+($4*\1)
.ENDM

.MACRO LKS_BULLET_DRAW_BG

	
	ldx #(2*\1)
	jsl LKS_BULLET_DRAW_BG
	
	
	lda LKS_BULLET.X+1+(2*\1)
	sta LKS_BUF_OAML+($4*\1)

	lda LKS_BULLET.Y+1+(2*\1)
	sta LKS_BUF_OAML+1+($4*\1)
	
	lda LKS_BULLET.Tile+\1
	sta LKS_BUF_OAML+2+($4*\1)
	
	lda LKS_BULLET.Flip+\1
	sta LKS_BUF_OAML+3+($4*\1)
.ENDM

.MACRO LKS_BULLET_DRAW

	ldx #(2*\1)
	jsl LKS_BULLET_DRAW
	
	lda LKS_BULLET.X+1+(2*\1)
	sta LKS_BUF_OAML+($4*\1)

	lda LKS_BULLET.Y+1+(2*\1)
	sta LKS_BUF_OAML+1+($4*\1)
	
	lda LKS_BULLET.Tile+\1
	sta LKS_BUF_OAML+2+($4*\1)
	
	lda LKS_BULLET.Flip+\1
	sta LKS_BUF_OAML+3+($4*\1)
.ENDM


.MACRO LKS_BULLET_DRAW_FAST1

	lda LKS_BULLET.X+(2*\1)
	adc LKS_BULLET.VX+(2*\1)
	sta LKS_BULLET.X+(2*\1)
	
	and #$F800
	cmp #$F800
	bne +
		ldx #(2*\1)
		stx MEM_TEMP+4
		
		jsl LKS_Bullet_Draw_Init
		
		bra ++
	+:

	
	lda LKS_BULLET.Y+(2*\1)
	adc LKS_BULLET.VY+(2*\1)
	sta LKS_BULLET.Y+(2*\1)
	and #$F000
	cmp #$F000
	bne ++
		ldx #(2*\1)
		stx MEM_TEMP+4
		
		jsl LKS_Bullet_Draw_Init
		
	++:
	
	
.ENDM

.MACRO LKS_BULLET_DRAW_FAST2

	lda LKS_BULLET.X+1+(2*\1)
	sta LKS_BUF_OAML+($4*\1)

	lda LKS_BULLET.Y+1+(2*\1)
	sta LKS_BUF_OAML+1+($4*\1)

.ENDM

.MACRO LKS_BULLET_DRAW_FAST3

	lda LKS_BULLET.X+1+(2*\1)
	adc #8
	sta LKS_BUF_OAML+($4*\1)

	lda LKS_BULLET.Y+1+(2*\1)
	sta LKS_BUF_OAML+1+($4*\1)

.ENDM

