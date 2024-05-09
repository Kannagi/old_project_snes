



Mode7:
	SNES_INIT
	
    ;INITIAL SETTINGS
	SNES_INIDISP $8F ; FORCED BLANK , brigtness 15
	
	;object
	SNES_OBJSEL $A3 ; 32x32 , $4000 address
	
	;background
	SNES_BGMODE $07 ;  Mode 7
	SNES_BG1SC $00
	SNES_BGNBA $00 $00 ; address BG1,2,3,4 (2,1 / 4,3)
	
	;general init
	SNES_SETINI $00
    SNES_TM $11 ; obj & bg 1,3 enable
    
    ;FORCED BLANK
       

	;Load bg 1
    SNES_VMAINC $00
	SNES_VMADD $0000
    
    SNES_DMA0 $00
	SNES_DMA0_BADD $18
	SNES_DMA0_ADD Map $4000
	
    SNES_MDMAEN $01
    

    SNES_VMAINC $80
	SNES_VMADD $0000
    
    SNES_DMA0 $00
	SNES_DMA0_BADD $19
    SNES_DMA0_ADD Tiles $2000
    
    SNES_MDMAEN $01    
    
    ;Load Object
    SNES_VMADD $6000
    
    SNES_DMA0 $01
	SNES_DMA0_BADD $18
	SNES_DMA0_ADD Eagle1 $1800	
	
    SNES_MDMAEN $01
    

    
    ; Load Palette
    SNES_CGADD $00
       
    SNES_DMA0 $00
	SNES_DMA0_BADD $22
    SNES_DMA0_ADD pallette_mode7 $009A
    SNES_MDMAEN $01
    
    ;pl hero
    SNES_CGADD $80
       
    SNES_DMA0 $00
	SNES_DMA0_BADD $22
    SNES_DMA0_ADD pallette_eagle1 $0020
    SNES_MDMAEN $01
    
    SNES_NMITIMEN $81 ; Enable NMI , enable joypad

    ;Begin game
    init_oam -32
    
    ldx #1
	stx MEM_VBLANK
    
    SNES_M7SEL $80

	;--------------------------
	

	
	ldy #$00
	sty angle
	
	;centre de rotation
	ldx #$0080
	stx X
	stx Y
	
	;scale
	ldx #$0200
	stx sx
	stx sy
	
	SNES_INIDISP $0F ;  brigtness 15
		
	Game2:	
		wai
		
		
		lda MEM_STDCTRL + $04	; read joypad 1 L
		cmp #2
		bne +
			inc angle
		+:
		
		lda MEM_STDCTRL + $05	; read joypad 1 R
		cmp #2
		bne +
			dec angle
		+:
		
		lda MEM_STDCTRL + $07	; read joypad 1 Start
		cmp #1
		bne +	
			jml Begin
		+:
		
		
		lda MEM_STDCTRL + $0A	; read joypad 1 Down
		cmp #2
		bne +	
			rep #$20
			inc sx
			inc sy
			
			sep #$20
		+:
		
		lda MEM_STDCTRL + $0B	; read joypad 1 UP
		cmp #2
		bne +
			rep #$20
			dec sx
			dec sy
			sep #$20
		+:
			

    jmp Game2
    
    
    	
sincos:
	.include "rotation/sincos.inc"
	



