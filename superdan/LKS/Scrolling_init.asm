
LKS_Background_Camera_scrolling_init:

	rep #$20
	stz LKS_BG.EnableX
	stz LKS_BG.EnableY
	
	
	lda LKS_SPRITE.X
	sec
	sbc LKS_BG.x
	cmp #$70
	beq +
	bmi +
	
		lda LKS_BG.x
		clc
		adc #16
		sta LKS_BG.x
		
		inc LKS_BG.EnableX
	+:

	lda LKS_SPRITE.Y
	sec
	sbc LKS_BG.y
	cmp #$80
	beq +
	bmi +
		lda LKS_BG.y
		clc
		adc #16
		sta LKS_BG.y
		
		
		inc LKS_BG.EnableY
	+:
	
	sep #$20
	

	rtl
	
LKS_Scrolling_init:


	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	-:
		
		jsl LKS_Background_Camera_scrolling_init
		jsl LKS_Scrolling_limite
		rep #$20
		lda LKS_BG.EnableX
		clc
		adc LKS_BG.EnableY
		tax
		sep #$20
		

		
		phx
		
		jsl LKS_Scrolling
		
		jsl LKS_BackgroundX
		jsl LKS_BackgroundY
		
		LKS_BG_update
		
		plx
		
		cpx #0
	bne -

    
	
	lda #0
	sta LKS_BG.EnableX
	sta LKS_BG.EnableY

	rtl
