;test pal
		
		lda MEM_STDCTRL + $02
		cmp #$00
		bne +
			ldx #pallette_eagle1
			stx MEM_PAL
			jmp Game
		+:
		
		
		inc MEM_PAL + 2
		lda MEM_PAL + 2
		cmp #$2
		bne +
			inc MEM_PAL + 3
			stz MEM_PAL + 2
			
			ldx MEM_PAL
		
			rep #$20
			txa
			clc
			adc #$20
			tax
			sep #$20
			
			stx MEM_PAL
		+:
		
		lda MEM_PAL + 3
		cmp #$10
		bne +
			ldx #pallette_effect
			stx MEM_PAL
			stz MEM_PAL + 3
		+: