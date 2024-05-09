
.MACRO LKS_HITBOX_INIT
	
	rep #$20

	lda LKS_SPRITE.X,y
	sec
	sbc #\3
	sta MEM_TEMP+4
	clc
	adc #\1+\3
	sta MEM_TEMP+6
	
	lda LKS_SPRITE.Y,y
	sec
	sbc #\4
	sta MEM_TEMP+0
	clc
	adc #\2+\4
	sta MEM_TEMP+2
	sep #$20
	
.ENDM

.MACRO LKS_HITBOX_INIT2
	
	rep #$20

	lda LKS_SPRITE.PX,y
	bit #$8000
	beq +
		lsr
		lsr
		ora #$C000
		bra ++
	+:
	lsr
	lsr
	++:
	sec
	sbc #\3
	sta MEM_TEMP+4
	clc
	adc #\1+\3
	sta MEM_TEMP+6
	
	lda LKS_SPRITE.PY,y
	bit #$8000
	beq +
		lsr
		lsr
		ora #$C000
		bra ++
	+:
	lsr
	lsr
	++:
	sec
	sbc #\4
	sta MEM_TEMP+0
	clc
	adc #\2+\4
	sta MEM_TEMP+2
	sep #$20
	
.ENDM

.MACRO LKS_HITBOX_INIT_POS
	
	rep #$20

	lda LKS_SPRITE.X,y
	sec
	sbc #\3-\5
	sta MEM_TEMP+4
	clc
	adc #\1+\3
	sta MEM_TEMP+6
	
	lda LKS_SPRITE.Y,y
	sec
	sbc #\4-\6
	sta MEM_TEMP+0
	clc
	adc #\2+\4
	sta MEM_TEMP+2
	sep #$20
	
.ENDM

.MACRO LKS_HITBOX_INIT_POS2
	
	rep #$20

	lda LKS_SPRITE.X,y
	sec
	sbc #\3-\5
	sta MEM_TEMP+4
	clc
	adc #\1+\3
	sta MEM_TEMP+6
	
	lda LKS_SPRITE.Y,y
	sec
	sbc #\4-\6
	sta MEM_TEMP+0
	clc
	adc #\2+\4
	sta MEM_TEMP+2
	sep #$20
	
.ENDM

.MACRO LKS_HITBOX2
	
	ldx #\1*$10
	lda ShipE.hp
	beq +
	
	ldy LKS_SPRITE_CTRL.id+(2*\1)
	lda LKS_SPRITE.Y,y
	
	cmp MEM_TEMP+0
	bmi +
	
	cmp MEM_TEMP+2
	bpl +
	
	lda LKS_SPRITE.X,y
	
	cmp MEM_TEMP+4
	bmi +
	
	cmp MEM_TEMP+6
	bpl +

	stz MEM_RETURN+0
	tyx
	stx MEM_RETURN+2
	rts
	+:
	
.ENDM


.MACRO LKS_HITBOX_IMM
	
	lda LKS_SPRITE.Y,y
	
	
	cmp #\3
	bmi +
	
	cmp #\4
	bpl +
	
	
	
	lda LKS_SPRITE.X,y
	
	cmp #\1
	bmi +
	
	cmp #\2
	bpl +

	rep #$20
	stz MEM_RETURN+0
	lda #$FFFF
	sta MEM_RETURN+2
	sep #$20
	rts
	+:
	
.ENDM


.MACRO LKS_HITBOX_BULLET
	
	lda LKS_BULLET.Y+1+(2*\1)
	and #$E0
	cmp #$E0
	beq +
	
	lda LKS_BULLET.Y+1+(2*\1)
	and #$FF
	adc LKS_BG.y
	cmp MEM_TEMP+0
	bmi +
	
	cmp MEM_TEMP+2
	bpl +
	
	lda LKS_BULLET.X+1+(2*\1)
	and #$FF
	adc LKS_BG.x
	cmp MEM_TEMP+4
	bmi +
	
	cmp MEM_TEMP+6
	bpl +

	stz MEM_RETURN+0
	ldx #(2*\1)
	stx MEM_RETURN+2
	
	rts
	+:
	
.ENDM

.MACRO LKS_HITBOX_BULLET_FAST_OBJ
	
	lda LKS_BULLET.Y+1+(2*\1),x ;6
	and #$FF ;3
	cmp MEM_TEMP+0 ;5
	bmi + ;3

	cmp MEM_TEMP+2
	bpl +
	
	lda LKS_BULLET.X+1+(2*\1),x ;6
	and #$FF ;3
	cmp MEM_TEMP+4
	bmi +

	
	cmp MEM_TEMP+6
	bpl +

	
	stz MEM_RETURN+0
	stx MEM_RETURN+2
	ldx #(2*\1)
	stx MEM_RETURN+4
	
	
	rts
	+:
	
.ENDM

.MACRO LKS_HITBOX_FAST_OBJ
	
	
	
	lda LKS_SPRITE.Y+($20*\1),x ;6
	cmp MEM_TEMP+0 ;5
	bmi + ;3

	cmp MEM_TEMP+2
	bpl +
	
	lda LKS_SPRITE.X+($20*\1),x ;6
	cmp MEM_TEMP+4
	bmi +

	
	cmp MEM_TEMP+6
	bpl +

	
	stz MEM_RETURN+0
	stx MEM_RETURN+2
	ldx #($20*\1)
	stx MEM_RETURN+4
	
	
	rts
	+:
	
.ENDM
