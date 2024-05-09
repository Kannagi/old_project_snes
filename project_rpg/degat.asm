
Degat_test:

	lda s_degat
	clc
	adc #12
	sta s_degat
	
	
	lda #1
	;cpx #0
	;bne +
		;sta s_perso+_dgt+0,x
		;sta s_perso+_dgt+1,x
	;+:
	
	lda s_perso+_dgt+1,x
	cmp #$FF
	bne +
		rts
	+:
	
	lda s_menu+_rdraw
	cmp #0
	beq +
		rts
	+:
	

	
	lda s_perso+_dgt,x
	sta MEM_TEMP+6
	
	lda s_perso+_dgt+1,x
	sta MEM_TEMP+7
	
	phx
	
	rep #$20
	
	
	
	lda MEM_TEMP+6
	compute_digit_for_base16 100
	stx MEM_TEMP+8
	compute_digit_for_base16 10
	stx MEM_TEMP + 10
	sta MEM_TEMP + 12
	
	plx
	
	lda #0
	sta MEM_TEMP + 14
	sta MEM_TEMP+4
	
	lda MEM_TEMP+8
	cmp #0
	beq +
		inc MEM_TEMP + 14
	+:
	cmp #2
	bmi +
		lda #$20
		sta MEM_TEMP+4
	+:
	
	
	lda MEM_TEMP+6
	cmp #10
	bmi +
		inc MEM_TEMP + 14
		inc MEM_TEMP + 14
	+:
	
		
	lda MEM_TEMP+8
	clc
	adc MEM_TEMP+4
	asl
	asl
	asl
	asl
	asl
	sta MEM_TEMP+8
	
	lda MEM_TEMP+10
	clc
	adc MEM_TEMP+4
	asl
	asl
	asl
	asl
	asl
	sta MEM_TEMP+10
	
	lda MEM_TEMP+12
	clc
	adc MEM_TEMP+4
	asl
	asl
	asl
	asl
	asl
	sta MEM_TEMP+12
	
	
	ldy s_degat
	
	lda s_perso+_x,x
	sec
	sbc #$6
	sec
	sbc LKS_BG+_bg1x
	sta LKS_OAM+_sprx
	
	lda s_perso+_y,x
	clc
	adc #$8
	adc s_degat+_di,y
	sec
	sbc LKS_BG+_bg1y
	sta LKS_OAM+_spry
	
	sep #$20
	jsr Degat_i
	
	lda #$3F
	sta LKS_OAM+_sprext
	
	lda #$10
	sta LKS_OAM+_sprsz
	
	stz MEM_TEMPFUNC+11
	;----
	
	phx
	
	rep #$20
	
	lda #0
	sta MEM_TEMPFUNC+14
	
	lda s_degat+_dch1,y
	and #$FF
	clc
	adc #$20*10
	tax
	stx MEM_TEMPFUNC+10
	
	
	
	sep #$20
	
	
	
	
	
	
	
	
	
	lda MEM_TEMP+14
	bit #$01
	beq +
		;lda s_degat+_dch1,y
		;sta MEM_TEMPFUNC+10
		
		lda MEM_TEMP+8
		sta MEM_TEMPFUNC+12
		lda MEM_TEMP+9
		sta MEM_TEMPFUNC+13
		
		lda s_degat+_ch1,y
		sta LKS_OAM+_sprtile
		
		rep #$20
		lda LKS_OAM+_sprx
		clc
		adc #$9
		sta LKS_OAM+_sprx
		sep #$20
		
		jsl LKS_OAM_Draw
		jsr Degat_affichage
		bra ++
	+:
		rep #$20
		lda LKS_OAM+_sprx
		clc
		adc #$5
		sta LKS_OAM+_sprx
		sep #$20
	++:
	
	;----
	lda MEM_TEMP+14
	bit #$02
	beq +
		;lda s_degat+_dch1,y
		;sta MEM_TEMPFUNC+10
		
		lda MEM_TEMP+10
		sta MEM_TEMPFUNC+12
		lda MEM_TEMP+11
		sta MEM_TEMPFUNC+13
		
		lda s_degat+_ch1,y
		sta LKS_OAM+_sprtile
		
		rep #$20
		lda LKS_OAM+_sprx
		clc
		adc #$9
		sta LKS_OAM+_sprx
		sep #$20
		
		jsl LKS_OAM_Draw
		jsr Degat_affichage
		bra ++
	+:
		rep #$20
		lda LKS_OAM+_sprx
		clc
		adc #$5
		sta LKS_OAM+_sprx
		sep #$20
	++:
	
	
	
	;----
	
	;lda s_degat+_dch1,y
	;sta MEM_TEMPFUNC+10
	
	lda MEM_TEMP+12
	sta MEM_TEMPFUNC+12
	lda MEM_TEMP+13
	sta MEM_TEMPFUNC+13
	
	lda s_degat+_ch1,y
	sta LKS_OAM+_sprtile
	
	rep #$20
	lda LKS_OAM+_sprx
	clc
	adc #$9
	sta LKS_OAM+_sprx
	sep #$20
	
	jsl LKS_OAM_Draw
	jsr Degat_affichage
	
	
	
	lda MEM_TEMPFUNC+14
	cmp #0
	beq +
		ldx MEM_TEMPFUNC+10
		sta LKS_DMA+_dmaEnable,x
		
		lda #$20
		sta LKS_DMA+_dmat,x
		
		lda #:Font3
		sta LKS_DMA+_dmaBank,x
		
		rep #$20
		lda #$200
		sta LKS_DMA+_dmaSrcR,x
		
		
		lda #LKS_DMA_VRAM2
		sta LKS_DMA+_dmaFunc,x
		sep #$20
		
		
	+:
	
	plx
	
	
	
	
	rts
	
