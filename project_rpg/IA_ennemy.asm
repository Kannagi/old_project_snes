
IA_Ennemy:

	
		
	lda s_perso+_cstop,x
	cmp #0
	beq +
		rep #$20
		lda s_ia
		clc
		adc #$10
		sta s_ia
		
		lda #0
		sep #$20
		rts
	+:

	lda #3
	sta s_perso+_vlim,x

	lda s_perso+_etat,x
	sta MEM_TEMP

	phx
	
	
	;incremente pattern
	ldx s_ia
	inc s_ia+_patterni,x
	
	lda s_ia+_patterni,x
	cmp #50
	bne +
		inc s_ia+_pattern,x
		inc s_ia+_pattern,x
		stz s_ia+_patterni,x
	+:
	
	lda s_ia+_pattern,x
	cmp #16*1
	bne +
		stz s_ia+_pattern,x
	+:
	
	
	;------
	stz MEM_TEMPFUNC+6
	lda MEM_TEMP
	cmp #4
	bne +
		lda s_ia+_patternl,x
		inc a
		sta s_ia+_patternl,x
		sta MEM_TEMPFUNC+6
		cmp #$30
		bne +++
			lda #0
			sta s_ia+_patternl,x
		+++:
		
		bra ++
	+:
		stz s_ia+_patternl,x
	++:
	;------
	
	rep #$20
	lda s_ia
	clc
	adc #$10
	sta s_ia
	
	lda #0
	sep #$20
	
	
	
	
	lda s_ia+_pattern,x
	tay
	
	plx
	
	
	
	lda s_perso+_etat,x
	cmp #4
	bne +
		jsr IA_Degat
		rts
	+:
	
	;pattern
	rep #$20
	
	lda #$10
	sta MEM_TEMP
	
	lda s_perso+_vx,x
	cmp #0
	bne +
	
		
		
		lda IA_Patternx,y
		sta s_perso+_vx,x
		
		lda s_perso+_vx,x
		cmp #1
		bmi ++
			lda #0
			sta MEM_TEMP
			lda #3
			sta s_perso+_direction,x
			bra +
		++:
		cmp #0
		bpl +
			lda #1
			sta MEM_TEMP
			
			lda #2
			sta s_perso+_direction,x
		
	+:
		
	lda s_perso+_vy,x
	cmp #0
	bne +
	
		
		
		lda IA_Patterny,y
		sta s_perso+_vy,x
		
		lda s_perso+_vy,x
		cmp #1
		bmi ++
			lda #1
			sta s_perso+_direction,x
			lda #2
			sta MEM_TEMP
			bra +
		++:
		cmp #0
		bpl +
			lda #3
			sta MEM_TEMP
			
			lda #0
			sta s_perso+_direction,x		
	+:
	;stz s_perso+_vx,x
	;stz s_perso+_vy,x
	
	sep #$20
	
	;--------------
	;IA
	
	lda #0
	sta s_perso+_anims,x
	
	lda MEM_TEMP
	cmp #0
	bne +
		lda s_perso+_flip,x
		and #$3F
		sta s_perso+_flip,x
		
		lda #1
		sta s_perso+_animact,x
		rts
	+:
	cmp #1
	bne +
		lda s_perso+_flip,x
		ora #$40
		sta s_perso+_flip,x
		
		lda #1
		sta s_perso+_animact,x
		rts
	+:
	cmp #2
	bne +
		lda #0
		sta s_perso+_animact,x
		rts
	+:
	cmp #3
	bne +
		lda #2
		sta s_perso+_animact,x
		rts
	+:
	
	
	rts
	
IA_Degat:
	
	lda #6
	sta s_perso+_animact,x
	
	lda #1
	sta s_perso+_anims,x
	
	/*
	jsr Degat_d1
	jsr Degat_d2
	jsr Degat_d3
	jsr Degat_d4
	*/
	lda #0
	sta s_perso+_vlim,x
	sta s_perso+_vtmp,x

	lda MEM_TEMPFUNC+6
	cmp #$30
	bne +
		lda #0
		sta s_perso+_etat,x
		
	+:
	
	rts
	
	
IA_Patternx:
 .dw 0,1,0,-1,0,1,0,-1

	
IA_Patterny:
 .dw -1,0,1,0,-1,0,1,0
 
IA_Patternd:
 .dw -1,0,1,0,-1,0,1,0
	
	
