
IA_Tir:

	
	rts
	ldx #2*24
	

	
	lda #128
	sta LKS_BULLET.X+1,x
	
	lda #0
	sta LKS_BULLET.Y+1,x
	
	rep #$20
	lda #0
	sta LKS_BULLET.VX,x
	sta LKS_BULLET.VY,x
	sep #$20
	rts
	
	rts
	
	
	rep #$20
	lda LKS_BULLET.iuse2
	and #$FF
	tay
	sep #$20
	
	stz MEM_TEMP+1
	
	lda LKS_STDCTRL+_X
	cmp #1
	bne +
		lda Ship.void
		eor #$FF
		sta Ship.void
	+:
	
	lda Ship.void
	cmp #0
	bne ++
		lda LKS_BULLET.i+1
		ina
		sta LKS_BULLET.i+1
		cmp #$10
		bcc +
			lda #0
			sta LKS_BULLET.i+1
			;jsr Fire_Ennemy1
			jsr Fire_Ennemy3
			;jsr Fire_Ennemy2
		+:
		
		tya
		sta LKS_BULLET.iuse2
		rts
	++:
	lda LKS_BULLET.i+1
	ina
	sta LKS_BULLET.i+1
	cmp #$10
	bcc +
		lda #0
		sta LKS_BULLET.i+1
		jsr Fire_Ennemy0
	+:
	
	tya
	sta LKS_BULLET.iuse2
			
	rts
	

IA_hit:

	
	rts
	
.MACRO FIRE_INIT_ENNEMY

	tyx
	lda LKS_BULLET.Usable2,x
	sta MEM_TEMP

	ldx MEM_TEMP
	cmp #$E0
	bne +
		rts
	+:
	iny
	
	lda #\1
	adc MEM_TEMP+2
	sta LKS_BULLET.X+1,x
	
	lda #32+\2
	sta LKS_BULLET.Y+1,x
	
	rep #$20
	lda #\3
	sta LKS_BULLET.VX,x
	
	lda #\4
	sta LKS_BULLET.VY,x
	sep #$20
	
.ENDM

Fire_Ennemy1:

	
	
	lda #64
	sta MEM_TEMP+2
	
	FIRE_INIT_ENNEMY 0,32,$00,$100
	FIRE_INIT_ENNEMY 0,32,-$28,$FC
	FIRE_INIT_ENNEMY 0,32,-$4F,$F3
	FIRE_INIT_ENNEMY 0,32,-$74,$E4
	FIRE_INIT_ENNEMY 0,32,$28,$FC
	FIRE_INIT_ENNEMY 0,32,$4F,$F3
	FIRE_INIT_ENNEMY 0,32,$74,$E4

	
	;------------------------ right
	lda #128+64
	sta MEM_TEMP+2
	
	FIRE_INIT_ENNEMY 0,32,$00,$100
	FIRE_INIT_ENNEMY 0,32,-$28,$FC
	FIRE_INIT_ENNEMY 0,32,-$4F,$F3
	FIRE_INIT_ENNEMY 0,32,-$74,$E4
	FIRE_INIT_ENNEMY 0,32,$28,$FC
	FIRE_INIT_ENNEMY 0,32,$4F,$F3
	FIRE_INIT_ENNEMY 0,32,$74,$E4
	rts
	
	
Fire_Ennemy2:
	tyx
	lda LKS_BULLET.Usable2,x
	iny
	sta MEM_TEMP
	
	ldx MEM_TEMP
	cmp #$E0
	bne +
		rts
	+:
	
	
	phy
	
	lda #128
	sta LKS_BULLET.X+1,x
	
	lda #100
	sta LKS_BULLET.Y+1,x

	
	rep #$20
	;ldy LKS_DEBUG
	
	lda SinCos+$00,y
	and #$FF
	asl
	asl
	sec
	sbc #$80
	
	sta LKS_BULLET.VX,x
	
	lda SinCos+$40,y
	and #$FF
	asl
	asl
	sec
	sbc #$80
	sta LKS_BULLET.VY,x
	sep #$20
	
	
	ply
	
	rts
	
.MACRO FIRE_INIT_ENNEMY2

	
	tyx
	lda LKS_BULLET.Usable2,x
	iny
	sta MEM_TEMP
	
	ldx MEM_TEMP
	cmp #$E0
	bne +
		rts
	+:
	
	
	lda #128
	sta LKS_BULLET.X+1,x
	
	lda #64
	sta LKS_BULLET.Y+1,x

	
	rep #$20
	
	
	lda.l SinCos+$00+\1
	and #$FF
	asl
	asl
	asl
	sec
	sbc #$100
	
	sta LKS_BULLET.VX,x
	
	lda.l SinCos+$40+\1
	and #$FF
	asl
	asl
	asl
	sec
	sbc #$100
	sta LKS_BULLET.VY,x
	sep #$20
	
	
	
	
.ENDM

Fire_Ennemy3:
	
	FIRE_INIT_ENNEMY2 $90
	FIRE_INIT_ENNEMY2 $A0
	FIRE_INIT_ENNEMY2 $B0
	FIRE_INIT_ENNEMY2 $C0
	FIRE_INIT_ENNEMY2 $D0
	FIRE_INIT_ENNEMY2 $E0
	FIRE_INIT_ENNEMY2 $F0
	rts
	
