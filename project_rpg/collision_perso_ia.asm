
rep #$20
Collision_ch2:
	
	lda #$0
	sta MEM_TEMPFUNC
	
	ldy #1
	sty MEM_TEMP+8
	
	
	collision_perso 0
	collision_perso 2
	collision_perso 4
	
	rts
sep #$20
	
Collision_perso:


	
	rep #$20
	
	
	
	lda s_perso+_vx,x
	cmp #1
	bmi +	

		lda s_perso+_x,x
		ina
		ina
		sta MEM_TEMP+4
		clc
		adc #16
		sta MEM_TEMP+6

		lda s_perso+_y,x
		sec
		sbc #8
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		
		
		jsr Collision_ch2
		
		lda MEM_TEMP+8
		cmp #0
		bne +
			stz s_perso+_vx,x
	+:
	
	
	
	
	lda s_perso+_vx,x
	cmp #0
	bpl +	

		lda s_perso+_x,x
		sec
		sbc #16 + 2
		sta MEM_TEMP+4
		clc
		adc #8
		sta MEM_TEMP+6

		lda s_perso+_y,x
		sec
		sbc #8
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		jsr Collision_ch2
		
		lda MEM_TEMP+8
		cmp #0
		bne +
			stz s_perso+_vx,x
	+:
	
	
	lda s_perso+_vy,x
	cmp #1
	bmi +	

		lda s_perso+_x,x
		sec
		sbc #16
		sta MEM_TEMP+4
		clc
		adc #32
		sta MEM_TEMP+6

		lda s_perso+_y,x
		ina
		ina
		sta MEM_TEMP
		clc
		adc #8
		sta MEM_TEMP+2
		
		jsr Collision_ch2
		
		lda MEM_TEMP+8
		cmp #0
		bne +
			stz s_perso+_vy,x
			
	+:
	
	lda s_perso+_vy,x
	cmp #0
	bpl +	

		lda s_perso+_x,x
		sec
		sbc #16
		sta MEM_TEMP+4
		clc
		adc #32
		sta MEM_TEMP+6

		lda s_perso+_y,x
		sec
		sbc #10
		sta MEM_TEMP
		clc
		adc #8
		sta MEM_TEMP+2
		
		jsr Collision_ch2
		
		lda MEM_TEMP+8
		cmp #0
		bne +
			stz s_perso+_vy,x
	+:
	
	sep #$20
	
	rts