Degat_i:

	lda s_degat+_dl,y
	sta MEM_TEMPFUNC+8
	ina
	sta s_degat+_dl,y
	
	
	cmp #$30
	bne +
		lda #0
		sta s_degat+_dl,y
		
		lda #0
		sta s_degat+_di,y
		sta s_degat+_di+1,y
		
		sta s_perso+_dgt,x
		lda #$FF
		sta s_perso+_dgt+1,x
		
		rts
	+:
	cmp #$5
	bpl +
		rep #$20
		
		lda s_degat+_di,y
		sec
		sbc #2
		sta s_degat+_di,y
		
		sep #$20
		rts
	+:
	cmp #$12
	bpl +
		rep #$20
		
		lda s_degat+_di,y
		sec
		sbc #1
		sta s_degat+_di,y
		
		sep #$20
		rts
	+:
	
	
	
	
	rts
	
Degat_affichage:

	
	phy

	rep #$20
	
	lda MEM_TEMPFUNC+10
	tax

	sep #$20
	
	
	;------------
	lda MEM_TEMPFUNC+8
	cmp #0
	bne +
		lda MEM_TEMPFUNC+14
		inc a
		sta MEM_TEMPFUNC+14
		
		cmp #2
		bne ++
			rep #$20
			txa
			clc
			adc #6
			tax
			sep #$20
		++:
		
		cmp #3
		bne +
			rep #$20
			txa
			clc
			adc #12
			tax
			sep #$20
	+:
	
	
	
	
	rep #$20
	
	lda #Font3
	clc
	adc MEM_TEMPFUNC+12
	sta LKS_DMA+_dmaSrc1,x
	
	
	
	lda LKS_OAM+_sprtile
	and #$FF
	asl a
	asl a
	asl a
	asl a
	clc
	adc #$7000
	sta LKS_DMA+_dmaDst1,x
	
	
	lda #$20
	sta LKS_DMA+_dmaSize1,x
	
	sep #$20
	
	
	
	ply
	
	
	
	rts
	
