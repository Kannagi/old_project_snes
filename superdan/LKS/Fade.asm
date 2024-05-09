
LKS_Fade_in:
	
	lda LKS_FADE.phase
	cmp #0
	beq +
		rtl
	+:

	lda LKS_FADE.brg
	sta INIDISP
	
	
	lda LKS_FADE.timer
	cmp #3
	bne +
		lda LKS_FADE.brg
		ina
		sta LKS_FADE.brg
		
		lda #0
		sta LKS_FADE.timer
		
		bra ++
	+:
		lda LKS_FADE.timer
		ina
		sta LKS_FADE.timer
	++:
	
	lda LKS_FADE.brg
	cmp #$10
	bne +
		lda #$0F
		sta INIDISP
		sta LKS_FADE.phase
		
		lda #0
		sta LKS_FADE.timer
		
		rtl
	+:
	

	rtl
	
	
LKS_Fade_out:
	
	lda LKS_FADE.phase
	cmp #0
	bne +
		rtl
	+:

	lda LKS_FADE.brg
	sta INIDISP
		
	lda LKS_FADE.timer
	cmp #3
	bne +
		lda LKS_FADE.brg
		dea
		sta LKS_FADE.brg
		
		lda #0
		sta LKS_FADE.timer
		
		bra ++
	+:
		lda LKS_FADE.timer
		ina
		sta LKS_FADE.timer
	++:
	
	lda LKS_FADE.brg
	cmp #-$1
	bne +
		lda #$00
		sta INIDISP
		sta LKS_FADE.phase
		
		lda #0
		sta LKS_FADE.timer
	
		rtl
	+:

	rtl
	

