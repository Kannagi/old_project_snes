
Map_transparent:

	SNES_INIDISP $0F
	
	SNES_TS $11
    
	SNES_CGSWSEL $02
	SNES_CGADSUB $42
	
	SNES_INIDISP $8F
	rts

Load_map1:
	init_map map1 map2 mapc $00

	;Load bg 2
	SNES_VMADD $2000
    
	SNES_DMA0_ADD tile2 $1000
	SNES_DMA1_ADD tile4 $1000
	SNES_DMA2_ADD tile5 $1000
	
    SNES_MDMAEN $07
    
    ;Load bg 1
    SNES_VMADD $0000
   
	SNES_DMA0_ADD tile7 $1000
	SNES_DMA1_ADD tile9 $1000
	SNES_DMA2_ADD tile8 $2000
	
    SNES_MDMAEN $07


    ; Load Palette       
    SNES_DMAX $00
	SNES_DMAX_BADD $22

	;Object Palette
	SNES_CGADD $80
	
    SNES_DMA0_ADD pallette_eagle1 $0020
    SNES_DMA1_ADD pallette_old_man $0020
    SNES_DMA2_ADD pallette_man $0020
    SNES_DMA3_ADD pallette_Jean $0020
    SNES_DMA4_ADD pallette_soldat $0020
 
    SNES_MDMAEN $1F
    
    
    ;Tile palette
    SNES_CGADD $20
    SNES_DMA0_ADD pallette_tile2 $0020
    SNES_DMA1_ADD pallette_tile4 $0020
    SNES_DMA2_ADD pallette_tile5 $0020
    
    SNES_DMA3_ADD pallette_tile7 $0020
    SNES_DMA4_ADD pallette_tile9 $0020
    SNES_DMA5_ADD pallette_tile8 $0020
    
    SNES_MDMAEN $3F


	rts
	
Load_map2:

	init_map map3 map4 mapc2 $01
	jsr Map_transparent
	
	;Load bg 2
	SNES_VMADD $2000
    
	SNES_DMA0_ADD tile14 $1000
	SNES_DMA1_ADD tile15 $1000
	
    SNES_MDMAEN $03
    
    ;Load bg 1
    SNES_VMADD $0000
   
	SNES_DMA0_ADD tile13 $1000
	SNES_DMA1_ADD tile15 $1000
	
    SNES_MDMAEN $03


    ; Load Palette       
    SNES_DMAX $00
	SNES_DMAX_BADD $22

	;Object Palette
	SNES_CGADD $80
	
    SNES_DMA0_ADD pallette_eagle1 $0020
    SNES_DMA1_ADD pallette_Papi $0020
    SNES_DMA2_ADD pallette_man $0020
    SNES_DMA3_ADD pallette_Jean $0020
    SNES_DMA4_ADD pallette_soldat $0020
 
    SNES_MDMAEN $1F
    
    
    ;Tile palette
    SNES_CGADD $20
    SNES_DMA0_ADD pallette_tile14 $0020
    SNES_DMA1_ADD pallette_tile15 $0020
    SNES_DMA2_ADD pallette_tile14 $0020
    
    SNES_DMA3_ADD pallette_tile13 $0020
    SNES_DMA4_ADD pallette_tile15 $0020
    SNES_DMA5_ADD pallette_tile13 $0020
    
    SNES_MDMAEN $3F


	rts
