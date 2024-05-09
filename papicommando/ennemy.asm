
Ennemy:

	ldx #0
	-:
		stx SCharacterExt.frameenable
		
		phx
		jsr Screen_ennemy 
		plx
		

		inx
		inx
		cpx #2*8
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
	
	ldx SCharacterExt.frameenable
	lda #0
	sta LKS_OAM.enable,x
	
	rep #$20
	lda LKS_OAM.Address+4,x
	cmp #$FFFF
	bne +
		sep #$20
		rts
		rep #$20
	+:
	tay
	sty MEM_TEMPFUNC
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
	clc
	adc #$20
	sta SCharacterExt.idbullet
	
	sep #$20
		
	lda LKS_SPRITE.Enable,y
	bit #$04	
	bne +
		ldx SCharacterExt.frameenable
		rep #$20
		lda #$FFFF
		sta LKS_OAM.Address+4,x
		sep #$20
		rts
	+:
	
	lda LKS_SPRITE.Enable,y
	bit #$08	
	bne +
		ldx SCharacterExt.frameenable
		rep #$20
		lda #$FFFF
		sta LKS_OAM.Address+4,x
		sep #$20
		rts
	+:
	
	ldx SCharacterExt.frameenable
	lda #1
	sta LKS_OAM.enable,x
	
	
	lda LKS_OAM.etile,x
	sta MEM_TEMP
	
	rep #$20
	lda LKS_OAM.evram,x
	tyx
	sta LKS_DMA.Dst1,x
	sep #$20
	
	lda MEM_TEMP
	sta LKS_SPRITE.Tile,x
	
	lda SCharacterExt.framediv
	cmp SCharacterExt.frameenable
	bne +
		jsr IA_move
		jsr IA_Tir
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
	jsl LKS_Sprite_Move
	
	
	jsl LKS_Sprite_Draw_32x32_Meta
		
	jsl LKS_Sprite_Anim
	jsr IA_hit
	jsl LKS_Sprite_DMA
	
	jsr Test_collision_bullet_Player
	
	inc LKS_SPRITE_CTRL.n
	

	rts
	
Ennemy_Sort_Init
	ldy #$20*(2+0)
	jsl LKS_Ennemy_Screen_Sort_Inv
	jsl LKS_Ennemy_Screen_Sort_Inv
	jsl LKS_Ennemy_Screen_Sort_Inv
	jsl LKS_Ennemy_Screen_Sort_Inv
	
	jsl LKS_Ennemy_Screen_Sort_Inv
	jsl LKS_Ennemy_Screen_Sort_Inv
	jsl LKS_Ennemy_Screen_Sort_Inv
	jsl LKS_Ennemy_Screen_Sort_Inv
	rts
	
Ennemy_Sort:
	lda LKS.clockf
	and #$07
	cmp #0
	bne +
		ldy #$20*(2+0)
		jsl LKS_Ennemy_Screen_Sort
		rts
	+:
	cmp #1
	bne +
		ldy #$20*(2+8)
		jsl LKS_Ennemy_Screen_Sort
		rts
	+:
	cmp #2
	bne +
		ldy #$20*(2+16)
		jsl LKS_Ennemy_Screen_Sort
		rts
	+:
	cmp #3
	bne +
		ldy #$20*(2+24)
		jsl LKS_Ennemy_Screen_Sort
		rts
	+:
	cmp #4
	bne +
		ldy #$20*(2+32)
		jsl LKS_Ennemy_Screen_Sort
		rts
	+:
	cmp #5
	bne +
		ldy #$20*(2+40)
		jsl LKS_Ennemy_Screen_Sort
		rts
	+:
	cmp #6
	bne +
		ldy #$20*(2+48)
		jsl LKS_Ennemy_Screen_Sort
		rts
	+:
	cmp #7
	bne +
		ldy #$20*(2+56)
		jsl LKS_Ennemy_Screen_Sort
		rts
	+:
	rts
