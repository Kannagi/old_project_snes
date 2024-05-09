
Test_collision_bullet_Player:

	lda Ship.hit
	cmp #0
	beq +
		rts
	+:
	lda Ship.invincible
	cmp #0
	beq +
		rts
	+:
	
	LKS_HITBOX_INIT_POS 2,2,7,7,12+3,9+2
	
	lda #1
	sta MEM_RETURN
	
	
	jsr Test_collision0
	
	sep #$20
	

	lda MEM_RETURN
	cmp #0
	bne +
		
		rep #$20
		lda MEM_RETURN+2
		clc
		adc MEM_RETURN+4
		tax
		
		lda #$E000
		sta LKS_BULLET.Y,x
		
		lda #0
		sta LKS_BULLET.X,x
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		
		sep #$20
		
		lda #1
		sta Ship.hit
	+:
	
	;hitbox player/ennemy
	LKS_HITBOX_INIT_POS 4,16,32,16,14,0
	
	lda #1
	sta MEM_RETURN
	
	lda LKS.clockf
	bit #$01
	beq +
		jsr Test_collision0z
		bra ++
	+:
		jsr Test_collision1z
	++:
	
	
	lda MEM_RETURN
	cmp #0
	bne +
		
		lda #1
		sta Ship.hit
	+:

	rts
	
Test_collision_bullet_Ennemi:
	
	
	LKS_HITBOX_INIT2 32,32,8,8
	
	
	
	ldx SDAN.id
	lda ShipE.hp,x	
	cmp #0
	bne +
		rts
	+:
	
	
	lda #1
	sta MEM_RETURN
	
	lda LKS.clockf
	bit #$01
	beq +
		jsr Test_collision3
		bra ++
	+:
		jsr Test_collision4
	++:
	
	;jsr Test_collision3
	;jsr Test_collision4
	
	sep #$20
	

	lda MEM_RETURN
	cmp #0
	bne +
	
		rep #$20
		
		lda MEM_RETURN+2
		cmp #$FFFF
		beq ++
			lda MEM_RETURN+2
			clc
			adc MEM_RETURN+4
			tax
			
			phy
			
			ldy Impact.n 
			lda LKS_BULLET.Y,x
			sta Impact.y,y
			
			lda LKS_BULLET.X,x
			sta Impact.x,y
			
			lda Impact.n
			ina
			ina
			sta  Impact.n 
			cmp #10
			bne +++
				stz  Impact.n 
			+++:
			ply
		
			lda #$E000
			sta LKS_BULLET.Y,x
			
			lda #0
			sta LKS_BULLET.X,x
			sta LKS_BULLET.VX,x
			sta LKS_BULLET.VY,x
		++:
		
		
		sep #$20
		
		ldx SDAN.id
		dec ShipE.hp,x
		inc ShipE.hit,x
		
		LKS_BCD8_addi SDAN.score,$1,$0
		
	+:
	

	rts
	
Test_collision3:

	lda Ship.laser
	cmp #0
	beq +++
		rep #$20
		lda LKS_SPRITE.Y,y
		cmp #0
		bmi +
		
		cmp LKS_SPRITE.Y
		bpl +
		
		lda LKS_SPRITE.X,y
		adc #32
		cmp LKS_SPRITE.X
		bmi +
		
		sbc #64
		cmp LKS_SPRITE.X
		bpl +

		stz MEM_RETURN+0
		lda #$FFFF
		sta MEM_RETURN+2
		sep #$20
		rts
		+:
		sep #$20
		
		ldx #76*2
		jsr LKS_Bullet_Test_Fast12L
		bra ++
	+++:
		ldx #76*2
		jsr LKS_Bullet_Test_Fast12
	++:

	
	rts
	
Test_collision0z:

	LKS_HITBOX2 0
	LKS_HITBOX2 1
	LKS_HITBOX2 2
	LKS_HITBOX2 3
	
	LKS_HITBOX2 4
	LKS_HITBOX2 5
	rts
	
Test_collision1z:

	LKS_HITBOX2 6
	LKS_HITBOX2 7
	
	LKS_HITBOX2 8
	LKS_HITBOX2 9
	LKS_HITBOX2 10
	LKS_HITBOX2 11
	rts

Test_collision4:

	ldx #88*2
	jsr LKS_Bullet_Test_Fast12
	
	rts

Test_collision0:
	
	ldx #0*2
	jsr LKS_Bullet_Test_Fast12
		
	ldx #12*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #24*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #36*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #48*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #60*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #72*2
	jsr LKS_Bullet_Test_Fast4
	
	rts
	
Test_collision1:
	
	ldx #0*2
	jsr LKS_Bullet_Test_Fast12
		
	ldx #12*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #24*2
	jsr LKS_Bullet_Test_Fast12
	
	rts

Test_collision2:
	
	ldx #36*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #48*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #60*2
	jsr LKS_Bullet_Test_Fast12
	
	ldx #72*2
	jsr LKS_Bullet_Test_Fast4
	
	rts
	
LKS_Bullet_Test_Fast12L:
	rep #$20
	
	LKS_HITBOX_BULLET_FAST_OBJ 6
	LKS_HITBOX_BULLET_FAST_OBJ 7
	
	LKS_HITBOX_BULLET_FAST_OBJ 8
	LKS_HITBOX_BULLET_FAST_OBJ 9
	LKS_HITBOX_BULLET_FAST_OBJ 10
	LKS_HITBOX_BULLET_FAST_OBJ 11

	sep #$20
	rts

LKS_Bullet_Test_Fast12:
	rep #$20
	
	LKS_HITBOX_BULLET_FAST_OBJ 8
	LKS_HITBOX_BULLET_FAST_OBJ 9
	LKS_HITBOX_BULLET_FAST_OBJ 10
	LKS_HITBOX_BULLET_FAST_OBJ 11
	
LKS_Bullet_Test_Fast8:
	rep #$20
	
	LKS_HITBOX_BULLET_FAST_OBJ 4
	LKS_HITBOX_BULLET_FAST_OBJ 5
	LKS_HITBOX_BULLET_FAST_OBJ 6
	LKS_HITBOX_BULLET_FAST_OBJ 7
	
LKS_Bullet_Test_Fast4:
	rep #$20
	
	LKS_HITBOX_BULLET_FAST_OBJ 0
	LKS_HITBOX_BULLET_FAST_OBJ 1
	LKS_HITBOX_BULLET_FAST_OBJ 2
	LKS_HITBOX_BULLET_FAST_OBJ 3
	
	sep #$20
	rts
