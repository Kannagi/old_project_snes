
LKS_BackgroundY:

	lda LKS_BG.EnableY
	cmp #0
	bne +
		rtl
	+:
	
	;BG1
	ldx LKS_BG.V_vadd1
	stx VMADDL
	
	ldx LKS_BG.Dadd1_1
	lda LKS_BG.Address1+2
	ldy #$20
	
	stx DMA_ADDL+$00
	sta DMA_BANK+$00
	sty DMA_SIZEL+$00
	 
	ldx LKS_BG.Dadd2_1
	
	stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10
	
	SNES_MDMAEN $03
	
	;BG2
	ldx LKS_BG.V_vadd2
	stx VMADDL
	
	ldx LKS_BG.Dadd1_2
	lda LKS_BG.Address2+2
	
	stx DMA_ADDL+$00
	sta DMA_BANK+$00
	sty DMA_SIZEL+$00
	 
	ldx LKS_BG.Dadd2_2
	
	stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10
	
	SNES_MDMAEN $03

		
	rtl
	
LKS_BackgroundY2:

	lda LKS_BG.EnableY
	cmp #0
	bne +
		rtl
	+:
	
	;BG2
	ldx LKS_BG.V_vadd2
	stx VMADDL
	
	ldx LKS_BG.Dadd1_2
	lda LKS_BG.Address2+2
	ldy #$20
	
	stx DMA_ADDL+$00
	sta DMA_BANK+$00
	sty DMA_SIZEL+$00
	 
	ldx LKS_BG.Dadd2_2
	
	stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10
	
	SNES_MDMAEN $03

		
	rtl

LKS_BackgroundX:

	lda LKS_BG.EnableX
	cmp #0
	bne +
		rtl
	+:

	SNES_VMAINC $81
	
	ldx LKS_BG.H_vadd1
	stx VMADDL
	
	lda #$7E
	ldx #LKS_BUF_BGS1&$FFFF
	ldy #$40
	
	sta DMA_BANK
	stx DMA_ADDL
	sty DMA_SIZEL
	
	SNES_MDMAEN $01
	
	ldx LKS_BG.H_vadd2
	stx VMADDL
	
	lda #$7E
	ldx #LKS_BUF_BGS2&$FFFF
	
	sta DMA_BANK
	stx DMA_ADDL
	sty DMA_SIZEL
	
	SNES_MDMAEN $01
	
	SNES_VMAINC $80

	
	rtl
	
	
;---------------------------------------------------

LKS_Background_line1:

	lda LKS_BG.Enable1
	cmp #0
	bne +
		rtl
	+:

	rep #$20
	lda LKS_BG.Update1vram
	sta VMADDL
	clc
	adc #$20
	and #$5BFF
	sta MEM_TEMP+2

	lda LKS_BG.Update1
	tax
	clc
	adc LKS_BG.addyr
	sta MEM_TEMP
	sep #$20
	
	;----------
	lda LKS_BG.Address1+2
	ldy #$20
	
	stx DMA_ADDL+$00
	sta DMA_BANK+$00
	sty DMA_SIZEL+$00
	
	ldx MEM_TEMP
	stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10

	SNES_MDMAEN $01
	
	;----------
	ldx MEM_TEMP+2
	stx VMADDL

	SNES_MDMAEN $02
	
	stz LKS_BG.Enable1
	
	rtl
	
LKS_Background_line2:

	lda LKS_BG.Enable2
	cmp #0
	bne +
		rtl
	+:

	rep #$20
	lda LKS_BG.Update2vram
	sta VMADDL
	clc
	adc #$20
	and #$5BFF
	sta MEM_TEMP+2

	lda LKS_BG.Update2
	tax
	clc
	adc LKS_BG.addyr
	sta MEM_TEMP
	sep #$20
	
	;----------
	lda LKS_BG.Address2+2
	ldy #$20
	
	stx DMA_ADDL+$00
	sta DMA_BANK+$00
	sty DMA_SIZEL+$00
	
	ldx MEM_TEMP
	stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10

	SNES_MDMAEN $01
	
	;----------
	ldx MEM_TEMP+2
	stx VMADDL

	SNES_MDMAEN $02
	
	stz LKS_BG.Enable2

	
	rtl
