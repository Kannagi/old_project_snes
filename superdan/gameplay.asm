

Gameplay:
	lda #-32
	LKS_OAM4_Clear $19
	
	lda LKS_BULLET.i
	ina
	cmp #$FE
	beq +
		sta LKS_BULLET.i
	+:
	
	rep #$20
	lda #0
	sta LKS_SPRITE.VX
	sta LKS_SPRITE.VY
	
	lda #$C
	sta MEM_TEMP
	sep #$20
	
	
	
	lda LKS_STDCTRL+_SELECT
	cmp #1
	bne +
		lda Ship.invincible
		eor #$FF
		sta Ship.invincible
	+:
	
	lda LKS_STDCTRL+_A
	cmp #2
	bne +
		lda #$8
		sta MEM_TEMP
	+:
	
	stz Ship.laser
	lda LKS_STDCTRL+_B
	cmp #2
	bne +
		lda #$4+2
		;sta MEM_TEMP
		;sta Ship.laser
	+:
	
	
	
	lda LKS_STDCTRL+_UP
	cmp #2
	bne +
		rep #$20
		lda LKS_SPRITE.VY
		sec
		sbc MEM_TEMP
		sta LKS_SPRITE.VY
		sep #$20
	+:
	
	lda LKS_STDCTRL+_DOWN
	cmp #2
	bne +
		rep #$20
		lda LKS_SPRITE.VY
		clc
		adc MEM_TEMP
		sta LKS_SPRITE.VY
		sep #$20
	+:
	
	lda #0
	sta Ship.direction
	
	lda LKS_STDCTRL+_LEFT
	cmp #2
	bne +
		rep #$20
		lda LKS_SPRITE.VX
		sec
		sbc MEM_TEMP
		sta LKS_SPRITE.VX
		sep #$20
		
		lda #1
		sta Ship.direction
	+:
	
	lda LKS_STDCTRL+_RIGHT
	cmp #2
	bne +
		rep #$20
		lda LKS_SPRITE.VX
		clc
		adc MEM_TEMP
		sta LKS_SPRITE.VX
		sep #$20
		
		lda #2
		sta Ship.direction
	+:
	
	
	rep #$20
	lda LKS_SPRITE.X
	cmp #1
	bpl +
		stz LKS_SPRITE.VX+0
		lda #1
		sta LKS_SPRITE.X
		asl
		asl
		sta LKS_SPRITE.PX
	+:
	lda LKS_SPRITE.X
	cmp #255-32
	bmi +
		stz LKS_SPRITE.VX+0
		lda #254-32
		sta LKS_SPRITE.X
		asl
		asl
		sta LKS_SPRITE.PX
	+:
	lda LKS_SPRITE.Y
	cmp #$20-8
	bpl +
		stz LKS_SPRITE.VY+0
		lda #$21-8
		sta LKS_SPRITE.Y
		asl
		asl
		sta LKS_SPRITE.PY
	+:
	lda LKS_SPRITE.Y
	cmp #225-32
	bmi +
		stz LKS_SPRITE.VY+0
		lda #224-32
		sta LKS_SPRITE.Y
		asl
		asl
		sta LKS_SPRITE.PY
	+:
	sep #$20
	
	
	lda LKS_STDCTRL+_B
	cmp #1
	bne +
		lda LKS_SPRITE.Y
		sec
		sbc #32
		;sta Ship.lasery
	+:
	
	lda LKS_STDCTRL+_B
	cmp #2
	bne +
		;jsr Fire_ShipB
		;rts
	+:
	
	;jsr Fire_ShipB
	
	
	;-------------
	jsr Fire_Reset_Blast
	
	

	
	lda LKS_STDCTRL+_L
	cmp #1
	bne +
		
		lda Ship.weapon
		cmp #0
		beq +
		dea
		sta Ship.weapon
	+:
	
	lda LKS_STDCTRL+_R
	cmp #1
	bne +
		
		lda Ship.weapon
		cmp #3
		beq +
		ina
		sta Ship.weapon
	+:
	
	stz MEM_TEMP+1

	
	;tir
	lda LKS_STDCTRL+_A
	cmp #2
	bne +
		lda #1
		sta SFX.enable1
		
		lda LKS_BULLET.i
		cmp #8
		bcc +
		
		stz MEM_TEMP+1
		lda #0
		sta LKS_BULLET.i
		
		lda Ship.weapon
		cmp #0
		bne ++
			jsr Fire_Ship1
			bra +
		++:
		
		lda Ship.weapon
		cmp #1
		bne ++
			jsr Fire_Ship2
			bra +
		++:
		
		lda Ship.weapon
		cmp #2
		bne ++
			jsr Fire_Ship3
			bra +
		++:
		
		lda Ship.weapon
		cmp #3
		bne ++
			jsr Fire_ShipR4
			bra +
		++:
	+:

	rts
	
;Blast------------------------
.MACRO FIRE_RESET_BLAST

	lda LKS_BULLET.Y+(2*\1)
	cmp #$E000
	beq +
	clc
	lda LKS_BULLET.VX+(2*\1)
	adc LKS_BULLET.VY+(2*\1)
	cmp #0
	bne +
		lda #$E000
		sta LKS_BULLET.Y+(2*\1)
	+:
	
