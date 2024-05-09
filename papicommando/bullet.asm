
bullet_init_speed:

	rep #$20
	lda #0
	sta MEM_TEMP+2
	sta MEM_TEMP+0
	
	lda MEM_TEMP+4
	cmp #0
	bne +
		lda MEM_TEMP+6
		sta MEM_TEMP+2
		bra ++
	+:
	cmp #1
	bne +
		lda MEM_TEMP+6
		eor #$FFFF
		sta MEM_TEMP+2
		bra ++
	+:
	cmp #2
	bne +
		lda MEM_TEMP+6
		eor #$FFFF
		sta MEM_TEMP
		bra ++
	+:
	cmp #3
	bne +
		lda MEM_TEMP+6
		sta MEM_TEMP
		bra ++
	+:
	cmp #4
	bne +
		lda MEM_TEMP+6
		sta MEM_TEMP
		sta MEM_TEMP+2
		bra ++
	+:
	cmp #6
	bne +
		lda MEM_TEMP+6
		sta MEM_TEMP+2
		eor #$FFFF
		sta MEM_TEMP+0
		bra ++
	+:
	cmp #5
	bne +
		lda MEM_TEMP+6
		sta MEM_TEMP+0
		eor #$FFFF
		sta MEM_TEMP+2
		bra ++
	+:
	cmp #7
	bne +
		lda MEM_TEMP+6
		eor #$FFFF
		sta MEM_TEMP+2
		sta MEM_TEMP+0
		bra ++
	+:
		
	++:
	
	lda MEM_TEMP
	sta LKS_BULLET.VX,x
	
	lda MEM_TEMP+2
	sta LKS_BULLET.VY,x
	sep #$20
	
	rts
	
bullet_init_direction:
	
	stz MEM_TEMP+8
	stz MEM_TEMP+10
	stz MEM_TEMP+8+1
	stz MEM_TEMP+10+1
	
	lda MEM_TEMP+4
	cmp #0
	bne +
		lda #13
		sta MEM_TEMP+8
		lda #22
		sta MEM_TEMP+10
		bra ++
	+:
	cmp #1
	bne +
		lda #12
		sta MEM_TEMP+8
		lda #0
		sta MEM_TEMP+10
		bra ++
	+:
	cmp #2
	bne +
		lda #0
		sta MEM_TEMP+8
		lda #14
		sta MEM_TEMP+10
		bra ++
	+:
	cmp #3
	bne +
		lda #24
		sta MEM_TEMP+8
		lda #14
		sta MEM_TEMP+10
		bra ++
	+:
	cmp #4
	bne +
		lda #24
		sta MEM_TEMP+8
		lda #20
		sta MEM_TEMP+10
		bra ++
	+:
	cmp #6
	bne +
		lda #0
		sta MEM_TEMP+8
		lda #20
		sta MEM_TEMP+10
		bra ++
	+:
	cmp #5
	bne +
		lda #24
		sta MEM_TEMP+8
		lda #12
		sta MEM_TEMP+10
		bra ++
	+:
	cmp #7
	bne +
		lda #0
		sta MEM_TEMP+8
		lda #12
		sta MEM_TEMP+10
		bra ++
	+:
	++:
	

	rts
	
	

	
bullet_init_pos:

	rep #$20
	lda LKS_SPRITE.X,y
	clc
	adc MEM_TEMP+8
	sec
	sbc LKS_BG.x
	sta MEM_TEMP
	
	lda LKS_SPRITE.Y,y
	clc
	adc MEM_TEMP+10
	sec
	sbc LKS_BG.y
	sta MEM_TEMP+2
	sep #$20
	
	stz MEM_RETURN
	lda MEM_TEMP+0+1
	cmp #0
	beq +
		lda #1
		sta MEM_RETURN
		rts
	+:
	lda MEM_TEMP+0
	cmp #$FF
	bne +
		lda #1
		sta MEM_RETURN
		rts
	+:
	
	lda MEM_TEMP+2+1
	cmp #0
	beq +
		lda #1
		sta MEM_RETURN
		rts
	+:
	lda MEM_TEMP+2
	cmp #$E0
	bcc +
		lda #1
		sta MEM_RETURN
		rts
	+:
	
	lda MEM_TEMP
	sta LKS_BULLET.X+1,x
	
	lda MEM_TEMP+2
	sta LKS_BULLET.Y+1,x
	
	rts

.MACRO BULLET_INIT_ARRAY

	.DEFINE CNT \1

.REPT \2
	LKS_BULLET_INIT CNT,\3,$2F

.REDEFINE CNT CNT+1
.ENDR
.UNDEFINE CNT
		
.ENDM

Bullet_Init:
	lda #10
	sta LKS_BULLET.n

	;bullet Papi & Mami
	BULLET_INIT_ARRAY 0,$10,$E0
	
	;bullet Ennemi
	BULLET_INIT_ARRAY $10,$10,$F0
	
	
	rts
	
.MACRO BULLET_DRAW_ARRAY

	.DEFINE CNT \1

.REPT \2
	LKS_BULLET_DRAW_BG CNT

.REDEFINE CNT CNT+1
.ENDR
.UNDEFINE CNT
		
.ENDM
Draw_Bullet:
	
	;Papi & Mami
	BULLET_DRAW_ARRAY 0,7
	BULLET_DRAW_ARRAY 8,7
	
	BULLET_DRAW_ARRAY $10,$10
	rts

.MACRO BULLET_COLLISION_ARRAY

	.DEFINE CNT \1

.REPT \2
	ldx #CNT
	jsl LKS_Collision_Map_Bullet

.REDEFINE CNT CNT+2
.ENDR
.UNDEFINE CNT
.ENDM
		
Collision_Bullet:

	lda LKS.clockf
	and #$03
	cmp #0
	bne +
		jsr Collision_Bullet1
		rts
	+:
	cmp #1
	bne +
		jsr Collision_Bullet2
		rts
	+:
	cmp #2
	bne +
		jsr Collision_Bullet3
		rts
	+:
	cmp #3
	bne +
		jsr Collision_Bullet4
		rts
	+:
	
	rts
	
	
Collision_Bullet1:

	BULLET_COLLISION_ARRAY 0,7
	rts
	
Collision_Bullet2:

	BULLET_COLLISION_ARRAY $10,7
	rts
	
Collision_Bullet3:

	BULLET_COLLISION_ARRAY $20,8
	rts
	
Collision_Bullet4:

	BULLET_COLLISION_ARRAY $30,8
	rts
	


