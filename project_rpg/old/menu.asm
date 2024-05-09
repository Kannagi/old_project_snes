


Menu_eangle:

	lda s_menu+_nring
	
	ldx #$100
	stx s_menu+_eangle
	
	cmp #2
	bne +
		ldx #$80
		stx s_menu+_eangle
	+:
	
	cmp #3
	bne +
		ldx #$54
		stx s_menu+_eangle
	+:
	
	cmp #4
	bne +
		ldx #$40
		stx s_menu+_eangle
	+:
	
	cmp #5
	bne +
		ldx #$33
		stx s_menu+_eangle
	+:
	
	cmp #6
	bne +
		ldx #$2A
		stx s_menu+_eangle
	+:
	
	cmp #7
	bne +
		ldx #$24
		stx s_menu+_eangle
	+:
	
	cmp #8
	bne +
		ldx #$20
		stx s_menu+_eangle
	+:
	
	rtl
	
Menu_rotation:

	stz MEM_TEMP
	stz MEM_TEMP+1
	
	lda s_menu+_ring_dir
	cmp #$01
	bne +
		rep #$20
		lda s_menu+_ering
		clc
		adc #04
		sta s_menu+_ering
		sep #$20
		
		
		
		
		lda #04
		sta MEM_TEMP
	+:
	
	lda s_menu+_ring_dir
	cmp #$02
	bne +
		rep #$20
		lda s_menu+_ering
		clc
		adc #04
		sta s_menu+_ering
		sep #$20
		
		lda #-04
		sta MEM_TEMP
	+:

	
	ldx s_menu+_ering
	cpx s_menu+_eangle
	bmi +
		stz s_menu+_ering
		stz s_menu+_ering+1
		stz s_menu+_ring_dir
	+:
	
	
	lda s_menu+_angle
	clc
	adc MEM_TEMP
	sta s_menu+_angle
	
	
	;div for n select
	ldx s_menu+_angle
	stx WRDIVL
	lda s_menu+_eangle
	sta WRDIVB
	ora 0
	ora 0
	ora 0
	ora 0
	ora 0
	
	lda RDDIVL
	sta s_menu+_rselect

	jsl Menu_ajust
	
	rtl
	
Menu_ajust:
	lda s_menu+_ring
	cmp #2
	beq +
		rtl
	+:
	
	lda s_menu+_ring_dir
	cmp #$00
	beq +
		rtl
	+:
	
	jsl Menu_ajust1
	jsl Menu_ajust2
	jsl Menu_ajust3
	
	rtl
	
Menu_ajust1:
	lda s_menu+_nring
	cmp #$03
	beq +
		rtl
	+:
	
	lda s_menu+_rselect
	cmp #0
	bne +
		ldx #$40
		stx s_menu+_angle
	+:
	cmp #1
	bne +
		ldx #$97
		stx s_menu+_angle
	+:
	cmp #2
	bne +
		ldx #$EB
		stx s_menu+_angle
	+:
	
	rtl
	
Menu_ajust2:
	lda s_menu+_nring
	cmp #$05
	beq +
		rtl
	+:
	
	lda s_menu+_rselect
	cmp #0
	bne +
		ldx #$0C
		stx s_menu+_angle
	+:
	lda s_menu+_rselect
	cmp #1
	bne +
		ldx #$40
		stx s_menu+_angle
	+:
	cmp #4
	bne +
		ldx #$DB
		stx s_menu+_angle
	+:
	
	rtl
	
Menu_ajust3:
	lda s_menu+_nring
	cmp #$06
	beq +
		rtl
	+:
	
	
	lda s_menu+_rselect
	cmp #0
	bne +
		ldx #$15
		stx s_menu+_angle
	+:
	cmp #1
	bne +
		ldx #$40
		stx s_menu+_angle
	+:
	cmp #2
	bne +
		ldx #$6D
		stx s_menu+_angle
	+:
	cmp #3
	bne +
		ldx #$99
		stx s_menu+_angle
	+:
	cmp #4
	bne +
		ldx #$C1
		stx s_menu+_angle
	+:
	cmp #5
	bne +
		ldx #$ED
		stx s_menu+_angle
	+:
	
	rtl
	
