
VBlank:
	
	phd
	php
	phb
	rep #$10	;16 bit xy
	sep #$20	; 8 bit a
	pha
	phx
	phy


	lda RDNMI
	lda LKS.VBlankEnable
	cmp #0
	bne +
		ply
		plx
		pla
		
		plb
		plp
		pld

		rti
	+:
	
	
	
	SNES_DMA4 $00
	SNES_DMA4_BADD $04
	jsl LKS_DMA_OAM
	
	lda LKS.VBlankType
	cmp #1
	bne ++
		SNES_DMAX $01
		SNES_DMAX_BADD $18

		jsl LKS_DMA_BG3

		jsl VBlank0
	++:
	
	lda LKS.VBlankType
	cmp #2
	bne ++
		
		jsl VBlank3
		
	++:
	
	
	ldy #0
	-:
		lda HVBJOY
		and #$01
	bne -
	jsl LKS_NMI_Joypad

	lda LKS.VBlankWait
	cmp #0
	bne +
	-:
		iny
		
		lda	HVBJOY
		and #$80		
	bne -
	sty LKS.VBlankTime
	+:

	ply
	plx
	pla
	
	plb
	plp
	pld

	rti
	
VBlank3

	SNES_DMA0 $00
	SNES_DMA0_BADD $19
	
	ldx #0
	stx MEM_TEMP
	

	lda LKS3D.frame_i
	cmp #0
	bne +
		ldx #$0
		stx MEM_TEMP
	+:
	cmp #1
	bne +
		ldx #$1000
		stx MEM_TEMP
	+:
	cmp #2
	bne +
		ldx #$2000
		stx MEM_TEMP
	+:
	cmp #3
	bne +
		lda #0
		sta LKS3D.frame_i
		rtl
	+:
	
	ina
	and #$03
	sta LKS3D.frame_i
	
	ldx MEM_TEMP
	stx VMADDL
	
	lda #$7F  
	ldx MEM_TEMP	
	ldy #$1000 
	
	stx DMA_ADDL
	sta DMA_BANK
	sty DMA_SIZEL
	
	ldx #$01 
	stx MDMAEN

	rtl

HVSync:

	rti

Int:
	
	rti
	
LKS_SPC_Wait:

	lda LKS_SPC_VAR
	sta APUIO0
	-:
		cmp APUIO0
	beq -
	stz APUIO1
	lda APUIO0
	sta LKS_SPC_VAR

	rts

LKS_SPC_SetD2:

	lda #$FF
	sta APUIO1
	
	tya
	sta LKS_SPC_VAR
	
	lda #0
	-:
		cmp APUIO1
	bne -
	stz APUIO1

	rts

LKS_SPC_SetD1:
	inx
	inx
	iny

	-:
		cmp APUIO0
	beq -
	stz APUIO1
		
	rts
