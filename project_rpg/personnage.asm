
Personnage:
	
	rep #$20
	
	
	lda #0
	sta MEM_TEMP
	lda s_perso+_direction,x
	cmp #1
	beq +
		lda s_perso+_mt,x
		asl
		asl
		asl
		asl
		sta MEM_TEMP
	+:
	
	lda s_perso+_oam,x
	clc
	adc MEM_TEMP
	tay
	sty MEM_TEMPFUNC
	
	lda s_perso+_x,x
	sec
	sbc LKS_BG+_bg1x
	sta MEM_TEMPFUNC+$C
	sta LKS_OAM+_sprx
	
	lda s_perso+_y,x
	sec
	sbc LKS_BG+_bg1y
	sta MEM_TEMPFUNC+$E
	sta LKS_OAM+_spry
	
	sep #$20
	
	
	;-------------
	phy	
	
	rep #$20
	lda MEM_TEMPFUNC
	lsr
	lsr
	lsr
	lsr
	
	tay
	sep #$20
	
	lda s_perso+_type,x
	cmp #0
	bne ++
		jsr Personnage_limite_ecran
	++:
	lda s_perso+_type,x
	cmp #1
	bne ++
		jsr Personnage_limite_ecran2
	++:
	
	ply
	
	
	
	lda MEM_TEMPFUNC+4
	cmp #0
	beq +
	
		rep #$20
		lda #$01E0
		sta s_perso+_oam,x
		
		sep #$20
		
		jsr Collision_perso_map
		jsr Deplacement_perso
		rts
	+:
	
	
	inc LKS_OAM+_nperso1
	inc LKS_OAM+_nperso2

	;-------------
	lda s_perso+_type,x
	cmp #0
	bne ++
		jsr Set_Draw_OAMp
	++:
	lda s_perso+_type,x
	cmp #1
	bne ++
		jsr Set_Draw_OAMp2
	++:
	
	
	lda s_text+_tdraw
	cmp #0
	bne +
		stz s_perso+_text,x
		bra ++
	+:
	lda s_perso+_text,x
	cmp #0
	beq ++
		stz s_perso+_vx,x
		stz s_perso+_vx+1,x
		
		stz s_perso+_vy,x
		stz s_perso+_vy+1,x
	++:


	
	;-------------
	lda s_perso+_cstop,x
	cmp #0
	bne ++
	
	lda s_game+_stopall
	cmp #0
	beq +
	++:
		rep #$20
	
		lda #0
		sta s_perso+_vx,x
		sta s_perso+_vy,x
		
		sep #$20
		ldy LKS_OAM
		stx LKS_OAM+$10,y
		iny
		iny
		sty LKS_OAM
		rts
	+:
	
	;Animation
	ldy MEM_TEMPFUNC+2
    jsr Personnage_animation
    
    
    ;Collision
    jsr Collision_perso_map
    jsr Deplacement_perso
    
    

    ;-------------
    
    ldy LKS_OAM
    stx LKS_OAM+$10,y
    iny
    iny
    sty LKS_OAM
    
    
    ;-------------
    
	rts
	

