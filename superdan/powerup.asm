
Power_up:

	lda LKS_SPRITE.X,y
	clc
	adc LKS_SPRITE.VX,y
	sta LKS_SPRITE.X,y
	cmp #0
	bne +
		lda LKS_SPRITE.VX,y
		eor #$FF
		ina
		sta LKS_SPRITE.VX,y
		bra ++
	+:
	and #$F0
	cmp #$F0
	bne ++
		lda LKS_SPRITE.VX,y
		eor #$FF
		ina
		sta LKS_SPRITE.VX,y
	++:
	
	lda LKS_SPRITE.Y,y
	clc
	adc LKS_SPRITE.VY,y
	sta LKS_SPRITE.Y,y
	cmp #0
	bne +
		lda LKS_SPRITE.VY,y
		eor #$FF
		ina
		sta LKS_SPRITE.VY,y
		bra ++
	+:
	and #$D0
	cmp #$D0
	bne ++
		lda LKS_SPRITE.VY,y
		eor #$FF
		ina
		sta LKS_SPRITE.VY,y
	++:
	
	jsl LKS_Sprite_Draw_Fast_Meta2x2
	
	rts

Power_up_collision:
	ldy #0
	LKS_HITBOX_INIT_POS 12,12,16,16,10,10
	
	lda #1
	sta MEM_RETURN
	
	jsr Power_up_collision_test
	
	lda MEM_RETURN
	cmp #0
	bne +
		rep #$20
		lda MEM_RETURN+2
		clc
		adc MEM_RETURN+4
		tax
		sep #$20
				
		lda #$E0
		sta LKS_SPRITE.Y,x
		
		lda #0
		sta LKS_SPRITE.X,x
		sta LKS_SPRITE.VX,x
		sta LKS_SPRITE.VY,x
		
		rep #$20
		lda  MEM_RETURN+4
		lsr
		lsr
		lsr
		lsr
		lsr
		and #$FF
		tax
		sep #$20
		lda Bonus.power,x
		cmp #0
		bne ++
			lda Ship.weapon
			ina
			cmp #4
			beq +
			sta Ship.weapon
			bra +
		++:
		lda Ship.bomb
		ina
		cmp #4
		beq +
		sta Ship.bomb
	+:
	
	rts
	
Power_up_collision_test:
	ldx #$20*16
	LKS_HITBOX_FAST_OBJ 0
	LKS_HITBOX_FAST_OBJ 1
	LKS_HITBOX_FAST_OBJ 2
	rts
	
