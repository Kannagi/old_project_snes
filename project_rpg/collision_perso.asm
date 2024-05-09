

.MACRO collision_perso
	
	ldy LKS_OAM+$10+\1
	lda s_perso+_y,y
	
	cmp MEM_TEMP
	bmi +
	
	cmp MEM_TEMP+2
	bpl +
	
	lda s_perso+_x,y
	cmp MEM_TEMP+4
	bmi +
	
	cmp MEM_TEMP+6
	bpl +

	stz MEM_TEMP+8
	sty MEM_TEMPFUNC
	rts
	+:
	
.ENDM

rep #$20
Collision_perso_text_ch:

	stz MEM_TEMPFUNC
	stz MEM_TEMPFUNC+1

	collision_perso 6
	collision_perso 8
	collision_perso 10
	collision_perso 12
	collision_perso 14
	
	collision_perso 16
	collision_perso 18
	collision_perso 20
	collision_perso 22

	rts
sep #$20

Collision_perso_text:


	lda s_map+_mode
	cmp #0
	beq +
		rts
	+:
	
	rep #$20
	
	
	
	
	lda s_perso+_direction
	and #$00FF
	cmp #0
	bne +
		lda s_perso+_x
		sec
		sbc #16
		sta MEM_TEMP+4
		clc
		adc #32
		sta MEM_TEMP+6
		
		
		lda s_perso+_y
		
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		ldy LKS_OAM+$10+6
		lda s_perso+_y,y
		
		jsr Collision_perso_text_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			inc s_text+_texton
			
			lda #1
			sta s_perso+_text
			sta s_perso+_text,x
			
			;lda s_text+_texton
			;cmp #2
			;bne +
				;lda #1
				;sta s_perso+_text
				;sta s_perso+_text,x
	+:
	
	
	
	lda s_perso+_direction
	and #$00FF
	cmp #1
	bne +
		lda s_perso+_x
		sec
		sbc #16
		sta MEM_TEMP+4
		clc
		adc #32
		sta MEM_TEMP+6
		
		
		lda s_perso+_y
		sec
		sbc #16
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		ldy LKS_OAM+$10+6
		lda s_perso+_y,y
		
		jsr Collision_perso_text_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			inc s_text+_texton
			lda #1
			sta s_perso+_text
			sta s_perso+_text,x
	+:
	
	
	
	
	lda s_perso+_direction
	cmp #2
	bne +
		lda s_perso+_x
		sta MEM_TEMP+4
		clc
		adc #28
		sta MEM_TEMP+6
		
		
		lda s_perso+_y
		sec
		sbc #8
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		ldy LKS_OAM+$10+6
		lda s_perso+_y,y
		
		jsr Collision_perso_text_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			inc s_text+_texton
			lda #1
			sta s_perso+_text
			sta s_perso+_text,x
	+:
	
	lda s_perso+_direction
	cmp #3
	bne +
		lda s_perso+_x
		sec
		sbc #28
		sta MEM_TEMP+4
		clc
		adc #16
		sta MEM_TEMP+6
		
		
		lda s_perso+_y
		sec
		sbc #8
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		ldy LKS_OAM+$10+6
		lda s_perso+_y,y
		
		jsr Collision_perso_text_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			inc s_text+_texton
			lda #1
			sta s_perso+_text
			sta s_perso+_text,x
	+:
	
	
	
	
	
	sep #$20
	
	rts

rep #$20
Collision_ch:
	
	stz MEM_TEMPFUNC
	stz MEM_TEMPFUNC+1
	
	collision_perso 6
	collision_perso 8
	collision_perso 10
	
	lda s_map+_mode
	cmp #0
	beq +
		rts
	+:
	
	collision_perso 12
	collision_perso 14
	
	collision_perso 16
	collision_perso 18
	collision_perso 20
	collision_perso 22
	rts
