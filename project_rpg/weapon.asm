
Weapon_draw:


	lda s_map+_mode
	cmp #0
	bne +
		rts
	+:
	
	lda s_menu+_rdraw
	cmp #0
	beq +
		rts
	+:
	
	rep #$20
	lda s_perso+_animact,x
	and #$00FF
	asl
	asl
	sta MEM_TEMP
	lda s_perso+_animi,x
	and #$00FF
	clc
	adc MEM_TEMP
	tay
	sep #$20
	
	
	
	lda Pos_Weapon_x,y
	sta MEM_TEMP
	
	lda Pos_Weapon_y,y
	sta MEM_TEMP+2
	
	lda Pos_Weapon_t,y
	and #$0F
	sta MEM_TEMP+9
	
	lda Pos_Weapon_t,y
	and #$F0
	sta MEM_TEMP+10
	
	
	lda s_perso+_flip,x
	and #$40
	cmp #0
	beq +
		lda #$10
		sec
		sbc MEM_TEMP
		sta MEM_TEMP
	
	+:
	;-----------
	
	rep #$20
	
	
	lda s_perso+_x,x
	clc
	adc s_perso+_vx,x
	clc
	adc MEM_TEMP
	sta MEM_TEMP+14
	sec
	sbc LKS_BG+_bg1x
	sta MEM_TEMP
	
	
	lda s_perso+_y,x
	clc
	adc s_perso+_vy,x
	clc
	adc MEM_TEMP+2
	sta MEM_TEMP+12
	sec
	sbc LKS_BG+_bg1y
	sta MEM_TEMP+2
	
	lda #0
	sta MEM_TEMP+4
	lda s_perso+_direction,x
	cmp #1
	bne +
		lda #$10
		sta MEM_TEMP+4
	+:
	
	lda s_perso+_oam,x
	clc
	adc MEM_TEMP+4
	sta MEM_TEMPFUNC
	
	sep #$20
	
	lda s_perso+_flip,x
	and #$40
	sta MEM_TEMP+11
	
	
	lda s_perso+_flip,x
	and #$30
	ora MEM_TEMP+10
	eor MEM_TEMP+11
	sta MEM_TEMP+10
	
	
	;-----------------
	
	ldy MEM_TEMPFUNC
	phx
	tyx
	
	lda MEM_TEMP
	sta LKS_BUF_OAML,x
	inx
	
	lda MEM_TEMP+2
	sta LKS_BUF_OAML,x
	inx
	
	
	lda #$20
	clc
	adc MEM_TEMP+9
	sta LKS_BUF_OAML,x
	inx
	
	lda #$0C
	ora MEM_TEMP+10
	sta LKS_BUF_OAML,x
	inx
	
	txy
	plx
	
	
	;jsr Weapon_test
	
	lda s_perso+_etat,x
	cmp #1
	beq +
		rts
	+:
	
	
	rep #$20
	
	lda MEM_TEMP+14
	sec
	sbc #32
	sta MEM_TEMP+4
	clc
	adc #48
	sta MEM_TEMP+6
	
	
	lda MEM_TEMP+12
	sec
	sbc #32
	sta MEM_TEMP
	clc
	adc #32
	sta MEM_TEMP+2
	
	sep #$20
	
	
	lda s_perso+_direction,x
	sta MEM_TEMP+10
	
	
	
	jsr Weapon_Hitbox1
	ldx MEM_TEMPFUNC
	cpx #0
	beq +
		lda s_perso+_etat,x
		cmp #4
		beq +
			lda #4
			sta s_perso+_etat,x
			
			lda MEM_TEMP+10
			sta s_perso+_gdirection,x
			
			rep #$20
			lda s_perso+_x,x
			sta s_perso+_dgt,x
			sep #$20
	+:
	
	
	
	jsr Weapon_Hitbox2
	ldx MEM_TEMPFUNC	
	cpx #0
	beq +
		
		
		
		lda s_perso+_etat,x
		cmp #4
		beq +
			lda #4
			sta s_perso+_etat,x
			
			lda MEM_TEMP+10
			sta s_perso+_gdirection,x
			
			rep #$20
			lda s_perso+_x,x
			sta s_perso+_dgt,x
			sep #$20
	+:
	
	
	
	jsr Weapon_Hitbox3
	
	ldx MEM_TEMPFUNC
	cpx #0
	beq +
		
		
		lda s_perso+_etat,x
		cmp #4
		beq +
			lda #4
			sta s_perso+_etat,x
			
			lda MEM_TEMP+10
			sta s_perso+_gdirection,x
			
			rep #$20
			lda s_perso+_x,x
			
			sta s_perso+_dgt,x
			sep #$20
	+:
	
	
	rts


	
Weapon_test:
	
	rep #$20
	
	lda s_perso+_x,x
	sec
	sbc #$18
	sta MEM_TEMP+14
	sec
	sbc LKS_BG+_bg1x
	sta MEM_TEMP
	
	
	lda s_perso+_y,x
	clc
	adc #$8
	sta MEM_TEMP+12
	sec
	sbc LKS_BG+_bg1y
	sta MEM_TEMP+2
	
	sep #$20
	
	phx
	tyx
	ldy #$10
	lda MEM_TEMP
	sta LKS_BUF_OAML,x
	inx
	
	lda MEM_TEMP+2
	sta LKS_BUF_OAML,x
	inx
	
	
	lda #$00
	sta LKS_BUF_OAML,x
	inx
	
	lda #$3D
	sta LKS_BUF_OAML,x
	inx
	txy
	plx
	
	rts
		

Weapon_Hitbox1:

	stz MEM_TEMPFUNC
	stz MEM_TEMPFUNC+1
	collision_perso 6
	
	
	rts
	
Weapon_Hitbox2:

	stz MEM_TEMPFUNC
	stz MEM_TEMPFUNC+1
	collision_perso 8
	
	rts
	
Weapon_Hitbox3:

	stz MEM_TEMPFUNC
	stz MEM_TEMPFUNC+1
	collision_perso 10
	
	rts
	

Pos_Weapon_x:
	.db $01,$02,$05,$0D ;marche bas
	.db $06,$0D,$0D,$11 ;marche droite
	.db $0F,$12,$11,$06 ;marche haut
	.db -$1,$0B,$11,$00 ;normal
	.db $02,-$8,$06,$1A ;atk bas
	.db $0B,-$5,$04,$1B ;atk droite
	.db $0D,$16,$10,-$8 ;atk haut

Pos_Weapon_y:
	.db -$1,$02,$06,$0B ;marche bas
	.db $0F,$0F,$05,$06 ;marche droite
	.db $07,$04,$02,$06 ;marche haut
	.db $08,$0D,$08,$00 ;normal
	.db $05,$14,$1A,$0C ;atk bas
	.db $06,$0D,$14,$0B ;atk droite
	.db $07,$0D,-$5,$01 ;atk haut
	
Pos_Weapon_t:
	.db $06,$06,$42,$04 ;marche bas
	.db $84,$00,$42,$42 ;marche droite
	.db $42,$42,$06,$44 ;marche haut
	.db $02,$04,$42,$00 ;normal
	.db $02,$40,$C6,$00 ;atk bas
	.db $42,$40,$C4,$00 ;atk droite
	.db $42,$04,$06,$44 ;atk haut
