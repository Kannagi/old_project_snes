
; VVVR RRRR
; 0BBB BBVV

.MACRO palette_color

	ldx LKS_BUF_PAL+(\1*$20)+(\2*2)
	stx MEM_TEMPFUNC
	
	ldx #LKS_BUF_PAL+(\1*$20)+(\2*2)
	stx MEM_TEMPFUNC+2
	
	ldx #\3
	stx MEM_TEMPFUNC+4
	
	ldx #\4
	stx MEM_TEMPFUNC+6
	
	ldx #\5
	stx MEM_TEMPFUNC+8
	
	jsr Pal_out_color

.ENDM

Pal_out_color:


	rep #$20
	
	;----------------------
	
	lda MEM_TEMPFUNC
	and #$001F ;red
	sta MEM_TEMP
	
	
	lda MEM_TEMPFUNC
	and #$03E0 ;green
	lsr
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP+2
	
	lda MEM_TEMPFUNC
	and #$7C00 ;blue
	lsr
	lsr
	lsr
	lsr
	
	lsr
	lsr
	lsr
	lsr
	
	lsr
	lsr
	sta MEM_TEMP+4
	
	
	;----------------------
	
	lda MEM_TEMP
	clc
	adc MEM_TEMPFUNC+4
	cmp #$0
	bpl +
		lda #0
	+:
	cmp #$20
	bmi +
		lda #$1F
	+:
	sta MEM_TEMP
	
	;---------
	
	lda MEM_TEMP+2
	clc
	adc MEM_TEMPFUNC+6
	cmp #$0
	bpl +
		lda #0
	+:
	cmp #$20
	bmi +
		lda #$1F
	+:
	asl
	asl
	asl
	asl
	asl
	sta MEM_TEMP+2
	
	;---------
	
	lda MEM_TEMP+4
	clc
	adc MEM_TEMPFUNC+8
	cmp #$0
	bpl +
		lda #0
	+:
	cmp #$20
	bmi +
		lda #$1F
	+:
	asl
	asl
	asl
	asl
	
	asl
	asl
	asl
	asl
	
	asl
	asl
	
	
	sta MEM_TEMP+4
	
	;---------
	
	lda MEM_TEMP
	clc
	adc MEM_TEMP+2
	clc
	adc MEM_TEMP+4
	
	ldx MEM_TEMPFUNC+2
	sta $7E0000,x
	
	sep #$20
	
	rts
	
	
.MACRO palette_color_all ARGS argpl,argred,arggren,argblue

	palette_color argpl,1, argred,arggren,argblue
	palette_color argpl,2, argred,arggren,argblue
	palette_color argpl,3, argred,arggren,argblue
	
	palette_color argpl,4, argred,arggren,argblue
	palette_color argpl,5, argred,arggren,argblue
	palette_color argpl,6, argred,arggren,argblue
	palette_color argpl,7, argred,arggren,argblue
	
	palette_color argpl,8, argred,arggren,argblue
	palette_color argpl,9, argred,arggren,argblue
	palette_color argpl,10, argred,arggren,argblue
	palette_color argpl,11, argred,arggren,argblue
	
	palette_color argpl,12, argred,arggren,argblue
	palette_color argpl,13, argred,arggren,argblue
	palette_color argpl,14, argred,arggren,argblue
	palette_color argpl,15, argred,arggren,argblue

.ENDM


.MACRO palette_color_all_bv ARGS arg2,arg3

	;ldx LKS_BUF_PAL+(arg2*$20)+(2*arg3)
	;stx MEM_TEMPFUNC
	
	;ldx #LKS_BUF_PAL+(arg2*$20)+(2*arg3)
	;stx MEM_TEMPFUNC+2
	
	rep #$20
	lda LKS_BUF_PAL+(arg2*$20)+(2*arg3)
	sta MEM_TEMPFUNC
	
	lda #LKS_BUF_PAL&$FFFF+(arg2*$20)+(2*arg3)
	sta MEM_TEMPFUNC+2
	
	sep #$20
	
	jsr Pal_out_color

.ENDM

.MACRO palette_color_all_b ARGS arg1

	
	
	ldx #\2
	stx MEM_TEMPFUNC+4
	stx MEM_TEMPFUNC+6
	stx MEM_TEMPFUNC+8
	
	palette_color_all_bv arg1,1
	palette_color_all_bv arg1,2
	palette_color_all_bv arg1,3
	
	palette_color_all_bv arg1,4
	palette_color_all_bv arg1,5
	palette_color_all_bv arg1,6
	palette_color_all_bv arg1,7
	
	palette_color_all_bv arg1,8
	palette_color_all_bv arg1,9
	palette_color_all_bv arg1,10
	palette_color_all_bv arg1,11
	
	palette_color_all_bv arg1,12
	palette_color_all_bv arg1,13
	palette_color_all_bv arg1,14
	palette_color_all_bv arg1,15
	
	
	
	

