

.MACRO draw_bg_ligne
    
    
    ldy #\1
    sty VMADDL
    
    
    ldy #$0020
    
    stx DMA_BANK + $00
    sta DMA_ADDL + $00
    sty DMA_SIZEL + $00
    
    ldy #$01
    sty MDMAEN
    
	adc LKS_BG+_bgaddyr
	
		
.ENDM


.MACRO background ARGS _addsc
	
    rep #$20
    
    clc
	txa
	
	ldx MEM_TEMPFUNC
	
    ;colonne 0 
    draw_bg_ligne _addsc + $0
    
    ;colonne 1
    draw_bg_ligne _addsc + $20

	;colonne 2
    draw_bg_ligne _addsc + $40
	
	;colonne 3
    draw_bg_ligne _addsc + $60
	
	;colonne 4
    draw_bg_ligne _addsc + $80
	
	;colonne 5
    draw_bg_ligne _addsc + $A0
	
	;colonne 6
    draw_bg_ligne _addsc + $C0
	
	;colonne 7
    draw_bg_ligne _addsc + $E0
	
	;colonne 8
    draw_bg_ligne _addsc + $100
	
	;colonne 9
    draw_bg_ligne _addsc + $120
	
	;colonne 10
    draw_bg_ligne _addsc + $140
	
	;colonne 11
    draw_bg_ligne _addsc + $160
	
	;colonne 12
    draw_bg_ligne _addsc + $180
	
	;colonne 13
    draw_bg_ligne _addsc + $1A0
    
    ;colonne 14
    draw_bg_ligne _addsc + $1C0
    
    ;colonne 15
    draw_bg_ligne _addsc + $1E0
    
	
	sep #$20
.ENDM

Background1:
	lda s_map+_bg1+2
	sta MEM_TEMPFUNC
	
	ldx	s_map+_bg1
	background $5400
	
	rtl
	
Background2:
	lda s_map+_bg2+2
	sta MEM_TEMPFUNC
	
	ldx	s_map+_bg2
	background $5000
	
	rtl
	
	


Background1Y:

	
	lda LKS_BG+_bgEnableY
	cmp #0
	bne +
		rtl
	+:
	
	ldx LKS_BG+_bg2Vaddsc
	stx VMADDL
	
	ldx LKS_BG+_bg2add1
    lda s_map+_bg1+2
	ldy #$20
	
	stx DMA_ADDL+$50
	sta DMA_BANK+$50
	sty DMA_SIZEL+$50
	 
    ldx LKS_BG+_bg2add2
	
    stx DMA_ADDL+$60
	sta DMA_BANK+$60
	sty DMA_SIZEL+$60
	
	
    SNES_MDMAEN $60
    
    lda LKS_DMAT
    adc #$10
    sta LKS_DMAT
		
	rtl
	
Background2Y:

	lda LKS_BG+_bgEnableY
	cmp #0
	bne +
		rtl
	+:
	
	ldx LKS_BG+_bg1Vaddsc
	stx VMADDL
	
	ldx LKS_BG+_bg1add1
    lda s_map+_bg2+2
	ldy #$20
	
	stx DMA_ADDL+$50
	sta DMA_BANK+$50
	sty DMA_SIZEL+$50
	 
    ldx LKS_BG+_bg1add2
	
    stx DMA_ADDL+$60
	sta DMA_BANK+$60
	sty DMA_SIZEL+$60
	
	
    SNES_MDMAEN $60
    
    lda LKS_DMAT
    adc #$10
    sta LKS_DMAT
		
	rtl

Background1X:

	lda LKS_BG+_bgEnableX
	cmp #0
	bne +
		rtl
	+:

	SNES_VMAINC $81
	
	ldx LKS_BG+_bg2Haddsc
	stx VMADDL
    
    lda #$7E
	ldx #LKS_BUF_BGS1&$FFFF
	ldy #$40
	
	sta DMA_BANK+$70
	stx DMA_ADDL+$70
	sty DMA_SIZEL+$70
	
    SNES_MDMAEN $80
	
	SNES_VMAINC $80
	
	lda LKS_DMAT
    adc #$10
    sta LKS_DMAT
	
	rtl
	
Background2X:

	lda LKS_BG+_bgEnableX
	cmp #0
	bne +
		rtl
	+:

	SNES_VMAINC $81
	
	ldx LKS_BG+_bg1Haddsc
	stx VMADDL
    
    lda #$7E
	ldx #LKS_BUF_BGS2&$FFFF
	ldy #$40
	
	sta DMA_BANK+$70
	stx DMA_ADDL+$70
	sty DMA_SIZEL+$70
	
    SNES_MDMAEN $80
	
	SNES_VMAINC $80
	
	lda LKS_DMAT
    adc #$10
    sta LKS_DMAT
	
	rtl
	
	

.MACRO Background_bloc

	tay
	pha
	
	lda [LKS_ZP],y
	sta $7E0000+(\1*2),x

	pla
	
	adc LKS_BG+_bgaddyr
	
.ENDM

rep #$20
BLOC_DRAM:

	lda MEM_TEMP+10
	sta LKS_ZP+2
	
	lda MEM_TEMPFUNC
	clc
	
	Background_bloc 0
	Background_bloc 1
	Background_bloc 2
	Background_bloc 3
	
	Background_bloc 4
	Background_bloc 5
	Background_bloc 6
	Background_bloc 7
	
	Background_bloc 8
	Background_bloc 9
	Background_bloc 10
	Background_bloc 11
	
	Background_bloc 12
	Background_bloc 13
	Background_bloc 14
	Background_bloc 15

	rts
sep #$20
	
rep #$20
BLOC_DRAM2:
	
	lda MEM_TEMPFUNC
	clc
	adc LKS_BG+_bgaddy
		
	
	Background_bloc 16
	Background_bloc 17
	Background_bloc 18
	Background_bloc 19
	
	Background_bloc 20
	Background_bloc 21
	Background_bloc 22
	Background_bloc 23
	
	Background_bloc 24
	Background_bloc 25
	Background_bloc 26
	Background_bloc 27
	
	Background_bloc 28
	Background_bloc 29
	Background_bloc 30
	Background_bloc 31

	rts
sep #$20
