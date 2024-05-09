

Bullet_Init:
	lda #10
	sta LKS_BULLET.n
	
	ldy #100
	ldx #0
	stx MEM_TEMP
	stx MEM_TEMP+2
	
	-:
		ldx MEM_TEMP
		lda #$E0
		sta LKS_BULLET.Y+1,x
		
		rep #$20
		
		ldx MEM_TEMP+2
		lda #$2FD0
		sta LKS_BUF_OAML+2,x
		
		lda MEM_TEMP
		clc
		adc #2
		sta MEM_TEMP
		asl
		sta MEM_TEMP+2
		
		sep #$20
		dey
	bne -


	rtl
	
Bullet_Anim:

	lda SDAN.ibullet
	ina
	and #$0F
	sta SDAN.ibullet
	
	
	rep #$20
	lda SDAN.ibullet
	lsr
	lsr
	and #$FF
	asl
	tax
	lda.l EXPLOSION_TILE3,x
	sta MEM_TEMPFUNC
	sep #$20
	
	ldy #$20*100
	lda #1
	jsl LKS_Sprite_DMA_Fast
	
	rtl
	
Bullet_Slow:
	rtl
	rep #$20
	lda SDAN.islow
	tax
	ina
	ina
	cmp #76*2
	bne +
		
		lda #0
	+:
	sta SDAN.islow
	sep #$20
	
	
	
	lda LKS_BULLET.Y+1,x
	cmp #$E0
	beq +
		rep #$20
		lda LKS_BULLET.VY,x
		dea
		sta LKS_BULLET.VY,x	
		
		lda LKS_BULLET.VX,x
		dea
		sta LKS_BULLET.VX,x	
		/*
		bit #$8000
		beq +++
			lsr 
			ora #$F000
			sta  LKS_BULLET.VY,x
			bra ++
		+++:
			lsr
			sta LKS_BULLET.VY,x	
		++:
		
		
		lda LKS_BULLET.VX,x
		bit #$8000
		beq +++
			lsr 
			ora #$F000
			sta  LKS_BULLET.VX,x
			bra ++
		+++:
			lsr
			sta LKS_BULLET.VX,x	
		++:
		*/
		
		sep #$20
	+:
	
	
	rtl
	
Bullet_Impact:
	
	;-----1-----
	stz  MEM_TEMP
	lda #$E0+4
	sta  MEM_TEMP+1
	
	lda Impact.i1
	cmp #0
	beq +
		ldy Impact.n1
		lda Impact.x+1,y
		sta MEM_TEMP+0
		
		lda Impact.y+1,y
		sta MEM_TEMP+1
		
		inc  Impact.i1
		bra ++
	+:
	
	ldy #0
	-:
		cpy Impact.n2
		beq +++
		lda Impact.y+1,y
		cmp #$E0
		bne +
		+++:
		iny
		iny
		cpy #10
	bne -
	bra ++
	+:
		lda Impact.x+1,y
		sta MEM_TEMP+0
		
		lda Impact.y+1,y
		sta MEM_TEMP+1
		sty Impact.n1
		inc Impact.i1
	++:
	
	lda Impact.i1
	cmp #5
	bne +
		stz Impact.i1
		
		ldy Impact.n1
		lda #$E0
		sta Impact.y+1,y
	+:
	
	;---------------
	
	LKS_SPRITE_CONFIG 8,8,128,102
	ldy #$20*14
	
	lda MEM_TEMP
	sta LKS_SPRITE.X,y
	
	lda MEM_TEMP+1
	sec
	sbc #4
	sta LKS_SPRITE.Y,y
	
	jsl LKS_Sprite_Draw_Fast
	
	
	;---2------
	stz  MEM_TEMP
	lda #$E0+4
	sta  MEM_TEMP+1
	
	lda Impact.i2
	cmp #0
	beq +
		ldy Impact.n2
		lda Impact.x+1,y
		sta MEM_TEMP+0
		
		lda Impact.y+1,y
		sta MEM_TEMP+1
		
		inc  Impact.i2
		bra ++
	+:
	
	ldy #0
	-:
		cpy Impact.n1
		beq +++
		lda Impact.y+1,y
		cmp #$E0
		bne +
		+++:
		iny
		iny
		cpy #10
	bne -
	bra ++
	+:
		lda Impact.x+1,y
		sta MEM_TEMP+0
		
		lda Impact.y+1,y
		sta MEM_TEMP+1
		
		sty Impact.n2
		inc Impact.i2
	++:
	
	lda Impact.i2
	cmp #5
	bne +
		stz Impact.i2
		
		ldy Impact.n2
		lda #$E0
		sta Impact.y+1,y
	+:
	;---------------
	
	
	LKS_SPRITE_CONFIG 8,8,128,103
	ldy #$20*15
	
	lda MEM_TEMP
	sta LKS_SPRITE.X,y
	
	lda MEM_TEMP+1
	sec
	sbc #4
	sta LKS_SPRITE.Y,y
	
	jsl LKS_Sprite_Draw_Fast

	rtl
	
