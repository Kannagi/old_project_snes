
IA_Tir:
	
	ldx SCharacterExt.index
	lda SCharacter.hp,x
	cmp #$0
	bne +
		rts
	+:
	lda SCharacter.direction,x 
	sta MEM_TEMP+4
	
	
	ldx SCharacterExt.frameenable
	lda SCharacterExt.cadence,x
	ina
	sta SCharacterExt.cadence,x
	cmp #6
	beq +
		rts
	+:
	stz SCharacterExt.cadence,x
	
	
	ldx SCharacterExt.idbullet
	lda LKS_BULLET.Y+1,x
	cmp #$E0
	beq +
		rep #$20
		txa
		clc
		adc #$10
		tax
		sep #$20
		lda LKS_BULLET.Y+1,x
		cmp #$E0
		beq +
			rts
	+:
	
	lda #0
	sta MEM_TEMP+6
	lda #2
	sta MEM_TEMP+7
	stz MEM_TEMP+5

	jsr bullet_init_direction
	jsr bullet_init_pos
	
	lda MEM_RETURN
	cmp #0
	beq +
		rts
	+:
	
	jsr bullet_init_speed
		
	rts
	

IA_hit:

	ldx SCharacterExt.index
	

	lda LKS_SPRITE.Anim_act,y
	cmp #12
	bne +
		lda LKS_SPRITE.Anim_i,y
		cmp #3
		bne +
			lda #$0
			sta LKS_SPRITE.Anim_type,y
			
			lda SCharacter.oldanim,x
			sta LKS_SPRITE.Anim_act,y
			
			lda SCharacter.hp,x
			cmp #0
			bne +
				
				lda #10
				sta LKS_SPRITE.Anim_act,y
				
				
				rts
	+:
	
	;anim mort 1
	lda LKS_SPRITE.Anim_act,y
	cmp #10
	bne +
		lda #6
		sta LKS_SPRITE.Anim_n,y
		lda #2
		sta LKS_SPRITE.Anim_type,y
		lda LKS_SPRITE.Anim_end,y
		cmp #0
		beq +
			lda #14
			sta LKS_SPRITE.Anim_act,y
			
			rts
	+:
	;anim mort 2
	lda LKS_SPRITE.Anim_act,y
	cmp #14
	bne ++
		lda LKS_SPRITE.Anim_end,y
		cmp #0
		beq ++
			lda #0
			sta LKS_SPRITE.Anim_act,y
			sta LKS_SPRITE.Anim_type,y
			
			lda #4
			sta LKS_SPRITE.Anim_n,y
			lda #3
			sta SCharacter.enable,x
			
			lda LKS_SPRITE.Enable,y
			and #$FF-8
			sta LKS_SPRITE.Enable,y
			
			lda #-32
			ldx LKS_SPRITE_CTRL.oam
			jsl LKS_OAM4_Clear
	++:
	rts
