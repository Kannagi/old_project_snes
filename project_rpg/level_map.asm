
Map_alpha:

	
	SNES_TS $11
	    
	SNES_CGSWSEL $02
	SNES_CGADSUB $42
	
	rtl
	
Map_Level1_out:

	lda MEM_TEMPFUNC
	cmp #0
	bne +
		ldx #1
		stx s_map+_mlevel 
	+:

	rtl
	
Map_Level1:

	
	load_map map1,map2,mapc
	jsl Map_Tile1
	
	lda #0
	sta s_map+_mode
	
	
	lda s_map+_beginp
	cmp #0
	bne +
		init_position 360,300,16,12
		bra ++
	+:
	cmp #1
	bne +
		init_position 830,170,46,6
	+:
	++:
	
	
	init_pnj 3,380,350,$28,$06,Soldat,Text
	init_pnj 4,460,350,$40,$08,old_man,Text
	init_pnj 5,460,300,$48,$0A,Jean,Text
	
	init_pnj 6,460,250,$60,$0C,Man,Text
	init_pnj 7,460,200,$68,$06,Soldat,Text
	
	init_pnj 8,280,350,$80,$06,Soldat,Text
	init_pnj 9,340,350,$88,$08,old_man,Text
	init_pnj 10,280,300,$A0,$0C,Man,Text
	init_pnj 11,280,250,$A8,$0A,old_man,Text
	
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$160,0
    
    SNES_DMA0_ADD pallette_soldat    $0020
    SNES_DMA1_ADD pallette_old_man   $0020
    SNES_DMA2_ADD pallette_Jean     $0020
    SNES_DMA3_ADD pallette_man     $0020
    
    SNES_MDMAEN $0F
    
    PAL_WRAM pallette_soldat,11
    PAL_WRAM pallette_old_man,12
    PAL_WRAM pallette_Jean,13
    PAL_WRAM pallette_man,14
	
	rtl
	
Map_Level2_out:

	lda MEM_TEMPFUNC
	cmp #0
	bne +
		ldx #0
		stx s_map+_mlevel 
		
		lda #1
		sta s_map+_beginp 
		rtl
	+:
	cmp #1
	bne +
		ldx #2
		stx s_map+_mlevel 
		
		
		rtl
	+:

	rtl
		
Map_Level2:

	load_map map4,map5,mapc2
	jsl Map_Tile2
	lda #1
	sta s_map+_mode
	
	lda s_map+_beginp
	cmp #0
	bne +
		init_position 200,550,7,28
		bra ++
	+:
	cmp #1
	bne +
		init_position 200,200,8,4
	+:
	++:
	
	jsl Map_alpha
	
	init_ennemi 3,280,200,$60,$06,Lapin,pallette_Lapin
	init_ennemi 4,160,200,$88,$08,Lapin,pallette_Lapin
	init_ennemi 5,160,150,$C0,$0A,Lapin,pallette_Lapin
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$160,0
    
    SNES_DMA0_ADD pallette_Lapin   $0020
    SNES_DMA1_ADD pallette_Lapin   $0020
    SNES_DMA2_ADD pallette_Lapin   $0020
    
    SNES_MDMAEN $07
    
    PAL_WRAM pallette_Lapin,11
    PAL_WRAM pallette_Lapin,12
    PAL_WRAM pallette_Lapin,13
	
	
	rtl
	
	
Map_Tile1:

	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;Load bg 2
	SNES_VMADD $0000
    
	SNES_DMA0_ADD tile2 $1000
	SNES_DMA1_ADD tile4 $1000
	SNES_DMA2_ADD tile5 $1000
	
    SNES_MDMAEN $07
    
    ;Load bg 1
    SNES_VMADD $2000
   
	SNES_DMA0_ADD tile7 $1000
	SNES_DMA1_ADD tile9 $1000
	SNES_DMA2_ADD tile8 $2000
	
    SNES_MDMAEN $07

	;palette ram
    SNES_WMADD LKS_BUF_PAL&$FFFF+$40,0
	
	SNES_DMAX $00
	SNES_DMAX_BADD $80
	
	SNES_DMA0_ADD pallette_tile2 $0020
    SNES_DMA1_ADD pallette_tile4 $0020
    SNES_DMA2_ADD pallette_tile5 $0020
    
    SNES_DMA3_ADD pallette_tile7 $0020
    SNES_DMA4_ADD pallette_tile9 $0020
    SNES_DMA5_ADD pallette_tile8 $0020
	
    SNES_MDMAEN $3F
    
    
    ;----------------
    PAL_WRAM pallette_tile2,2
    PAL_WRAM pallette_tile4,3
    PAL_WRAM pallette_tile5,4
    
    PAL_WRAM pallette_tile7,5
    PAL_WRAM pallette_tile9,6
    PAL_WRAM pallette_tile8,7
    
    
	rtl
	
