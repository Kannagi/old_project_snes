
.MACRO LKS_DMA_VRAM_MC 
	ldx MEM_TEMPFUNC
	
	rep #$20
	
	lda LKS_DMA.Dst1,x
	sta MEM_TEMP+0
	
	lda LKS_DMA.Src1,x
	sta MEM_TEMP+2
	
	lda LKS_DMA.Size1,x
	tay
	
	ldx MEM_TEMPFUNC+2
	clc
.ENDM

.MACRO LKS_DMA_VRAM_ADD 
	adc #$100
	sta VMADDL
	
	ldx #\1
	stx MDMAEN
.ENDM
	
;$X bloc
LKS_DMA_VRAM1:

	LKS_DMA_VRAM_MC
	
	;--------------
	lda MEM_TEMP+2

	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  +$10
	sta DMA_ADDL  +$10
	sty DMA_SIZEL +$10
	
	;--------------
	lda MEM_TEMP+0
	sta VMADDL
	ldx #$01
	stx MDMAEN
   
	LKS_DMA_VRAM_ADD $02
	
	sep #$20
	
	rts
	
LKS_DMA_VRAM2:

	LKS_DMA_VRAM_MC

	;--------------
	lda MEM_TEMP+2

	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $10
	sta DMA_ADDL  + $10
	sty DMA_SIZEL + $10
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $20
	sta DMA_ADDL  + $20
	sty DMA_SIZEL + $20
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $30
	sta DMA_ADDL  + $30
	sty DMA_SIZEL + $30
	   
	;--------------
	lda MEM_TEMP+0
	sta VMADDL
	ldx #$01
	stx MDMAEN
	LKS_DMA_VRAM_ADD $02
	
	LKS_DMA_VRAM_ADD $04
	LKS_DMA_VRAM_ADD $08
	
	sep #$20
	
	rts
	
LKS_DMA_VRAM3:

	LKS_DMA_VRAM_MC
	
	;--------------
	lda MEM_TEMP+2

	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $10
	sta DMA_ADDL  + $10
	sty DMA_SIZEL + $10
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $20
	sta DMA_ADDL  + $20
	sty DMA_SIZEL + $20
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $30
	sta DMA_ADDL  + $30
	sty DMA_SIZEL + $30
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $40
	sta DMA_ADDL  + $40
	sty DMA_SIZEL + $40
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $50
	sta DMA_ADDL  + $50
	sty DMA_SIZEL + $50
	   
	;--------------
	lda MEM_TEMP+0
	sta VMADDL
	ldx #$01
	stx MDMAEN
	LKS_DMA_VRAM_ADD $02
	
	LKS_DMA_VRAM_ADD $04
	LKS_DMA_VRAM_ADD $08
	LKS_DMA_VRAM_ADD $10
	LKS_DMA_VRAM_ADD $20
	
	sep #$20
	
	rts


LKS_DMA_VRAM4:

	LKS_DMA_VRAM_MC
	
	;--------------
	lda MEM_TEMP+2

	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL

	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $10
	sta DMA_ADDL  + $10
	sty DMA_SIZEL + $10
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $20
	sta DMA_ADDL  + $20
	sty DMA_SIZEL + $20
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $30
	sta DMA_ADDL  + $30
	sty DMA_SIZEL + $30
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $40
	sta DMA_ADDL  + $40
	sty DMA_SIZEL + $40
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $50
	sta DMA_ADDL  + $50
	sty DMA_SIZEL + $50
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $60
	sta DMA_ADDL  + $60
	sty DMA_SIZEL + $60
	
	adc MEM_TEMPFUNC+4
	stx DMA_BANK  + $70
	sta DMA_ADDL  + $70
	sty DMA_SIZEL + $70
	   
	;--------------
	lda MEM_TEMP+0
	sta VMADDL
	ldx #$01
	stx MDMAEN
	LKS_DMA_VRAM_ADD $02
	
	LKS_DMA_VRAM_ADD $04
	LKS_DMA_VRAM_ADD $08
	
	LKS_DMA_VRAM_ADD $10
	LKS_DMA_VRAM_ADD $20
	LKS_DMA_VRAM_ADD $40
	LKS_DMA_VRAM_ADD $80
	
	sep #$20
	
	rts
;$XLoop
LKS_DMA_VRAMX:

	ldx MEM_TEMPFUNC
		
	rep #$20
	lda LKS_DMA.Enable,x
	and #$FF
	tay

	-:
	phy
	lda LKS_DMA.Size1,x
	tay
	
	;---------
	lda LKS_DMA.Src1,x
	
	phx
	ldx MEM_TEMPFUNC+2
	
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL
	
	clc
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK +$10
	sta DMA_ADDL +$10
	sty DMA_SIZEL +$10
	plx
	
	
	lda LKS_DMA.Dst1,x
	sta VMADDL
	ldy #$01
	sty MDMAEN
	
	adc #$100
	sta VMADDL
	ldy #$02
	sty MDMAEN
	

	txa
	adc #6
	tax
	
	
	ply
	dey
	bne -
	
	sep #$20

	rts
