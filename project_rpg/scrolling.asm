	
	
Scrolling_limite:
	
	rep #$20
	lda LKS_BG+_bg1x
	cmp #0
	bpl +
		lda #0
		sta LKS_BG+_bg1x
	+:
	
	lda LKS_BG+_bg1x
	clc
	adc #$100
	cmp LKS_BG+_bglimitex
	bmi +
		lda LKS_BG+_bglimitex
		sec
		sbc #$100
		sta LKS_BG+_bg1x
	+:
	
	lda LKS_BG+_bg1y
	cmp #0
	bpl +
		lda #0
		sta LKS_BG+_bg1y
	+:
	
	lda LKS_BG+_bg1y
	clc
	adc #$E1
	cmp LKS_BG+_bglimitey
	bmi +
		lda LKS_BG+_bglimitey
		sec
		sbc #$E1
		sta LKS_BG+_bg1y
	+:
	
	sep #$20
	
	rts
	
	

	
Scrolling_precalcul:


	jsr Scrolling_limite
	
	
	rep #$20
	
	;precalcul BGX
	lda #$10
	sta MEM_TEMP+2

	lda LKS_BG+_bgEnableX
	and #$FF
	cmp #2
	bne +
		lda #$0
		sta MEM_TEMP+2
	+:
	
	;precalcul BGY
	lda #$1E0
	sta MEM_TEMP+8
	
	lda #$10-1
	sta MEM_TEMP+10

	lda LKS_BG+_bgEnableY
	and #$FF
	cmp #2
	bne +
	
		lda #$0
		sta MEM_TEMP+8
		sta MEM_TEMP+10
	+:
	
	
	;calcul HSCROLLING
	lda LKS_BG+_bg1x
	
	lsr
	lsr
	lsr
	lsr
	
	sta LKS_BG+_bgH
	
	;calcul VMADD
	
	clc
	adc MEM_TEMP+2
	
	-:
	cmp #$20
	bmi +
		sec
		sbc #$20
	+:
	
	cmp #$20
	bpl -
	
	clc
	adc #$5000
	
	sta LKS_BG+_bg1Haddsc
	
	adc #$400
	sta LKS_BG+_bg2Haddsc
	
	;calcul VSCROLLING
	lda LKS_BG+_bg1y
	
	lsr
	lsr
	lsr
	lsr
	
	
	sta LKS_BG+_bgV
	
	;calcul VMADD
	asl
	asl
	asl
	asl
	asl
	
	clc
	adc MEM_TEMP+8
	
	
	-:
	cmp #$400
	bmi +
		sec
		sbc #$400
	+:
	
	cmp #$400
	bpl -
	
	clc
	adc #$5000
	sta LKS_BG+_bg1Vaddsc
	adc #$400
	sta LKS_BG+_bg2Vaddsc
	
	
	;----------------
	lda LKS_BG+_bgV
	
	asl
	asl
	asl
	asl
	asl
	
	clc
	adc MEM_TEMP+8
	
	ldx LKS_BG+_bgaddyr
	cpx #$40 ;512 / 32
	bmi +
		asl
	+:
	
	cpx #$80 ;1024 /64
	bmi +
		asl
	+:
	cpx #$100 ;2048 /128
	bmi +
		asl
	+:
	
	cpx #$200 ;4096 /256
	bmi +
		asl
	+:
	
	/*
	cpx #$400 ;8000 /512
	bmi +
		asl
	+:
	cpx #$800 ;16000 /1024
	bmi +
		asl
	+:
	*/
	
	sta MEM_TEMP+10
	clc
	adc s_map+_bg1
	
	sta LKS_BG+_bg2add1
	
	clc
	adc #$20
	sta LKS_BG+_bg2add2
	
	lda MEM_TEMP+10
	clc
	adc s_map+_bg2
	
	sta LKS_BG+_bg1add1
	
	clc
	adc #$20
	sta LKS_BG+_bg1add2
	
	
	;----------
	
	;calcul
	
	lda #$0
	sta MEM_TEMP+4
	sta MEM_TEMP+6
	
	lda LKS_BG+_bgV
	clc
	adc #$10
	and #$FFE0
	cmp #0
	beq +
		clc
		adc LKS_BG+_bgaddy
		sta WRMPYA
		LKS_cycle8
		lda RDMPYL
		asl a
		asl a
		asl a
		asl a
		sta MEM_TEMP+4
	+:
	
	lda LKS_BG+_bgV
	and #$FFE0
	cmp #0
	beq +
		clc
		adc LKS_BG+_bgaddy
		sta WRMPYA
		LKS_cycle8
		lda RDMPYL
		asl a
		asl a
		asl a
		asl a
		sta MEM_TEMP+6
	+:
	
	;BG1
	lda LKS_BG+_bgH
	clc
	adc MEM_TEMP+2
	asl
	clc
	adc s_map+_bg1
	sta MEM_TEMP
	adc MEM_TEMP+4
	sta MEM_TEMPFUNC
	;
	
	ldx #LKS_BUF_BGS1&$FFFF
	
	lda s_map+_bg1+2
	sta MEM_TEMP+10
	stz MEM_TEMP+11
	jsr BLOC_DRAM
	
	
	lda MEM_TEMP
	adc MEM_TEMP+6
	sta MEM_TEMPFUNC
	jsr BLOC_DRAM2
	
	;BG2
	lda LKS_BG+_bgH
	clc
	adc MEM_TEMP+2
	asl
	clc
	adc s_map+_bg2
	sta MEM_TEMP
	adc MEM_TEMP+4
	sta MEM_TEMPFUNC
	
	ldx #LKS_BUF_BGS2&$FFFF
	
	lda s_map+_bg2+2
	sta MEM_TEMP+10
	stz MEM_TEMP+11
	jsr BLOC_DRAM
	
	lda MEM_TEMP
	adc MEM_TEMP+6
	sta MEM_TEMPFUNC
	jsr BLOC_DRAM2
	
	;-------
	
	
	
	
	lda #$0
	sta MEM_TEMP+4
	sta MEM_TEMP+6
	
	lda LKS_BG+_bgH
	clc
	adc #$10
	and #$FFE0
	cmp #0
	beq +
		
		asl a
		sta MEM_TEMP+4
	+:
	
	lda LKS_BG+_bgH
	and #$FFE0
	cmp #0
	beq +
		asl a
		sta MEM_TEMP+6
	+:
	
	lda LKS_BG+_bg2add1
	clc
	adc MEM_TEMP+4
	sta LKS_BG+_bg2add1
	
	lda LKS_BG+_bg2add2
	clc
	adc MEM_TEMP+6
	sta LKS_BG+_bg2add2
	
	lda LKS_BG+_bg1add1
	clc
	adc MEM_TEMP+4
	sta LKS_BG+_bg1add1
	
	lda LKS_BG+_bg1add2
	clc
	adc MEM_TEMP+6
	sta LKS_BG+_bg1add2
    
	
	sep #$20
	
	rts
	
