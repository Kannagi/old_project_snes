



.MACRO init_personnage

	ldx #\1*$40

	rep #$20
	
	lda #\2
	sta	s_perso + _x,x
	
	lda #\3
	sta	s_perso + _y,x
	
	lda #\6
	sta	s_perso + _add,x
	
	lda #\7
	sta	s_perso + _tadd,x
	
	sep #$20
	
	lda #:\6
	sta	s_perso + _bankadd,x
	
	lda #:\7
	sta	s_perso + _tbankadd,x
	
	
	lda #$00+\4
	sta s_perso + _tile,x
	
	lda #$20+\5
	sta s_perso + _flip,x
	
	lda #$21
	sta s_perso + _dma,x
	
	stz	s_perso + _tag,x
	
	stz	s_perso + _oam,x
	stz	s_perso + _oam+1,x
	
	stz s_perso + _mt,x
	lda s_map+_mode
	cmp #0
	beq +
		lda #\8
		sta s_perso + _mt,x
	+:
	
	lda #$FF
	sta s_perso+_dgt+1,x
	
	
.ENDM

.MACRO init_hero

	ldx #\1*$40

	rep #$20
	
	
	lda #\4
	sta	s_perso + _add,x
	
	sep #$20
	
	lda #:\4
	sta	s_perso + _bankadd,x
	
	
	lda #$00+\2
	sta s_perso + _tile,x
	
	lda #$20+\3
	sta s_perso + _flip,x
	
	lda #$21
	sta s_perso + _dma,x
	
	stz	s_perso + _tag,x
	
	stz	s_perso + _oam,x
	stz	s_perso + _oam+1,x
	
	stz s_perso + _mt,x
	lda s_map+_mode
	cmp #0
	beq +
		lda #\5
		sta s_perso + _mt,x
	+:
	
	lda #$FF
	sta s_perso+_dgt+1,x
	
	
.ENDM

.MACRO init_pnj

	ldx #\1*$40

	rep #$20
	
	lda #\2
	sta	s_perso + _x,x
	
	lda #\3
	sta	s_perso + _y,x
	
	lda #\6
	sta	s_perso + _add,x
	
	lda #\7
	sta	s_perso + _tadd,x
	
	sep #$20
	
	lda #:\6
	sta	s_perso + _bankadd,x
	
	lda #:\7
	sta	s_perso + _tbankadd,x
	
	
	lda #$00+\4
	sta s_perso + _tile,x
	
	lda #$20+\5
	sta s_perso + _flip,x
	
	lda #$21
	sta s_perso + _dma,x
	
	stz	s_perso + _tag,x
	
	stz	s_perso + _oam,x
	stz	s_perso + _oam+1,x
	
	stz s_perso + _mt,x
	
	lda #$FF
	sta s_perso+_dgt+1,x
	
	
.ENDM

.MACRO init_ennemi

	ldx #\1*$40

	rep #$20
	
	lda #\2
	sta	s_perso + _x,x
	
	lda #\3
	sta	s_perso + _y,x
	
	lda #\6
	sta	s_perso + _add,x
	
	lda #\7
	sta	s_perso + _tadd,x
	
	sep #$20
	
	lda #:\6
	sta	s_perso + _bankadd,x
	
	lda #:\7
	sta	s_perso + _tbankadd,x
	
	
	lda #$00+\4
	sta s_perso + _tile,x
	
	lda #$20+\5
	sta s_perso + _flip,x
	
	lda #$21
	sta s_perso + _dma,x
	
	stz	s_perso + _tag,x
	
	stz	s_perso + _oam,x
	stz	s_perso + _oam+1,x
	
	stz s_perso + _mt,x
	
	lda #$FF
	sta s_perso+_dgt+1,x
	
	
	
	
.ENDM



.MACRO Clear_RAM_Game
    
    ldx #$0
	ldy #0
	sty 0
	-:
		sty 0,x
		inx
		inx
		cpx #$240
	bne -
	
	ldx #$300
	-:
		sty 0,x
		inx
		inx
		cpx #$1000
	bne -
	
	ldx #$10C0
	-:
		sty 0,x
		inx
		inx
		cpx #$2000
	bne -
	
	
.ENDM




