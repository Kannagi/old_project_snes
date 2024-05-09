.MACRO collision

	stz MEM_TEMP + 9
	stz MEM_TEMP + 11
	
	
	
	lda MEM_HSCROLLING
	lsr A
	sta MEM_TEMP
	

	lda MEM_TEMP + 8
	sec
	sbc #8
	clc
	adc MEM_TMPSCROLLING
	lsr A
	lsr A
	lsr A
	lsr A
	
	clc
	adc MEM_TEMP
	sta MEM_TEMP + 2
	stz MEM_TEMP + 3
		
	lda MEM_TEMP + 10
	sec
	sbc #4
	clc
	adc MEM_TMPSCROLLING + 2
	lsr A
	lsr A
	lsr A
	lsr A
	
	clc
	adc MEM_VSCROLLING
	adc #2
	sta MEM_TEMP
	stz MEM_TEMP + 1
	
	ldx	s_map + $08
			
	rep #$20
	
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
	
	sep #$20
		
.ENDM

.MACRO collision_perso
	
	lda s_oam + \2
	cmp #-16
	bne ++
		lda s_oam + \2  + $08
		cmp #-16
		beq +
	++:
	
	lda MEM_TEMP + 8
	cmp s_oam + \2 + $08
	bpl +
	
	lda MEM_TEMP + 10
	cmp s_oam + \2 + $08
	bmi +
	
	lda MEM_TEMP + 9
	cmp s_oam + \2
	bpl +
	
	lda MEM_TEMP + 11
	cmp s_oam + \2
	bmi +
	
	stz s_perso + \1,X
	rts
	+:
	
	
.ENDM
Collision_hero_mur:
	collision
	
	lda $010000-1,X
	sta MEM_TEMP + 1
	
	lda $010000,X
	sta MEM_TEMP
	
	rts

Collision_chx:
	ldx MEM_TEMPFUNC
	
	collision_perso 12 2
	collision_perso 12 3
	
	collision_perso 12 4
	collision_perso 12 5
	collision_perso 12 6
	collision_perso 12 7

	rts
	
Collision_chy:

	ldx MEM_TEMPFUNC
	
	collision_perso 13 2
	collision_perso 13 3
	
	collision_perso 13 4
	collision_perso 13 5
	collision_perso 13 6
	collision_perso 13 7
	rts

Collision_perso:

	ldx MEM_TEMPFUNC
	
	lda s_perso + 12,X
	cmp #1
	bne +
		lda s_perso,X
		inc A
		inc A
		sta MEM_TEMP + 8
		clc
		adc #16
		sta MEM_TEMP + 10
		
		lda s_perso + 1,X
		sec
		sbc #8
		sta MEM_TEMP + 9
		clc
		adc #16
		sta MEM_TEMP + 11
		
		jsr Collision_chx
	+:
	
	lda s_perso + 12,X
	cmp #2
	bne +
		lda s_perso,X
		sec
		sbc #16 + 2
		sta MEM_TEMP + 8
		clc
		adc #8
		sta MEM_TEMP + 10
		
		lda s_perso + 1,X
		sec
		sbc #8
		sta MEM_TEMP + 9
		clc
		adc #16
		sta MEM_TEMP + 11
		
		jsr Collision_chx
	+:

	lda s_perso + 13,X
	cmp #1
	bne +
		
		lda s_perso,X
		sec
		sbc #16
		sta MEM_TEMP + 8
		clc
		adc #32
		sta MEM_TEMP + 10
		
		lda s_perso + 1,X
		sec
		sbc #8 + 2
		sta MEM_TEMP + 9
		clc
		adc #8
		sta MEM_TEMP + 11
		
		jsr Collision_chy
	+:
	
	lda s_perso + 13,X
	cmp #2
	bne +
		lda s_perso,X
		sec
		sbc #16
		sta MEM_TEMP + 8
		clc
		adc #32
		sta MEM_TEMP + 10
		
		lda s_perso + 1,X
		inc A
		inc A
		sta MEM_TEMP + 9
		clc
		adc #8
		sta MEM_TEMP + 11
		
		jsr Collision_chy
		
	+:
	

	
	rts
	
