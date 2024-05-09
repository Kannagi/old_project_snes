
Test_collision_bullet_Player:

	ldx SCharacterExt.index
	lda SCharacter.hp,x
	cmp #$0
	bne +
		rts
	+:
	
	lda LKS_SPRITE.Anim_act,y
	cmp #12
	bne +
		rts
	+:
	
	
	LKS_HITBOX_INIT 30,28,4,4
	
	lda LKS.clockf
	bit #$01
	beq +
		jsr Test_collision1
		bra ++
	+:
		jsr Test_collision2
	++:
	sep #$20
	

	lda MEM_RETURN
	cmp #0
	bne +
		
		rep #$20
		lda #$E000
		
		sta LKS_BULLET.Y,x
		lda #0
		sta LKS_BULLET.X,x
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		sep #$20
		
		lda #12
		sta LKS_SPRITE.Anim_act,y
		
		lda #2
		sta LKS_SPRITE.Anim_i,y
		
		lda #0
		sta LKS_SPRITE.Anim_l,y
		
		lda #$80+$40
		sta LKS_SPRITE.Anim_type,y
		
		ldx SCharacterExt.index
		lda SCharacter.hp,x
		dec a
		sta SCharacter.hp,x
		
	+:
		
	rts
	
Test_collision_bullet_Ennemy_Papi:

	ldx SCharacterExt.index
	lda SCharacter.hp,x
	cmp #$0
	bne +
		rts
	+:
	
	lda LKS_SPRITE.Anim_act
	cmp #20
	bne +
		rts
	+:
	cmp #22
	bne +
		rts
	+:
	
	lda SCharacter.chrono
	cmp #0
	beq +
		rts
	+:
	
	LKS_HITBOX_INIT 30,28,4,4
	
	lda LKS.clockf
	bit #$01
	beq +
		jsr Test_collision3A
		bra ++
	+:
		jsr Test_collision3B
	++:
	sep #$20

	lda MEM_RETURN
	cmp #0
	bne +
		
		rep #$20
		lda #$E000
		sta LKS_BULLET.Y,x
		lda #0
		sta LKS_BULLET.X,x
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		sep #$20
		
		inc SCharacter.chrono
		
		ldx SCharacterExt.index
		lda SCharacter.hp,x
		dec a
		sta SCharacter.hp,x
		
		lda SCharacter.hp
		cmp #0
		bne +
			lda #20
			sta LKS_SPRITE.Anim_act
			stz SCharacter.chrono
	+:
		
	rts

Test_collision1:
	
	rep #$20
	lda #1
	sta MEM_RETURN
	
	LKS_HITBOX_BULLET 0
	
	LKS_HITBOX_BULLET 1
	LKS_HITBOX_BULLET 2
	LKS_HITBOX_BULLET 3
	
	LKS_HITBOX_BULLET 4
	LKS_HITBOX_BULLET 5
	LKS_HITBOX_BULLET 6

	sep #$20
	
	rts

Test_collision2:
	
	rep #$20
	lda #1
	sta MEM_RETURN
	
	LKS_HITBOX_BULLET 8
	
	LKS_HITBOX_BULLET 9
	LKS_HITBOX_BULLET 10
	LKS_HITBOX_BULLET 11
	
	LKS_HITBOX_BULLET 12
	LKS_HITBOX_BULLET 13
	LKS_HITBOX_BULLET 14

	sep #$20
	
	rts
	
Test_collision3A:
	
	rep #$20
	lda #1
	sta MEM_RETURN
	
	LKS_HITBOX_BULLET $10
	LKS_HITBOX_BULLET $11
	LKS_HITBOX_BULLET $12
	LKS_HITBOX_BULLET $13
	
	LKS_HITBOX_BULLET $14
	LKS_HITBOX_BULLET $15
	LKS_HITBOX_BULLET $16
	LKS_HITBOX_BULLET $17

	sep #$20
	
	rts

Test_collision3B:
	
	rep #$20
	lda #1
	sta MEM_RETURN

	LKS_HITBOX_BULLET $18
	LKS_HITBOX_BULLET $19
	LKS_HITBOX_BULLET $1A
	LKS_HITBOX_BULLET $1B
	
	LKS_HITBOX_BULLET $1C
	LKS_HITBOX_BULLET $1D
	LKS_HITBOX_BULLET $1E
	LKS_HITBOX_BULLET $1F
	sep #$20
	
	rts
