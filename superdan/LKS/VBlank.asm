
VBlank_Mode:
	
	
	SNES_DMA4 $00
	SNES_DMA4_BADD $04
	jsl LKS_DMA_OAM
	


	SNES_DMAX $01
	SNES_DMAX_BADD $18

	jsl LKS_DMA_BG3

	jsl VBlank0

	
	
	jsl LKS_Background_line2
	
/*
	SNES_DMA0 $02
	SNES_DMA0_BADD $0F
		
	SNES_HDMAL_ADD LVL1BRIGHT,:LVL1BRIGHT, 0
			
	SNES_DMA1 $02
	SNES_DMA1_BADD $10
		
	SNES_HDMAL_ADD LVL2BRIGHT,:LVL2BRIGHT, 1
		
	SNES_HDMAEN $01
*/
	ldy #0
	-:
		lda HVBJOY
		and #$01
	bne -
	jsr LKS_NMI_Joypad
	
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
	
	rtl

VBlank0:
	
	;---------------------------
	;jsl LKS_BackgroundX
	jsl LKS_BackgroundY2  
	;---------------------------	

	LKS_DMA_VRAM 0
	LKS_DMA_VRAM 1
	LKS_DMA_VRAM 2
	LKS_DMA_VRAM 3
	
	LKS_DMA_VRAM 4

	;---------------------------
	
	;jsl LKS_DMA_PAL

	LKS_BG_update
	rtl
	
VBlank1:
	
	;---------------------------
	;jsl LKS_BackgroundX
	;jsl LKS_BackgroundY  
	;---------------------------	

	LKS_DMA_VRAM 0
	LKS_DMA_VRAM 1
	LKS_DMA_VRAM 2
	LKS_DMA_VRAM 3
	
	LKS_DMA_VRAM 4

	;---------------------------
	
	jsl LKS_DMA_PAL

	LKS_BG_update
	rtl
	
	
VBlank3

	SNES_DMA0 $00
	SNES_DMA0_BADD $19
	
	ldx #0
	stx MEM_TEMP
	

	
	lda LKS3D.frame_i
	cmp #0
	bne +
		ina
		sta LKS3D.frame_i
		
		bra ++
	+:
	cmp #1
	bne +
		ina
		sta LKS3D.frame_i
		
		ldx #$1000
		stx MEM_TEMP
		
		bra ++
	+:
	cmp #2
	bne +
		ina
		sta LKS3D.frame_i
		
		ldx #$2000
		stx MEM_TEMP
		
		bra ++
	+:
	cmp #3
	bne +
		ldx #$3000
		stx MEM_TEMP

		lda #0
		sta LKS3D.frame_i
		sta LKS3D.frame_i+1
	+:
	++:
	
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
	
WaitVBlank:

	lda LKS.clockf
	ina
	cmp #60
	bne +
		stz LKS.mcpu
		
		lda LKS.clocks
		ina
		cmp #60
		bne ++
			lda LKS.clockm
			ina
			cmp #60
			bne +++
				inc LKS.clockh
				lda #0
			+++:
			sta LKS.clockm
			lda #0
		++:
		sta LKS.clocks
		lda #0
	+:
	sta LKS.clockf
	
	
	
	lda SLHV
	lda OPVCT	

	rep #$20
	and #$FF
	asl
	asl
	asl
	asl
	asl
	asl
	sta WRDIVL
	sep #$20
	lda #143
	sta WRDIVB
	lda LKS.cpu
	cmp LKS.mcpu
	bcc +
		sta LKS.mcpu
	+:
	
	cmp LKS.pcpu
	bcc +
		sta LKS.pcpu
	+:
	
	lda RDDIVL
	sta LKS.cpu
	
	lda #1
	sta LKS.VBlankEnable
	wai
	stz LKS.VBlankEnable
	rtl
	
