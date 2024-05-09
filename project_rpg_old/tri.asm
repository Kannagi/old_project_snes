
Tri_msb_VBlank:

    lda #$08
	sta OAMADDL
	lda #$01
	sta OAMADDH
	
	
	lda s_msb
	sta OAMDATA
	
	lda s_msb + 1
	sta OAMDATA
	
	lda s_msb + 2
	sta OAMDATA
	
	lda s_msb + 3
	sta OAMDATA
	
	lda s_msb + 4
	sta OAMDATA
	
	lda s_msb + 5
	sta OAMDATA
	
	lda s_msb + 6
	sta OAMDATA
	
	lda s_msb + 7
	sta OAMDATA
	
	stz s_msb + $00
	stz s_msb + $01
	stz s_msb + $02
	stz s_msb + $03
	
	stz s_msb + $04
	stz s_msb + $05
	stz s_msb + $06
	stz s_msb + $07


	rts
	
Tri_msb:



	
	/*
	;OAM ADD & MSB
	lda #$08
	sta OAMADDL
	lda #$01
	sta OAMADDH
	
	lda s_msb
	cmp #$00
	beq +
		lda s_msb
		sta t_hoam ; $80
		bra ++
	+:
		stz t_hoam  ; $80
	++:
	
	lda s_msb + 1
	cmp #$00
	beq +
		lda s_msb + 1
		sta OAMDATA ; $88
		bra ++
	+:
		stz OAMDATA ; $88
	++:
	
	lda s_msb + 2
	cmp #$00
	beq +
		lda s_msb + 2
		sta OAMDATA ; $90
		bra ++
	+:
		stz OAMDATA ; $90
	++:
	
	lda s_msb + 3
	cmp #$00
	beq +
		lda s_msb + 3
		sta OAMDATA ; $98
		bra ++
	+:
		stz OAMDATA ; $98
	++:
	
	lda s_msb + 4
	cmp #$00
	beq +
		lda s_msb + 4
		sta OAMDATA ; $A0
		bra ++
	+:
		stz OAMDATA ; $A0
	++:
	
	lda s_msb + 5
	cmp #$00
	beq +
		lda s_msb + 5
		sta OAMDATA ; $A8
		bra ++
	+:
		stz OAMDATA ; $A8
	++:
	
	lda s_msb + 6
	cmp #$00
	beq +
		lda s_msb + 6
		sta OAMDATA ; $B0
		bra ++
	+:
		stz OAMDATA ; $B0
	++:
	
	lda s_msb + 7
	cmp #$00
	beq +
		lda s_msb + 7
		sta OAMDATA ; $B8
		bra ++
	+:
		stz OAMDATA ; $B8
	++:
	*/

	;stz OAMADDL
	;stz OAMADDH
	
	stz s_msb + $00
	stz s_msb + $01
	stz s_msb + $02
	stz s_msb + $03
	
	stz s_msb + $04
	stz s_msb + $05
	stz s_msb + $06
	stz s_msb + $07


	rts
	
Tri_zorder:
	stz MEM_TEMP + $08
	stz MEM_TEMP + $09
	stz MEM_TEMP + $0A
	stz MEM_TEMP + $0B
	
	stz MEM_TEMP + $0C
	stz MEM_TEMP + $0D
	stz MEM_TEMP + $0E
	stz MEM_TEMP + $0F
	
	z_order_oam $00
	
	
	z_order_oam $01
	z_order_oam $02
	z_order_oam $03
	z_order_oam $04
	z_order_oam $05
	z_order_oam $06
	z_order_oam $07
	
	
	lda #-32
	;y
	sta s_oam + $00
	sta s_oam + $01
	sta s_oam + $02
	sta s_oam + $03
	sta s_oam + $04
	sta s_oam + $05
	sta s_oam + $06
	sta s_oam + $07
	;x
	sta s_oam + $08
	sta s_oam + $09
	sta s_oam + $0A
	sta s_oam + $0B
	sta s_oam + $0C
	sta s_oam + $0D
	sta s_oam + $0E
	sta s_oam + $0F

	rts
	