Menu_centre_perso:
	
	
	rep #$20
	
	ldx #0
	
	lda s_perso+_x,x
	sec
	sbc LKS_BG+_bg1x
	sta MEM_TEMPFUNC+$4
	clc
	adc MEM_TEMPFUNC+$8
	sec
	sbc MEM_TEMPFUNC+2
	clc
	adc #$8
	sta MEM_TEMPFUNC+$C
	
	
	lda s_perso+_y,x
	sec
	sbc LKS_BG+_bg1y
	sta MEM_TEMPFUNC+$6
	clc
	adc MEM_TEMPFUNC+$8
	sec
	sbc MEM_TEMPFUNC+2
	clc
	adc #$7
	sta MEM_TEMPFUNC+$E
	
	sep #$20
	
	rtl
	
.MACRO Draw_icon_select		
		
	lda MEM_TEMPFUNC+$4
	clc
	adc #\1
	sta MEM_OAML,y
	iny
	
	lda MEM_TEMPFUNC+$6
	sec
	sbc #\2
	sta MEM_OAML,y
	iny
	
	
	lda #$E0
	sta MEM_OAML,y
	iny
	
	lda #$31
	sta MEM_OAML,y
	iny
	
	;-----------------------
	lda MEM_TEMPFUNC+$4
	clc
	adc #\1+$10
	sta MEM_OAML,y
	iny
	
	lda MEM_TEMPFUNC+$6
	sec
	sbc #\2
	sta MEM_OAML,y
	iny
	
	
	lda #$E0
	sta MEM_OAML,y
	iny
	
	lda #$71
	sta MEM_OAML,y
	iny
	
	;-----------------------
	lda MEM_TEMPFUNC+$4
	clc
	adc #\1
	sta MEM_OAML,y
	iny
	
	lda MEM_TEMPFUNC+$6
	sec
	sbc #\2-$10
	sta MEM_OAML,y
	iny
	
	
	lda #$E0
	sta MEM_OAML,y
	iny
	
	lda #$B1
	sta MEM_OAML,y
	iny
	
	;-----------------------
	lda MEM_TEMPFUNC+$4
	clc
	adc #\1+$10
	sta MEM_OAML,y
	iny
	
	lda MEM_TEMPFUNC+$6
	sec
	sbc #\2-$10
	sta MEM_OAML,y
	iny
	
	
	lda #$E0
	sta MEM_OAML,y
	iny
	
	lda #$F1
	sta MEM_OAML,y
	iny
	
	;-----------------------
	
.ENDM


	
Menu_init:

	
	
	lda s_menu+_ring
	cmp #0
	bne +
		
		lda #1
		sta s_palette+_pleffect
		sta s_menu+_ringdma
		stz s_menu+_ringload
		
		lda #1
		sta s_menu+_ring
		
		lda #18
		sta s_menu+_ringi
		rtl
	+:
	
	cmp #5
	bne +
		lda s_menu+_ringi
		cmp #5
		bpl ++
			lda #5
			sta s_menu+_ringi
		++:
		rtl
	+:
	
	jsl Menu_init_icon

	rtl
	
.MACRO Menu_init_pal1
	lda #\1
	sta s_menu+_rpal
	
	lda #\2
	sta s_menu+_rpal+1
	
	lda #\3
	sta s_menu+_rpal+2
	
	lda #\4
	sta s_menu+_rpal+3
	
	lda #\5
	sta s_menu+_rpal+4
	
	lda #\6
	sta s_menu+_rpal+5
	
	lda #\7
	sta s_menu+_rpal+6
	
	lda #\8
	sta s_menu+_rpal+7
.ENDM
	
