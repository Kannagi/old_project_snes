/*
bgx 21 0x80
bgy 24 0x80
Pal 30 0x100
Sprite 30 + 40 0x100
Sprite 45 0x80


+30
+(Size/5)
VRAM1 0
VRAM2 5
VRAM3 10
VRAM4 15
VRAMx2 +5
455-(0x100/5,12)-15-VRAM
*/

LKS_DMA_SORT:
	
	lda LKS_DMA_SEND.i
	cmp #0
	bne +
		rtl
	+:	
	
	rep #$20
	lda LKS_DMA_SEND.i
	ldy #0
	tax
	stz MEM_TEMP
	stz MEM_TEMP +2
	stz MEM_TEMP +4
	
	lda LKS_BG.EnableX
	cmp #0
	beq +
		lda #21
		sta MEM_TEMP
	+: 
	lda LKS_BG.EnableY
	cmp #0
	beq +
		lda #24
		sta MEM_TEMP+2
	+:

	lda LKS_PAL.type
	cmp #$0
	beq +
		lda #31
		sta MEM_TEMP+4
	+:
	lda #445
	sec
	sbc MEM_TEMP
	sbc MEM_TEMP+2
	sbc MEM_TEMP+4
	sta MEM_TEMP
	
	
	lda #25
	sta MEM_TEMP+8
	
	lda LKS.VBlankWait
	cmp #2
	bne +
		lda #70
		sta MEM_TEMP+8
	+:
	
	-:
		lda LKS_DMA_SEND.index-2,x
		sta MEM_TEMP+2
		
		phx
		tax
		lda LKS_DMA.Enable,x
		and #$FF
		sta MEM_TEMP+4
		
		lda MEM_TEMP
		sec
		sbc LKS_DMA.dmat,x
		sta MEM_TEMP
		plx
		cmp MEM_TEMP+8
		bmi +
		
		phx
		tyx
		
		lda MEM_TEMP+4
		sta LKS_DMA_SEND.Enable,x
		lda MEM_TEMP+2
		sta LKS_DMA_SEND.dma,x
		
		iny
		iny
		plx
		
		dex
		dex
		
		cpy #10
		beq +
		cpx #0
	bne -
	+:
	
	txa
	sta LKS_DMA_SEND.i
	
	lda MEM_TEMP
	sta LKS.VBlankTimeS
	
	sep #$20
	
	

	rtl

LKS_DMA_BG3:

	lda #$7E
	sta DMA_BANK
	
	ldy #$200
	sty DMA_SIZEL
	
	ldx #LKS_BUF_BG3&$FFFF
	ldy #$5800
	
	lda LKS.bg3i
	inc LKS.bg3i
	LKS_DMA_BG3_bloc 0
	LKS_DMA_BG3_bloc 1
	LKS_DMA_BG3_bloc 2
	cmp #3
	bne +
		ldx #LKS_BUF_BG3&$FFFF+($200*3)
		ldy #$5C00+($100*3)
		stz LKS.bg3i
	+:
		
	stx DMA_ADDL
	sty VMADDL
	
	SNES_MDMAEN $01
	
	rtl

LKS_DMA_OAM:

	ldx #$0000	
	stx OAMADDL

	lda #$7E
	ldx #LKS_BUF_OAML&$FFFF
	ldy #$220
	
	sta DMA_BANK+CHANNEL4
	stx DMA_ADDL+CHANNEL4
	sty DMA_SIZEL+CHANNEL4
	
	SNES_MDMAEN $10

	rtl
	
LKS_DMA_PAL:

	
	lda LKS_PAL.type
	cmp #$0
	bne +
		rtl
	+:
	SNES_DMA5 $00
	SNES_DMA5_BADD $22
	
	
	lda LKS_PAL.type
	cmp #$2
	bne +
		SNES_CGADD $80
		ldx #LKS_BUF_PAL&$FFFF+$100
		bra ++
	+:;else
		SNES_CGADD $00
		ldx #LKS_BUF_PAL&$FFFF
	
	++:
	
	lda #$7E
	ldy #$100
	
	sta DMA_BANK+CHANNEL5
	stx DMA_ADDL+CHANNEL5
	sty DMA_SIZEL+CHANNEL5
	
	SNES_MDMAEN $20
	
	stz LKS_PAL.type

	rtl
	


	


	
	
