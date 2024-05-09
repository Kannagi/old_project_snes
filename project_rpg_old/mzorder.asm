
.MACRO z_order_oam_cmp

	ldx MEM_TEMP + 1
	cpx #-32
	beq ++	
		lda s_oam + \1
		sta MEM_TEMP + 3
		
		ldx MEM_TEMP + 1
		cpx MEM_TEMP + 3
		bpl +
			clc
			lda MEM_TEMP
			adc #$08
			sta MEM_TEMP
		+:
		
		lda MEM_TEMP + 1
		cmp MEM_TEMP + 3
		bne +
			inc MEM_TEMP + 5
		+:
	
	++:
	
.ENDM

.MACRO z_order_oam_plus

	lda MEM_TEMP + $08 + \1
	cmp MEM_TEMP
	bne ++
		lda MEM_TEMP + 6
		clc
		adc #8
		sta MEM_TEMP + 6
	++:
	
.ENDM

.MACRO z_order_oam ARGS _arg1
	lda #$80
	sta MEM_TEMP
	
	
	lda s_oam + \1
	sta MEM_TEMP + 1
	stz MEM_TEMP + 2
	stz MEM_TEMP + 4
	stz MEM_TEMP + 5
	
	.IF _arg1 != $00
			z_order_oam_cmp $00
	.ENDIF
	
	.IF _arg1 != $01
			z_order_oam_cmp $01
	.ENDIF
	
	.IF _arg1 != $02
			z_order_oam_cmp $02
	.ENDIF
	
	.IF _arg1 != $03
			z_order_oam_cmp $03
	.ENDIF
	
	.IF _arg1 != $04
			z_order_oam_cmp $04
	.ENDIF
	
	.IF _arg1 != $05
			z_order_oam_cmp $05
	.ENDIF
	
	.IF _arg1 != $06
			z_order_oam_cmp $06
	.ENDIF
	
	.IF _arg1 != $07
			z_order_oam_cmp $07
	.ENDIF
		
	.IF _arg1 != $00
		lda MEM_TEMP + 5
		cmp #0
		beq +
			stz MEM_TEMP + 6
			
			z_order_oam_plus $00
			z_order_oam_plus $01
			z_order_oam_plus $02
			z_order_oam_plus $03
			
			z_order_oam_plus $04
			z_order_oam_plus $05
			z_order_oam_plus $06
			z_order_oam_plus $07
			
			lda MEM_TEMP
			sta MEM_TEMP + $08 + \1
			clc
			adc MEM_TEMP + 6
			sta MEM_TEMP
		+:
	.ELSE
		lda MEM_TEMP
		sta MEM_TEMP + $08 + \1
	.ENDIF



	lda MEM_TEMP
	sta MEM_OAM + \1
	
	
.ENDM