Menu_Page:

	lda #1
	sta s_menu+_ringdma
	
	lda s_menu+_page
	cmp #$FF
	bne +
		lda #2
		sta s_menu+_page
	+:
	
	lda s_menu+_page
	cmp #3
	bne +
		stz s_menu+_page
	+:
	
	lda s_menu+_page
	cmp #0
	bne +
		lda #0
		sta s_menu+_ringload
		
		ldx #_itemSum
		stx s_menu+_rx
		
		SNES_WMADD LKS_BUF_PAL&$FFFF+$1C0,0
	
		SNES_DMA0_ADD pallette_invocation1,$20
		SNES_DMA1_ADD pallette_invocation2,$20
		
		SNES_MDMAEN $03
		
		Menu_init_pal1 6,7,6,7,6,7,6,7
	+:
	
	lda s_menu+_page
	cmp #1
	bne +
		lda #1
		sta s_menu+_ringload
		
		ldx #_itemOption
		stx s_menu+_rx
		
		SNES_WMADD LKS_BUF_PAL&$FFFF+$1C0,0
	
		SNES_DMA0_ADD pallette_roption,$20
		SNES_DMA1_ADD pallette_roption,$20
		
		SNES_MDMAEN $03
		
		Menu_init_pal1 6,7,6,7,6,7,6,7
	+:
	lda s_menu+_page
	cmp #2
	bne +
		lda #2
		sta s_menu+_ringload
		
		SNES_WMADD LKS_BUF_PAL&$FFFF+$180,0
	
		SNES_DMA0_ADD pallette_ritem1,$20
		SNES_DMA1_ADD pallette_ritem2,$20
		SNES_DMA2_ADD pallette_ritem3,$20
		SNES_DMA3_ADD pallette_ritem4,$20
		
		SNES_MDMAEN $0F
		
		
	+:
	lda s_menu+_page
	cmp #2
	bne +
		ldx #_itemItem
		stx s_menu+_rx
		
		Menu_init_pal1 4,4,4,5,5,5,6,6
	+:
	rtl
	