Collision_mur_tagx:
	
	cmp #$00
	bne +
		lda s_perso + 3,Y
		and #$40
		sta s_perso + 3,Y
		
		lda #0
		sta s_map + $0C
		sta s_perso + $10,Y
		rts
	+:
	
	cmp #$01
	bne +
		lda #0
		sta s_perso + 12,Y
		rts
	+:
		
	cmp #$02
	bne +
		lda s_perso + 3,Y
		ora #$10
		sta s_perso + 3,Y
		rts
	+:
	
	cmp #$03
	bne +
		lda #$10
		sta s_perso + $10,Y
		rts
	+:
	
	cmp #$10
	bmi +
		sta s_map + $0C
		rts
	+:
	

		
	rts
	
Collision_mur_tagy:
	
	lda MEM_TEMP
	
	cmp #$01
	bne +
		lda #0
		sta s_perso + 13,Y
		rts
	+:
	
	cmp #$03
	bne +
		lda #$10
		sta s_perso + $10,Y
		rts
	+:
	
	
	lda MEM_TEMP + 1
	
	cmp #$01
	bne +
		lda #0
		sta s_perso + 13,Y
		rts
	+:
	
	cmp #$03
	bne +
		lda #$10
		sta s_perso + $10,Y
		rts
	+:
	
	;prio
	lda MEM_TEMP
	
	cmp #$02
	bne +
		lda s_perso + 3,Y
		ora #$10
		sta s_perso + 3,Y
		rts
	+:
	
	
	
	lda MEM_TEMP + 1
	
	cmp #$02
	bne +
		lda s_perso + 3,Y
		ora #$10
		sta s_perso + 3,Y
		rts
	+:
	
	cmp #$00
	bne +
		lda s_perso + 3,Y
		and #$40
		sta s_perso + 3,Y
		
		lda #0
		sta s_map + $0C
		sta s_perso + $10,Y
		
		rts
	+:
	
	lda MEM_TEMP
	cmp #$00
	bne +
		lda s_perso + 3,Y
		and #$40
		sta s_perso + 3,Y
		
		lda #0
		sta s_map + $0C
		sta s_perso + $10,Y
		rts
	+:
	
	cmp #$10
	bmi +
		sta s_map + $0C
		rts
	+:
	
	lda MEM_TEMP + 1
	cmp #$10
	bmi +
		sta s_map + $0C
		rts
	+:
	
	
	
	rts

Collision_mur:

	ldy MEM_TEMPFUNC
	
	lda s_perso + 12,Y
	cmp #1
	bne +
		lda s_perso,Y
		inc A
		inc A
		sta MEM_TEMP + 8
		
		lda s_perso + 1,Y
		sta MEM_TEMP + 10
		
		jsr Collision_hero_mur
		
		lda $010000,X
		jsr Collision_mur_tagx
	+:
	
	lda s_perso + 12,Y
	cmp #2
	bne +
		lda s_perso,Y
		dec A
		dec A
		sta MEM_TEMP + 8
		
		lda s_perso + 1,Y
		sta MEM_TEMP + 10
		
		jsr Collision_hero_mur
		
		lda $010000-1,X
		jsr Collision_mur_tagx
	+:
	
	lda s_perso + 13,Y
	cmp #1
	bne +
		lda s_perso,Y
		sta MEM_TEMP + 8
		
		lda s_perso + 1,Y
		dec A
		dec A
		sta MEM_TEMP + 10
		
		jsr Collision_hero_mur
		
		jsr Collision_mur_tagy
		
	+:
	
	lda s_perso + 13,Y
	cmp #2
	bne +
		lda s_perso,Y
		sta MEM_TEMP + 8
		
		lda s_perso + 1,Y
		inc A
		inc A
		clc
		adc #6
		sta MEM_TEMP + 10
		
		jsr Collision_hero_mur
		
		jsr Collision_mur_tagy
	+:
	rts
	
