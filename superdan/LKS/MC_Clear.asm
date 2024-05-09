

.MACRO LKS_Clear_RAM
	
	
	rep #$20
	lda #0
	ldx #$FFFE
	-:
		sta $7E0000,x
		dex
		dex
	bne -
	sta $7E0000
	sep #$20
	
	
.ENDM

.MACRO LKS_Clear_VRAM
	
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
	
	
	
.ENDM

.MACRO LKS_Clear_OAM
	
	SNES_OAMADDL $0000
	
	ldy #$0000
	sty $0000
	ldx #$0000
	-:
		sty $0000,x
		inx
		
	cpx #$110
	bne -
	
.ENDM
