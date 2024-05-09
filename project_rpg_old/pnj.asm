

IA_perso_pnj:

	lda s_pnj + $1F,X
	cmp #0
	beq +
		rts
	+:
	
	;IA
	inc s_pnj + $0B,X

	lda s_pnj + $0B,X
	cmp #60
	bmi +
		stz s_pnj + $0A,X
		stz s_pnj + $0B,X
		
		jsr Random
		
		ldy rand8
		tya
		adc s_perso + 2
		adc s_perso + 3
		tay
		lda Randomp.l,Y
				
		cmp #$00
		bne ++
			lda #0
			sta s_pnj + $0A,X
			
			rep #$20
			
			lda s_pnj + $1C,X
			clc
			adc #$1000
			sta s_pnj + $18,X
			
			sep #$20
			
			bra +
		++:
		
		cmp #$01
		bne ++
			lda #1
			sta s_pnj + $0A,X
			
			rep #$20
			
			lda s_pnj + $1C,X
			sta s_pnj + $18,X
			
			sep #$20
			
			bra +
		++:
		
		cmp #$02
		bne ++
			lda #2
			sta s_pnj + $0A,X
			
			rep #$20
			
			lda s_pnj + $1C,X
			clc
			adc #$0800
			sta s_pnj + $18,X
			
			sep #$20
			
			bra +
		++:
		
		cmp #$03
		bne ++
			lda #3
			sta s_pnj + $0A,X
			
			rep #$20
			
			lda s_pnj + $1C,X
			clc
			adc #$0800
			sta s_pnj + $18,X
			
			sep #$20
			
			bra +
		++:
			
	+:
	
	lda s_pnj + $0A,X
	cmp #$00
	bne +
		lda #-1
		sta s_pnj + $06,X
	+:
	
	
	lda s_pnj + $0A,X
	cmp #$01
	bne +
		lda #1
		sta s_pnj + $06,X
	+:
	
	lda s_pnj + $0A,X
	cmp #$02
	bne +
		lda #-1
		sta s_pnj + $04,X
	+:
	
	lda s_pnj + $0A,X
	cmp #$03
	bne +
		lda #1
		sta s_pnj + $04,X
	+:
	
	rts

