
VBlank:

	jml FastVBlank
FastVBlank:

	phd
	php
	
	phb
	pha
	phx
	phy
	
	sep #$20 	; 8 bit a
	
	lda RDNMI
	lda LKS.VBlankEnable
	cmp #0
	bne +
		ply
		plx
		pla
		
		plb
		plp
		pld

		rti
	+:

	rep #$10	;16 bit xy
	sep #$20	; 8 bit a

	lda RDNMI
	
	jsl VBlank_Mode
	

	ply
	plx
	pla
	plb

	plp
	pld

	
	
	


HVSync:

	rti

IRQ_COP:
	

	lda #1
	sta LKS_IRQ
	bra +
	
IRQ_BRK:
	
	lda #2
	sta LKS_IRQ
	bra +
	
	
IRQ_ABORT:
	lda #3
	sta LKS_IRQ
	+:
	
	plx
	stx LKS_IRQ+1
	
	plx
	stx LKS_IRQ+3
	
	ldx LKS_DEBUG
	stx LKS_IRQ+5
	
	jml Main
	rti
	


   
LVL1BRIGHT:	
.db $08,1,0
.db $08,4,0
.db $08,6,0
.db $08,8,0
.db $08,10,0
.db $08,100,0
.db $08,0,0
.db $00

LVL2BRIGHT:	
.db $08,1,0
.db $08,4,0
.db $08,6,0
.db $08,8,0
.db $08,10,0
.db $08,100,0
.db $08,100,1
.db $00


SC_BG1:
.db $0C,$0F
.db $0C,$0E
.db $0C,$0D
.db $0C,$0C
.db $0C,$0B
.db $0C,$0A
.db $0C,$09
.db $0C,$08
.db $0C,$07
.db $0C,$06
.db $0C,$05
.db $0C,$04
.db $0C,$03
.db $0C,$02
.db $0C,$01
.db $0C,$00
.db $00
   

   

	
.db 0,1,2,3,4,5,6,7,8,9,10,11
