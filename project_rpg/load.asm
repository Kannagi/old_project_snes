



	
Load_Hud:

	;Load Object
    SNES_DMAX $01
	SNES_DMAX_BADD $18
    
    ;Load bg 3
	SNES_VMADD $4000
	SNES_DMA0_ADD Texte $0400
	SNES_DMA1_ADD wmenu1 $40
    SNES_MDMAEN $03
    
    SNES_VMADD $4400
	SNES_DMA0_ADD Texte2 $0C00	
    SNES_MDMAEN $01
	
	;----------------
	SNES_DMAX $00
	SNES_DMAX_BADD $80
	
    SNES_WMADD LKS_BUF_PAL&$FFFF,0
    
    SNES_DMA0_ADD pallette_fontm $0008
    SNES_DMA1_ADD pallette_wmenu1 $0008
    SNES_DMA2_ADD pallette_font8x16 $0008
    SNES_MDMAEN $07
    

    lda #0
    sta LKS_BUF_PAL
    sta LKS_BUF_PAL+1
    
    
    lda #1
    sta s_palette+_pltype
    
    jsl LKS_DMA_PAL

	rts

Load_other:

    ;load select menu
    LKS_LOAD_VRAM $7E00,$00,select_menu,$40
    LKS_LOAD_VRAM $7F00,$40,select_menu,$40
    
    ;load select 
    LKS_LOAD_VRAM $7E20,$00,Select,$40
    LKS_LOAD_VRAM $7F20,$40,Select,$40
	
	;load epee
	LKS_LOAD_VRAM $6200,$000,Epee,$100
    LKS_LOAD_VRAM $6300,$100,Epee,$100
	
	
	
	

    ;----------------
    
    SNES_DMAX $00
	SNES_DMAX_BADD $80
    
    
    ;------
    SNES_WMADD LKS_BUF_PAL&$FFFF+$100,0
    
    SNES_DMA0_ADD pallette_randi  $0020
    SNES_DMA1_ADD pallette_eagle1 $0020
    SNES_DMA2_ADD pallette_Jean $0020
    
    SNES_MDMAEN $07
    
    
    PAL_WRAM pallette_randi,8
    PAL_WRAM pallette_eagle1,9
    PAL_WRAM pallette_Jean,10
    ;

	;autre
	lda s_map+_mode
	cmp #0
	beq +
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$1C0,0
    
    SNES_DMA0_ADD pallette_epee $0020
    SNES_DMA1_ADD pallette_fontdgt $0020
    
    SNES_MDMAEN $03
    
    PAL_WRAM pallette_epee,14
    PAL_WRAM pallette_fontdgt,15
    
    +:
    
    lda #2
    sta s_palette+_pltype
    
    jsl LKS_DMA_PAL

	rts



