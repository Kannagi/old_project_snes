


.MACRO collision_pnj

	;position X
	lda MEM_TEMP + 8
	sec
	sbc #8
	lsr A
	lsr A
	lsr A
	lsr A
	sta MEM_TEMP + 2
	
	;position Y
	lda MEM_TEMP + 10
	sec
	sbc #4
	lsr A
	lsr A
	lsr A
	lsr A
	sta MEM_TEMP
	
	;collision
	ldx	s_map + $08
				
	lda MEM_TEMP
	asl A
	asl A
	asl A
	asl A
	asl A
	asl A
	sta MEM_TEMP
	
	txa
	clc
	adc MEM_TEMP + 2
	inc A
	adc MEM_TEMP
	tax
		
.ENDM

.MACRO collision_perso_pnj

	stz MEM_TEMP
		
	lda s_oam + \2 + $08
	cmp #-16
	bne ++
		lda s_oam + \2
		cmp #-16
		bne ++
			bra +++
	++:
	
	lda MEM_TEMP + 8
	cmp s_oam + \2 + $08
	bpl ++
		inc MEM_TEMP
	++:
	
	lda MEM_TEMP + 10
	cmp s_oam + \2 + $08
	bmi ++
		inc MEM_TEMP
	++:
	
	lda MEM_TEMP + 9
	cmp s_oam + \2
	bpl ++
		inc MEM_TEMP
	++:
	
	lda MEM_TEMP + 11
	cmp s_oam + \2
	bmi ++
		inc MEM_TEMP
	++:
	
	
	lda MEM_TEMP
	cmp #4
	bne ++
		stz s_pnj + 4,X
	++:
	
	+++:
	
	
.ENDM

;-------------PNJ--------------------------


Collision_chx_pnj:
	ldx MEM_TEMPFUNC
	
	collision_perso_pnj 0 0
	collision_perso_pnj 0 1


	rts
	
Collision_chy_pnj:
	ldx MEM_TEMPFUNC
	inx
	inx
	
	collision_perso_pnj 8 0
	collision_perso_pnj 8 1
	
	dex
	dex
	
	rts

Collision_perso_pnj:

	
	ldx MEM_TEMPFUNC
	
	lda  s_pnj +$08,X
	cmp #0
	bne +
		rts
	+:
	
	
	lda #0
	xba
	lda s_pnj + 9,X
	tay
	
	lda s_pnj + 4,X
	cmp #1
	bmi +
		lda s_oam + $08,Y
		inc A
		inc A
		sta MEM_TEMP + 8
		clc
		adc #16
		sta MEM_TEMP + 10
		
		lda s_oam,Y
		sec
		sbc #8
		sta MEM_TEMP + 9
		clc
		adc #16
		sta MEM_TEMP + 11
		
		jsr Collision_chx_pnj
	+:
	
	lda s_pnj + 4,X
	cmp #0
	bpl +
		lda s_oam + $08,Y
		sec
		sbc #16 + 2
		sta MEM_TEMP + 8
		clc
		adc #8
		sta MEM_TEMP + 10
		
		lda s_oam,Y
		sec
		sbc #8
		sta MEM_TEMP + 9
		clc
		adc #16
		sta MEM_TEMP + 11
		
		jsr Collision_chx_pnj
	+:
	
	
	lda s_pnj + 6,X
	cmp #1
	bmi +
		lda s_oam + $08,Y
		sec
		sbc #16
		sta MEM_TEMP + 8
		clc
		adc #32
		sta MEM_TEMP + 10
		
		lda s_oam,Y
		inc A
		;inc A
		sta MEM_TEMP + 9
		clc
		adc #8
		sta MEM_TEMP + 11
				
		jsr Collision_chy_pnj
		
	+:
	
	lda s_pnj + 6,X
	cmp #0
	bpl +
		lda s_oam + $08,Y
		sec
		sbc #16
		sta MEM_TEMP + 8
		clc
		adc #32
		sta MEM_TEMP + 10
		
		lda s_oam,Y
		sec
		sbc #8 + 1
		sta MEM_TEMP + 9
		clc
		adc #8
		sta MEM_TEMP + 11
		
		jsr Collision_chy_pnj
	+:
	
	
	rts
	
	
Collision_mur_pnj_tagx:
	
	cmp #$01
	bne +
		lda #0
		sta s_pnj + 4,Y
	+:
	
	cmp #$00
	bne +
		lda s_pnj +$0D,Y
		and #$40
		sta s_pnj +$0D,Y
		rts
	+:
		
	cmp #$02
	bne +
		lda s_pnj +$0D,Y
		ora #$10
		sta s_pnj +$0D,Y
		rts
	+:

	rts

