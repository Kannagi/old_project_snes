	
	
Scrolling:

	
	;X----------
		
	;Right
	lda s_perso
	cmp #0
	bpl +
		cmp #LIMIT_CAMERAW
		bmi +
			lda MEM_TMPSCROLLING
			inc A
			inc A
			sta MEM_TMPSCROLLING
			
			lda #LIMIT_CAMERAW-1
			sta s_perso
	+:


	;Left
	lda s_perso
	cmp #0
	bmi +
		ldy MEM_HSCROLLING
		cpy #0
		beq +
			cmp #LIMIT_CAMERAX
			bpl +
				lda MEM_TMPSCROLLING
				dec A
				dec A
				sta MEM_TMPSCROLLING
				
				lda #LIMIT_CAMERAX
				sta s_perso
	+:
	
	
	
	lda MEM_TMPSCROLLING
	cmp #16 + $20
	bmi +
		
		ldy MEM_HSCROLLING
		iny
		iny
		sty MEM_HSCROLLING
		
		lda #$20 
		sta MEM_TMPSCROLLING
		sta MEM_TMPSCROLLING + 8
	+:
	
	
	lda MEM_TMPSCROLLING
	cmp #-15 + $20
	bpl +
		ldy MEM_HSCROLLING
		dey
		dey
		sty MEM_HSCROLLING
		
		lda #$20
		sta MEM_TMPSCROLLING
		sta MEM_TMPSCROLLING + 8
	+:
	
	;Y----------
	
	;down
	lda s_perso + 1
	cmp #0
	bpl +
		cmp #LIMIT_CAMERAH
		bmi +
			lda MEM_TMPSCROLLING + 2
			inc A
			inc A
			sta MEM_TMPSCROLLING + 2
			
			lda #LIMIT_CAMERAH - 1
			sta s_perso + 1
			
	+:
			
	;up	
	lda s_perso + 1
	cmp #0
	bmi +
		cmp #LIMIT_CAMERAY
		bpl +
			lda MEM_VSCROLLING
			cmp #$00
			beq +
				lda MEM_TMPSCROLLING + 2
				dec A
				dec A
				sta MEM_TMPSCROLLING + 2
				
				lda #LIMIT_CAMERAY
				sta s_perso + 1
	+:	
	
	lda MEM_TMPSCROLLING + 2
	cmp #16 + $10
	bmi +
		inc MEM_VSCROLLING
		
		lda #$10
		sta MEM_TMPSCROLLING + 2
		sta MEM_TMPSCROLLING + 8
	+:

	
	lda MEM_TMPSCROLLING + 2
	cmp #-15 + $10
	bpl +
		
		dec MEM_VSCROLLING
		
		lda #$10
		sta MEM_TMPSCROLLING + 2
		sta MEM_TMPSCROLLING + 8
	+:
	
	;---------
	
	rts