.MACRO init_degat
    
    ;1
    ldx #12*1
    
    lda #$4C
    sta s_degat+_ch1,x
    lda #$4E
    sta s_degat+_ch2,x
    lda #$60
    sta s_degat+_ch3,x
    
    lda #$20*0
    sta s_degat+_dch1,x
    
    lda #$0
    sta s_degat+_dch2,x
    
    lda #$4A
    sta s_degat+_dch3,x
    
    ;2
    ldx #12*2
    
    lda #$62
    sta s_degat+_ch1,x
    lda #$64
    sta s_degat+_ch2,x
    lda #$66
    sta s_degat+_ch3,x
    
    lda #$20*1
    sta s_degat+_dch1,x
    
    lda #$0
    sta s_degat+_dch2,x
    
    lda #$60
    sta s_degat+_dch3,x
    
    ;3
    ldx #12*3
    
    lda #$68
    sta s_degat+_ch1,x
    lda #$6A
    sta s_degat+_ch2,x
    lda #$6C
    sta s_degat+_ch3,x
    
    lda #$20*2
    sta s_degat+_dch1,x
    
    lda #$0
    sta s_degat+_dch2,x
    
    lda #$66
    sta s_degat+_dch3,x
    
    ;4
    ldx #12*4
    
    lda #$6E
    sta s_degat+_ch1,x
    lda #$80
    sta s_degat+_ch2,x
    lda #$82
    sta s_degat+_ch3,x
    
    lda #$20*3
    sta s_degat+_dch1,x
    
    lda #$0
    sta s_degat+_dch2,x
    
    lda #$6C
    sta s_degat+_dch3,x
    
    ;5
    ldx #12*5
    
    lda #$84
    sta s_degat+_ch1,x
    lda #$86
    sta s_degat+_ch2,x
    lda #$88
    sta s_degat+_ch3,x
    
    lda #$20*4
    sta s_degat+_dch1,x
    
    lda #$0
    sta s_degat+_dch2,x
    
    lda #$0
    sta s_degat+_dch3,x
    
    ;6
    ldx #12*6
    
    lda #$8A
    sta s_degat+_ch1,x
    lda #$8C
    sta s_degat+_ch2,x
    lda #$8E
    sta s_degat+_ch3,x
    
    lda #$20*5
    sta s_degat+_dch1,x
    
    lda #$0
    sta s_degat+_dch2,x
    
    lda #$0
    sta s_degat+_dch3,x
    
.ENDM



.MACRO init_position
	ldx #\1
	stx s_map+_ix
	
	ldx #\2
	stx s_map+_iy
	
	ldx #\3
	stx s_map+_imx
	
	ldx #\4
	stx s_map+_imy
.ENDM

.MACRO update_position
	ldx s_map+_ix
	stx s_perso+_x
	stx s_perso+_x+$40
	;stx s_perso+_x+$80
	
	ldx s_map+_iy
	stx s_perso+_y
	stx s_perso+_y+$40
	;stx s_perso+_y+$80
	
	
.ENDM

.MACRO init_scrolling

	lda #1
	sta LKS_BG+_bgEnableX
	sta LKS_BG+_bgEnableY
	
	
	
	
	
	lda s_map+_imx
	cmp #0
	beq +
	ldx #0
	-:
		phx
		
		lda LKS_BG+_bg1x
		sta BG2H0FS
		lda LKS_BG+_bg1x+1
		sta BG2H0FS
		
		lda LKS_BG+_bg1x
		sta BG1H0FS
		lda LKS_BG+_bg1x+1
		sta BG1H0FS
		
		
		SNES_DMA0 $00
		SNES_DMA0_BADD $80
		jsr Scrolling_precalcul
		
		
		SNES_DMAX $01
		SNES_DMAX_BADD $18
		
		jsl Background1X
		jsl Background2X
		
		rep #$20
		lda LKS_BG+_bg1x
		clc
		adc #$10
		sta LKS_BG+_bg1x
		sep #$20
		
		plx
		
		inx
		cpx s_map+_imx
	bne -
	+:
	
	
    
    lda s_map+_imy
	cmp #0
	beq +
    ldx #0
	-:
		phx
		
		lda LKS_BG+_bg1y
		sta BG2H0FS
		lda LKS_BG+_bg1y+1
		sta BG2H0FS
		
		lda LKS_BG+_bg1y
		sta BG1H0FS
		lda LKS_BG+_bg1y+1
		sta BG1H0FS
	
		SNES_DMA0 $00
		SNES_DMA0_BADD $80
		jsr Scrolling_precalcul
		SNES_DMAX $01
		SNES_DMAX_BADD $18
		
		jsl Background1Y
		jsl Background2Y
		
		rep #$20
		lda LKS_BG+_bg1y
		clc
		adc #$10
		sta LKS_BG+_bg1y
		sep #$20
		
		plx
		
		inx
		cpx s_map+_imy
	bne -
	+:
    
	
	lda #0
	sta LKS_BG+_bgEnableX
	sta LKS_BG+_bgEnableY
	
.ENDM






.MACRO init_menu
    
.ENDM




