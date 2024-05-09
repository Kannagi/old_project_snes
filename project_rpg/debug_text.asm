
Text:

		;LKS_SPC_Get LKS_SPC_TICKS
		;ldy APUIO2
		;ldy #$C21F
		;LKS_printh16 6,23
		
		;lda APUIO2
		;LKS_printh8 6,20
		
		/*
		lda APUIO0
		LKS_printh8 6,20
		
		lda LKS_SPC_VAR
		LKS_printh8 6,21
		*/
		
		;LKS_SPC_Get LKS_SPC_TICKS
		ldy APUIO2
		LKS_printf16 6,23

		
		;text
		lda LKS_VBLANK+_vbltimemin
		sta MEM_TEMP
		stz MEM_TEMP+1
		
		rep #$20
		lda MEM_TEMP
		
		asl a
		asl a
		asl a
		clc
		adc MEM_TEMP
		adc MEM_TEMP
		
		tay
		sep #$20
		ldy LKS_VBLANK+_vbltimemin
		LKS_printf16 6,24
		
		
		
		;ldx #2
		;;stx MEM_TEMPFUNC+2
		;ldx #8
		;stx MEM_TEMPFUNC
		;jsr mul
		
		;ldy s_ennemi+_enP1
		;LKS_printfu16 18,2
		
		
		;ldy $650
		;LKS_printfu16 18,4
		
		;lda MEM_OAM+_nperso1
		
		;LKS_printf8 1,6
		/*
		inc $652
		lda $652
		cmp #30
		bne +
			inc $650
			stz $652
		+:
		*/
		
		lda $1800
		LKS_printh8 0,22
		
		ldy $1804
		LKS_printh16 4,22
		
		lda #30
		cmp $1802
		bne +
			inc $1800
			stz $1802
		+:
		inc $1802
		
		lda LKS_CPU
		LKS_printf8 6,25
		LKS_printfc 8,25,$2004 ; %
		
		/*
		
		
		
/*
stz s_menu+_angle
		stz s_menu+_eangle
		stz s_menu+_ering
		stz s_menu+_ring_dir
		stz s_menu+_ringl


		ldx s_perso+_oam
		lda MEM_OAML+3,x
		and #$30
		lsr a
		lsr a
		lsr a
		lsr a
		LKS_printf8 5,6

	*/	
		
		
		rts
		
	

	
	
Text2:

	ldx	#text_s2
	LKS_printfs 1,25
	
	;ldx	#text_s1
	;LKS_printfs 1,3
	
		
	ldx	#text_s3
	LKS_printfs 1,24
	
	ldx	#text_ticks
	LKS_printfs 1,23

	rts
	
text_ticks:
	.db "tick",0
text_s1:
	.db "hello world",0

text_s2:
	.db "cpu",0
	
text_s3:
	.db "vblk",0
	