Menu:

	lda s_menu+_rdraw
	cmp #0
	bne +
		
		rtl
	+:
	
	
	
	sta s_game+_stopall
	
	
	
	
	jsl Menu_init
	
	
	ldx s_menu+_ringi
	stx MEM_TEMPFUNC
	lda s_menu+_ringi
	sta WRMPYA
	
	
	lda #8
	sta s_menu+_nring
	
	
	ldx #$8
	stx MEM_TEMPFUNC+2
	
	ldx #$0
	stx MEM_TEMPFUNC+$8
	
	lda s_menu+_ring
	cmp #1
	bne +
		ldx #$10
		stx MEM_TEMPFUNC+2
	
		ldx #$28
		stx MEM_TEMPFUNC+$8
	+:
	lda s_menu+_ring
	cmp #4
	bne +
		ldx #$10
		stx MEM_TEMPFUNC+2
	
		ldx #$28
		stx MEM_TEMPFUNC+$8
	+:
	lda s_menu+_ring
	cmp #5
	bne +
		ldx #$10
		stx MEM_TEMPFUNC+2
	
		ldx #$28
		stx MEM_TEMPFUNC+$8
	+:
	lda MEM_TEMPFUNC+2
	sta WRMPYB
	ora 0
	ora 0

	ldy RDMPYL
	sty MEM_TEMPFUNC+2
	
	jsl Menu_centre_perso
	
	jsl Menu_eangle
	
	jsl Menu_rotation
	
	lda s_menu+_ring
	cmp #2
	bne +
		ldy #$B0
		Draw_icon_select $0,$20
		bra ++
	+:
		
		lda #-32
		LKS_OAM4_Clear $B
		
	++:
	
	ldy #$C0 ;OAMADD
	
	lda s_menu+_ring
	cmp #1
	bne +
		lda #$00
		sta MEM_TEMP
		sta MEM_TEMP+1
		jsl Menu_icon3
	+:
	
	lda s_menu+_ring
	cmp #2
	bne +
		jsl Menu_Select
	+:
	
	lda s_menu+_ring
	cmp #3
	bne +
		jsl Menu_icon2
	+:
	
	lda s_menu+_ring
	cmp #4
	bne +
		lda #$00
		sta MEM_TEMP
		sta MEM_TEMP+1
		jsl Menu_icon3
	+:
	
	lda s_menu+_ring
	cmp #6
	bne +
		jsl Menu_icon2
	+:
	
	lda s_menu+_ring
	cmp #5
	bne +
		lda #$FF
		sta MEM_TEMP
		sta MEM_TEMP+1
		jsl Menu_icon3
	+:
	
	
	
	inc s_menu+_ringl
    lda s_menu+_ringl
    cmp #2
    bne ++
		stz s_menu+_ringl
		
		lda s_menu+_ring
		cmp #1
		bne +
			dec s_menu+_ringi
		+:
		cmp #3
		bne +
			dec s_menu+_ringi
		+:
		cmp #4
		bne +
			inc s_menu+_ringi
		+:
		cmp #5
		bne +
			inc s_menu+_ringi
		+:
		cmp #6
		bne +
			inc s_menu+_ringi
		+:
		
    ++:
    
    lda s_menu+_ring
	cmp #5
	bne +
		lda s_menu+_ringi
		cmp #18
		bmi ++
			jsl Menu_Clear
			
		++:
		
		rtl
	+:
	
	


	lda s_menu+_ring
	cmp #1
	bne +
		
    lda s_menu+_ringi
    cmp #5
    bpl +
		lda #4
		sta s_menu+_ringi
		
		lda #2
		sta s_menu+_ring

    +:
    
    lda s_menu+_ring
	cmp #4
	bne +
		
    lda s_menu+_ringi
    cmp #18
    bne +
		lda #0
		sta s_menu+_ringi
		
		
		lda #6
		sta s_menu+_ring
		
		
		
		lda #8
		sta s_palette+_pleffect
		
		inc s_menu+_page

    +:
    
    lda s_menu+_ring
	cmp #3
	bne +
	
	
		
    lda s_menu+_ringi
    cmp #-1
    bne +
		lda #18
		sta s_menu+_ringi
		
		
		lda #1
		sta s_menu+_ring
		
			
		lda #8
		sta s_palette+_pleffect
		
		dec s_menu+_page

    +:
    
    lda s_menu+_ring
	cmp #6
	bne +
		
    lda s_menu+_ringi
    cmp #5
    bne +
		lda #4
		sta s_menu+_ringi
		
		
		lda #2
		sta s_menu+_ring

    +:
    
	
	rtl
	
