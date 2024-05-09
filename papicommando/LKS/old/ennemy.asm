
Ennemy:

	ldx #0
	-:
		
		stx SCharacterExt.frameenable
		
		
		
		rep #$20
		
		
		lda LKS_OAM.Address+4,x
		tay
		sep #$20
		LKS_SPRITE_CONFIG 32,32,128,0
		rep #$20


		lda LKS_OAM.oam+4,x
		clc
		adc #$140
		sta LKS_SPRITE_CTRL.oam

		lda LKS_SPRITE.PY,y
		sta LKS_OAM.y+4,x
		
		tya
		lsr ;$10
		sta SCharacterExt.index+0
		
		
		txa
		phx
		clc
		adc #$20
		sta SCharacterExt.idbullet
		
		
		sep #$20

		jsr Screen_ennemy 

		plx

		inx
		inx
		cpx #2*1
	bne -
	
	lda SCharacterExt.framediv
	ina
	ina
	cmp #16
	bne +
		lda #0
	+:
	sta SCharacterExt.framediv
		
	rts

Screen_ennemy:
	stz LKS_DEBUG+2
	lda LKS_SPRITE.Enable,y
	bit #$04	
	bne +
		rts
	+:
	
	
	
	lda SCharacterExt.framediv
	cmp SCharacterExt.frameenable
	bne +
		jsr IA_move
		;jsr IA_Tir
	+:
	
	jsl LKS_Sprite_limite
	
	ldx SCharacterExt.index
	lda SCharacter.flagcol,x
	cmp #0
	bne +
		lda MEM_RETURN
		sta SCharacter.flagcol,x
	+:
	
	jsl LKS_Collision_Map

	ldx SCharacterExt.index
	lda SCharacter.flagcol,x
	cmp #0
	bne +
		lda MEM_RETURN
		sta SCharacter.flagcol,x
	+:
	;jsl LKS_Sprite_Move
	
	
	jsl LKS_Sprite_Draw_32x32_Meta
		
	jsl LKS_Sprite_Anim
	jsr IA_hit
	jsl LKS_Sprite_DMA
	
	jsr Test_collision_bullet_Player
	

		lda #1
		sta LKS_DEBUG+2

	
	
	rts
	
Ennemy_up:
	ldx SCharacterExt.index
	lda #3
	sta SCharacter.hp,x
	
	rep #$20
	stz MEM_TEMP
	stz MEM_TEMP+2
	lda LKS_SPRITE.X,y
	sec
	sbc LKS_BG.x
	clc
	adc #32
	sta LKS_DEBUG+2
	bit #$8000
	beq +
		lda #1
		sta MEM_TEMP
		bra ++
	+:
	cmp #256+32
	bmi ++
		lda #1
		sta MEM_TEMP
	++:
	
	lda LKS_SPRITE.Y,y
	sec
	sbc LKS_BG.y
	clc
	adc #32
	bit #$8000
	beq +
		lda #1
		sta MEM_TEMP+2
		bra ++
	+:
	cmp #256+32
	bmi ++
		lda #1
		sta MEM_TEMP+2
	++:
	sep #$20
	
	ldx SCharacterExt.index
	lda MEM_TEMP
	cmp #$00
	beq +
		lda #0
		sta SCharacter.enable,x
		rts
	+:
	
	lda MEM_TEMP+2
	cmp #$00
	beq +
		lda #0
		sta SCharacter.enable,x
		rts
	+:
	rts
	
