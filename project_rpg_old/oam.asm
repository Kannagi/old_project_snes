
	
Valeur_OAM:

	ldx MEM_TEMPFUNC + 8
	lda MEM_OAM,X


	cmp #$80
	bne +
		ldx #0
		stx MEM_TEMPFUNC + 6
		rts
	+:
	
	cmp #$88
	bne +
		ldx #1
		stx MEM_TEMPFUNC + 6
		rts
	+:
	
	
	
	cmp #$90
	bne +
		ldx #2
		stx MEM_TEMPFUNC + 6
		rts
	+:
	
	cmp #$98
	bne +
		ldx #3
		stx MEM_TEMPFUNC + 6
		rts
	+:
	
	
	
	cmp #$A0
	bne +
		ldx #4
		stx MEM_TEMPFUNC + 6
		rts
	+:
	
	cmp #$A8
	bne +
		ldx #5
		stx MEM_TEMPFUNC + 6
		rts
	+:
	
	cmp #$B0
	bne +
		ldx #6
		stx MEM_TEMPFUNC + 6
		rts
	+:
	
	cmp #$B8
	bne +
		ldx #7
		stx MEM_TEMPFUNC + 6
		rts
	+:
	
	ldx #0
	stx MEM_TEMPFUNC + 6
	
	rts
	
Draw_oam__s1:
	draw_oam1_ram MEM_TEMPFUNC $00
	draw_oam3_ram MEM_TEMPFUNC $20
	rts
	
Draw_oam__s2:
	draw_oam2_ram MEM_TEMPFUNC $02
	draw_oam4_ram MEM_TEMPFUNC $22
	rts
	
Draw_oam__s3:
	draw_oam1_ram MEM_TEMPFUNC $02
	draw_oam3_ram MEM_TEMPFUNC $22
	rts
	
Draw_oam__s4:
	draw_oam2_ram MEM_TEMPFUNC $00
	draw_oam4_ram MEM_TEMPFUNC $20
	rts
	
Draw_oam_32:

	lda MEM_TEMPFUNC + 5
	cmp #0
	beq +
		lda MEM_TEMPFUNC
		cmp #-28
		bmi ++
		
		jsr Draw_oam__s1
		
		lda MEM_TEMPFUNC
		adc #32
		cmp #0
		bmi ++
			jsr Draw_oam__s2
		++:
		rts
	+:


	jsr Draw_oam__s1
	
	lda MEM_TEMPFUNC
	cmp #-16
	bmi +
		cmp #$00
		bpl +
			rts
	+:
	
	jsr Draw_oam__s2
	

	rts
	
Draw_oam_32_fx:

	lda MEM_TEMPFUNC + 5
	cmp #0
	beq +
		lda MEM_TEMPFUNC
		cmp #-28
		bmi ++
		
		jsr Draw_oam__s3
		
		lda MEM_TEMPFUNC
		adc #32
		cmp #0
		bmi ++
			jsr Draw_oam__s4
		++:
		rts
	+:


	jsr Draw_oam__s3
	
	lda MEM_TEMPFUNC
	cmp #-16
	bmi +
		cmp #$00
		bpl +
			rts
	+:
	
	jsr Draw_oam__s4
	

	rts
