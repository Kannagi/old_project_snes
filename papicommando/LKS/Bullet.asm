
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