Draw_pnj:

		stz s_pnj +$08,X
		;--------INIT--------
		rep #$20
		
		lda #0
		sta MEM_TEMP     ; si = 4 alors il se trouve a écran
		sta MEM_TEMP + 2 ; variable temporaire
		sta MEM_TEMP + 4 ; MSB
		ldx MEM_TEMPFUNC ; id pnj
		stx MEM_TEMPFUNC + 12; copy id pnj

		;--------HSCROLL--------		
		lda #0
		sta MEM_TEMP + 2
		
		lda s_pnj,X
		cmp #$0100
		bmi +
			lda s_pnj,X
			sec
			sbc #$0100
			sta MEM_TEMP + 2
		+:

		lda MEM_TMPSCROLLING + 4
		cmp MEM_TEMP + 2
		bmi +
			inc MEM_TEMP
		+:
		
		lda MEM_TMPSCROLLING + 4
		sbc #$20
		cmp s_pnj,X
		bpl +
			inc MEM_TEMP
			
			;MSB
			lda MEM_TMPSCROLLING + 4
			cmp s_pnj,X
			bmi +
				lda #1
				sta MEM_TEMP + 4
		+:
		
		;--------VSCROLL--------
		lda #0
		sta MEM_TEMP + 2
		
		lda s_pnj + 2,X
		cmp #$0100
		bmi +
			lda s_pnj + 2,X
			sbc #$0100
			sta MEM_TEMP + 2
		+:
		
		lda MEM_TMPSCROLLING + 6
		cmp MEM_TEMP + 2
		bmi +
			inc MEM_TEMP
		+:
		
		lda MEM_TMPSCROLLING + 6
		cmp s_pnj + 2,X
		bpl +
			inc MEM_TEMP
		+:
				
		sep #$20
		
		
		
		;CMP SCROLL (s'il se trouve a écran)
		lda MEM_TEMP
		cmp #$04
		beq +
			rts
		+:
		;--------DRAW--------
		
		ldy MEM_OAM + $08
		sty MEM_TEMPFUNC + 8
		lda MEM_OAM + $08
		sta s_pnj +$09,X

		inc MEM_OAM + $08
		
		lda MEM_OAM,Y
		sta s_pnj +$08,X
		sta MEM_TEMP + 14
		
		
					
		stz MEM_TEMPFUNC + 5
		
		;init OAM
		clc
		lda #0
		adc MEM_TMPSCROLLING + 4
		eor #$FF
		clc
		adc s_pnj,X
		sta MEM_TEMPFUNC
		sta s_oam + $08,Y		
		
		
		;-------id-------
		rep #$20
		tya
		asl A
		phy
		tay
		txa
		sta s_oam_id,Y
		ply
		sep #$20
		;----------------
		
		
		
		clc
		lda #0
		adc MEM_TMPSCROLLING + 6
		adc #$20
		eor #$FF
		inc A
		clc
		adc s_pnj + 2,X
		sta MEM_TEMPFUNC + 1
		sta s_oam,Y
		
		stz MEM_TEMP
		stz MEM_TEMP + 1
				
		;coupe du pnj	
		lda MEM_TEMP + 4
		cmp #1
		bne +
			jsr Valeur_OAM
			ldx MEM_TEMPFUNC + 6
			stx MEM_TEMP
			
			lda #%00000101
			sta s_msb,X
			sta MEM_TEMPFUNC + 5
			
			lda MEM_TEMPFUNC
			cmp #-16
			bpl +
				lda #%01010101
				sta s_msb,X	
		+:
		
		
		;OAM
		lda MEM_TEMP + 14
		sec
		sbc #$80
		asl A
		rep #$20
		
		clc
		adc #t_oam
		sta MEM_TEMP + 14
		sep #$20
		
		stz MEM_TEMPFUNC + 4

		ldx MEM_TEMPFUNC + 12
		lda s_pnj + $0A,X
		cmp #$03
		bne +
			lda MEM_TEMPFUNC + 3
			ora #$40
			ora s_pnj + $0D,X
			sta MEM_TEMPFUNC + 3
			
			ldx MEM_TEMP + 14
			jsr Draw_oam_32_fx
			
			bra ++
		+:
			lda MEM_TEMPFUNC + 3
			ora s_pnj + $0D,X
			sta MEM_TEMPFUNC + 3
			
			ldx MEM_TEMP + 14
			jsr Draw_oam_32
		++:
		
		
		
		
	rts
	
Animation_pnj:

	lda  s_pnj +$08,X
	cmp #0
	bne +
		rts
	+:

	lda s_pnj + $1F,X
	cmp #0
	beq +
		stz s_pnj + $12,X
		
		lda s_pnj + $0A,X
		cmp #0
		bne ++
			rep #$20
			
			lda s_pnj + $1C,X
			clc
			adc #$1000
			sta s_pnj + $18,X
			
			sep #$20
			bra +
		++:
		cmp #1
		bne ++
			rep #$20
			
			lda s_pnj + $1C,X
			sta s_pnj + $18,X
			
			sep #$20
			bra +
		++:
		cmp #2
		bne ++
			rep #$20
			
			lda s_pnj + $1C,X
			clc
			adc #$0800
			sta s_pnj + $18,X
			
			sep #$20
			bra +
		++:
		cmp #3
		bne ++
			rep #$20
			
			lda s_pnj + $1C,X
			clc
			adc #$0800
			sta s_pnj + $18,X
			
			sep #$20
		++:
		
	+:
	

	;Animation
	lda s_pnj + $12,X
	cmp #9 ;speed animation
	bmi +
		lda s_pnj + $10,X
		clc
		adc #4
		sta s_pnj + $10,X
		
		stz s_pnj + $12,X
	+:

	;tmp animation cadence
	inc s_pnj + $12,X
	
	;nanim max (4)
	lda s_pnj + $10,X
	cmp #$10
	bmi +
		stz s_pnj + $10,X
	+:
	
	stz MEM_TEMP
	stz MEM_TEMP + 1
	
	;si animation change
	lda s_pnj + $10,X
	cmp s_pnj + $15,X
	beq +
		lda s_pnj + $10,X
		sta s_pnj + $15,X
		lda #1
		sta MEM_TEMP
	+:
	
	rep #$20
	
	;si on change anim en renvoie le DMA
	lda s_pnj + $18,X
	cmp s_pnj + $1A,X
	beq +
		lda s_pnj + $18,X
		sta s_pnj + $1A,X
		lda #1
		sta MEM_TEMP
	+:
	
	;store DMA enable
	lda MEM_TEMP
	cmp #$0000
	beq +
		lda s_pnj + $10,X
		asl A
		asl A
		asl A
		asl A
		asl A
		sta MEM_TEMP
		
		lda s_pnj + $18,X
		
		clc
		adc MEM_TEMP
		
		sta MEM_DMA,Y
	+:
	
	sep #$20

	rts

