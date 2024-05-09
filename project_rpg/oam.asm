
Set_Draw_OAMp:

	stz MEM_TEMP
	lda s_perso+_tag,x
	cmp #3
	bne +
		lda #$30
		sta MEM_TEMP
	+:
	
	lda s_perso+_tile,x
	sta MEM_TEMP+4

	lda s_perso+_flip,x
	sta MEM_TEMP+5
	
	phx
	pha
	
	tyx
	
	;OAM 1&2
	lda MEM_TEMPFUNC+$C
	sta LKS_BUF_OAML,x
	clc
	adc #$10
	sta LKS_BUF_OAML+4,x
	
	lda MEM_TEMPFUNC+$E
	sta LKS_BUF_OAML+1,x
	sta LKS_BUF_OAML+5,x
	
	lda MEM_TEMP+5
	ora MEM_TEMP
	sta LKS_BUF_OAML+3,x
	sta LKS_BUF_OAML+7,x
	
	;OAM 3&4
	lda MEM_TEMPFUNC+$C
	sta LKS_BUF_OAML+8,x
	clc
	adc #$10
	sta LKS_BUF_OAML+12,x
	
	lda MEM_TEMPFUNC+$E
	clc
	adc #$10
	sta LKS_BUF_OAML+9,x
	sta LKS_BUF_OAML+13,x
	
	lda MEM_TEMP+5
	sta LKS_BUF_OAML+11,x
	sta LKS_BUF_OAML+15,x
	
	pla
	
	bit #$40
	bne +
	
	lda MEM_TEMP+4
	sta LKS_BUF_OAML+2,x
	clc
	adc #2
	sta LKS_BUF_OAML+6,x
	
	lda MEM_TEMP+4
	clc
	adc #4
	sta LKS_BUF_OAML+10,x
	adc #2
	sta LKS_BUF_OAML+14,x

	plx
	rts
	+:
	
	;Flip X

	lda MEM_TEMP+4
	sta LKS_BUF_OAML+6,x
	clc
	adc #2
	sta LKS_BUF_OAML+2,x
	
	lda MEM_TEMP+4
	clc
	adc #4
	sta LKS_BUF_OAML+14,x
	adc #2
	sta LKS_BUF_OAML+10,x

	plx
	rts
	
	



	