Personnage2:
	
	rep #$20
	
	
	lda #0
	sta MEM_TEMP
	lda s_perso+_direction,x
	cmp #1
	beq +
		lda s_perso+_mt,x
		asl
		asl
		asl
		asl
		sta MEM_TEMP
	+:
	
	lda s_perso+_oam,x
	clc
	adc MEM_TEMP
	tay
	sty MEM_TEMPFUNC
	
	lda s_perso+_x,x
	sec
	sbc LKS_BG+_bg1x
	sta MEM_TEMPFUNC+$C
	sta LKS_OAM+_sprx
	
	lda s_perso+_y,x
	sec
	sbc LKS_BG+_bg1y
	sta MEM_TEMPFUNC+$E
	sta LKS_OAM+_spry
	
	sep #$20
	
	
	;-------------
	phy	
	
	rep #$20
	lda MEM_TEMPFUNC
	lsr
	lsr
	lsr
	lsr
	
	tay
	sep #$20
	
	lda s_perso+_type,x
	cmp #0
	bne ++
		jsr Personnage_limite_ecran
	++:
	lda s_perso+_type,x
	cmp #1
	bne ++
		jsr Personnage_limite_ecran2
	++:
	
	ply
	
	
	
	lda MEM_TEMPFUNC+4
	cmp #0
	beq +
	
		rep #$20
		lda #$01E0
		sta s_perso+_oam,x
		
		sep #$20
		
		jsr Collision_perso_map
		jsr Deplacement_perso
		rts
	+:
	
	
	inc LKS_OAM+_nperso1
	inc LKS_OAM+_nperso2

	;-------------
	lda s_perso+_type,x
	cmp #0
	bne ++
		jsr Set_Draw_OAMp
	++:
	lda s_perso+_type,x
	cmp #1
	bne ++
		jsr Set_Draw_OAMp2
	++:
	
	
	lda s_text+_tdraw
	cmp #0
	bne +
		stz s_perso+_text,x
		bra ++
	+:
	lda s_perso+_text,x
	cmp #0
	beq ++
		stz s_perso+_vx,x
		stz s_perso+_vx+1,x
		
		stz s_perso+_vy,x
		stz s_perso+_vy+1,x
	++:


	
	;-------------
	lda s_perso+_cstop,x
	cmp #0
	bne ++
	
	lda s_game+_stopall
	cmp #0
	beq +
	++:
		rep #$20
	
		lda #0
		sta s_perso+_vx,x
		sta s_perso+_vy,x
		
		sep #$20
		ldy LKS_OAM
		stx LKS_OAM+$10,y
		iny
		iny
		sty LKS_OAM
		rts
	+:
	
	;Animation
	ldy MEM_TEMPFUNC+2
    jsr Personnage_animation
    
    
    ;Collision
    jsr Collision_perso_map
    jsr Deplacement_perso
    
    

    ;-------------
    
    ldy LKS_OAM
    stx LKS_OAM+$10,y
    iny
    iny
    sty LKS_OAM
    
    
    ;-------------
    
	rts
	
	
Personnage_limite_ecran:

	stz MEM_TEMPFUNC+4
	
	;Y
	rep #$20
	lda MEM_TEMPFUNC+$E
	clc
	adc #$20
	sta MEM_TEMP
	sep #$20
	
	lda MEM_TEMP+1
	cmp #$00
	beq +
		bra +++
	+:
	
	
	
	;X droite
	lda MEM_TEMPFUNC+$C+1
	cmp #$01
	bmi +
		bra +++
	+:
	
	;X gauche
	rep #$20
	lda MEM_TEMPFUNC+$C
	clc
	adc #$20
	sta MEM_TEMP
	sep #$20
		
	lda MEM_TEMP+1
	cmp #$0
	bpl +
		bra +++
	+:
	
	
	phx
	tyx
	;clipping
	lda MEM_TEMPFUNC+$C
	clc
	adc #$10
	bcc +
		lda #$44
		sta LKS_BUF_OAMH,x
	+:
	
	lda MEM_TEMPFUNC+$C+1
	cmp #$00
	bpl +
		lda #$11
		sta LKS_BUF_OAMH,x
		
		
		lda MEM_TEMPFUNC+$C
		clc
		adc #$10
		bcs ++
			lda #$44+$11
			sta LKS_BUF_OAMH,x
		++:
	+:
	
	plx
	
	;inc MEM_OAM+_nperso
	
	rts
	
	+++:
	
	inc MEM_TEMPFUNC+4
	
	rts

	
