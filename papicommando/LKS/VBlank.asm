

VBlank0:
	
	;---------------------------
	jsl LKS_BackgroundX
	jsl LKS_BackgroundY  
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
	nop
	nop
	nop
	nop
	nop
	nop
	
	lda RDDIVL
	sta LKS.cpu
	cmp LKS.mcpu
	bcc +
		sta LKS.mcpu
	+:
	sta LKS.cpu
	cmp LKS.pcpu
	bcc +
		sta LKS.pcpu
	+:
	
	lda #1
	sta LKS.VBlankEnable
	wai
	stz LKS.VBlankEnable
	
	rtl
	
FastWaitVBlank:

	lda #1
	sta LKS.VBlankEnable
	wai
	stz LKS.VBlankEnable
	
	rtl
	
VoidWaitVBlank:

	stz LKS.VBlankEnable
	wai
	
	rtl
