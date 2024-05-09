

.MACRO mRand8
	; Utilise le registre A
	; C'est une version utilisant les opérations en 16 bits car j'arrive pas à gérer le truc en 8 bit avec les flags n, s et v
	lda #0
	xba
	lda rand8

	rep #$20

	asl
	asl	; A *= 4
	
	clc
	adc rand8
	
	clc
	adc #3
	
	and #$00ff
	clc
	
	sep #$20
	sta rand8
.ENDM