Deplacement_hero:

	ldx MEM_TEMPFUNC
	
	lda s_perso + 12,X
	cmp #1
	bne +
		lda s_perso
		inc A
		inc A
		sta s_perso
	+:
	
	lda s_perso + 12,X
	cmp #2
	bne +
		lda s_perso
		dec A
		dec A
		sta s_perso
	+:
	
	
	lda s_perso + 13,X
	cmp #1
	bne +
		lda s_perso + 1
		dec A
		dec A
		sta s_perso + 1
	+:
	
	lda s_perso + 13,X
	cmp #2
	bne +
		lda s_perso + 1
		inc A
		inc A
		sta s_perso + 1
	+:
	
	stz s_perso + 12,X
	stz s_perso + 13,X
	
	rts
	
	
	
;TEXT
.MACRO collision_text
	
	lda MEM_TEMP + 8
	cmp s_oam + \1 + $08
	bpl +
	
	lda MEM_TEMP + 10
	cmp s_oam + \1 + $08
	bmi +
	
	lda MEM_TEMP + 9
	cmp s_oam + \1
	bpl +
	
	lda MEM_TEMP + 11
	cmp s_oam + \1
	bmi +
	
	lda #\1
	sta MEM_TEMP
	rts
	+:
	
.ENDM

Collision_perso_text_oam:
	collision_text 2
	collision_text 3
	
	collision_text 4
	collision_text 5
	collision_text 6
	collision_text 7
	
	rts
	
Collision_perso_text:

	lda MEM_TEXT + 15
	cmp #0
	beq +
		rts
	+:

	ldx MEM_TEMPFUNC
	stz MEM_TEMP
	
	lda s_perso + 14,X
	cmp #0
	bne +
		rts
	+:
	
	;perso direction bas
	lda s_perso + 15,X
	cmp #0
	bne +
		lda s_perso,X
		sec
		sbc #16
		sta MEM_TEMP + 8
		clc
		adc #16 + 16
		sta MEM_TEMP + 10
		
		lda s_perso + 1,X
		sta MEM_TEMP + 9
		clc
		adc #14
		sta MEM_TEMP + 11
	
		jsr Collision_perso_text_oam
	+:

	;perso direction haut
	lda s_perso + 15,X
	cmp #1
	bne +
		lda s_perso,X
		sec
		sbc #16
		sta MEM_TEMP + 8
		clc
		adc #16 + 16
		sta MEM_TEMP + 10
		
		lda s_perso + 1,X
		sec
		sbc #14
		sta MEM_TEMP + 9
		clc
		adc #14
		sta MEM_TEMP + 11
	
		jsr Collision_perso_text_oam
	+:
	
	;perso direction droite
	lda s_perso + 15,X
	cmp #2
	bne +
		lda s_perso,X
		clc
		adc #16
		sta MEM_TEMP + 8
		clc
		adc #8
		sta MEM_TEMP + 10
		
		lda s_perso + 1,X
		sec
		sbc #8
		sta MEM_TEMP + 9
		clc
		adc #8 + 8
		sta MEM_TEMP + 11
	
		jsr Collision_perso_text_oam
	+:
	
	;perso direction gauche
	lda s_perso + 15,X
	cmp #3
	bne +
		lda s_perso,X
		sec
		sbc #24
		sta MEM_TEMP + 8
		clc
		adc #8
		sta MEM_TEMP + 10
		
		lda s_perso + 1,X
		sec
		sbc #8
		sta MEM_TEMP + 9
		clc
		adc #8 + 8
		sta MEM_TEMP + 11
	
		jsr Collision_perso_text_oam
	+:
	
	lda MEM_TEMP
	cmp #0
	beq +
		lda #1
		sta MEM_TEXT + 15
		
		rep #$20
		lda #0
		sep #$20
		
		lda MEM_TEMP
		
		rep #$20
		asl A
		phy
		tay
		lda s_oam_id,Y
		tay
		
		lda s_pnj + $0E,Y
		
		inc A
		inc A
		sta MEM_TEXT + 10
		
		
		sep #$20
	
		lda #1
		sta s_pnj + $1F,Y
		sty MEM_TEXT + 12
		
		
		lda s_perso + 15,X
		sta s_pnj + $0A,Y
		
		ply
		
	+:
	
	stz s_perso + 14,X
	
	rts
	
