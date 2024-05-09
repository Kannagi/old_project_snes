
Player_Papi:
	ldy #$20*0
	
	LKS_SPRITE_CONFIG 32,32,128,0
	
	sty SCharacterExt.index
	
	rep #$20
	lda LKS_OAM.oam
	clc
	adc #$140
	sta LKS_SPRITE_CTRL.oam
	
	lda LKS_SPRITE.PY
	sta LKS_OAM.y

	
	sep #$20
	
	jsl LKS_Sprite_limite
	jsl LKS_Collision_Map
	jsl LKS_Sprite_Move
	jsl LKS_Background_Camera
	jsl LKS_Scrolling_limite
	
	lda SCharacter.chrono
	cmp #0
	beq +
		lda SCharacter.chrono
		ina
		sta SCharacter.chrono
		cmp #60
		bne +
			stz SCharacter.chrono
	+:
	
	lda SCharacter.chrono
	bit #$02
	bne +
		jsl LKS_Sprite_Draw_32x32_Meta
		
	+:
	
	jsl LKS_Sprite_Anim
	jsl LKS_Sprite_DMA
	
	jsr Test_collision_bullet_Ennemy_Papi
	
	rts

Player_Mami:
	ldy #$20*1
	
	rep #$20
	lda LKS_OAM.oam+2
	clc
	adc #$140
	sta LKS_SPRITE_CTRL.oam
	
	lda LKS_SPRITE.PY,y
	sta LKS_OAM.y+2
	sep #$20
	
	rts
