

Gameplay_ringdir:
	lda LKS_STDCTRL+_DOWN
	cmp #2
	bne ++
		lda #3
		sta s_menu+_ring
		rts
	++:
	
	lda LKS_STDCTRL+_UP
	cmp #2
	bne ++
		lda #4
		sta s_menu+_ring
		inc s_menu+_ringi
		rts
	++:
	
	lda LKS_STDCTRL+_RIGHT
	cmp #2
	bne ++
		dec s_menu+_rdelay
		
	++:
	
	lda LKS_STDCTRL+_LEFT
	cmp #2
	bne ++
		inc s_menu+_rdelay
	++:
	
	lda LKS_STDCTRL+_RIGHT
	cmp #1
	bne ++
		lda #-5
		sta s_menu+_rdelay
	++:
	
	lda LKS_STDCTRL+_LEFT
	cmp #1
	bne ++
		lda #5
		sta s_menu+_rdelay
	++:
	
	lda s_menu+_rdelay
	cmp #5
	bne ++
		lda #2
		sta s_menu+_ring_dir
		
		lda LKS_STDCTRL+_LEFT
		cmp #2
		bne +++
			lda #4
			sta s_menu+_rdelay
			bra ++
		+++:
		stz s_menu+_rdelay
	++:
	
	lda s_menu+_rdelay
	cmp #-5
	bne ++
		lda #1
		sta s_menu+_ring_dir
		
		lda LKS_STDCTRL+_RIGHT
		cmp #2
		bne +++
			lda #-4
			sta s_menu+_rdelay
			bra ++
		+++:
		stz s_menu+_rdelay
			
		
	++:


	rts
	
Gameplay_ring:

	lda s_menu+_rdraw
	cmp #0
	bne +
		rts
	+:
	
	
	lda s_menu+_ring
	cmp #2
	beq +
		rts
	+:
	
	lda s_menu+_rselecte
	cmp #0
	beq +
		jsr Gameplay_ring_select
		rts
	+:
	
	lda s_menu+_ering
	cmp #$00
	bne +
		
		
		
		jsr Gameplay_ringdir
		
		
	+:
	
	
	lda s_menu+_ring_dir
	cmp #0
	beq +
		rts
	+:
	
	lda LKS_STDCTRL+_X
	cmp #1
	bne ++
		lda #5
		sta s_menu+_ring
		rts
	++:
	
	lda s_map+_mode
	cmp #0
	bne +
		rts
	+:
	/*
	lda s_menu+_mvoid
	cmp #0
	beq +
		rts
	+:
	*/
	
	
	ldx s_menu+_mx
	lda s_item+_itemType,x
	cmp #3
	beq +
		rts
	+:
	
	lda LKS_OAM+_nperso2
	cmp #0
	bne +
		rts
	+:
	
	lda LKS_STDCTRL+_A
	cmp #1
	bne ++
		lda #1
		sta s_menu+_rselecte
		
		
		
		
		rts
	++:
	
	
	
	rts
	
Gameplay_ring_select:

	lda LKS_STDCTRL+_RIGHT
	cmp #1
	bne +
		inc s_menu+_rselect2
	+:
	
	lda LKS_STDCTRL+_LEFT
	cmp #1
	bne +
		dec s_menu+_rselect2
	+:
	
	lda LKS_STDCTRL+_B
	cmp #1
	bne +
		stz s_menu+_rselecte
		
		lda #8
		sta s_palette+_pleffect
	+:
	
	lda s_perso+_etat
	cmp #0
	bne +
	
	lda s_effect+_efenable
	cmp #0
	bne +
	
	lda s_menu+_page
	cmp #0
	bne +
	
	lda LKS_STDCTRL+_A
	cmp #1
	bne +
	
	
		jsr Game_Menu_Magic_use
		
	+:
		

	rts
	
Game_Menu_Magic_use:

	ldx s_menu+_mx
	lda s_item+_itemType,x
	cmp #3
	beq +
		rts
	+:
	
	ldx s_menu+_meffect
	stx s_effect+_efnsel1
	
	
	ldx s_menu+_mx
	
	
	
	lda s_item+_itemID,x
	cmp #0
	bne +
		lda #$1
		sta s_effect+_efinit
		
		lda #$0
		sta s_effect+_eftype
		jsl Menu_Clear
		
	+:
	
	lda s_item+_itemID,x
	cmp #1
	bne +
		lda #$1
		sta s_effect+_efinit
		
		lda #$1
		sta s_effect+_eftype
		jsl Menu_Clear
		rts
	+:
	
	
	rts