.MACRO BULLET_TILE
	
	
	ldx #(\1*2)+0
	jsl LKS_Collision_Map_Bullet
	
	ldx #(\1*2)+2
	jsl LKS_Collision_Map_Bullet
	
	ldx #(\1*2)+4
	jsl LKS_Collision_Map_Bullet
	
	ldx #(\1*2)+6
	jsl LKS_Collision_Map_Bullet
	
	
.ENDM
	
Bullet_Tile:

	ldy #0
	sty MEM_TEMP+4
	
	sty MEM_RETURN+0
	sty MEM_RETURN+2
	
	lda LKS.clockf
	and #$01
	cmp #0
	bne +
		BULLET_TILE 76
		BULLET_TILE 80
		BULLET_TILE 84
		bra ++
	+:
		BULLET_TILE 88
		BULLET_TILE 92
		BULLET_TILE 96
	++:
	
	
	lda MEM_RETURN
	cmp #10
	bmi +
		sec
		sbc #10
		clc
		adc #$10
		sta MEM_RETURN
	+:
	
	LKS_BCD8_add SDAN.score,MEM_RETURN
	
	rtl
	
.MACRO LKS_BULLET_DRAW_ARRAY1

	.DEFINE CNT \1

.REPT \2
	LKS_BULLET_DRAW_FAST1 CNT

.REDEFINE CNT CNT+1
.ENDR
.UNDEFINE CNT
		
.ENDM


.MACRO LKS_BULLET_DRAW_ARRAY2

	.DEFINE CNT \1

.REPT \2
	LKS_BULLET_DRAW_FAST2 CNT

.REDEFINE CNT CNT+1
.ENDR
.UNDEFINE CNT
		
.ENDM

.MACRO LKS_BULLET_DRAW_ARRAY2a

	.DEFINE CNT \1

.REPT \2
	LKS_BULLET_DRAW_FAST3 CNT

.REDEFINE CNT CNT+1
.ENDR
.UNDEFINE CNT
		
.ENDM

Draw_Bullet1:


	LKS_BULLET_DRAW_ARRAY2 0,100
	rtl
	
	
	

Draw_Bullet2:

	LKS_BULLET_DRAW_ARRAY2a 0,100

	rtl

Draw_Bullet:

	;sep #$10
	
	rep #$20
	LKS_BULLET_DRAW_ARRAY1 0,100
	sep #$20
	
	/*
	lda LKS.clockf
	bit #$01
	beq +
		jsl Draw_Bullet1
		bra ++
	+:
	jsl Draw_Bullet2
	++:
	*/
	LKS_BULLET_DRAW_ARRAY2 0,100
	
	rep #$20
	lda #$E0
	tay
	sep #$20
	
	lda #0
	sta LKS_BULLET.iuse1
	sta LKS_BULLET.iuse2

	
	LKS_BULLET_SORT_ARRAY_INIT1 76,24
	LKS_BULLET_SORT_ARRAY_INIT2 0,76
	;rep #$10
	
	rtl


	


