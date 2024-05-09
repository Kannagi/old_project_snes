
	
Draw_hero:
		stz MEM_TEMP

		;Animation
		lda s_perso + 4
		cmp #7 ;speed animation
		bmi +
			lda s_perso + 2
			clc
			adc #4
			sta s_perso + 2
			
			stz s_perso + 4
		+:

		;tmp animation cadence
		inc s_perso + 4
		
		
		;nanim max (4)
		lda s_perso + 2
		cmp #$10
		bmi +
			stz s_perso + 2
		+:
		
		;si no play anim
		lda s_perso + 5
		cmp #0
		bne +
			stz s_perso + 2
			;stz s_perso + 4
		+:
		
		;si animation change
		lda s_perso + 2
		cmp s_perso + 11
		beq +
			lda s_perso + 2
			sta s_perso + 11
			lda #1
			sta MEM_TEMP
		+:
		
		
		;si on change anim en renvoie le DMA
		ldx s_perso + 7 
		cpx s_perso + 9
		beq +
			ldx s_perso + 7 
			stx s_perso + 9
			lda #1
			sta MEM_TEMP
		+:
		
		;store DMA enable
		lda MEM_TEMP
		cmp #$00
		beq +
			rep #$20
			
			lda s_perso + 2
			asl A
			asl A
			asl A
			asl A
			asl A
			sta MEM_TEMP
			
			ldx s_perso + 7  
			
			txa
			clc
			adc MEM_TEMP
			tax
			
			sep #$20
			
			stx MEM_DMA + 2
		+:

		
				
		;
		ldx MEM_OAM + $08
		inc MEM_OAM + $08
		
		lda s_perso + 0
		sta MEM_TEMPFUNC + 0
		sta s_oam + $08,X
		
		lda s_perso + 1
		sta MEM_TEMPFUNC + 1
		sta s_oam,X
		
		stz MEM_TEMPFUNC + 2
		
		lda s_perso + 3
		sta MEM_TEMPFUNC + 3
		
		lda s_perso + $10
		sta MEM_TEMPFUNC + 4
		
		stz MEM_TEMPFUNC + 5
		
		;OAM
		lda MEM_OAM,X
		sta MEM_TEMP
		stz MEM_TEMP + 1
		
		rep #$20
		lda MEM_TEMP
		
		sec
		sbc #$80
		asl A
		
		clc
		adc #t_oam
		
		tax
		sep #$20
				
		lda s_perso + 3
		and #$40
		cmp #$40
		beq +
			jsr Draw_oam_32
			bra ++
		+:
			jsr Draw_oam_32_fx
		++:
		
	rts