Map_Tile2:

	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;Load bg 2
	SNES_VMADD $0000
    
	SNES_DMA0_ADD tile14 $1000
	SNES_DMA1_ADD tile15 $1000
	SNES_DMA2_ADD tile2 $1000
	
    SNES_MDMAEN $07
    
    ;Load bg 1
    SNES_VMADD $2000
   
	SNES_DMA0_ADD tile13 $1000
	SNES_DMA1_ADD tile15 $1000
	SNES_DMA2_ADD tile2 $2000
	
    SNES_MDMAEN $07

	;palette ram
    SNES_WMADD LKS_BUF_PAL&$FFFF+$40,0
	
	SNES_DMAX $00
	SNES_DMAX_BADD $80
	
	SNES_DMA0_ADD pallette_tile14 $0020
    SNES_DMA1_ADD pallette_tile15 $0020
    SNES_DMA2_ADD pallette_tile5 $0020
    
    SNES_DMA3_ADD pallette_tile13 $0020
    SNES_DMA4_ADD pallette_tile15 $0020
    SNES_DMA5_ADD pallette_tile8 $0020
	
    SNES_MDMAEN $3F
    
    
    ;----------------
    PAL_WRAM pallette_tile14,2
    PAL_WRAM pallette_tile15,3
    PAL_WRAM pallette_tile5,4
    
    PAL_WRAM pallette_tile13,5
    PAL_WRAM pallette_tile15,6
    PAL_WRAM pallette_tile8,7
    
    
	rtl
	
Map_Level3_out:

	lda MEM_TEMPFUNC
	cmp #0
	bne +
		ldx #$01
		stx s_map+_mlevel 
		
		lda #1
		sta s_map+_beginp 
	+:

	rtl

Map_Level3:

	load_map map6,map7,mapc3
	jsl Map_Tile3
	lda #1
	sta s_map+_mode
	
	init_position 40,55,1,1
	
	jsl Map_alpha
	
	ldx #$800
	stx LKS_BG+_bglimitex
	
	ldx #$800
	stx LKS_BG+_bglimitey
	
	ldx #$1000
	stx LKS_BG+_bgaddy
	
	init_ennemi 3,140,30,$60,$06,Dragon,pallette_dragon
	lda #$1
	sta s_perso + _type,x
	init_ennemi 4,160,200,$88,$08,Dragon,pallette_dragon
	lda #$1
	sta s_perso + _type,x
	init_ennemi 5,160,150,$C0,$0A,Dragon,pallette_dragon
	lda #$1
	sta s_perso + _type,x
	
	
	init_ennemi 6,540,100,$60,$06,Lapin,pallette_Lapin
	init_ennemi 7,600,100,$60,$06,Lapin,pallette_Lapin
	
	init_ennemi 8,100,300,$60,$06,Lapin,pallette_Lapin
	init_ennemi 9,100,500,$60,$06,Lapin,pallette_Lapin
	init_ennemi 10,100,700,$60,$06,Lapin,pallette_Lapin
	init_ennemi 11,100,900,$60,$06,Lapin,pallette_Lapin
	init_ennemi 12,100,1100,$60,$06,Lapin,pallette_Lapin
	
	init_ennemi 13,160,1450,$C0,$0A,Dragon,pallette_dragon
	lda #$1
	sta s_perso + _type,x
	
	init_ennemi 14,160,1850,$C0,$0A,Dragon,pallette_dragon
	lda #$1
	sta s_perso + _type,x
	
	init_ennemi 15,100,1900,$60,$06,Lapin,pallette_Lapin

	SNES_WMADD LKS_BUF_PAL&$FFFF+$160,0
    
    SNES_DMA0_ADD pallette_dragon   $0020
    SNES_DMA1_ADD pallette_dragon   $0020
    SNES_DMA2_ADD pallette_dragon   $0020
    
    SNES_MDMAEN $07
    
    PAL_WRAM pallette_dragon,11
    PAL_WRAM pallette_dragon,12
    PAL_WRAM pallette_dragon,13
    
    
	
	
	rtl

Map_Tile3:

	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;Load bg 2
	SNES_VMADD $0000
    
	SNES_DMA0_ADD tile14 $1000
	SNES_DMA1_ADD tile15 $1000
	SNES_DMA2_ADD tile2 $1000
	
    SNES_MDMAEN $07
    
    ;Load bg 1
    SNES_VMADD $2000
   
	SNES_DMA0_ADD tile13 $1000
	SNES_DMA1_ADD tile7 $1000
	SNES_DMA2_ADD tile8 $2000
	
    SNES_MDMAEN $07

	;palette ram
    SNES_WMADD LKS_BUF_PAL&$FFFF+$40,0
	
	SNES_DMAX $00
	SNES_DMAX_BADD $80
	
	SNES_DMA0_ADD pallette_tile14 $0020
    SNES_DMA1_ADD pallette_tile15 $0020
    SNES_DMA2_ADD pallette_tile2 $0020
    
    SNES_DMA3_ADD pallette_tile13 $0020
    SNES_DMA4_ADD pallette_tile7 $0020
    SNES_DMA5_ADD pallette_tile8 $0020
	
    SNES_MDMAEN $3F
    
    
    ;----------------
    PAL_WRAM pallette_tile14,2
    PAL_WRAM pallette_tile15,3
    PAL_WRAM pallette_tile2,4
    
    PAL_WRAM pallette_tile13,5
    PAL_WRAM pallette_tile7,6
    PAL_WRAM pallette_tile8,7
    
    
	rtl
	
