
.MACRO Collision_persoXY

	rep #$20

	lda s_perso+_x,x
	clc
	adc #$8
	.if \1 == 0
	adc s_perso+_vx,x
	.endif
	
	.if \1 == 2
	adc s_perso+_vx,x
	.endif
	.if \1 == 3
	adc #$8
	.endif
	lsr
	lsr
	lsr
	lsr
	
	sta MEM_TEMP
	
	lda s_perso+_y,x
	clc
	adc #$1C
	.if \1 == 1
	adc s_perso+_vy,x
	.endif
	
	.if \1 == 2
	adc s_perso+_vy,x
	.endif
	lsr
	lsr
	lsr
	lsr
	
	
	
	and #$00FF
	clc
	adc MEM_TEMP+2
	sta WRMPYA
	LKS_cycle8
	lda RDMPYL
	
	asl
	asl
	asl
	asl
	
	clc
	adc MEM_TEMP
	adc s_map+_mapc
	sta MEM_TEMP
	
	sep #$20
	
	lda s_map+_mapc+2
	sta LKS_ZP+2
	
	ldy MEM_TEMP
	
	rep #$20
	lda [LKS_ZP],y
	sta MEM_TEMP+5
	sep #$20


.ENDM


	
Collision_perso_map:

	rep #$20
	lda LKS_BG+_bgaddyr
	asl
	asl
	asl
	sta MEM_TEMP+2
	sep #$20

	Collision_persoXY 0

	
	lda MEM_TEMP+5
	cmp #1
	bne ++
		stz s_perso+_vx,x
		stz s_perso+_vx+1,x
		
	++:
	
	lda MEM_TEMP+6
	cmp #1
	bne ++
		stz s_perso+_vx,x
		stz s_perso+_vx+1,x
		
	++:
	

	
	Collision_persoXY 2
	
	lda MEM_TEMP+5
	cmp #1
	bne ++
		stz s_perso+_vy,x
		stz s_perso+_vy+1,x
	++:
	
	lda MEM_TEMP+6
	cmp #1
	bne ++
		stz s_perso+_vy,x
		stz s_perso+_vy+1,x
	++:
	
	Collision_persoXY 3
	
	;tag
	lda MEM_TEMP+5
	sta s_perso+_tag,x
	cmp #2
	bne +
		lda s_perso+_flip,x
		ora #$10
		sta s_perso+_flip,x
		rts
	+:
	cmp #3
	bne +
		lda s_perso+_flip,x
		and #$EF
		sta s_perso+_flip,x
		rts
	+:
	
	lda s_perso+_flip,x
	and #$EF
	sta s_perso+_flip,x
	
	
	lda MEM_TEMP+6
	cmp #2
	bne +
		lda s_perso+_flip,x
		ora #$10
		sta s_perso+_flip,x
		rts
	+:
	cmp #3
	bne +
		lda s_perso+_flip,x
		and #$EF
		sta s_perso+_flip,x
		rts
	+:
	
	lda s_perso+_flip,x
	and #$EF
	sta s_perso+_flip,x

	
	
	
	
	rts
	
Deplacement_perso:


	lda s_perso+_vtmp,x
	cmp s_perso+_vlim,x
	bne +
		cmp #0
		beq ++
		
		stz s_perso+_vx,x
		stz s_perso+_vy,x
		
		stz s_perso+_vx+1,x
		stz s_perso+_vy+1,x
		stz s_perso+_vtmp,x
		bra ++
	+:
		ina
		sta s_perso+_vtmp,x
	++:

	rep #$20
	
	
	
	lda s_perso+_vx,x
	clc
	adc s_perso+_x,x
	sta s_perso+_x,x
	
	lda s_perso+_vy,x
	clc
	adc s_perso+_y,x
	sta s_perso+_y,x
	
	
	lda #0
	sta s_perso+_vx,x
	sta s_perso+_vy,x
	
	sep #$20
	
	
	rts