Menu_Select:

	
	
	jsl Menu_icon
	
	lda #-32
	LKS_OAM4_Clear $A
	stz MEM_OAMH +$A
	
	lda s_menu+_rselecte
	cmp #0
	bne +
		rtl
	+:
	
	LKS_OAM_position 0,0
	stz  s_menu+_mvoid
	
	lda s_menu+_rselect2
	cmp #0
	bpl +
		lda #2
		sta s_menu+_rselect2
	+:
	cmp #3
	bmi +
		lda #0
		sta s_menu+_rselect2
	+:
	cmp #0
	bne +
		ldx MEM_OAM+$10+$6
		
		pha
		rep #$20
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			ldx MEM_OAM+$10+$8
		
		++:
		
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			ldx MEM_OAM+$10+$A
		
		++:
		
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			lda #1
			sta s_menu+_mvoid
		
		++:
		
		sep #$20
		pla
		
	+:
	cmp #1
	bne +
		ldx MEM_OAM+$10+$8
		
		pha
		rep #$20
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			ldx MEM_OAM+$10+$6
		
		++:
		
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			ldx MEM_OAM+$10+$A
		
		++:
		
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			lda #1
			sta s_menu+_mvoid
		
		++:
		
		sep #$20
		pla
	+:
	cmp #2
	bne +
		ldx MEM_OAM+$10+$A
		
		pha
		rep #$20
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			ldx MEM_OAM+$10+$8
		
		++:
		
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			ldx MEM_OAM+$10+$06
		
		++:
		
		lda s_perso+_oam,x
		cmp #$1E0
		bne ++
			lda #1
			sta s_menu+_mvoid
		
		++:
		
		sep #$20
		pla
	+:
	
	
	
	stx s_menu+_meffect
	
	
	rep #$20
	lda s_perso+_oam,x
	cmp #0
	beq +
		
		
		
		
		lda s_perso+_x,x
		clc
		adc #$10
		sec
		sbc LKS_BG+_bg1x
		sta MEM_OAM+_sprx
		
		lda s_perso+_y,x
		sec
		sbc LKS_BG+_bg1y
		sta MEM_OAM+_spry
		
	+:
	sep #$20
	
	ldy #$AC
	LKS_OAM_Draw $E2,$3F,$10
	
	lda #-32
	LKS_OAM4_Clear $B
	LKS_OAM4_Clear $C
	LKS_OAM4_Clear $D
	LKS_OAM4_Clear $E
	LKS_OAM4_Clear $F
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$1E0,0
	SNES_DMA0_ADD pallette_select,$20
	SNES_MDMAEN $01
	
	lda #2
	sta s_palette+_pltype
	
	rtl

Menu_Clear

	lda #$FD
	sta s_palette+_pleffect
	
	stz s_game+_stopall
	stz s_menu+_rdraw
	stz s_menu+_ring
	stz s_menu+_rselect2
	stz s_menu+_rselecte
	
	lda #-32
	LKS_OAM4_Clear $B
	LKS_OAM4_Clear $C
	LKS_OAM4_Clear $D
	LKS_OAM4_Clear $E
	LKS_OAM4_Clear $F
	
	rtl
	
Menu_icon:

	ldx s_menu+_angle
	
	
	stz MEM_TEMP+2
	stz MEM_TEMP+3
	
	lda s_menu+_nring
	sta MEM_TEMP
	
	-:
		rep #$20
		
		lda SinCosmenu.l ,x
		and #$00FF
		
		clc
		adc MEM_TEMPFUNC+$C
		sta MEM_OAM+_sprx
		
		lda SinCosmenu.l+$40,x
		and #$00FF
		clc
		adc MEM_TEMPFUNC+$E
		sta MEM_OAM+_spry
		
		
		lda #0
		sep #$20
		
		
		phx
		
		rep #$20
		lda s_menu+_rx
		clc
		adc MEM_TEMP+2
		tax
		
		lda MEM_TEMP+2
		clc
		adc #4
		sta MEM_TEMP+2
		
		sep #$20
		
		lda s_item+_itemTile,x
		and #$F0
		lsr
		lsr
		lsr
		;lda s_menu+_rpal+0
		;asl
		
		ora #$31
		sta MEM_OAM+_sprext
		
		
		lda s_item+_itemTile,x
		and #$0F
		asl a
		clc
		adc #$A0
		sta MEM_OAM+_sprtile
		
		plx
		
		
		
		lda #$10
		sta MEM_OAM+_sprsz
		
		jsl LKS_OAM_Draw
		
		txa
		clc
		adc s_menu+_eangle
		tax
	
		dec MEM_TEMP
		lda MEM_TEMP
		cmp #0
	bne -

	rtl
	
	;-------------
	ldx s_menu+_angle
	Draw_icon $A0 $00

	lda s_menu+_nring
	cmp #2
	bmi +
		Draw_icon $A2 $01
	+:
	lda s_menu+_nring
	cmp #3
	bmi +
		Draw_icon $A4 $02
	+:
	
	lda s_menu+_nring
	cmp #4
	bmi +
		Draw_icon $A6 $03
	+:
	lda s_menu+_nring
	cmp #5
	bmi +
		Draw_icon $A8 $04
	+:
	
	lda s_menu+_nring
	cmp #6
	bmi +
		Draw_icon $AA $05
	+:
	lda s_menu+_nring
	cmp #7
	bmi +
		Draw_icon $AC $06
	+:
	
	lda s_menu+_nring
	cmp #8
	bmi +
		Draw_icon $AE $07
	+:
	

	rtl
	