Personnage_animation:

	lda s_perso+_animact,x
    cmp s_perso+_animactold,x
    beq +
		sta s_perso+_animactold,x
		stz s_perso+_animl,x
		stz s_perso+_animi,x
		inc s_perso+_dma,x
    +:

	inc s_perso+_animl,x
    lda s_perso+_animl,x
    cmp #9
    bne +
		stz s_perso+_animl,x
		inc s_perso+_animi,x
		inc s_perso+_dma,x
    +:
    
    
    stz s_perso+_animend,x
    lda s_perso+_animi,x
    cmp #4
    bne +
		stz s_perso+_animl,x
		stz s_perso+_animi,x
		inc s_perso+_dma,x
		sta s_perso+_animend,x
    +:
    
    
    
    
    lda s_perso+_anims,x
    cmp #0
    beq +
		dec a
		sta s_perso+_animi,x
		stz s_perso+_animl,x
    +:
    
    ;------------------
    
    
    
    lda s_perso+_dma,x
    cmp #0
    beq +
		
		
		lda s_perso+_bankadd,x
		sta MEM_TEMP
		
		lda s_perso+_type,x
		cmp #0
		bne ++
			jsr Personnage_DMA0
		++:
		lda s_perso+_type,x
		cmp #1
		bne ++
			jsr Personnage_DMA1
		++:
		
		
		/*
		lda #1
		sta MEM_DMA,y
		
		lda s_perso+_bankadd,x
		sta MEM_DMA+_badress,y
		
		rep #$20
		
		lda s_perso+_add,x
		sta MEM_DMA+_adress,y
		
		
		
		lda s_perso+_animact,x
		and #$00FF
		asl
		asl
		asl
		asl
		
		clc
		adc s_perso+_animi,x
		and #$00FF
		asl
		asl
		asl
		asl
		asl
		asl
		asl
		clc
		adc s_perso+_add,x
		sta MEM_DMA+_sadress,y
		
		sep #$20
		*/
		
		stz s_perso+_dma,x
    +:

	rts
	

	
	
Personnage_DMA0:


	rep #$20
	lda s_perso+_add,x
	sta MEM_TEMP+2
	
	lda s_perso+_animact,x
	and #$00FF
	asl
	asl
	asl
	asl
	
	clc
	adc s_perso+_animi,x
	and #$00FF
	asl
	asl
	asl
	asl
	asl
	asl
	asl
	clc
	adc s_perso+_add,x
	sta MEM_TEMP+4
	sep #$20
	
	
	
	phx
	tyx
	
	lda #1
	sta LKS_DMA+_dmaEnable,x
	
	
	lda MEM_TEMP
	sta LKS_DMA+_dmaBank,x
	
	lda #$20
	sta LKS_DMA+_dmat,x
	
	rep #$20
	
	lda #$200
	sta LKS_DMA+_dmaSrcR,x
	
	lda MEM_TEMP+4
	sta LKS_DMA+_dmaSrc1,x
	
	lda #$6000
	clc
	adc MEM_TEMPFUNC+6
	sta LKS_DMA+_dmaDst1,x
	
	lda #$080
	sta LKS_DMA+_dmaSize1,x
	
	lda #LKS_DMA_VRAM1x2
	sta LKS_DMA+_dmaFunc,x
	
	
	
	sep #$20
	
	
	
	;lda #$31
	;sta LKS_DMA+_dmaType1,x
	
	plx

	rts

