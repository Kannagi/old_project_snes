
Text_draw:
/*
	LKS_printf_setpal 1 ; select pal 1
	ldx	#text_s1
	LKS_printfs 1,27
	
	LKS_printf_setpal 0 ; select pal 0
	ldx	#text_s1
	LKS_printfs 1,1
	
	ldy LKS_VBLANK+_vbltime
	LKS_printf16u 1,1
	
	*/
	lda LKS.mcpu
	LKS_printf8u 1,0
	LKS_printfc 4,0,$2004 
	
	lda LKS.pcpu
	LKS_printf8u 6,0
	LKS_printfc 6+3,0,$2004 
	
	ldy LKS.VBlankTime
	;LKS_printf16u 1,4
	
	ldy LKS.VBlankTimeS
	;LKS_printf16u 8,4
	
	ldy LKS_DEBUG
	LKS_printf16u 1,1
	
	ldy LKS_DEBUG+2
	
	
	LKS_printf16h 1,2
	
	lda SCharacter.hp
	LKS_printf8u 1,5
	
	lda LKS_BG.x
	;LKS_printf8h 1,5
	
	lda LKS_SPRITE.Anim_flg
	;LKS_printf8h 1,6
	
	lda LKS.clocks
	LKS_printf8u 1,26
	
	
	
	LKS_printf_setpal 0 ; select pal 0
	ldx	#text_s1a
	LKS_printfs 7,1
	
	ldx	#text_s2a
	LKS_printfs 12,2
	rts
	
text_s1a:
	.db "super papi commando",0,0,0,0
text_s2a:
	.db "demo snes",0,0,0,0
