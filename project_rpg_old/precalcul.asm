
precalcul_scrolling_ch:
	
	rep #$20
	
	;precalcul scroll X
	lda MEM_HSCROLLING
	asl A
	asl A
	asl A
	
	clc
	adc MEM_TMPSCROLLING
	sta MEM_TMPSCROLLING + 4
	
	
	;precalcul scroll Y
	lda MEM_VSCROLLING
	asl A
	asl A
	asl A
	asl A
	
	clc
	adc MEM_TMPSCROLLING + 2
	sta MEM_TMPSCROLLING + 6
	
	sep #$20

	rts
	
