
;MAX NTSC
; 2 BG Scrolling
; DMA $0A00

.ENUM $600
angle		dw
sx			dw
sy			dw
A			dw
B			dw
C			dw
D			dw
X			dw
Y			dw
.ENDE

	
VBlank:
		
	
	ldx #0
	stx MEM_DMA
	

	
	;init le DMA
	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;DMA Perso
	jsr DMA_enable1

	
	
	
	;---------------------------

	

	
	SNES_OAMADD $00
	lda s_perso
	sta OAMDATA
	
	lda s_perso+1
	sta OAMDATA
	
	lda #$00
	sta OAMDATA
	
	lda #$20
	sta OAMDATA
	
	lda s_perso
	clc
	adc #16
	sta OAMDATA
	
	lda s_perso+1
	sta OAMDATA
	
	lda #$02
	sta OAMDATA
	
	lda #$20
	sta OAMDATA
	
	lda s_perso
	sta OAMDATA
	
	lda s_perso+1
	clc
	adc #16
	sta OAMDATA
	
	lda #$20
	sta OAMDATA
	
	lda #$20
	sta OAMDATA
	
	lda s_perso
	clc
	adc #16
	sta OAMDATA
	
	lda s_perso+1
	clc
	adc #16
	sta OAMDATA
	
	lda #$22
	sta OAMDATA
	
	lda #$20
	sta OAMDATA
	
    
    SNES_DMA0 $00
	SNES_DMA0_BADD $04
	
    stz OAMADDL
    lda #1
    sta OAMADDH
    
    SNES_DMA0_ADD Vide $0020
	
    SNES_MDMAEN $01
    
    stz OAMADDL
    stz OAMADDH

	
	;---------------------------
	
	;---------------------------
    -:
		bit $4212
	bne -
	
	jsr Tri_joypad
		
    rti
    
    /*
    SNES_DMA0 $00
    SNES_DMA0_BADD $27 ; $06 size scan line , $0B change tileset ,$0D shift line , $0E shift line
    SNES_HDMA0_ADD $0000 $00 HDMATable2
    
    SNES_HDMAEN $01
    */
    ;---------------------------
		
	rti
	
HDMATable2:
   .DB $28,$FF    ;Set left=255, skip to line 40
   .DB $64,$20    ;Set left=32, skip to line 140
   .DB $01,$FF    ;Set left=255
   .DB 0
	
HDMATable3:
   .DB $01,$0F
   .DB $01,$01
   

   
   .DB 0
   
Luminosite_clair:


	lda MEM_BRIGTNESS
	and #$10
	cmp #$10
	bne +
		rts
	+:

	lda MEM_BRIGTNESS
	sta INIDISP
	and #$0F
	cmp #$0F
	bne +
		lda #$1F
		sta MEM_BRIGTNESS
		stz MEM_BRIGTNESS + 1
		rts
	+:
	
	
	lda MEM_BRIGTNESS + 1
	inc A
	sta MEM_BRIGTNESS + 1
	cmp #2
	bne +
		inc MEM_BRIGTNESS
		stz MEM_BRIGTNESS + 1
	+:
	rts
	
Luminosite_sombre:

	lda MEM_BRIGTNESS
	and #$20
	cmp #$20
	beq +
		rts
	+:
	

	lda MEM_BRIGTNESS
	sta INIDISP
	and #$0F
	cmp #$00
	bne +
		lda #$40
		sta MEM_BRIGTNESS
		stz MEM_BRIGTNESS + 1
		rts
	+:
	
	
	lda MEM_BRIGTNESS + 1
	inc A
	sta MEM_BRIGTNESS + 1
	cmp #2
	bne +
		dec MEM_BRIGTNESS
		stz MEM_BRIGTNESS + 1
	+:
	rts
	
HDMATable:
	.DB $10,$01
	.DB $10,$0E
	.DB $10,$0D
	.DB $10,$0C
	.DB $10,$0B
	.DB $10,$0A
	.DB $10,$09
	.DB $10,$08
	.DB $10,$07
	.DB $10,$06
	.DB $10,$05
	.DB $10,$04
	.DB $10,$01
	.DB $10,$01
	   
	.db $00
   
CalMode7:

	;SNES_DMA0 $00
    ;SNES_DMA0_BADD $0D ; $06 size scan line , $0B change tileset ,$0D shift line , $0E shift line
    ;SNES_HDMA0_ADD $0000 $00 HDMATable
    
    ;SNES_HDMAEN $01
	
    ;inc angle
    
	ldx angle
	
	; Calculate B and C (sin's)
	; B
	
	lda sx
	sta M7A
	
	lda sx + 1
	sta M7A
	lda sincos.l + $80,X	;sin (x)

	sta M7B
	ldy $2135
	sty B
	
	; C
	lda sy			; low byte scale_y
	sta M7A
	
	lda sy+1		; high byte scale_y
	sta M7A
	
	lda sincos.l,X	; sin(x)
	sta M7B
	
	ldy $2135
	sty C
	

	
	; Calculate A and D (cos's)
	; A
	lda sx
	sta M7A
	
	lda sx + 1
	sta M7A
	
	lda sincos.l + $40,X	; Cos (x)
	sta M7B
	
	ldy $2135
	sty A
	
	; D
	lda sy
	sta M7A
	
	lda sy+1
	sta M7A
	
	lda sincos.l + $40,X	; Cos (x)
	sta M7B
	
	ldy $2135
	sty D
	
	; Store results as Matrix Parameters
	lda A
	sta M7A
	lda A+1
	sta M7A
	
	lda B
	sta M7B
	lda B+1
	sta M7B
	
	lda C
	sta M7C
	lda C+1
	sta M7C
	
	lda D
	sta M7D
	lda D+1
	sta M7D
	
	lda X
	sta M7X
	lda X+1
	sta M7X
	
	lda Y
	sta M7Y
	lda Y+1
	sta M7Y
	
	rtl