.ENDM

Pal_Effect1_1:

	lda s_palette+_pleffect
	cmp #1
	beq +
		rts
	+:
	palette_color_all_b 2,-10
	
	rts

Pal_Effect1_2:

	lda s_palette+_pleffect
	cmp #2
	beq +
		rts
	+:
	palette_color_all_b 3,-10
	
	rts
	
Pal_Effect1_3:

	lda s_palette+_pleffect
	cmp #3
	beq +
		rts
	+:
	palette_color_all_b 4,-10
	
	rts
	
Pal_Effect1_4:

	lda s_palette+_pleffect
	cmp #4
	beq +
		rts
	+:
	palette_color_all_b 5,-10
	
	rts
	
Pal_Effect1_5:

	lda s_palette+_pleffect
	cmp #5
	beq +
		rts
	+:
	palette_color_all_b 6,-10
	
	rts
	
Pal_Effect1_6:

	lda s_palette+_pleffect
	cmp #6
	beq +
		rts
	+:
	palette_color_all_b 7,-10
	
	rts


Pal_Effect1:

	lda s_palette+_pleffect
	cmp #8
	bmi +
		rts
	+:
	cmp #0
	bne +
		rts
	+:
	stz MEM_TEMP+6
	
	jsr Pal_Effect1_1
	jsr Pal_Effect1_2
	jsr Pal_Effect1_3
	jsr Pal_Effect1_4
	jsr Pal_Effect1_5
	jsr Pal_Effect1_6
	
	lda s_palette+_pleffect
	cmp #6
	bne +
		lda #1
		sta s_palette+_pltype
	+:
	
	lda s_palette+_pleffect
	cmp #7
	bne +
		lda #2
		sta s_palette+_pltype
		
		SNES_WMADD LKS_BUF_PAL&$FFFF+$100+($20*3),0
		SNES_DMA0_ADD pallette_gris $0020
		SNES_MDMAEN $01
		
		jsl Menu_OAM_init
	+:
	
	inc s_palette+_pleffect
	
	rts
	
Pal_Effect2:

	lda s_palette+_pleffect
	cmp #8
	beq +
		rts
	+:
	
	jsl Menu_Page
	
	
	lda #2
	sta s_palette+_pltype
		
	inc s_palette+_pleffect
	
	rts
	
Pal_Effect3:

	lda s_palette+_pleffect
	cmp #10
	beq +
		rts
	+:
	
	jsl Menu_Page
	
	
	lda #2
	sta s_palette+_pltype
		
	inc s_palette+_pleffect
	
	rts
	
	
Pal_Effect0:

	lda s_palette+_pleffect
	cmp #$FD
	beq +
		rts
	+:
	
	SNES_WMADD  LKS_BUF_PAL&$FFFF+$40,0
	
	SNES_DMA_ADD s_palette+_bgpl3,$20,0
	SNES_DMA_ADD s_palette+_bgpl4,$20,1
	SNES_DMA_ADD s_palette+_bgpl5,$20,2
	
	SNES_DMA_ADD s_palette+_bgpl6,$20,3
	SNES_DMA_ADD s_palette+_bgpl7,$20,4
	SNES_DMA_ADD s_palette+_bgpl8,$20,5
	
	SNES_MDMAEN $3F
	
	
	lda #1
	sta s_palette+_pltype
	
	inc s_palette+_pleffect
	
	rts
	
Pal_Effect00:


	lda s_palette+_pleffect
	cmp #$FE
	beq +
		rts
	+:
	
	SNES_WMADD  LKS_BUF_PAL&$FFFF+$160,0
	
	SNES_DMA_ADD s_palette+_spl4,$20,0
	SNES_DMA_ADD s_palette+_spl5,$20,1
	SNES_DMA_ADD s_palette+_spl6,$20,2
	SNES_DMA_ADD s_palette+_spl7,$20,3
	SNES_DMA_ADD s_palette+_spl8,$20,4
	
	SNES_MDMAEN $1F
	
	lda #2
	sta s_palette+_pltype
	
	inc s_palette+_pleffect
	
	rts
