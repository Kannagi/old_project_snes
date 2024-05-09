
Map_Tile1:

	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;Load bg
	SNES_VMADD $0000
	
	SNES_DMA0_ADD MAP1_DATA $6000

	SNES_MDMAEN $01

	;palette ram	
	
	SNES_CGADD $10
	
	SNES_DMAX $00
	SNES_DMAX_BADD $22
	
	SNES_DMA0_ADD MAP1_PAL1 $0020
	SNES_DMA1_ADD MAP1_PAL2 $0020
	SNES_DMA2_ADD MAP1_PAL3 $0020
	SNES_DMA3_ADD MAP1_PAL4 $0020
	SNES_DMA4_ADD MAP1_PAL5 $0020
	SNES_DMA5_ADD MAP1_PAL6 $0020
	SNES_MDMAEN $3F
	
	
	;----------------

	
	rtl
	
Load_tile:

	LKS_INIT_BG MAP1_DATA_TILE,MAP1_DATA_TILE,16,1024,MAP1_DATA_TILEC
	
	jsl LKS_Unpack_Map_BG1
	jsl LKS_Unpack_Map_BGC
	
	rep #$20
	clc
	lda LKS_BG.Address2
	adc #(32*1010)
	sta LKS_BG.Address2
	lsr
	sta LKS_BG.y
	
	/*
	lda #$100
	sta LKS_BG.y
	
	lda LKS_BG.y2
	sec
	sbc #$4000-$200
	sta LKS_BG.y2
	*/

	sep #$20
	
	jsl LKS_Background2
	rtl
	
