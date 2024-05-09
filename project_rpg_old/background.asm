

.MACRO add_bloc
    
    lda MEM_VSCROLLING
    asl A
    asl A
    asl A
    asl A
    asl A
    asl A
    asl A
    
    clc
    adc MEM_HSCROLLING
    sta MEM_TEMP
    
	txa
	adc MEM_TEMP
	tax
	
.ENDM

.MACRO draw_bg_ligne
    
    SNES_VMADD \1
    
    lda MEM_TEMPFUNC
    ldy #$0024
    
    stx DMA_ADDL + $00
    sta DMA_BANK + $00
    sty DMA_SIZEL + $00
    
    SNES_MDMAEN $01
    
	txa
	adc #$80
	tax
	
	
		
.ENDM


.MACRO background ARGS _addsc
	
	
    rep #$20
    
    add_bloc
	
    ;colonne 0 
    draw_bg_ligne _addsc + $01
    
    ;colonne 1
    draw_bg_ligne _addsc + $21

	;colonne 2
    draw_bg_ligne _addsc + $20 + $21
	
	;colonne 3
    draw_bg_ligne _addsc + $40 + $21
	
	;colonne 4
    draw_bg_ligne _addsc + $60 + $21
	
	;colonne 5
    draw_bg_ligne _addsc + $80 + $21
	
	;colonne 6
    draw_bg_ligne _addsc + $A0 + $21
	
	;colonne 7
    draw_bg_ligne _addsc + $C0 + $21
	
	;colonne 8
    draw_bg_ligne _addsc + $E0 + $21
	
	;colonne 9
    draw_bg_ligne _addsc + $100 + $21
	
	;colonne 10
    draw_bg_ligne _addsc + $120 + $21
	
	;colonne 11
    draw_bg_ligne _addsc + $140 + $21
	
	;colonne 12
    draw_bg_ligne _addsc + $160 + $21
	
	;colonne 13
    draw_bg_ligne _addsc + $180 + $21
	
	;colonne 14
    draw_bg_ligne _addsc + $1A0 + $21
    
    ;colonne 15
    draw_bg_ligne _addsc + $1C0 + $21
    
	
	sep #$20
.ENDM

Background1:
	lda s_map + $02
	sta MEM_TEMPFUNC
	
	ldx	s_map + $00
	background $5400
	rtl
	
Background2:
	lda s_map + $06
	sta MEM_TEMPFUNC
	
	ldx	s_map + $04
	background $5000
	rtl

