
IA_move:
	rep #$20
	lda #0
	sta LKS_SPRITE.VX,y
	sta LKS_SPRITE.VY,y
	sep #$20
	
	ldx SCharacterExt.index
	lda SCharacter.hp,x
	cmp #0
	bne +
		rts
	+:
	lda LKS_SPRITE.Anim_act,y
	cmp #12
	bne +
		rts
	+:

	jsr IA_move_rand
	jsr IA_move_direction_change
	
	jsr IA_move_zone
	jsr IA_move_attack
	jsr IA_move_direction
	;jsr IA_move_attack_stop
	
	lda LKS_SPRITE.Anim_act,y
	sta SCharacter.oldanim,x
	rts
	
IA_move_attack:

	lda #1
	sta SCharacter.attack,x
	
	/*
	lda LKS_SPRITE.Y,y
	sbc LKS_SPRITE.Y
	
	bit #$8000
	beq +
		sta LKS_DEBUG
		sep #$20
		lda #0
		sta SCharacter.direction,x
		lda #0
		sta SCharacter.chrono,x
		rep #$20
	+:*/
	rts
	
IA_move_attack_stop:

	;anim direction
	lda SCharacter.attack,x
	cmp #0
	bne +
		rts
	+:
	rep #$20
	lda #$0
	sta LKS_SPRITE.VY,y
	sta LKS_SPRITE.VX,y
	sep #$20
	
	rts
	
IA_move_zone:
	

	rep #$20

	lda LKS_SPRITE.X,y
	sec
	sbc SCharacter.zonex,x
	cmp #64
	bmi +
		sep #$20
		lda #2
		sta SCharacter.direction,x
		lda #0
		sta SCharacter.chrono,x
		rep #$20
		bra ++
	+:
	cmp #-64
	bpl +
		sep #$20
		lda #3
		sta SCharacter.direction,x
		lda #0
		sta SCharacter.chrono,x
		rep #$20
		
	+:
	++:
	
	lda LKS_SPRITE.Y,y
	sec
	sbc SCharacter.zoney,x
	cmp #64
	bmi +
		sep #$20
		lda #1
		sta SCharacter.direction,x
		lda #0
		sta SCharacter.chrono,x
		rep #$20
		bra ++
	+:
	cmp #-64
	bpl +
		sep #$20
		lda #0
		sta SCharacter.direction,x
		lda #0
		sta SCharacter.chrono,x
		rep #$20
		
	+:
	++:
	
	sep #$20
	
	rts
	
IA_move_rand:
	;rand direction
	lda SCharacter.chrono,x
	ina
	sta SCharacter.chrono,x
	cmp #5
	bne +
	
		lda #0
		sta SCharacter.chrono,x
	
		lda SCharacter.flagcol,x
		cmp #0
		bne +
			;lda SCharacter.direction
			;sta SCharacter.direction,x
			LKS_RAND
			sta MEM_TEMP
			bit #$0C
			bne ++
				lda #1
				sta SCharacter.direction,x
				bra +
			++:
			bit #$30
			bne ++
				lda #2
				sta SCharacter.direction,x
				bra +
			++:
			bit #$C0
			bne ++
				lda #3
				sta SCharacter.direction,x
				bra +
			++:
			lda #0
			sta SCharacter.direction,x
	+:

	rts
	
IA_move_direction_change:
	;change direction collision
	lda SCharacter.flagcol,x
	cmp #0
	beq +
		
		lda #0
		sta SCharacter.chrono,x
		sta SCharacter.flagcol,x
		
		lda SCharacter.direction,x
		cmp #1
		bne ++
			lda #0
			sta SCharacter.direction,x
			rts
		++:
		
		cmp #0
		bne ++
			lda #1
			sta SCharacter.direction,x
			rts
		++:
		
		
		cmp #2
		bne ++
			lda #3
			sta SCharacter.direction,x
			rts
		++:
		
		cmp #3
		bne ++
			lda #2
			sta SCharacter.direction,x
			rts
		++:
	+:

	rts
IA_move_direction:

	;anim direction
	lda SCharacter.direction,x
	cmp #0
	bne +
		rep #$20
		lda #$1<<2
		sta LKS_SPRITE.VY,y
		sep #$20
		
		lda #0
		sta LKS_SPRITE.Anim_act,y
		rts
	+:
	cmp #1
	bne +
		rep #$20
		lda #$-1<<2
		sta LKS_SPRITE.VY,y
		sep #$20
		
		lda #4
		sta LKS_SPRITE.Anim_act,y
		rts
	+:
	cmp #2
	bne +
		rep #$20
		lda #$-1<<2
		sta LKS_SPRITE.VX,y
		sep #$20
		
		
		lda LKS_SPRITE.Flip,y
		and #$3F
		sta LKS_SPRITE.Flip,y
		lda #2
		sta LKS_SPRITE.Anim_act,y
		rts
	+:
	cmp #3
	bne +
		rep #$20
		lda #$1<<2
		sta LKS_SPRITE.VX,y
		sep #$20
		
		lda LKS_SPRITE.Flip,y
		ora #$40
		sta LKS_SPRITE.Flip,y
		
		lda #2
		sta LKS_SPRITE.Anim_act,y
		rts
	+:

	
	rts
