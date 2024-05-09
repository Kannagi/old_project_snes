

LKS_Clear_RAM:

	rep #$20
	
	lda #0
	ldx #$00
	-:
		sta $7E8000,x
		sta $7F0000,x
		sta $7F8000,x
		inx
		inx
		
		cpx #$8000
	bne -
	
	
	ldx #$00
	-:
		sta $7E2000,x
		sta $7E4000,x
		sta $7E6000,x
		inx
		inx
		
		cpx #$20
	bne -
	
	
	ldx #$100
	-:
		sta $00,x
		dex
		dex
	bne -
	sta $00
	
	ldx #$1DFE
	-:
		sta $200,x
		dex
		dex
	bne -
	sta $200
	
	sep #$20

	
	
	rtl
	
	


LKS_Clear_VRAM:
	
	SNES_VMADD $0000
	
	ldy #$0000
	ldx #0
	-:
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		inx
		
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		sty VMDATAL
		inx
		
	cpx #$1000
	bne -

	rtl

LKS_Clear_OAM:
	
	SNES_OAMADD $0000
	
	ldy #$0000
	sty $0000
	ldx #$0000
	-:
		sty $0000,x
		inx
		inx
		cpx #$220
	bne -
	
	rtl





	
