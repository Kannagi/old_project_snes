
TAB_ANGLE:
	.incbin "data.bin"
	
Ennemy_Vector_TypeT:
	.dw Ennemy_TypeT0, Ennemy_TypeT1, Ennemy_TypeT2, Ennemy_TypeT3
	;.dw Ennemy_Type4, Ennemy_Type5, Ennemy_Type6, Ennemy_Type7
	
Ennemy_Vector_Type:
	.dw Ennemy_Type0, Ennemy_Type1, Ennemy_Type2, Ennemy_Type3
	;.dw Ennemy_Type4, Ennemy_Type5, Ennemy_Type6, Ennemy_Type7
	
Ennemy_TypeT3:
Ennemy_TypeT2:
Ennemy_TypeT1:
Ennemy_TypeT0:
	cmp #0
	bne +

		rep #$20
		
		
		lda #0
		sta MEM_TEMP+2
		
		lda LKS_SPRITE.Y
		and #$F0
		sta MEM_TEMP
		
		lda LKS_SPRITE.PX,y
		lsr
		lsr
		sbc LKS_SPRITE.X
		bit #$8000
		beq +
			eor #$FFFF
			inc MEM_TEMP+2
		+:
		lsr
		lsr
		lsr
		lsr
		ora MEM_TEMP
		
		
		
		and #$FF
		tax
		sep #$20
		
		lda.l TAB_ANGLE,x
		sta MEM_TEMP
		
		rep #$20
		
		and #$0F
		
		sta LKS_SPRITE.VX,y
		
		lda MEM_TEMP+2
		cmp #0
		bne +
			lda LKS_SPRITE.VX,y
			eor #$FFFF
			sta LKS_SPRITE.VX,y
		+:
		
		lda MEM_TEMP
		lsr
		lsr
		lsr
		lsr
		
		sta LKS_SPRITE.VY,y
		sep #$20
		
		rts            
	+:
	
	
	rts
Ennemy_Type0:

	
	rep #$20
	lda MEM_TEMPFUNC+2
	asl
	and #$FF
	tax
	lda.l Ennemy_Vector_TypeT,x
	sta LKS_ZP
	
	sep #$20
	
	
	ldx #0
	lda #0
	jsr  (LKS_ZP,x)
	
	ldx MEM_TEMPFUNC
	
	rep #$20
	
	
		
	lda #SHIPE1A
	sta ShipE.address,x
	
	sep #$20
	
	;----
	lda #8
	sta ShipE.hp,x
	
	lda #:SHIPE1A
	sta ShipE.address+2,x
	
	lda #1<<1
	sta ShipE.flag,x
	
	rts
	
Ennemy_Type1:
	ldx MEM_TEMPFUNC
	
	rep #$20
	
	lda #$1
	sta LKS_SPRITE.VY,y
		
	lda #SHIPE3A
	sta ShipE.address,x
	
	sep #$20
	
	;----
	lda #10
	sta ShipE.hp,x
	
	lda #:SHIPE3A
	sta ShipE.address+2,x

	lda #3<<1
	sta ShipE.flag,x
	
	rts
	
Ennemy_Type2:



	ldx MEM_TEMPFUNC
	
	rep #$20
	
	lda #$2
	sta LKS_SPRITE.VY,y
		
	lda #SHIPE5A
	sta ShipE.address,x
	
	sep #$20
	
	;----
	lda #10
	sta ShipE.hp,x
	
	lda #:SHIPE5A
	sta ShipE.address+2,x

	lda #5<<1
	sta ShipE.flag,x
	
	rts
	
Ennemy_Type3:
	ldx MEM_TEMPFUNC
	
	rep #$20
	
	lda #$4
	sta LKS_SPRITE.VY,y
		
	lda #SHIPE2A
	sta ShipE.address,x
	
	sep #$20
	
	;----
	lda #10
	sta ShipE.hp,x
	
	lda #:SHIPE2A
	sta ShipE.address+2,x

	lda #2<<1
	sta ShipE.flag,x
	
	rts
	
Ennemy_Wait2:

	lda MEM_TEMPFUNC+2
	sta ShipE.type,x
	asl
	
	rep #$20
	
	and #$FF
	tax
	lda.l Ennemy_Vector_Type,x
	sta LKS_ZP
	
	sep #$20
	
	
	ldx #0
	jsr  (LKS_ZP,x)

	rts
	
Ennemy_Wait:
	phx
	ldx SDAN.cursor
	cpx #0
	beq +
	
	
	rep #$20
	
	lda.l ENNEMY_STAGE1+4,x
	cmp LKS_BG.y
	bne +
		lda.l ENNEMY_STAGE1+0,x
		sta MEM_TEMPFUNC+2
		
		lda #-120
		sta LKS_SPRITE.PY,y
		
		lda #$0
		sta LKS_SPRITE.VY,y
		sta LKS_SPRITE.VX,y
		
		lda.l ENNEMY_STAGE1+2,x
		asl
		asl
		sta LKS_SPRITE.PX,y
		
		lda SDAN.cursor
		cmp #2
		bne ++
			lda #6
		++:
		sec
		sbc #6
		sta SDAN.cursor
		
		tya
		sec
		sbc #$20
		lsr
		tax
		sta MEM_TEMPFUNC
		
		sep #$20
		
		
		stz ShipE.hit,x
		jsr Ennemy_Wait2
		
	+:
	sep #$20
	plx
	rts