sep #$20

	
Collision_perso1:

	rep #$20
	
	lda s_perso+_vx
	cmp #1
	bmi +	

		lda s_perso+_x
		ina
		ina
		sta MEM_TEMP+4
		clc
		adc #16
		sta MEM_TEMP+6

		lda s_perso+_y
		sec
		sbc #8
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		jsr Collision_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			lda s_perso+_vx,x
			clc
			adc s_perso+_vx
			sta s_perso+_vx,x
			
			stz s_perso+_vx
	+:
	
	lda s_perso+_vx
	cmp #0
	bpl +	

		lda s_perso+_x
		sec
		sbc #16 + 2
		sta MEM_TEMP+4
		clc
		adc #8
		sta MEM_TEMP+6

		lda s_perso+_y
		sec
		sbc #8
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		jsr Collision_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			lda s_perso+_vx,x
			clc
			adc s_perso+_vx
			sta s_perso+_vx,x
			
			stz s_perso+_vx
	+:
	
	
	lda s_perso+_vy
	cmp #1
	bmi +	

		lda s_perso+_x
		sec
		sbc #16
		sta MEM_TEMP+4
		clc
		adc #32
		sta MEM_TEMP+6

		lda s_perso+_y
		ina
		ina
		sta MEM_TEMP
		clc
		adc #8
		sta MEM_TEMP+2
		
		jsr Collision_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			lda s_perso+_vy,x
			clc
			adc s_perso+_vy
			sta s_perso+_vy,x
			
			stz s_perso+_vy
			
	+:
	
	lda s_perso+_vy
	cmp #0
	bpl +	

		lda s_perso+_x
		sec
		sbc #16
		sta MEM_TEMP+4
		clc
		adc #32
		sta MEM_TEMP+6

		lda s_perso+_y
		sec
		sbc #10
		sta MEM_TEMP
		clc
		adc #8
		sta MEM_TEMP+2
		
		jsr Collision_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			lda s_perso+_vy,x
			clc
			adc s_perso+_vy
			sta s_perso+_vy,x
			
			stz s_perso+_vy
	+:
	
	sep #$20
	
	rts
	
Collision_perso2:

	rep #$20
	
	lda s_perso+_vx+$40
	cmp #1
	bmi +	

		lda s_perso+_x+$40
		ina
		ina
		sta MEM_TEMP+4
		clc
		adc #16
		sta MEM_TEMP+6

		lda s_perso+_y+$40
		sec
		sbc #8
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		jsr Collision_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			lda s_perso+_vx,x
			clc
			adc s_perso+_vx+$40
			sta s_perso+_vx,x
			
			stz s_perso+_vx+$40
	+:
	
	lda s_perso+_vx+$40
	cmp #0
	bpl +	

		lda s_perso+_x+$40
		sec
		sbc #16 + 2
		sta MEM_TEMP+4
		clc
		adc #8
		sta MEM_TEMP+6

		lda s_perso+_y+$40
		sec
		sbc #8
		sta MEM_TEMP
		clc
		adc #16
		sta MEM_TEMP+2
		
		jsr Collision_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			lda s_perso+_vx,x
			clc
			adc s_perso+_vx+$40
			sta s_perso+_vx,x
			
			stz s_perso+_vx+$40
	+:
	
	
	lda s_perso+_vy+$40
	cmp #1
	bmi +	

		lda s_perso+_x+$40
		sec
		sbc #16
		sta MEM_TEMP+4
		clc
		adc #32
		sta MEM_TEMP+6

		lda s_perso+_y+$40
		ina
		ina
		sta MEM_TEMP
		clc
		adc #8
		sta MEM_TEMP+2
		
		jsr Collision_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			lda s_perso+_vy,x
			clc
			adc s_perso+_vy+$40
			sta s_perso+_vy,x
			
			stz s_perso+_vy+$40
			
	+:
	
	lda s_perso+_vy+$40
	cmp #0
	bpl +	

		lda s_perso+_x+$40
		sec
		sbc #16
		sta MEM_TEMP+4
		clc
		adc #32
		sta MEM_TEMP+6

		lda s_perso+_y+$40
		sec
		sbc #10
		sta MEM_TEMP
		clc
		adc #8
		sta MEM_TEMP+2
		
		jsr Collision_ch
		
		ldx MEM_TEMPFUNC
		cpx #0
		beq +
			lda s_perso+_vy,x
			clc
			adc s_perso+_vy+$40
			sta s_perso+_vy,x
			
			stz s_perso+_vy+$40
	+:
	
	sep #$20
	
	rts
	
