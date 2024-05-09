
.MACRO INIT_MAP

	rep #$20
	lda #\1
	sta LKS_ZP
	
	lda #:\1
	sta LKS_ZP+2
	
	sep #$20
	jsr Init_Map
	
.ENDM

Game:

	jsl LKS_INIT
	jsl LKS_OAM_Address_Init
	LKS_Clear_VRAM
	
	/*
	SNES_WH0 $40
	SNES_WH1 $F0
	SNES_W12SEL $02
	SNES_WOBJSEL $22
	SNES_TMW $01
	
	SNES_CGSWSEL $00
	SNES_CGADSUB $42
	*/
	
	jsl Map_Tile2
	;jsl LKS_MODE_ALPHA
	
	LKS_INIT_BG BG1,BG2,64,64,BG1C
	
	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	jsl LKS_Unpack_Map
	
	jsl LKS_Background1
	jsl LKS_Background2
	
	;load bullet
	LKS_LOAD_VRAM $7E00,$00,Bullet,$400
	LKS_LOAD_CG $F0,Bullet_pal,$20
	
	;load font
	jsl LKS_load_font
	
	;load sprite pal
	LKS_LOAD_CG $80,Papi_pal,$20
	LKS_LOAD_CG $90,Officier_pal,$20

	jsr Init_Game
	
	jsr Bullet_Init
	
	INIT_MAP BG1T
	
	
	ldy #0
	jsl LKS_Scrolling_init
	jsr Ennemy_Sort_Init
	
	jsl LKS_GAMELOOP_INIT
	GameLoop:
		jsl LKS_Fade_in
		
		lda LKS_STDCTRL+_START
		cmp #1
		bne +
			jsr Pause
		+:
		SNES_DMAX $00
		SNES_DMAX_BADD $80
			
		jsl LKS_Joypad
		
		jsl LKS_OAM_Clear
		
		
		jsr Gameplay
		
		jsr Player_Papi
		jsr Player_Mami
		jsr Ennemy		
		
		jsl LKS_Scrolling		
		
		jsr Text_draw
		
		jsr Collision_Bullet
		jsr Draw_Bullet
		
		jsr Ennemy_Sort
		
		
		jsl LKS_DMA_SORT
		jsl LKS_Zorder10
		jsl WaitVBlank

		jmp GameLoop
	
	rts
	
Pause:
	jsl WaitVBlank
	jsl LKS_Joypad
	lda LKS_STDCTRL+_START
	cmp #1
	beq +
		jmp Pause
	+:
	rts