Menu_icon3:

	
	rep #$20
	
	lda s_menu+_ringi
	sec
	sbc #4
	asl
	asl
	eor MEM_TEMP
	sta MEM_TEMP+2
	
	lda s_menu+_ringi
	sec
	sbc #5
	asl
	asl
	asl
	asl
	asl
	asl
	asl
	asl
	asl
	sta MEM_TEMP
	
	lda s_menu+_angle
	clc
	adc MEM_TEMP
	clc
	adc MEM_TEMP+2
	asl
	tax
	
	
	sec
	sbc s_menu+_angle
	clc
	adc #$200
	sta MEM_TEMPFUNC+4
	
	
	sep #$20
	Draw_icon3 $A0 $00
	
	lda s_menu+_nring
	cmp #2
	bmi +
		Draw_icon3 $A2 $01
	+:
	lda s_menu+_nring
	cmp #3
	bmi +
		Draw_icon3 $A4 $02
	+:
	
	lda s_menu+_nring
	cmp #4
	bmi +
		Draw_icon3 $A6 $03
	+:
	lda s_menu+_nring
	cmp #5
	bmi +
		Draw_icon3 $A8 $04
	+:
	
	lda s_menu+_nring
	cmp #6
	bmi +
		Draw_icon3 $AA $05
	+:
	lda s_menu+_nring
	cmp #7
	bmi +
		Draw_icon3 $AC $06
	+:
	
	lda s_menu+_nring
	cmp #8
	bmi +
		Draw_icon3 $AE $07
	+:
	
	rtl
	
Menu_icon2:

	

	rep #$20
	lda #4
	sec
	sbc s_menu+_ringi
	asl
	asl
	eor #$FF
	sta MEM_TEMP
	
	lda s_menu+_angle
	clc
	;adc MEM_TEMP
	tax
	sep #$20
	
	Draw_icon2 $A0 $00
	
	lda s_menu+_nring
	cmp #2
	bmi +
		Draw_icon2 $A2 $01
	+:
	lda s_menu+_nring
	cmp #3
	bmi +
		Draw_icon2 $A4 $02
	+:
	
	lda s_menu+_nring
	cmp #4
	bmi +
		Draw_icon2 $A6 $03
	+:
	lda s_menu+_nring
	cmp #5
	bmi +
		Draw_icon2 $A8 $04
	+:
	
	lda s_menu+_nring
	cmp #6
	bmi +
		Draw_icon2 $AA $05
	+:
	lda s_menu+_nring
	cmp #7
	bmi +
		Draw_icon2 $AC $06
	+:
	
	lda s_menu+_nring
	cmp #8
	bmi +
		Draw_icon2 $AE $07
	+:
	
	rtl
	
Menu_OAM_init:

	;-----------
	ldx MEM_OAM+$10+$6
	
	ldy #0
	-:
		cpx #0
		beq +
		
		cpx #$40
		beq +
		
		cpx #$80
		beq +
		
		phy
		
		rep #$20
		lda s_perso+_oam,x
		tay
		sep #$20
		cpy #0
		beq ++
		
		lda s_perso+_flip,x
		and #$F1
		ora #$06
		sta MEM_OAML+3,y
		sta MEM_OAML+7,y
		sta MEM_OAML+11,y
		sta MEM_OAML+15,y
		
		++:
		ply
		
		+:
		
		rep #$20
		txa
		clc
		adc #$40
		tax
		sep #$20
		
		iny
		cpy #9
	bne -
	
	

	rtl
	
	

