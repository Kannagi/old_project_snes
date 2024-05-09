


rep #$20
BLOC_DRAM:

	stz LKS_ZP+0
	lda MEM_TEMP+10
	sta LKS_ZP+2
	
	lda MEM_TEMPFUNC
	clc
	
	Background_bloc 0
	Background_bloc 1
	Background_bloc 2
	Background_bloc 3
	
	Background_bloc 4
	Background_bloc 5
	Background_bloc 6
	Background_bloc 7
	
	Background_bloc 8
	Background_bloc 9
	Background_bloc 10
	Background_bloc 11
	
	Background_bloc 12
	Background_bloc 13
	Background_bloc 14
	Background_bloc 15

	rtl

BLOC_DRAM2:
	
	lda MEM_TEMPFUNC
	clc
	adc LKS_BG.addy
		
	
	Background_bloc 16
	Background_bloc 17
	Background_bloc 18
	Background_bloc 19
	
	Background_bloc 20
	Background_bloc 21
	Background_bloc 22
	Background_bloc 23
	
	Background_bloc 24
	Background_bloc 25
	Background_bloc 26
	Background_bloc 27
	
	Background_bloc 28
	Background_bloc 29
	Background_bloc 30
	Background_bloc 31

	rtl
sep #$20

	
	
LKS_Scrolling_limite:
	
	
	
	rep #$20
	
	stz LKS_BG.Enablelim
	
	lda LKS_BG.x
	cmp #0
	bpl +
		lda #0
		sta LKS_BG.x
		inc LKS_BG.Enablelim
		stz LKS_BG.EnableX
	+:
	
	lda LKS_BG.x
	clc
	adc #$100
	cmp LKS_BG.limitex
	bmi +
		lda LKS_BG.limitex
		sec
		sbc #$100
		sta LKS_BG.x
		inc LKS_BG.Enablelim
		stz LKS_BG.EnableX
	+:
	
	lda LKS_BG.y
	cmp #0
	bpl +
		lda #0
		sta LKS_BG.y
		inc LKS_BG.Enablelim
		inc LKS_BG.Enablelim
		stz LKS_BG.EnableY
	+:
	
	lda LKS_BG.y
	clc
	adc #$E1
	cmp LKS_BG.limitey
	bmi +
		lda LKS_BG.limitey
		sec
		sbc #$E1
		sta LKS_BG.y
		inc LKS_BG.Enablelim
		inc LKS_BG.Enablelim
		stz LKS_BG.EnableY
	+:
	
	
	sep #$20
	
	rtl
	
LKS_Scrolling:

	rep #$20
	
	;precalcul BGX
	lda #$10
	sta MEM_TEMP+2

	lda LKS_BG.EnableX
	and #$FF
	cmp #2
	bne +
		lda #$0
		sta MEM_TEMP+2
	+:
	
	;precalcul BGY
	lda #$1E0
	sta MEM_TEMP+8


	lda LKS_BG.EnableY
	and #$FF
	cmp #2
	bne +
	
		lda #$0
		sta MEM_TEMP+8
	+:
	
	
	;calcul HSCROLLING
	lda LKS_BG.x
	
	lsr
	lsr
	lsr
	lsr
	
	sta LKS_BG.H
	
	;calcul VMADD
	
	clc
	adc MEM_TEMP+2
	and #$1F
	clc
	adc #$5400
	sta LKS_BG.H_vadd1
	
	adc #$400
	sta LKS_BG.H_vadd2
	
	;calcul VSCROLLING
	lda LKS_BG.y
	
	lsr
	lsr
	lsr
	lsr
	
	sta LKS_BG.V
	
	;calcul VMADD
	asl
	asl
	asl
	asl
	asl
	
	clc
	adc MEM_TEMP+8
	sta MEM_TEMP+10
	and #$3FF

	
	clc
	adc #$5400
	sta LKS_BG.V_vadd1
	adc #$400
	sta LKS_BG.V_vadd2
	
	;----------------
	lda MEM_TEMP+10
	
	ldx LKS_BG.addyr
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
	
	cpx #$400 ;8192 /512
	bmi +
		asl
	+:
	
	
	;src
	sta MEM_TEMP+10
	clc
	adc LKS_BG.Address2
	sta LKS_BG.Dadd1_2
	
	adc #$20
	sta LKS_BG.Dadd2_2
	
	lda MEM_TEMP+10
	clc
	adc LKS_BG.Address1
	sta LKS_BG.Dadd1_1
	
	adc #$20
	sta LKS_BG.Dadd2_1
	
	;----------
	
	;calcul
	
	lda #$0
	sta MEM_TEMP+4
	sta MEM_TEMP+6
	
	lda LKS_BG.V
	clc
	adc #$10
	and #$FFE0
	cmp #0
	beq +
		lsr
		lsr
		clc
		adc LKS_BG.addy
		sta WRMPYA
		LKS_cycle8
		lda RDMPYL
		asl a
		asl a
		asl a
		asl a
		asl a
		asl a
		sta MEM_TEMP+4
	+:
	
	lda LKS_BG.V
	and #$FFE0
	cmp #0
	beq +
		lsr
		lsr
		clc
		adc LKS_BG.addy
		sta WRMPYA
		LKS_cycle8
		lda RDMPYL
		asl a
		asl a
		asl a
		asl a
		asl a
		asl a
		sta MEM_TEMP+6
	+:
	
	;BG1
	lda LKS_BG.H
	clc
	adc MEM_TEMP+2
	asl
	clc
	adc LKS_BG.Address1
	sta MEM_TEMP
	adc MEM_TEMP+4
	sta MEM_TEMPFUNC
	
	;
	
	ldx #LKS_BUF_BGS1&$FFFF
	
	lda LKS_BG.Address1+2
	sta MEM_TEMP+10
	stz MEM_TEMP+11
	jsl BLOC_DRAM
	
	lda MEM_TEMP
	adc MEM_TEMP+6
	sta MEM_TEMPFUNC
	jsl BLOC_DRAM2
	
	;BG2
	lda LKS_BG.H
	clc
	adc MEM_TEMP+2
	asl
	clc
	adc LKS_BG.Address2
	sta MEM_TEMP
	adc MEM_TEMP+4
	sta MEM_TEMPFUNC
	
	ldx #LKS_BUF_BGS2&$FFFF
	
	lda LKS_BG.Address2+2
	sta MEM_TEMP+10
	stz MEM_TEMP+11
	jsl BLOC_DRAM
	
	lda MEM_TEMP
	adc MEM_TEMP+6
	sta MEM_TEMPFUNC
	jsl BLOC_DRAM2
	
	;-------

	
	lda #$0
	sta MEM_TEMP+4
	sta MEM_TEMP+6
	
	lda LKS_BG.H
	clc
	adc #$10
	and #$FFE0
	cmp #0
	beq +
		
		asl a
		sta MEM_TEMP+4
	+:
	
	lda LKS_BG.H
	and #$FFE0
	cmp #0
	beq +
		asl a
		sta MEM_TEMP+6
	+:
	
	lda LKS_BG.Dadd1_2
	clc
	adc MEM_TEMP+4
	sta LKS_BG.Dadd1_2
	
	lda LKS_BG.Dadd2_2
	clc
	adc MEM_TEMP+6
	sta LKS_BG.Dadd2_2
	
	lda LKS_BG.Dadd1_1
	clc
	adc MEM_TEMP+4
	sta LKS_BG.Dadd1_1
	
	lda LKS_BG.Dadd2_1
	clc
	adc MEM_TEMP+6
	sta LKS_BG.Dadd2_1
	
	
	sep #$20
	
	rtl
	
