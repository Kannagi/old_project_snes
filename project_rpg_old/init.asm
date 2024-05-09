

.MACRO init_bg
    
    SNES_VMADD $5000
    
	ldx #0
	-:
		SNES_VMDATA \1
		inx
		
	cpx #$C00
	bne -
	
.ENDM

.MACRO init_oam
    
    stz OAMADDL
    stz OAMADDH
    
    
	ldx #0
	-:
		stz OAMDATA
		lda #-32
		sta OAMDATA
		stz OAMDATA
		stz OAMDATA
		inx
	cpx #128
	bne -
	
	stz OAMADDL
    stz OAMADDH

.ENDM


.MACRO init_scrolling

	lda s_map + $10
    sta MEM_HSCROLLING
    stz MEM_HSCROLLING + 1
    
    lda s_map + $11
    sta MEM_VSCROLLING
    stz MEM_VSCROLLING + 1
	
	lda #$20
	sta MEM_TMPSCROLLING
	stz MEM_TMPSCROLLING + 1
	
	lda #$10
	sta MEM_TMPSCROLLING + 2
	stz MEM_TMPSCROLLING + 3
	
	
	stz MEM_TMPSCROLLING + 4
	stz MEM_TMPSCROLLING + 5
	
	stz MEM_TMPSCROLLING + 6
	stz MEM_TMPSCROLLING + 7
	
	lda #1
	sta MEM_TMPSCROLLING + 8
    
	
.ENDM

.MACRO init_control

	.DEFINE _CNT 0

	.REPT $20
	stz MEM_STDCTRL + _CNT
	.REDEFINE _CNT _CNT+1
	.ENDR
	
	.UNDEFINE _CNT
    
.ENDM


.MACRO init_zoam	
	lda #$80
	sta MEM_OAM + $00
	
	lda #$88
	sta MEM_OAM + $01
	
	lda #$90
	sta MEM_OAM + $02
	
	lda #$98
	sta MEM_OAM + $03
	
	lda #$A0
	sta MEM_OAM + $04
	
	lda #$A8
	sta MEM_OAM + $05
	
	lda #$B0
	sta MEM_OAM + $06
	
	lda #$B8
	sta MEM_OAM + $07
	
	;N OAM
	stz MEM_OAM + $08
	stz MEM_OAM + $09
	
	;mdmaen
	stz MEM_OAM + $0A
	
	;adresse OAM RAM
	ldx #t_oam
	stx MEM_OAM + $0B
	
	;Y position
	lda #-32
	sta s_oam + $00
	sta s_oam + $01
	sta s_oam + $02
	sta s_oam + $03
	sta s_oam + $04
	sta s_oam + $05
	sta s_oam + $06
	sta s_oam + $07
	
	;X position
	sta s_oam + $08
	sta s_oam + $09
	sta s_oam + $0A
	sta s_oam + $0B
	sta s_oam + $0C
	sta s_oam + $0D
	sta s_oam + $0E
	sta s_oam + $0F
	
	;ID
	stz s_oam_id + $00
	stz s_oam_id + $01
	stz s_oam_id + $02
	stz s_oam_id + $03
	stz s_oam_id + $04
	stz s_oam_id + $05
	stz s_oam_id + $06
	stz s_oam_id + $07
	
	lda #-32
	ldx #0
	-:
		sta t_oam,X
		inx
	cpx #128
	bne -
		
.ENDM

.MACRO init_dma

		;size DMA
		stz MEM_DMA + 0 
		stz MEM_DMA + 1
		
		;DMA 1
		stz MEM_DMA + 2 
		stz MEM_DMA + 3
		
		;DMA 2
		stz MEM_DMA + 4 
		stz MEM_DMA + 5 
		
		;DMA 3
		stz MEM_DMA + 6 
		stz MEM_DMA + 7
		
		;DMA 4 
		stz MEM_DMA + 8 
		stz MEM_DMA + 9 
		
		;DMA 5
		stz MEM_DMA + 10 
		stz MEM_DMA + 11
		
		;DMA 6
		stz MEM_DMA + 12 
		stz MEM_DMA + 13 
		
		;DMA 7
		stz MEM_DMA + 14 
		stz MEM_DMA + 15
		
		;DMA 8
		stz MEM_DMA + 16 
		stz MEM_DMA + 17 
		
		;bank DMA
		lda #5
		sta MEM_DMA + 18
		sta MEM_DMA + 19
		
		lda #4
		sta MEM_DMA + 20
		sta MEM_DMA + 21
		
		sta MEM_DMA + 22
		sta MEM_DMA + 23
		sta MEM_DMA + 24 
		sta MEM_DMA + 25
	
.ENDM