Fire_Ennemy4:
Fire_Ennemy0:

	rep #$20
	lda LKS_BULLET.iuse2
	and #$FF
	tax
	sep #$20
	
	lda LKS_BULLET.Usable2,x
	sta MEM_TEMP
	
	
	ldx MEM_TEMP
	cmp #$E0
	bne +
		rts
	+:
	
	lda LKS_BULLET.iuse2
	ina
	sta LKS_BULLET.iuse2
		
	lda #128
	sta LKS_BULLET.X+1,x
	sta MEM_TEMP+4
	stz MEM_TEMP+5
	
	lda #16
	sta LKS_BULLET.Y+1,x
	sta MEM_TEMP+6
	stz MEM_TEMP+7
	
	rep #$20
	
	lda MEM_TEMP+4
	sec
	sbc #16-4
	sbc LKS_SPRITE.X
	eor #$FFFF
	sta MEM_TEMP

	lda #$180
	sta WRDIVL
	
	lda MEM_TEMP+6
	sec
	sbc #9
	sbc LKS_SPRITE.Y
	eor #$FFFF
	sta MEM_TEMP+2

	
	lda MEM_TEMP+0
	bit #$8000
	beq +
		eor #$FFFF
	+:
	lsr
	lsr
	lsr
	sta MEM_TEMP+4
	
	lda MEM_TEMP+2
	bit #$8000
	beq +
		eor #$FFFF
	+:
	lsr
	lsr
	lsr
	sta MEM_TEMP+6
	clc
	adc MEM_TEMP+4
	
	
	sep #$20	
	sta WRDIVB
	rep #$20
	nop
	nop
	nop
	
	lda MEM_TEMP+4
	sta MEM_TEMP+8
	
	lda MEM_TEMP+6
	sta MEM_TEMP+11
	
	lda RDDIVL
	sta MEM_TEMP+9
	sta MEM_TEMP+12
	
	lda MEM_TEMP+8
	sta WRMPYA
	nop
	lda MEM_TEMP+0
	bit #$8000
	beq +
		lda RDMPYL
		eor #$FFFF
		sta MEM_TEMP+0
		bra ++
	+:
		lda RDMPYL
		sta MEM_TEMP+0
	++:
	
	lda MEM_TEMP+11
	sta WRMPYA
	nop
	lda MEM_TEMP+2
	bit #$8000
	beq +
		lda RDMPYL
		eor #$FFFF
		sta MEM_TEMP+2
		bra ++
	+:
		lda RDMPYL
		sta MEM_TEMP+2
	++:

	lda MEM_TEMP
	sta LKS_BULLET.VX,x
	
	lda MEM_TEMP+2
	sta LKS_BULLET.VY,x
	sep #$20
	
	stz MEM_TEMP+1

	rts

Fire_EnnemyT:

	rep #$20
	lda LKS_BULLET.iuse2
	and #$FF
	tax
	sep #$20
	
	lda LKS_BULLET.Usable2,x
	cmp #$E0
	bne +
		rts
	+:
	sta MEM_TEMP
	stz MEM_TEMP+1


	ldx MEM_TEMP
	lda LKS_BULLET.iuse2
	ina
	sta LKS_BULLET.iuse2
	
	clc
	lda LKS_SPRITE.X,y
	adc #16-4
	sta LKS_BULLET.X+1,x
	sta MEM_TEMP+4
	stz MEM_TEMP+5
	
	lda LKS_SPRITE.Y,y
	adc #32-2
	sta LKS_BULLET.Y+1,x
	sta MEM_TEMP+6
	stz MEM_TEMP+7
	
	rep #$20
	
	lda MEM_TEMP+4
	sec
	sbc #14
	sbc LKS_SPRITE.X
	eor #$FFFF
	sta MEM_TEMP
		

	;speed
	lda #$180
	sta WRDIVL
	
	lda MEM_TEMP+6
	sec
	sbc #10
	sbc LKS_SPRITE.Y
	eor #$FFFF
	sta MEM_TEMP+2

	
	lda MEM_TEMP+0
	bit #$8000
	beq +
		eor #$FFFF
	+:
	lsr
	lsr
	;lsr
	
	cmp #0
	bne +
		lda #1
	+:
	sta MEM_TEMP+4
	
	lda MEM_TEMP+2
	bit #$8000
	beq +
		eor #$FFFF
	+:
	lsr
	lsr
	;lsr
	
	cmp #0
	bne +
		lda #1
	+:
	sta MEM_TEMP+6
	clc
	adc MEM_TEMP+4
	
	
	sep #$20	
	sta WRDIVB
	rep #$20
	nop
	nop
	nop
	
	lda MEM_TEMP+4
	sta MEM_TEMP+8
	
	lda MEM_TEMP+6
	sta MEM_TEMP+11
	
	lda RDDIVL
	sta MEM_TEMP+9
	sta MEM_TEMP+12
	
	lda MEM_TEMP+8
	sta WRMPYA
	nop
	lda MEM_TEMP+0
	bit #$8000
	beq +
		lda RDMPYL
		eor #$FFFF
		sta MEM_TEMP+0
		bra ++
	+:
		lda RDMPYL
		sta MEM_TEMP+0
	++:
	
	lda MEM_TEMP+11
	sta WRMPYA
	nop
	lda MEM_TEMP+2
	bit #$8000
	beq +
		lda RDMPYL
		eor #$FFFF
		sta MEM_TEMP+2
		bra ++
	+:
		lda RDMPYL
		sta MEM_TEMP+2
	++:

	lda MEM_TEMP
	sta LKS_BULLET.VX,x
	
	lda MEM_TEMP+2
	sta LKS_BULLET.VY,x
	sep #$20
	
	stz MEM_TEMP+1

	rts
