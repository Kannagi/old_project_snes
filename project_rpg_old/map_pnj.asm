
.MACRO pnj_complete

	;Draw pnj
	ldx #\3
	stx MEM_TEMPFUNC + 2
	
	ldx #\1
	stx MEM_TEMPFUNC
	jsr Draw_pnj


	ldx #\1
	stx MEM_TEMPFUNC
	
	ldy #\2
	jsr Animation_pnj
	
	
	;collision
	jsr IA_perso_pnj
	jsr Collision_perso_pnj
	jsr Collision_mur_pnj
	jsr Deplacement_pnj
.ENDM

.MACRO pnj_only_draw

	;Draw pnj
	ldx #\1
	stx MEM_TEMPFUNC
	
	lda #0
	sta s_pnj + $0A,X
	
	ldx #\2
	stx MEM_TEMPFUNC + 2
	
	jsr Draw_pnj

.ENDM

Map0_pnj:
	
	rts
	
Map1_pnj:
	
	pnj_complete  $00 6 $0208
	pnj_complete  $40 8 $040C
	pnj_complete  $60 10 $0640
	pnj_complete  $80 12 $0844
	pnj_complete  $A0 14 $0848
	pnj_only_draw $20 $024C

	rts
	
Load_Map1_pnj:

	init_pnj $0090 $0130 $00 old_man Texte_2
	init_pnj $0330 $00E0 $20 old_man Texte_3
	init_pnj $0220 $0110 $40 Man Texte_4
	init_pnj $0200 $0230 $60 Jean Texte_6
	init_pnj $0100 $0380 $80 Soldat Texte_9
	init_pnj $0300 $0300 $A0 Soldat Texte_10
	
	ldx #old_man
	stx MEM_DMA + 16
	
	
	
	rts

Map2_pnj:
	pnj_complete  $00 6 $0808
	pnj_only_draw $20 $020C
	
	lda MEM_PAL + 4
	inc A
	sta MEM_PAL + 4
	cmp #4
	bne +
		inc MEM_PAL + 3
		stz MEM_PAL + 4
		
		rep #$20
	
		lda MEM_PAL
		clc
		adc #2
		sta MEM_PAL
		
		sep #$20
	+:
	
	lda MEM_PAL + 3		
	cmp #15
	bne +
		rep #$20
		lda MEM_PAL
		sec
		sbc #30
		sta MEM_PAL
		sep #$20
	
		stz MEM_PAL + 3
	+:
	

	rts
	
Load_Map2_pnj:

	init_pnj $0070 $0110 $00 Soldat Texte_11
	init_pnj $0130 $00C0 $20 Papi Texte_12
	
	ldx #Papi
	stx MEM_DMA + 8
	
	ldx #Eagle1 + $1000
	stx MEM_DMA + 2
	
	ldx #pallette_eau
	stx MEM_PAL
	
	lda #:pallette_eau
	sta MEM_PAL + 2
	
	stz MEM_PAL + 3
	stz MEM_PAL + 4
	
	rts
