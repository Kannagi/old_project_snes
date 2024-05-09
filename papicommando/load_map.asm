

	
Map_Tile2:

	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;Load bg
	SNES_VMADD $0000
	
	SNES_DMA0_ADD tile8 $8000

	SNES_MDMAEN $01

	;palette ram
	SNES_WMADD LKS_BUF_PAL&$FFFF+$20,0
	
	SNES_DMAX $00
	SNES_DMAX_BADD $80
	
	SNES_DMA0_ADD tile8_pal $0020
	SNES_DMA1_ADD tile8_pal $0020
	SNES_DMA2_ADD tile8_pal $0020
	SNES_DMA3_ADD tile8_pal $0020
	SNES_DMA4_ADD tile8_pal2 $0020
	SNES_DMA5_ADD tile8_pal2 $0020
	SNES_DMA6_ADD tile8_pal2 $0020
	SNES_MDMAEN $7F
	
	
	;----------------
	
	LKS_PAL_WRAM tile8_pal,1
	LKS_PAL_WRAM tile8_pal,2
	LKS_PAL_WRAM tile8_pal,3
	LKS_PAL_WRAM tile8_pal,4
	LKS_PAL_WRAM tile8_pal2,5
	LKS_PAL_WRAM tile8_pal2,6
	LKS_PAL_WRAM tile8_pal2,7
	
	lda #1
	sta LKS_PAL.type
	
	jsl LKS_DMA_PAL
	rtl
