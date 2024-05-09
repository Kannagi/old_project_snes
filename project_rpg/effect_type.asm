
;-------------------------
Explosion:
	
	ldx MEM_TEMPFUNC
	
	rep #$20
	
	lda s_perso+_x,x
	clc
	adc MEM_TEMP+6
	sec
	sbc #$20
	sbc LKS_BG+_bg1x
	sta MEM_TEMPFUNC+6
	sta MEM_TEMPFUNC +$C
	
	
	lda s_perso+_y,x
	clc
	adc MEM_TEMP+8
	sec
	sbc #$20
	sbc LKS_BG+_bg1y
	sta MEM_TEMPFUNC +$E
	sta MEM_TEMPFUNC+8
	
	sep #$20
	
	set_draw_OAMeg 0,0,0,0
	set_draw_OAMe 0,$40,$20,0
	set_draw_OAMe $20,$40,$20,$10
	
	set_draw_OAMe $00,$80,0,$20
	set_draw_OAMe $02,$80,$10,$1E
	set_draw_OAMe $00,$C0,$20,$20
	
	rtl
	
Explosion_dma:
	
	ldx #$20*8
	
	lda #:explosion
	sta LKS_DMA+_dmaBank,x
	
	lda #$20
	sta LKS_DMA+_dmat,x
	
	rep #$20
		
	lda #$280
	sta LKS_DMA+_dmaSrcR,x
	
	lda #$080
	sta LKS_DMA+_dmaSize1,x
	
	lda #LKS_DMA_VRAM3
	sta LKS_DMA+_dmaFunc,x
	
	sep #$20

	lda s_effect+_efdmai
	cmp #0
	bne +
	
		
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		
		rep #$20

		lda #explosion
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7000
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		inc s_effect+_efdmai
		rtl
	+:
	
	cmp #1
	bne +
	
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #explosion+$80
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7040
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	cmp #2
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #explosion+$100
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7080
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	cmp #3
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #explosion+$180
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$70C0
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	
	cmp #4
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #explosion+$200
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$6CC0
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	
	rtl
	
Explosion_phase:

	lda #1
	sta s_effect+_efpalen

	lda #:pallette_explosion
	sta s_effect+_efpal+2
	
	ldy #pallette_explosion
	sty s_effect+_efpal
	
	lda #:pallette_effect+2
	sta s_effect+_efpal2+2
	
	ldy #pallette_effect
	sty s_effect+_efpal2
	
	ldy #0
	sty MEM_TEMP+6
	sty MEM_TEMP+8
	
	inc s_effect+_eftm
	lda s_effect+_efend
	cmp #0
	beq +
		inc s_effect+_efphase
	+:
	
	
	lda s_effect+_efphase
	cmp #0
	bne +
		ldy #$10
		sty MEM_TEMP+6
		ldy #$10
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #1
	bne +
		ldy #$20
		sty MEM_TEMP+6
		ldy #$10
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #2
	bne +
		ldy #$10
		sty MEM_TEMP+6
		ldy #$20
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #3
	bne +
		ldy #$20
		sty MEM_TEMP+6
		ldy #$20
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #4
	bne +
		ldy #$18
		sty MEM_TEMP+6
		ldy #$18
		sty MEM_TEMP+8
	+:
	
	lda s_effect+_efi
	cmp #1
	bne +
		lda #$04*1
		sta MEM_TEMPFUNC+10
	+:
	
	lda s_effect+_efi
	cmp #2
	bne +
		lda #$08*1
		sta MEM_TEMPFUNC+10
	+:
	
	lda s_effect+_efi
	cmp #3
	bne +
		lda #$0C*1
		sta MEM_TEMPFUNC+10
	+:
	
	lda s_effect+_efi
	cmp #4
	bne +
		lda #$CC*1
		sta MEM_TEMPFUNC+10
		
		stz MEM_TEMPFUNC+11
	+:
	
	jsl Explosion_dma
	
	inc s_effect+_efl
    lda s_effect+_efl
    cmp #7
    bne +
		stz s_effect+_efl
		inc s_effect+_efi
		
	+:
	
	stz s_effect+_efend
	lda s_effect+_efi
    cmp #5
    bne +
		stz s_effect+_efi
		stz s_effect+_efl
		inc s_effect+_efend
	+:

	rtl


;-------------------------

Foudre:
	
	ldx MEM_TEMPFUNC
	
	rep #$20
	
	lda s_perso+_x,x
	clc
	adc MEM_TEMP+6
	sec
	sbc #$20
	sbc LKS_BG+_bg1x
	sta MEM_TEMPFUNC+6
	sta MEM_TEMPFUNC +$C
	
	
	lda s_perso+_y,x
	clc
	adc MEM_TEMP+8
	sec
	sbc #$20
	sbc LKS_BG+_bg1y
	sta MEM_TEMPFUNC +$E
	sta MEM_TEMPFUNC+8
	
	sep #$20
	
	lda s_effect+_efphase
	cmp #0
	bmi +
		cmp #4
		bpl +
		set_draw_OAMeg 0,0,0,0
	+:
	lda s_effect+_efphase
	cmp #1
	bmi +
		cmp #5
		bpl +
		set_draw_OAMeg 4,0,-16,$20
	+:
	lda s_effect+_efphase
	cmp #2
	bmi +
		cmp #6
		bpl +
		set_draw_OAMeg 8,0,-16,$40
	+:
	lda s_effect+_efphase
	cmp #3
	bmi +
		cmp #7
		bpl +
		set_draw_OAMeg 12,0,-32,$60
	+:
	
	lda s_effect+_efphase
	cmp #4
	bmi +
		cmp #8
		bpl +
		set_draw_OAMeg 0,0,-56,$70
	+:
	lda s_effect+_efphase
	cmp #5
	bmi +
		cmp #9
		bpl +
		set_draw_OAMeg 4,0,8-16*5,$90
	+:
	lda s_effect+_efphase
	cmp #6
	bmi +
		cmp #10
		bpl +
		set_draw_OAMeg 8,0,8-16*5,$B0
	+:
	lda s_effect+_efphase
	cmp #7
	bmi +
		cmp #11
		bpl +
		set_draw_OAMeg 12,0,8-16*6,$D0
		
		lda #1
		sta s_effect+_efpalen
	+:
	
	lda s_effect+_efphase
	cmp #12
	bmi +
		set_draw_OAMeg 0,0,0,0
	+:
	
	
	
	rtl
	