Personnage_DMA1:


	lda s_perso+_animact,x
	sta WRMPYA
	
	lda #$90
	sta WRMPYB
	
	rep #$20
	LKS_cycle8
	lda RDMPYL
	asl
	asl
	asl
	asl
	asl
	sta MEM_TEMP+2
	
	sep #$20
	
	
	lda s_perso+_animi,x
	sta WRMPYA
	
	lda #48
	sta WRMPYB
	
	rep #$20
	
	LKS_cycle8
	lda RDMPYL
	asl
	asl
	clc
	adc MEM_TEMP+2
	sta MEM_TEMP+2
	
	
	lda s_perso+_add,x
	clc
	adc MEM_TEMP+2
	
	sta MEM_TEMP+4
	
	sep #$20
	
	
	
	phx
	tyx
	
	lda #3
	sta LKS_DMA+_dmaEnable,x
	
	
	lda MEM_TEMP
	sta LKS_DMA+_dmaBank,x
	
	lda #$60
	sta LKS_DMA+_dmat,x
	
	rep #$20
	
	lda #LKS_DMA_VRAM2
	sta LKS_DMA+_dmaFunc,x
	
	lda #$300
	sta LKS_DMA+_dmaSrcR,x
	
	;1)
	lda MEM_TEMP+4
	sta LKS_DMA+_dmaSrc1,x
	
	lda #$6000
	clc
	adc MEM_TEMPFUNC+6
	sta LKS_DMA+_dmaDst1,x
	
	lda #$0C0
	sta LKS_DMA+_dmaSize1,x
	

	;2)
	
	lda MEM_TEMP+4
	clc
	adc #$600
	sta LKS_DMA+_dmaSrc2,x
	
	lda #$6000
	clc
	adc MEM_TEMPFUNC+6
	adc #$200
	sta LKS_DMA+_dmaDst2,x
	
	lda #$0C0
	sta LKS_DMA+_dmaSize2,x
	
	;3)
	
	lda MEM_TEMP+4
	clc
	adc #$600*2
	sta LKS_DMA+_dmaSrc3,x
	
	lda #$6000
	clc
	adc MEM_TEMPFUNC+6
	adc #$60
	sta LKS_DMA+_dmaDst3,x
	
	lda #$0C0
	sta LKS_DMA+_dmaSize3,x
	
	lda MEM_TEMPFUNC+6
	cmp #$880
	bne +
		lda #$6000
		clc
		adc MEM_TEMPFUNC+6
		adc #$180
		sta LKS_DMA+_dmaDst3,x
	
	+:
	
	
	sep #$20
	
	
	
	
	
	plx

	rts
	
Set_Draw_OAMp2:

	stz MEM_TEMP
	lda s_perso+_tag,x
	cmp #3
	bne +
		lda #$30
		sta MEM_TEMP
		
		
	+:
	
	lda s_perso+_flip,x
	bit #$40
	bne +
		jsl Set_Draw_OAM_48x48
		rts
	+:
	
	jsl Set_Draw_OAM_48x48f
	
	rts
	
Set_Draw_OAM_48x48f:

	;OAM 1
	
	lda #$21
	sta LKS_OAM+_sprsz
	
	rep #$20
	lda s_perso+_tile,x
	sta LKS_OAM+_sprtile
	
	lda LKS_OAM+_sprx
	clc
	adc #$10
	sta LKS_OAM+_sprx
	
	
	lda LKS_OAM+_sprext
	ora MEM_TEMP
	sta LKS_OAM+_sprext
	
	sep #$20
	jsl LKS_OAM_Draw
	
	
	
	;------
	lda #$10
	sta LKS_OAM+_sprsz
	
	
	;OAM 2
	rep #$20
	lda LKS_OAM+_sprx
	sec
	sbc #$10
	sta LKS_OAM+_sprx
	sep #$20
	
	
	lda s_perso+_tile,x
	clc
	adc #$4
	sta LKS_OAM+_sprtile
	
	
	
	jsl LKS_OAM_Draw
	
	
	;OAM 3
	rep #$20
	lda LKS_OAM+_spry
	clc
	adc #$10
	sta LKS_OAM+_spry
	sep #$20
	
	lda s_perso+_tile,x
	clc
	adc #$24
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	
	lda LKS_OAM+_sprext
	and #$EF
	sta LKS_OAM+_sprext
	
	;OAM 4
	rep #$20
	stz MEM_TEMP
	lda MEM_TEMPFUNC+6
	cmp #$880
	bne +
		lda #$12
		sta MEM_TEMP
	
	+:
	
	lda LKS_OAM+_spry
	clc
	adc #$10
	sta LKS_OAM+_spry
	sep #$20
	
	lda s_perso+_tile,x
	clc
	adc #$A
	adc MEM_TEMP
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	;OAM 5
	rep #$20
	lda LKS_OAM+_sprx
	clc
	adc #$10
	sta LKS_OAM+_sprx
	sep #$20
	
	lda LKS_OAM+_sprtile
	dec a
	dec a 
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	;OAM 6
	rep #$20
	lda LKS_OAM+_sprx
	clc
	adc #$10
	sta LKS_OAM+_sprx
	sep #$20
	
	lda LKS_OAM+_sprtile
	dec a
	dec a 
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	rtl
	
