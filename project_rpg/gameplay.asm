

	
Gameplay_text:

	lda s_menu+_rdraw
	cmp #0
	beq +
		rts
	+:
	
	lda LKS_STDCTRL+_A
	cmp #1
	bne +
		inc s_text+_texton
	+:
	
	

	rts
	
	
Gameplay1wait:

	lda #3
	sta s_perso+_animact
	
	lda #1
	sta s_perso+_anims
	
	lda s_perso+_direction
	cmp #1
	bne +
		lda #3
		sta s_perso+_anims
	+:
	
	lda s_perso+_direction
	cmp #2
	bne +
		lda #2
		sta s_perso+_anims
	+:
	
	lda s_perso+_direction
	cmp #3
	bne +
		lda #2
		sta s_perso+_anims
	+:
	rts
	
Gameplay1:

	
	
	lda s_game+_stopall
	cmp #0
	beq +
		rts
	+:
	
	
	jsr Gameplay1wait
	
	lda s_perso+_text
	cmp #0
	beq +
		rts
	+:
	
	lda LKS_STDCTRL+_X
	cmp #1
	bne +
		inc s_menu+_rdraw
	+:
	
	lda s_map+_mode
	cmp #0
	beq +
		jsr Gameplay_mode1
	+:
	
	lda s_perso+_etat
	cmp #1
	bne +
		
		lda #4
		sta s_perso+_animact
		
		lda s_perso+_direction
		cmp #1
		bne ++
			lda #6
			sta s_perso+_animact
		++:
		
		lda s_perso+_direction
		cmp #2
		bne ++
			lda #5
			sta s_perso+_animact
		++:
		
		lda s_perso+_direction
		cmp #3
		bne ++
			lda #5
			sta s_perso+_animact
		++:
		
		stz s_perso+_anims
		
		lda s_perso+_animend
		cmp #0
		beq ++
			stz s_perso+_etat
			jsr Gameplay1wait
		++:
		rts
		
	+:
	
	
	
	
	
	
	lda LKS_STDCTRL+_DOWN
	cmp #2
	bne +
		rep #$20
		lda #1
		sta s_perso+_vy,x
		sep #$20
		
		lda #0
		sta s_perso+_animact
		
		lda s_perso+_flip
		and #$3F
		sta s_perso+_flip
		
		lda #0
		sta s_perso+_direction
		
		stz s_perso+_anims
		
	+:
	
	lda LKS_STDCTRL+_UP
	cmp #2
	bne +
		rep #$20
		lda #-1
		sta s_perso+_vy,x
		sep #$20
		
		lda #2
		sta s_perso+_animact
		
		lda s_perso+_flip
		and #$3F
		sta s_perso+_flip
		
		lda #1
		sta s_perso+_direction
		
		stz s_perso+_anims
		
	+:	
	
	lda LKS_STDCTRL+_RIGHT
	cmp #2
	bne +
		rep #$20
		lda #1
		sta s_perso+_vx,x
		sep #$20
		
		lda #1
		sta s_perso+_animact
		
		lda s_perso+_flip
		and #$3F
		sta s_perso+_flip
		
		lda #2
		sta s_perso+_direction
		
		stz s_perso+_anims
	+:
	
	lda LKS_STDCTRL+_LEFT
	cmp #2
	bne +
		rep #$20
		lda #-1
		sta s_perso+_vx,x
		sep #$20
		
		lda #1
		sta s_perso+_animact
		
		lda s_perso+_flip
		ora #$40
		sta s_perso+_flip
		
		lda #3
		sta s_perso+_direction
		
		stz s_perso+_anims
	+:
	
	
	lda LKS_STDCTRL+_B
	cmp #2
	bne +
		rep #$20
		lda s_perso+_vx,x
		asl a
		sta s_perso+_vx,x
		
		lda s_perso+_vy,x
		asl a
		sta s_perso+_vy,x
		sep #$20
		
	+:
	
	rts
	
Gameplay_mode1:

	lda LKS_STDCTRL+_A
	cmp #1
	bne +
		lda s_perso+_etat
		cmp #0
		bne +
			lda #1
			sta s_perso+_etat
	+:
	
	lda s_perso+_etat
	cmp #0
	beq +
		jmp +++
	+:
	
	lda s_effect+_efinit
	cmp #0
	beq +
		jmp +++
	+:
	
	lda LKS_STDCTRL+_L
	cmp #1
	bne +
		
		
		ldy #0
		-:
			
			ldx LKS_OAM+$10,y
			
			cpx #0
			beq ++
			
			cpx #$40
			beq ++
			
			cpx #$80
			beq ++
			
			
			rep #$20
			lda s_perso+_oam,x
			
			sep #$20
			cpy #0
			beq ++
			
			stx s_effect+_efnsel1
			ldy #11*2
			++:			
			
			
			iny
			iny
			cpy #12*2
		bne -
		

		lda #$1
		sta s_effect+_efinit
	+:
	
	lda LKS_STDCTRL+_R
	cmp #1
	bne +++
	
		stz MEM_TEMP
		ldy #0
		-:
			
			ldx LKS_OAM+$10,y
			
			cpx #0
			beq ++
			
			cpx #$40
			beq ++
			
			cpx #$80
			beq ++
			
			
			rep #$20
			lda s_perso+_oam,x
			
			sep #$20
			cpy #0
			beq ++
			
			lda MEM_TEMP
			cmp #0
			bne +
				stx s_effect+_efnsel1
				inc MEM_TEMP
			+:
			cmp #1
			bne +
				stx s_effect+_efnsel2
				inc MEM_TEMP
			+:
			cmp #2
			bne +
				stx s_effect+_efnsel3
				inc MEM_TEMP
			+:
			
			++:			
			
			
			iny
			iny
			cpy #12*2
		bne -
		
		lda #$2
		sta s_effect+_efinit
	+++:
	
	rts
	
Joypad:

	lda #0
	sta LKS_BG+_bgEnableX
	sta LKS_BG+_bgEnableY
	ldx #0
	stx s_text+_texton
	
	
	
	
	
	
	
	ldx #$40*0
	
	
	jsr Gameplay_text
	jsr Gameplay1
	
	lda #0
	sta s_perso+_vlim
	
	
	rts
	
	
Background_camera:
	
	rep #$20
	
	lda s_perso+_x
	sec
	sbc LKS_BG+_bg1x
	sta MEM_TEMP
	
	lda s_perso+_y
	sec
	sbc LKS_BG+_bg1y
	sta MEM_TEMP+2
	
	sep #$20
	
	
	ldx MEM_TEMP
	cpx #$30
	bpl +
		rep #$20
		dec LKS_BG+_bg1x
		sep #$20
		
		inc LKS_BG+_bgEnableX
		inc LKS_BG+_bgEnableX
	+:
	
	ldx MEM_TEMP
	cpx #$B0
	bmi +
		rep #$20
		inc LKS_BG+_bg1x
		sep #$20
		
		inc LKS_BG+_bgEnableX
	+:
	
	ldx MEM_TEMP+2
	cpx #$30
	bpl +
		rep #$20
		dec LKS_BG+_bg1y
		sep #$20
		
		inc LKS_BG+_bgEnableY
		inc LKS_BG+_bgEnableY
	+:
	
	ldx MEM_TEMP+2
	cpx #$90
	bmi +
		rep #$20
		inc LKS_BG+_bg1y
		sep #$20
		
		inc LKS_BG+_bgEnableY
	+:
	
	
	
	rts
	
