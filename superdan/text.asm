



Text_draw:
	
	ldx SDAN.score
	stx MEM_TEMP
	
	ldx SDAN.score+2
	stx MEM_TEMP+2
	
	LKS_printfd8 2,1
	
	
	
	lda LKS.clockf
	and #$03
	cmp #0
	bne +
		jsr Text_draw0
		rts
	+:
	cmp #1
	bne +
		jsr Text_draw1
		rts
	+:
	cmp #2
	bne +
		;jsr Text_draw2
		rts
	+:
	cmp #3
	bne +
		jsr Text_draw3
		rts
	+:
	
	

	rts
	
text_score:
	.db "score",0
	
text_high:
	.db "high",0
	
Text_draw0:

	
	lda LKS.mcpu
	LKS_printf8u 1,2
	LKS_printfc 4,2,$2000+'A'+3
	
	lda LKS.pcpu
	LKS_printf8u 6,2
	LKS_printfc 6+3,2,$2000+'A'+3
	
	ldy LKS.VBlankTime
	LKS_printf16u 12,2
	
	rts
	
	lda LKS_IRQ
	LKS_printf8h 1,20
	
	ldy LKS_IRQ+1
	LKS_printf16h 1,21
	
	ldy LKS_IRQ+3
	LKS_printf16h 1,22
	
	ldy LKS_IRQ+5
	LKS_printf16h 1,23

	rts
	
Text_draw1:

	
	ldy LKS_DEBUG
	LKS_printf16u 1,3
	
	ldy LKS_DEBUG+2
	LKS_printf16h 1,4
	

	rts
	
	
.MACRO LKS_ZORDERt

	ldy #0
	

	.if \1 != 0
	cmp MEM_TEMP+4
	bcc +
		iny
	+:
	.endif
	
	.if \1 != 1
	cmp MEM_TEMP+5
	bcc +
		iny
	+:
	.endif
	
	.if \1 != 2
	cmp MEM_TEMP+6
	bcc +
		iny
	+:
	.endif
	
	tya
.ENDM


tri_test:
	lda #0
	sta MEM_TEMP+0
	sta MEM_TEMP+1
	sta MEM_TEMP+2
	
	lda #0
	sta MEM_TEMP+4
	
	lda #10
	sta MEM_TEMP+5
	sta MEM_TEMP+6
	ldy #0
	
	sep #$10
	;---------------
	lda MEM_TEMP+4
	LKS_ZORDERt 0
	sta LKS_OAM.y+0
	
	
	lda MEM_TEMP+5
	LKS_ZORDERt 1
	sta LKS_OAM.y+1
	
	ldy #0
	lda MEM_TEMP+6
	LKS_ZORDERt 2
	sta LKS_OAM.y+2
	
	
	rep #$10
	
	rts
	
;89 + 70
mul16:

	
	ldy #0 ;2 cycles
	sty MEM_TEMP+2
	
	tax
	bit #1 ;3 cycles
	beq + ;3 cycles
		tya
		clc
		adc MEM_TEMP ;3 cycles
		tay
		lda MEM_TEMP+2
		adc MEM_TEMP+1
		sta MEM_TEMP+2
		txa
	+:
	
	asl MEM_TEMP
	

	asl MEM_TEMP+1
	
	bit #$2
	beq +
		tya
		clc
		adc MEM_TEMP
		tay
		lda MEM_TEMP+2
		adc MEM_TEMP+1
		sta MEM_TEMP+2
		txa
	+:
	
	asl MEM_TEMP
	
	asl MEM_TEMP+1
	
	bit #$4
	beq +
		tya
		clc
		adc MEM_TEMP
		tay
		lda MEM_TEMP+2
		adc MEM_TEMP+1
		sta MEM_TEMP+2
		txa
	+:
	
	asl MEM_TEMP

	asl MEM_TEMP+1
	
	bit #$8
	beq +
		tya
		clc
		adc MEM_TEMP
		tay
		lda MEM_TEMP+2
		adc MEM_TEMP+1
		sta MEM_TEMP+2
		txa
	+:
	
	asl MEM_TEMP

	asl MEM_TEMP+1
	
	bit #$10
	beq +
		tya
		clc
		adc MEM_TEMP
		tay
		lda MEM_TEMP+2
		adc MEM_TEMP+1
		sta MEM_TEMP+2
		txa
	+:
	
	asl MEM_TEMP

	asl MEM_TEMP+1
	
	bit #$20
	beq +
		tya
		clc
		adc MEM_TEMP
		tay
		lda MEM_TEMP+2
		adc MEM_TEMP+1
		sta MEM_TEMP+2
		txa
	+:
	
	asl MEM_TEMP

	asl MEM_TEMP+1
	
	bit #$40
	beq +
		tya
		clc
		adc MEM_TEMP
		tay
		lda MEM_TEMP+2
		adc MEM_TEMP+1
		sta MEM_TEMP+2
		txa
	+:
	
	asl MEM_TEMP

	asl MEM_TEMP+1
	
	bit #$80
	beq +
		tya
		clc
		adc MEM_TEMP
		tay
		lda MEM_TEMP+2
		adc MEM_TEMP+1
		sta MEM_TEMP+2
	+:

	tya
	sta MEM_TEMP+1
	ldy MEM_TEMP+1

	
	rts


Text_draw2:

	ldy LKS.VBlankTime
	LKS_printf16u 12,0
	
	lda Ship.weapon
	
	
	ldy #100
	sty 0
	lda #2
	jsr mul16
	LKS_printf16u 1,5
	
	jsr tri_test
	lda LKS_OAM.y+0
	LKS_printf8u 1,15
	
	lda LKS_OAM.y+1
	LKS_printf8u 1,16
	
	lda LKS_OAM.y+2
	LKS_printf8u 1,17

	rts
	
Text_draw3:

	rep #$20
	
	lda #$FFFF
	sec
	sbc LKS_BG.y2
	tay
	sep #$20
	ldy LKS_BG.y
	LKS_printf16u 1,8
	
	rep #$20
	tsc
	tay
	sep #$20
	LKS_printf16h 1,7

	rts
