
.MACRO load_map
	;adresse load
    ldx #\1
    stx s_map + $20
    
    ;adresse load pnj
    ldx #\2
    stx s_map + $22
    
    ;adresse draw pnj
    ldx #\3
    stx s_map + $24
    
    ;adresse VBLANK
    ldx #\4
    stx s_map + $26

	
.ENDM

.MACRO map_transition1
	;transition 1
    ldx #\1
    stx s_map + $30
    
    ;transition 2
    ldx #\2
    stx s_map + $32
    
    ;transition 3
    ldx #\3
    stx s_map + $34
    
    ;transition 4
    ldx #\4
    stx s_map + $36
.ENDM

.MACRO map_transition2
	;transition 5
    ldx #\1
    stx s_map + $38
    
    ;transition 6
    ldx #\2
    stx s_map + $3A
    
    ;transition 7
    ldx #\3
    stx s_map + $3C
    
    ;transition 8
    ldx #\4
    stx s_map + $3E
.ENDM

Map_change:

	lda s_map + $0D
	sta MEM_TEMP + 2
	stz MEM_TEMP + 3
	
	lda s_map + $0C
	cmp #$20
	bmi +
		sec
		sbc #$20
		ldx #1
		stx MEM_TEMPFUNC
		bra ++
	+:
		sec
		sbc #$10
		stz MEM_TEMPFUNC
		
		ldx MEM_TEMP + 2
		cpx #$00
		beq +++
			ldx #1
			stx MEM_TEMPFUNC
			bra ++
		+++:
		
		rts
	++:
	
	sta MEM_TEMP
	stz MEM_TEMP + 1
	
	rep #$20
	
	lda MEM_TEMP
	tax
	lda s_map + $30,X
	sta s_map + $0E
	
	sep #$20

	rts

Map_choix:

	ldx s_map + $0E
	
	cpx #0
	bne +
		load_map Load_map2 Load_Map2_pnj Map2_pnj Map0_pnj
		init_position_map 10 28 $70 $80
		map_transition1 1,0,0,0
		rts
	+:
	
	cpx #1
	bne +
		load_map Load_map1 Load_Map1_pnj Map1_pnj Map0_pnj
		init_position_map 90 2 $60 $60
		map_transition1 0,0,0,0
		rts
	+:
	
	cpx #2
	bne +
		load_map Load_map1 Load_Map1_pnj Map1_pnj Map0_pnj
		init_position_map 10 10 $60 $80
		map_transition1 0,0,0,0
		rts
	+:
	
	rts
	
	