.MACRO init_text

	stz MEM_TEXT + 0
	stz MEM_TEXT + 1
	stz MEM_TEXT + 2
	stz MEM_TEXT + 3
	stz MEM_TEXT + 4
	stz MEM_TEXT + 5
	stz MEM_TEXT + 6
	stz MEM_TEXT + 7
	stz MEM_TEXT + 8
	stz MEM_TEXT + 9
	stz MEM_TEXT + 10
	stz MEM_TEXT + 11
	stz MEM_TEXT + 12
	stz MEM_TEXT + 13
	stz MEM_TEXT + 14
	stz MEM_TEXT + 15
    
.ENDM

.MACRO init_msb

	stz s_msb + $00
	stz s_msb + $01
	stz s_msb + $02
	stz s_msb + $03
	stz s_msb + $04
	stz s_msb + $05
	stz s_msb + $06
	stz s_msb + $07
    
.ENDM

.MACRO init_rand

	stz rand8
	stz rand8 + 1
    
.ENDM

.MACRO init_britgness

	stz MEM_BRIGTNESS
	stz MEM_BRIGTNESS + 1
    
.ENDM

.MACRO init_menu
    ;menu
    stz s_menu ; menu on/off
    lda #$40
    sta s_menu + 1 ;angle menu
    stz s_menu + 2 ;n objet
    stz s_menu + 3 ;tmp rotate icon
    stz s_menu + 4 ;direction rotate
    stz s_menu + 5 ;tmp rotate
    stz s_menu + 6 ; menu ouvert/ferme
    stz s_menu + 7 ; n objet actuel
    stz s_menu + 8 ; *objet actuel
.ENDM

.MACRO init_map
	;adresse bg 1
    ldx #\1
    stx s_map + $00
    
    ;bank bg 1
    ldx #:\1
    stx s_map + $02
    
    ;adresse bg 2
    ldx #\2
    stx s_map + $04
    
    ;bank bg 2
    ldx #:\2
    stx s_map + $06
    
    ;adresse collision
    ldx #\3
    stx s_map + $08
    
    ;bank collision
    ldx #:\3
    stx s_map + $0A
    
    ;map enable change
    lda #0
    sta s_map + $0C
    sta s_map + $0D
    
    
    ;enable palette
    lda #\4
    sta s_map + $1F
    
.ENDM


.MACRO init_position_map
    ;position H scroll
    lda #\1
    sta s_map + $10
    
    ;position V scroll
    lda #\2
    sta s_map + $11
    
    ;position x Hero
    lda #\3
    sta s_map + $12
    
    ;position y Hero
    lda #\4
    sta s_map + $13
	
.ENDM

.MACRO init_perso

	; hero x
    lda s_map + $12
    sta s_perso + $00
    
    ; hero y
    lda s_map + $13
    sta s_perso + $01
    
    ; hero tile (OAM)
    lda #0
    sta s_perso + $02

    ;flip x/autre
	stz s_perso + $03
	
	;temp animation
    stz s_perso + $04
    
    ;play anim
    stz s_perso + $05
    
    ;nanim
    stz s_perso + $06  
    
    ;adresse anim
    ldx #0
    stx s_perso + $07  
    stx s_perso + $09
    stz s_perso + $0B
    
    ;vitesse
    stz s_perso + $0C ;x
    stz s_perso + $0D ;y
    
    stz s_perso + $0E ; action talk
    stz s_perso + $0F ; direction
    
    stz s_perso + $10 ; prio trs
    
.ENDM

.MACRO init_pnj
	
	ldy #\1
	sty s_pnj + $00 + \3 ;x
	
	ldy #\2
	sty s_pnj + $02 + \3 ;y
	
	ldy #0
	sty s_pnj + $04 + \3 ;vitesse x
	sty s_pnj + $06 + \3 ;vitesse y
	
	stz s_pnj + $08 + \3 ; OAM ADDRESS
	stz s_pnj + $09 + \3 ; zorder
	
	stz s_pnj + $0A + \3 ; IA direction
	lda #60
	sta s_pnj + $0B + \3 ; IA incrémente

	lda #:\4
	sta s_pnj + $0C + \3 ; Bank DMA
	stz s_pnj + $0D + \3 ; prio
	
	ldy #\5
	sty s_pnj + $0E + \3 ; Texte adresse
	
	ldy #0
	sty s_pnj + $10 + \3 ;tile
	stz s_pnj + $12 + \3 ;temp animation
	stz s_pnj + $13 + \3 ;play anim
	stz s_pnj + $14 + \3 ;nanim
	stz s_pnj + $15 + \3 ;tile old
		
	sty s_pnj + $18 + \3 ; Store DMA
	sty s_pnj + $1A + \3 ; Store DMA old
	
	ldy #\4
	sty s_pnj + $1C + \3 ; Base DMA
	
	stz s_pnj + $1E + \3 ; Texte Bank
	stz s_pnj + $1F + \3 ; stop

.ENDM
