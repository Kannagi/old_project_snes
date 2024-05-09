

DMA_enable1

	ldx MEM_DMA + 2
	cpx #0
	bne +
		rts
	+:
	
	ldx MEM_DMA
	cpx #$0800
	bmi +
		rts
	+:
	add_DMA $0200

	dma_enable $6000 2

	rts
	
DMA_enable2
	ldx MEM_DMA + 4
	cpx #0
	bne +
		rts
	+:
	
	ldx MEM_DMA
	cpx #$0800
	bmi +
		rts
	+:
	add_DMA $0200

	dma_enable $6040 4

	rts
	
DMA_enable3
	ldx MEM_DMA + 6
	cpx #0
	bne +
		rts
	+:
	
	ldx MEM_DMA
	cpx #$0800
	bmi +
		rts
	+:
	add_DMA $0200

	dma_enable $6080 6

	rts
	
DMA_enable4
	ldx MEM_DMA + 8
	cpx #0
	bne +
		rts
	+:
	
	ldx MEM_DMA
	cpx #$0800
	bmi +
		rts
	+:
	add_DMA $0200

	dma_enable $60C0 8

	rts
	
DMA_enable5
	ldx MEM_DMA + 10
	cpx #0
	bne +
		rts
	+:
	
	ldx MEM_DMA
	cpx #$0800
	bmi +
		rts
	+:
	add_DMA $0200

	dma_enable $6400 10

	rts
	
DMA_enable6
	ldx MEM_DMA + 12
	cpx #0
	bne +
		rts
	+:
	
	ldx MEM_DMA
	cpx #$0800
	bmi +
		rts
	+:
	add_DMA $0200

	dma_enable $6440 12

	rts
	
DMA_enable7
	ldx MEM_DMA + 14
	cpx #0
	bne +
		rts
	+:
	
	ldx MEM_DMA
	cpx #$0800
	bmi +
		rts
	+:
	add_DMA $0200

	dma_enable $6480 14

	rts
	
DMA_enable8
	ldx MEM_DMA + 16
	cpx #0
	bne +
		rts
	+:
	
	ldx MEM_DMA
	cpx #$0800
	bmi +
		rts
	+:
	add_DMA $0200

	dma_enable $64C0 16

	rts
