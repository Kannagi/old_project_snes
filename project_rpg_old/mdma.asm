


.MACRO add_DMA

	rep #$20
	
	lda MEM_DMA
	clc
	adc #\1
	sta MEM_DMA
	
	sep #$20
.ENDM

.MACRO dma_enable

	rep #$20
	lda MEM_DMA + \2
	clc
	adc #$200
	sta MEM_TEMP
	
	adc #$200
	sta MEM_TEMP + 2
	
	adc #$200
	sta MEM_TEMP + 4
	
	sep #$20
	
	;-----------------------

	SNES_VMADD \1
	
	lda MEM_DMA + 18 + ( ( \2 -2)/2 )
    ldx MEM_DMA + \2      
    ldy #$0080  
    
    stx DMA_ADDL
    sta DMA_BANK
    sty DMA_SIZEL 

	SNES_MDMAEN $01
	
	;-----------------------
	
	SNES_VMADD \1 + $0100
	
	lda MEM_DMA + 18 + ( ( \2 -2)/2 )
    ldx MEM_TEMP      
    ldy #$0080  
    
    stx DMA_ADDL
    sta DMA_BANK
    sty DMA_SIZEL 

	SNES_MDMAEN $01
	
	;-----------------------
	
	SNES_VMADD \1 + $0200
	
	lda MEM_DMA + 18 + ( ( \2 -2)/2 )
    ldx MEM_TEMP + 2    
    ldy #$0080  
    
    stx DMA_ADDL
    sta DMA_BANK
    sty DMA_SIZEL 

	SNES_MDMAEN $01
	
	;-----------------------
	
	SNES_VMADD \1 + $0300
	
	lda MEM_DMA + 18 + ( ( \2 -2)/2 )
    ldx MEM_TEMP + 4   
    ldy #$0080  
    
    stx DMA_ADDL
    sta DMA_BANK
    sty DMA_SIZEL 

	SNES_MDMAEN $01
	
	;-----
	ldx #$00
	stx MEM_DMA + \2
	
.ENDM