.ENDM

Fire_Reset_Blast:
	rep #$20
	
	FIRE_RESET_BLAST 0+76
	FIRE_RESET_BLAST 1+76
	FIRE_RESET_BLAST 2+76
	FIRE_RESET_BLAST 3+76
	FIRE_RESET_BLAST 4+76
	FIRE_RESET_BLAST 5+76
	
	sep #$20
	
	
	lda #$00
	sta LKS_BUF_OAMH+0+(76/4)
	sta LKS_BUF_OAMH+1+(76/4)
	
	rts
	
;Fire Blast--------------------------------
.MACRO FIRE_INIT_BLAST

	lda LKS_SPRITE.X
	sta LKS_BULLET.X+1+(2*\2)
	
	lda LKS_SPRITE.Y
	cmp #\1
	bcc +
	sec
	sbc #\1
	sta LKS_BULLET.Y+1+(2*\2) 
	
	
	lda #$C8
	sta LKS_BUF_OAML+2+($4*\2)
	
	bra ++
	+:
	lda #$E0
	sta LKS_BULLET.Y+1+(2*\2)
	lda #$0
	sta LKS_BULLET.Y+(2*\2)
	++:
	
	rep #$20
	lda #0
	sta LKS_BULLET.VX+(2*\2)
	sta LKS_BULLET.VY+(2*\2)
	sep #$20
	
.ENDM

Fire_ShipB:
	

	
	FIRE_INIT_BLAST 32,0+76
	FIRE_INIT_BLAST 64,1+76
	FIRE_INIT_BLAST 96,2+76
	FIRE_INIT_BLAST 128,3+76
	FIRE_INIT_BLAST 128+32,4+76

	
	lda #$CC
	sta LKS_BUF_OAML+2+(4*76)
	
	lda LKS_SPRITE.X
	sta LKS_BULLET.X+1+(2*5)+(76*2)
	
	lda #0
	sta LKS_BULLET.Y+1+(2*5)+(76*2)
	
	lda #$C8
	sta LKS_BUF_OAML+2+((76+5)*4)
	
	rep #$20
	lda #0
	sta LKS_BULLET.VX+(2*5)+(76*2)
	sta LKS_BULLET.VY+(2*5)+(76*2)
	sep #$20
	
	lda #$AA
	sta LKS_BUF_OAMH+(76/4)
	lda #$0A
	sta LKS_BUF_OAMH+1+(76/4)
	
	
	;stz Ship.lasery
	;stz Ship.lasery+1
	

	lda Ship.lasery
	dec a
	cmp #0
	beq +
		sta Ship.lasery
	+:
	
	

	rts

;Fire Bullet--------------------------------
.MACRO FIRE_INIT
	
	lda LKS_BULLET.Usable1+(\5)
	cmp #$E0
	bne +
		ply
		rts
	+:
	sta MEM_TEMP
	ldx MEM_TEMP

	lda LKS_SPRITE.X
	clc
	adc #\1
	sta LKS_BULLET.X+1,x
	
	lda LKS_SPRITE.Y
	sec
	sbc #\2
	sta LKS_BULLET.Y+1,x
	
	rep #$20
	lda #\3
	sta LKS_BULLET.VX,x
	
	lda #\4
	sta LKS_BULLET.VY,x
	
	txa
	asl
	tax
		
	tya
	sep #$20
	
	sta LKS_BUF_OAML+2,x
	
.ENDM

Fire_Ship1:
	lda #$10
	sta SFX.pitch1
	
	phy
	ldy #$C0
	FIRE_INIT $10-4,8,0,-$400,0
	ply
	rts
	
Fire_Ship2:
	lda #8
	sta SFX.pitch1
	
	phy
	ldy #$C1
	FIRE_INIT $08,8,0,-$400,0
	FIRE_INIT $10,8,0,-$400,1
	ply
	rts
	
Fire_Ship3:
	lda #4
	sta SFX.pitch1
	
	phy
	ldy #$C1
	FIRE_INIT $4,8,-$30,-$400,0
	FIRE_INIT $10-4,8,$00,-$400,1
	FIRE_INIT $18-4,8,+$30,-$400,2
	ply
	rts

Fire_Ship4:
	phy
	ldy #$C1
	FIRE_INIT $0,8,-$30,-$400,0
	FIRE_INIT $8,8,-$10,-$400,1
	FIRE_INIT $10,8,+$10,-$400,2
	FIRE_INIT $18,8,+$30,-$400,3
	ply
	rts


Fire_ShipR4:

	phy
	ldy #$D1


	;FIRE_INIT $C,8,0,-$680,0
	
	;FIRE_INIT $8,8,-$220,-$580,1
	;FIRE_INIT $10,8,$220,-$580,2

	FIRE_INIT $C,8,0,-$600,0
	
	FIRE_INIT $8,8,-$1E0,-$500,1
	FIRE_INIT $10,8,$1E0,-$500,2
	
	FIRE_INIT $0,8,-$380,-$400,3
	FIRE_INIT $18,8,$380,-$400,4
	
	

	ply
	
	rts