LKS_Ennemy_Enable:

	
	
	rep #$20
	clc
	/*
	lda LKS_SPRITE.X,y
	sec
	sbc LKS_BG.x
	sta MEM_TEMP
	adc #48
	bit #$8000
	beq +
		adc #32
		
		bit #$8000
		bne +
			sep #$20
			lda #1
			rtl
			rep #$20
	+:
	

	lda MEM_TEMP
	cmp #256+48
	bmi +
		cmp #256+48+32
		bpl +
			sep #$20
			lda #1
			rtl
			rep #$20
	+:
	*/
	lda LKS_SPRITE.Y,y
	sec
	sbc LKS_BG.y
	sta MEM_TEMP
	adc #48
	bit #$8000
	beq +
		adc #32
		bit #$8000
		bne +
			sep #$20
			lda #1
			rtl
			rep #$20
	+:

	lda MEM_TEMP
	cmp #224
	bmi +
		cmp #224+32
		bpl +
			sep #$20
			lda #1
			rtl
			rep #$20
	+:
	
	sep #$20
	
	lda #0

	rtl
	
.MACRO LKS_Ennemy_Screen_Sort_MC

	stz LKS_DEBUG
	lda LKS_SPRITE_CTRL.n
	cmp LKS_SPRITE_CTRL.nmax
	bmi +
		;rtl
	+:
	ldy #$20*\1
	lda LKS_SPRITE.Enable,y
	bit #$04
	bne ++
	
	jsl LKS_Ennemy_SC
	cmp #0
	bne +
		lda LKS_SPRITE.Enable,y
		and #$FF-4
		sta LKS_SPRITE.Enable,y
		bra ++
	+:
		cmp #1
		bne ++
			lda LKS_SPRITE.Enable,y
			ora #$04
			sta LKS_SPRITE.Enable,y
			inc LKS_SPRITE_CTRL.n
	++:
	/*
		lda LKS_SPRITE.Enable,y
		bit #$04
		bne ++
			lda LKS_SPRITE.Enable,y
			ora #$04
			sta LKS_SPRITE.Enable,y
			inc LKS_SPRITE_CTRL.n
			bra +
		++:
		
	+:*/
	
.ENDM
LKS_Ennemy_Screen_Sort:
	

	LKS_Ennemy_Screen_Sort_MC 2
	rtl
	LKS_Ennemy_Screen_Sort_MC 3
	
	LKS_Ennemy_Screen_Sort_MC 4
	LKS_Ennemy_Screen_Sort_MC 5
	LKS_Ennemy_Screen_Sort_MC 6
	LKS_Ennemy_Screen_Sort_MC 7
	

	rtl

LKS_Ennemy_SC:


	rep #$20
	
	lda LKS_SPRITE.X,y
	sec
	sbc LKS_BG.x
	sta MEM_TEMPFUNC+$2
	
	cmp #-64
	bpl +
		bra ++
	+:
	cmp #256+64
	bmi +
		bra ++
	+:
	
	lda LKS_SPRITE.Y,y
	sec
	sbc LKS_BG.y
	sta MEM_TEMPFUNC+$0
	
	cmp #-64
	bpl +
		bra ++
	+:
	cmp #224+64
	bmi +
		bra ++
	+:
	
	sep #$20
	
	jsl Personnage_limite_ecranSC
	
	rtl
	
	++:
	sep #$20
	lda #0
	rtl

	
Personnage_limite_ecranSC:

	
	;Y
	rep #$20
	lda MEM_TEMPFUNC+$0
	clc
	adc #$10
	sta MEM_TEMP
	adc #$10
	sta MEM_TEMP+2
	sep #$20
	
	lda MEM_TEMP+1
	cmp #$01
	bmi +
		lda #1
		rtl
	+:
	
	lda MEM_TEMP+1+2
	cmp #$00
	bpl +
		lda #1
		rtl
	+:
	
	;X right
	lda MEM_TEMPFUNC+$2+1
	cmp #$01
	bmi +
		lda #1
		rtl
	+:
	
	;X left
	rep #$20
	lda MEM_TEMPFUNC+$2
	clc
	adc #$30
	sta MEM_TEMP
	sep #$20
		
	lda MEM_TEMP+1
	cmp #$0
	bpl +
		lda #1
		rtl
	+:
	
	lda #2
	rtl
	
