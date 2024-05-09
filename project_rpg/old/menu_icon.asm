

.MACRO Set_item		
		
	lda #\2
	sta s_item+_itemID+\1
	
	lda #\3
	sta s_item+_itemType+\1
	
	lda #\4
	sta s_item+_itemNb+\1
	
	lda #\5
	sta s_item+_itemTile+\1
	
	
		
.ENDM

Menu_init_icon:

	Set_item _itemSum+4*0,0,0,0,$60
	Set_item _itemSum+4*1,0,0,0,$71
	Set_item _itemSum+4*2,0,0,0,$62
	Set_item _itemSum+4*3,0,0,0,$73
	
	Set_item _itemSum+4*4,0,0,0,$64
	Set_item _itemSum+4*5,0,0,0,$75
	Set_item _itemSum+4*6,0,0,0,$66
	Set_item _itemSum+4*7,0,0,0,$77
	
	
	Set_item _itemOption+4*0,0,0,0,$60
	Set_item _itemOption+4*1,0,0,0,$71
	Set_item _itemOption+4*2,0,0,0,$62
	Set_item _itemOption+4*3,0,0,0,$73
	
	Set_item _itemOption+4*4,0,0,0,$64
	Set_item _itemOption+4*5,0,0,0,$75
	Set_item _itemOption+4*6,0,0,0,$66
	Set_item _itemOption+4*7,0,0,0,$77
	
	Set_item _itemItem+4*0,0,0,0,$40
	Set_item _itemItem+4*1,0,0,0,$41
	Set_item _itemItem+4*2,0,0,0,$42
	Set_item _itemItem+4*3,0,0,0,$53
	
	Set_item _itemItem+4*4,0,0,0,$54
	Set_item _itemItem+4*5,0,0,0,$55
	Set_item _itemItem+4*6,0,0,0,$66
	Set_item _itemItem+4*7,0,0,0,$67

	rtl



.MACRO Draw_icon3		
		
	lda #\1
	sta MEM_TEMPFUNC
	lda s_menu+_rpal+\2
	asl
	ora #$31
	sta MEM_TEMPFUNC+1
	jsl Menu_draw_icon3
		
.ENDM


Menu_draw_icon3:

	rep #$20
	lda SinCosE.l ,x
	clc
	adc MEM_TEMPFUNC+$C
	sta MEM_TEMP
	lda #0
	sep #$20
	
	
	lda MEM_TEMP+1
	cmp #0
	beq ++++
		bra +
	++++:
	
	lda MEM_TEMP
	sta MEM_OAML,y
	iny
	
	;----------------------
	rep #$20
	lda SinCosE.l+$80,x
	
	clc
	adc MEM_TEMPFUNC+$E
	sta MEM_TEMP
	lda #0
	sep #$20
	
	lda MEM_TEMP
	cmp #$F0
	bmi ++++
		cmp #$0
		bpl ++++
		bra ++
	++++:
	
	lda MEM_TEMP+1
	cmp #0
	beq ++++
		bra ++
	++++:
	
	
	lda MEM_TEMP
	sta MEM_OAML,y
	iny
	
	
	
	;----------------------
	bra +++

	+:
		lda #0
		sta MEM_OAML,y
		iny
	++:
		lda #-16
		sta MEM_OAML,y
		iny
	+++:
	;----------------------
	
	lda MEM_TEMPFUNC
	sta MEM_OAML,y
	iny
	
	lda MEM_TEMPFUNC+1
	sta MEM_OAML,y
	iny
	
	rep #$20
	txa
	clc
	adc s_menu+_eangle
	adc s_menu+_eangle
	cmp MEM_TEMPFUNC+4
	bmi +
		sec
		sbc #$200
	+:
	
	tax
	sep #$20

	rtl
	
Menu_draw_icon2:


	stz MEM_TEMP+1
	stz MEM_TEMP
	
	lda SinCos.l ,x
	sta WRMPYB
	ora 0
	ora 0

	rep #$20
	lda RDMPYL
	clc
	adc MEM_TEMPFUNC+$C
	sta MEM_TEMP
	lda #0
	sep #$20
	
	
	lda MEM_TEMP+1
	cmp #0
	beq ++++
		bra +
	++++:
	
	lda MEM_TEMP
	sta MEM_OAML,y
	iny
	
	;----------------------
	lda SinCos.l+$40,x
	sta WRMPYB
	ora 0
	ora 0
	
	rep #$20
	lda RDMPYL
	clc
	adc MEM_TEMPFUNC+$E
	sta MEM_TEMP
	lda #0
	sep #$20
	
	lda MEM_TEMP
	cmp #$F0
	bmi ++++
		cmp #$0
		bpl ++++
		bra ++
	++++:
	
	lda MEM_TEMP+1
	cmp #0
	beq ++++
		bra ++
	++++:
	
	
	lda MEM_TEMP
	sta MEM_OAML,y
	iny
	
	
	
	;----------------------
	bra +++

	+:
		lda #0
		sta MEM_OAML,y
		iny
	++:
		lda #-16
		sta MEM_OAML,y
		iny
	+++:
	;----------------------
	
	lda MEM_TEMPFUNC
	sta MEM_OAML,y
	iny
	
	lda MEM_TEMPFUNC+1
	sta MEM_OAML,y
	iny
	
	rep #$20
	lda #0
	sep #$20
	
	txa
	clc
	adc s_menu+_eangle
	tax

	rtl

.MACRO Draw_icon2		
		
	lda #\1
	sta MEM_TEMPFUNC
	lda s_menu+_rpal+\2
	asl
	ora #$31
	sta MEM_TEMPFUNC+1
	jsl Menu_draw_icon2
		
.ENDM

Menu_draw_icon1:


	

	rep #$20
	lda SinCosmenu.l ,x
	and #$00FF
	clc
	adc MEM_TEMPFUNC+$C
	sta MEM_TEMP
	sep #$20
	pha
	
	lda MEM_TEMP+1
	cmp #0
	beq ++++
		pla
		bra +
	++++:
	
	pla
	
	sta MEM_OAML,y
	iny
	
	;----------------------

	
	rep #$20
	lda SinCosmenu.l+$40,x
	and #$00FF
	clc
	adc MEM_TEMPFUNC+$E
	sta MEM_TEMP
	
	
	
	lda MEM_TEMP
	cmp #$F0
	bmi ++++
		sep #$20
		bra ++
	++++:
	
	
	sep #$20
	pha
	
	
	
	lda MEM_TEMP+1
	cmp #0
	beq ++++
		pla
		bra ++
	++++:
	
	pla
	
	sta MEM_OAML,y
	iny
	
	
	
	;----------------------
	bra +++

	+:
		lda #0
		sta MEM_OAML,y
		iny
	++:
		lda #-24
		sta MEM_OAML,y
		iny
	+++:
	;----------------------
	
	lda MEM_TEMPFUNC
	sta MEM_OAML,y
	iny
	
	lda MEM_TEMPFUNC+1
	sta MEM_OAML,y
	iny
	
	txa
	clc
	adc s_menu+_eangle
	tax

	rtl

.MACRO Draw_icon		
		
	lda #\1
	sta MEM_TEMPFUNC
	
	lda s_menu+_rpal+\2
	asl
	ora #$31
	sta MEM_TEMPFUNC+1
	jsl Menu_draw_icon1
		
.ENDM



