

mul:

	
	rep #$20
	
	lda #mul_add+2*20
	sec
	sbc MEM_TEMPFUNC
	sbc MEM_TEMPFUNC
	sta MEM_TEMP
	
	
	
	
	lda #0
	ldx #0
	clc
	jsr (MEM_TEMP,x)
	tay
	sep #$20
	
	
	
	
	rts

rep #$20
mul_add:

	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2

	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	adc MEM_TEMPFUNC+2
	

	rts
sep #$20
	
