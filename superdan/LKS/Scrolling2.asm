
LKS_ScrollingV2:

	rep #$20
	
	
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
	
	;calcul VSCROLLING VMADD
	lda LKS_BG.y2
	lsr
	lsr
	lsr
	lsr
	
	sta LKS_BG.V
	
	;calcul 
	asl
	asl
	asl
	asl
	asl
	
	sta LKS_BG.HV_add
	clc
	adc MEM_TEMP+8
	sta MEM_TEMP+10
	and #$3FF

	clc
	adc #$5800
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
	
	
	sep #$20
	
	rtl
	