Collision_mur_pnj_tagy:
	
	lda $010000,X
	cmp #$01
	bne +
		lda #0
		sta s_pnj + 6,Y
		rts
	+:
		
	lda $010000-1,X
	cmp #$01
	bne +
		lda #0
		sta s_pnj + 6,Y
		rts
	+:
	
	lda $010000,X
	cmp #$02
	bne +
		lda s_pnj +$0D,Y
		ora #$10
		sta s_pnj +$0D,Y
		rts
	+:
	
	lda $010000-1,X
	cmp #$02
	bne +
		lda s_pnj +$0D,Y
		ora #$10
		sta s_pnj +$0D,Y
		rts
	+:
	
	lda $010000,X
	cmp #$00
	bne +
		lda s_pnj +$0D,Y
		and #$40
		sta s_pnj +$0D,Y
		rts
	+:
	
	lda $010000-1,X
	cmp #$00
	bne +
		lda s_pnj +$0D,Y
		and #$40
		sta s_pnj +$0D,Y
		rts
	+:
	
	
	rts

Collision_mur_pnj:

	ldy MEM_TEMPFUNC
	
	
	;vitesse x positive
	lda s_pnj + 4,Y
	cmp #1
	bmi +
		
		rep #$20
		
		lda s_pnj,Y
		clc
		adc s_pnj + 4,Y
		sta MEM_TEMP + 8
		
		lda s_pnj + 2,Y
		sta MEM_TEMP + 10

		collision_pnj
		
		sep #$20
		
		lda $010000,X
		jsr Collision_mur_pnj_tagx
	+:
	

	
	;vitesse x negative
	lda s_pnj + 4,Y
	cmp #0
	bpl +
		rep #$20
		
		lda s_pnj + 4,Y
		eor #$FF
		inc A
		sta MEM_TEMP
				
		lda s_pnj,Y
		sec
		sbc MEM_TEMP
		sta MEM_TEMP + 8
		
		lda s_pnj + 2,Y
		sta MEM_TEMP + 10

		collision_pnj
		
		sep #$20
		
		lda $010000-1,X
		jsr Collision_mur_pnj_tagx
	+:
	
	;vitesse y positive
	lda s_pnj + 6,Y
	cmp #1
	bmi +
		
		rep #$20
		
		lda s_pnj,Y
		sta MEM_TEMP + 8
		
		lda s_pnj + 2,Y
		clc
		
		adc s_pnj + 6,Y
		adc #6
		sta MEM_TEMP + 10

		collision_pnj
		
		sep #$20
		
		jsr Collision_mur_pnj_tagy
	+:
	
	;vitesse y negative
	lda s_pnj + 6,Y
	cmp #0
	bpl +
	
		rep #$20
		
		lda s_pnj + 6,Y
		eor #$FF
		inc A
		sta MEM_TEMP
		
		
		lda s_pnj,Y
		sta MEM_TEMP + 8
		
		lda s_pnj + 2,Y
		sec
		sbc MEM_TEMP
		sta MEM_TEMP + 10

		collision_pnj
		
		sep #$20
		
		jsr Collision_mur_pnj_tagy
	+:
	
	
	rts
	
Deplacement_pnj:

	ldx MEM_TEMPFUNC
	
	
	;vitesse x positive
	lda s_pnj + $04,X
	cmp #1
	bmi +
		rep #$20
		
		lda s_pnj,X
		clc
		adc s_pnj + $04,X
		sta s_pnj,X
		
		lda #0
		sta s_pnj + $04,X
		
		sep #$20
	+:
	
	;vitesse x negative
	lda s_pnj + $04,X
	cmp #0
	bpl +
		rep #$20
		
		lda s_pnj + $04,X
		eor #$FF
		inc A
		sta MEM_TEMP
		
		lda s_pnj,X
		sec
		sbc MEM_TEMP
		sta s_pnj,X
		
		lda #0
		sta s_pnj + $04,X
		
		sep #$20
	+:
	
	;vitesse y positive
	lda s_pnj + $06,X
	cmp #1
	bmi +
		rep #$20
		
		lda s_pnj + 2,X
		clc
		adc s_pnj + $06,X
		sta s_pnj + 2,X
		
		lda #0
		sta s_pnj + $06,X
		
		sep #$20
	+:
	
	;vitesse y negative
	lda s_pnj + $06,X
	cmp #0
	bpl +
		rep #$20
		
		lda s_pnj + $06,X
		eor #$FF
		inc A
		sta MEM_TEMP
		
		lda s_pnj + 2,X
		sec
		sbc MEM_TEMP
		sta s_pnj + 2,X
		
		lda #0
		sta s_pnj + $06,X
		
		sep #$20
	+:
	
	
	
	rts
	