Set_Draw_OAM_48x48:

	
	;OAM 1
	
	lda #$21
	sta LKS_OAM+_sprsz
	
	rep #$20
	lda s_perso+_tile,x
	sta LKS_OAM+_sprtile
	sep #$20

	lda LKS_OAM+_sprext
	ora MEM_TEMP
	sta LKS_OAM+_sprext
	
	jsl LKS_OAM_Draw
	
	
	
	;------
	lda #$10
	sta LKS_OAM+_sprsz
	
	
	;OAM 2
	rep #$20
	lda LKS_OAM+_sprx
	clc
	adc #$20
	sta LKS_OAM+_sprx
	sep #$20
	
	
	lda s_perso+_tile,x
	clc
	adc #$4
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	
	;OAM 3
	rep #$20
	lda LKS_OAM+_spry
	clc
	adc #$10
	sta LKS_OAM+_spry
	sep #$20
	
	lda s_perso+_tile,x
	clc
	adc #$24
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	lda LKS_OAM+_sprext
	and #$EF
	sta LKS_OAM+_sprext
	
	;OAM 4
	rep #$20
	
	stz MEM_TEMP
	lda MEM_TEMPFUNC+6
	cmp #$880
	bne +
		lda #$12
		sta MEM_TEMP
	
	+:
	
	
	lda LKS_OAM+_spry
	clc
	adc #$10
	sta LKS_OAM+_spry
	sep #$20
	
	lda s_perso+_tile,x
	clc
	adc #$A
	adc MEM_TEMP
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	;OAM 5
	rep #$20
	lda LKS_OAM+_sprx
	sec
	sbc #$10
	sta LKS_OAM+_sprx
	sep #$20
	
	lda LKS_OAM+_sprtile
	dec a
	dec a 
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	;OAM 6
	rep #$20
	lda LKS_OAM+_sprx
	sec
	sbc #$10
	sta LKS_OAM+_sprx
	sep #$20
	
	lda LKS_OAM+_sprtile
	dec a
	dec a 
	sta LKS_OAM+_sprtile
	jsl LKS_OAM_Draw
	
	rtl
	

	
	
Personnage_limite_ecran2:

	
	stz MEM_TEMPFUNC+4
	
	;Y
	rep #$20
	lda MEM_TEMPFUNC+$E
	clc
	adc #$10
	
	sta MEM_TEMP
	sep #$20
	
	lda MEM_TEMP+1
	cmp #$01
	bmi +
		bra +++
	+:
	
	
	rep #$20
	lda MEM_TEMPFUNC+$E
	sec
	sbc #$10
	sta MEM_TEMPFUNC+$E
	sta LKS_OAM+_spry
	clc
	adc #$30
	sta MEM_TEMP
	sep #$20
	
	lda MEM_TEMP+1
	cmp #$00
	bpl +
		bra +++
	+:
	
	
	
	;X droite
	lda MEM_TEMPFUNC+$C+1
	cmp #$01
	bmi +
		bra +++
	+:
	
	;X gauche
	rep #$20
	lda MEM_TEMPFUNC+$C
	clc
	adc #$30
	sta MEM_TEMP
	sep #$20
		
	lda MEM_TEMP+1
	cmp #$0
	bpl +
		bra +++
	+:
	
	
	
			
	rts
	
	+++:
	
	inc MEM_TEMPFUNC+4
	
	rts

	