Foudre_dma:
	
	ldx #$20*8
	
	lda #:foudre
	sta LKS_DMA+_dmaBank,x
	
	lda #$20
	sta LKS_DMA+_dmat,x
	
	rep #$20
		
	lda #$200
	sta LKS_DMA+_dmaSrcR,x
	
	lda #$080
	sta LKS_DMA+_dmaSize1,x
	
	lda #LKS_DMA_VRAM3
	sta LKS_DMA+_dmaFunc,x
	
	sep #$20

	lda s_effect+_efdmai
	cmp #0
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7000
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	
	cmp #1
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre+$80
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7040
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	cmp #2
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre+$100
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7080
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	cmp #3
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre+$180
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$70C0
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	
	lda #:foudre2
	sta LKS_DMA+_dmaBank,x
	
	rep #$20
		
	lda #$280
	sta LKS_DMA+_dmaSrcR,x
	
	sep #$20
	
	lda s_effect+_efdmai
	cmp #5
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre2
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7000
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	cmp #6
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre2+$80
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7040
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	cmp #7
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre2+$100
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$7080
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	cmp #8
	bne +
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre2+$180
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$70C0
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	cmp #9
	bne +

		
		lda #1
		sta LKS_DMA+_dmaEnable,x
		
		rep #$20

		lda #foudre2+$200
		sta LKS_DMA+_dmaSrc1,x
		
		lda #$6CC0
		sta LKS_DMA+_dmaDst1,x
		
		sep #$20
		
		inc s_effect+_efdmai
		rtl
	+:
	
	
	rtl
	
Foudre_phase:

	lda #:pallette_Foudre
	sta s_effect+_efpal+2
	
	ldy #pallette_Foudre
	sty s_effect+_efpal
	
	
	lda #:pallette_effect1+2
	sta s_effect+_efpal2+2
	
	ldy #pallette_effect1
	sty s_effect+_efpal2
	
	ldy #0
	sty MEM_TEMP+6
	sty MEM_TEMP+8
	
	inc s_effect+_eftm
	lda s_effect+_efend
	cmp #0
	beq +
		inc s_effect+_efphase
	+:
	
	ldy #$88
	sty MEM_TEMP+6
	ldy #-224+44
	sty MEM_TEMP+8
	
	
	
	lda s_effect+_efphase
	cmp #12
	bne +
		ldy #$18
		sty MEM_TEMP+6
		ldy #$10
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #13
	bne +
		ldy #$28
		sty MEM_TEMP+6
		ldy #$28
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #14
	bne +
		ldy #$20
		sty MEM_TEMP+6
		ldy #$1C
		sty MEM_TEMP+8
	+:
	
	
	/*
	lda s_effect+_efphase
	cmp #0
	bne +
		ldy #$10
		sty MEM_TEMP+6
		ldy #$10
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #1
	bne +
		ldy #$20
		sty MEM_TEMP+6
		ldy #$10
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #2
	bne +
		ldy #$10
		sty MEM_TEMP+6
		ldy #$20
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #3
	bne +
		ldy #$20
		sty MEM_TEMP+6
		ldy #$20
		sty MEM_TEMP+8
	+:
	lda s_effect+_efphase
	cmp #4
	bne +
		ldy #$18
		sty MEM_TEMP+6
		ldy #$18
		sty MEM_TEMP+8
	+:
	*/
	
	lda s_effect+_efi
	cmp #1
	bne +
		lda #$04*1
		sta MEM_TEMPFUNC+10
	+:
	
	lda s_effect+_efi
	cmp #2
	bne +
		lda #$08*1
		sta MEM_TEMPFUNC+10
	+:
	
	lda s_effect+_efi
	cmp #3
	bne +
		lda #$0C*1
		sta MEM_TEMPFUNC+10
	+:
	lda s_effect+_efi
	cmp #4
	bne +
		lda #$CC*1
		sta MEM_TEMPFUNC+10
		
		stz MEM_TEMPFUNC+11
	+:
	
	
	jsl Foudre_dma
	
	lda #4
	sta MEM_TEMP
	lda s_effect+_efphase
	cmp #11
	bmi +
		lda #7
		sta MEM_TEMP
	+:
	
	inc s_effect+_efl
    lda s_effect+_efl
    cmp MEM_TEMP
    bne +
		stz s_effect+_efl
		inc s_effect+_efi
		lda s_effect+_efphase
		cmp #11
		bpl +
			stz s_effect+_efi
			inc s_effect+_efphase
	+:
	
	lda s_effect+_efphase
	cmp #11
	bne +
		lda #5
		sta s_effect+_efdmai
	+:
	
	stz s_effect+_efend
	lda s_effect+_efi
    cmp #5
    bne +
		stz s_effect+_efi
		stz s_effect+_efl
		inc s_effect+_efend
	+:

	rtl
