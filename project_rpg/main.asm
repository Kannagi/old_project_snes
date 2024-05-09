.include "header.asm"
.include "snes.asm"
.include "init.asm"
.include "variable.asm"

.include "MC_libks.asm"
.include "SPC/spc.asm"


.MACRO	PAL_WRAM

	lda #:\1
	ldx #\1
	
	stx s_palette+$10+(3*\2)
	sta s_palette+$10+(3*\2)+2
	
.ENDM

.bank 0 slot 0
.org 0

;cycle 10 * _while
.MACRO test_perf ARGS _while
	ldx #0
	-:
		ldy $00
		sta $00
		inx
		
	cpx #_while
	bne -
	
.ENDM



.MACRO test_save
    
    lda #\2
	sta \1
	
	lda #'A'
	sta \1+1
	lda #'B'
	sta \1+2
	lda #'C'
	sta \1+3
	lda #'D'
	sta \1+4
	lda #'E'
	sta \1+5

	
	
.ENDM



Int:
	
	rti

Main:
	sei
	clc
    xce
    
    phk
	plb
	rep #$38

	ldx.w #$1FFF 
	txs

	lda.w #$0000
	tcd
	
	
	rep #$10	;16 bit xy
	sep #$20	; 8 bit a

	
	SNES_INIDISP $80
	SNES_NMITIMEN $00
	LKS_Clear_RAM

	
Reset:
	rep #$10	;16 bit xy
	sep #$20	; 8 bit a
	
	SNES_INIDISP $80
	SNES_NMITIMEN $00
	LKS_Clear_RAM
	
	
	
	lda #0
	stz s_map+_beginp
	sta s_map+_mlevel
	
	stz s_map+_beginp
	
Begin:

    SNES_INIT
    
    
    
    Clear_RAM_Game
    ;jml Mode7
	
    ;INITIAL SETTINGS
	
	;object
	SNES_OBJSEL $63 ; 16x16 , $6000 address
	
	;background
	SNES_BGMODE $39 ; BG 1 & 2 16x16, BG 3 8x8,mode 1 , BG 3 pri
	
	SNES_BG1SC $50 ; address data BG1 $5000
	SNES_BG2SC $54 ; address data BG2 $5400
	SNES_BG3SC $58 ; address data BG3 $5800
	
	SNES_BGNBA $00 $04; address BG1,2,3,4 (2,1 / 4,3)
	
	;general init
	SNES_SETINI $00
	SNES_MEMSEL $00
	SNES_WRIO $FF
    SNES_TM $17 ; obj & bg 1,2,3 enable
    SNES_COLDATA $E0
    
    SNES_VMAINC $80

    LKS_Clear_VRAM
    
    test_save $700000,$88
    
    
    ;FORCED BLANK
       
    
    jsr Map_Load
    jsr Load_Hud
    
	jsr Load_other
	
	;n id,tile,flip/prio,adresse image ,weapon 
	init_hero 0,$00,$00,Randi,1
	init_hero 1,$08,$02,Eagle1,1
	init_hero 2,$40,$04,Jean,0
	
	update_position
	
	;Init BG
	
	SNES_DMAX $01
	SNES_DMAX_BADD $18
	jsl Background1
	jsl Background2
	init_scrolling
	
	;init
	ldx #-1
	stx s_effect+_efsel1 
	stx s_effect+_efsel2 
	stx s_effect+_efsel3 
	
	ldx #$3000
	stx LKS_VBLANK+_vbltimemin
	
	ldx #$40
	stx s_menu+_angle
	
	
	LKS_printf_setpal 0
	
	init_degat
	
	
	lda #0
	sta LKS_DMA+_dmaEnable
	
	
	ldx #$C0
	stx s_ennemi+_enP1
	
	ldx #$100
	stx s_ennemi+_enP2
	
	ldx #$140
	stx s_ennemi+_enP3
	
	LKS_printf_setpal 0
	

	
	
	lda	RDNMI
	SNES_INIDISP $00 ;  brigtness 0
	SNES_NMITIMEN $81 ; Enable NMI , enable joypad
	wai
	;SNES_INIDISP $0F ;  brigtness 0
	
	
	;Begin game
	Game:	
		
		jsl LKS_Fade_in
		
		
		jsr Text2
		jsr Text

		
		lda LKS_STDCTRL+_START
		cmp #1
		bne +
			
			;jml Mode7
			;jmp Reset
			;jml Mode7
			
		+:
		
		lda LKS_STDCTRL+_Y
		cmp #1
		bne +

		+:
		
		lda LKS_STDCTRL+_SELECT
		cmp #1
		bne +	
			ldx #$7000
			stx LKS_VBLANK+_vbltimemin
			
			
			
		+:
		
		
		lda s_perso+_tag
		cmp #31
		bmi +
			lda #1
			sta s_game+_stopall
			jsl LKS_Fade_out
		+:
		lda LKS_FADE+_fdphase
		cmp #2
		bne +
			jsr Map_Out
			jmp Begin
		+:
		
		SNES_DMAX $00
		SNES_DMAX_BADD $80
		
		lda s_map+_mlevel
		cmp #1
		bne +
			;LKS_PAL_ANIM 2,$20,3
		+:
		
		lda s_map+_mlevel
		cmp #2
		bne +
			;LKS_PAL_ANIM 2,$20,3
		+:
		
		jsr Pal_Effect00
		
		
		jsl LKS_Joypad
		jsr Joypad
		jsr Perso2_IA
		
		jsr Background_camera
		
		jsr Collision_perso1
		jsr Collision_perso2
		
		jsr Collision_perso_text
	
		jsr Scrolling_precalcul
		
		ldy #$0
		sty s_degat
		stz s_effect
		
		jsl LKS_OAM_Clear	
		
		
		

		
		;----

		
		
		jsr Effect
		ldy #0
		
		stz LKS_OAM+_nperso1
		
		ldx #0 ;port DMA dst
		stx MEM_TEMPFUNC+6
		ldx #0 ;port DMA
		stx MEM_TEMPFUNC+2
		ldx #$00 ;n'id perso
		jsr Personnage2
		jsr Degat_test
		jsr Weapon_draw
		
		;Perso2
		lda #0
		bit #1
		beq +
			ldx #$80 ;port DMA dst
			stx MEM_TEMPFUNC+6
			ldx #$20 ;port DMA
			stx MEM_TEMPFUNC+2
			ldx #$40 ;n'id perso
			jsr Personnage
			jsr Degat_test
			bra ++
		+:
			ldy LKS_OAM
			stx LKS_OAM+$10,y
			iny
			iny
			sty LKS_OAM
		
		++:
		
		
		
		
		;Perso3
		ldy LKS_OAM
		stx LKS_OAM+$10,y
		iny
		iny
		sty LKS_OAM
		
		
		jsr Mode_battle
		jsr Mode_Pnj
		
		jsr Game_Menu_Ring
		
		jsr Z_order_pnj
		jsr Z_order_ennemi
		
		jsr Fenetre_Text
		;test_perf 2500
		
		;test_perf 1570
		
		
		lda s_palette+_pltype
		cmp #0
		bne +

			lda #1
			sta s_palette+_pltype
		
		+:
		
		
		;test_perf (25*80)
		
		;test_perf 700
		
		lda #2
		sta LKS_VBLANK
		jsl WaitVBlank
		stz LKS_VBLANK
		
		
		
		
		;min time VBLANK
		ldy LKS_VBLANK+_vbltime
		cpy LKS_VBLANK+_vbltimemin
		bpl +
			sty LKS_VBLANK+_vbltimemin
		+:
		
		
		
		
    jmp Game
    

	

	

WaitVBlank:
	
	lda SLHV
	lda OPVCT
	lsr
	cmp #12
	bmi ++
	cmp #28
	bpl +
		sec
		sbc #2
		sta LKS_CPU
		bra ++
	+:
	cmp #28*2
	bpl +
		sec
		sbc #5
		sta LKS_CPU
		bra ++
	+:
	cmp #28*3
	bpl +
		sec
		sbc #8
		sta LKS_CPU
		bra ++
	+:
	
		sec
		sbc #11
		sta LKS_CPU
	++:
	
	
	sta LKS_CPU
	
	
	;rep #$20
	;lda #2222
	;wai
	lda #0
	-:
		cmp LKS_VBLANK+_vblenable
	beq -
	stz LKS_VBLANK+_vblenable
	;sta $650
	;sep #$20


	rtl

	
Game_Menu_Ring:

	
	lda s_menu+_rdraw
	cmp #0
	bne +
		rts
	+:
	
	lda s_menu+_ring
	cmp #0
	bne +
		lda #2
		sta LKS_VBLANK
		jsl WaitVBlank
		
		jsl Menu_init_icon
	+:
	
	jsl LKS_Joypad
	
	SNES_DMAX $00
	SNES_DMAX_BADD $80
	
	jsr Text
	
	

	jsr Pal_Effect2
	jsr Pal_Effect1
	jsl Menu
	jsr Gameplay_ring
	jsr Pal_Effect0
	
	ldx #0
	stx s_perso+_vx
	stx s_perso+_vy
	
	stx s_perso+_vx+$40
	stx s_perso+_vy+$40
	
	
	lda #2
	sta LKS_VBLANK
	jsl WaitVBlank
	
	
	
	jmp Game_Menu_Ring
	
	rts
    
Perso2_IA:

	
	
	ldy s_perso+_y
	iny
	cpy s_perso+_y+$40
	beq ++
	bmi +
		ldy #1
		sty s_perso+_vy+$40
		lda #0
		sta s_perso+_animact+$40
		bra ++
	+:
	bpl ++
		ldy #-1
		sty s_perso+_vy+$40
		lda #2
		sta s_perso+_animact+$40
	++:
	
	lda s_perso+_x
	clc
	adc #$28
	cmp s_perso+_x+$40
	beq ++
	bmi +
		ldy #1
		sty s_perso+_vx+$40
		lda #1
		sta s_perso+_animact+$40
		lda s_perso+_flip+$40
		and #$3F
		sta s_perso+_flip+$40
		bra ++
	+:
	bpl ++
		ldy #-1
		sty s_perso+_vx+$40
		lda #1
		sta s_perso+_animact+$40
		lda s_perso+_flip+$40
		ora #$40
		sta s_perso+_flip+$40
	++:

	rts
    


Mode_Pnj:

	lda s_map+_mode
	cmp #0
	beq +
		rts
	+:
	
	stz LKS_OAM+_nperso2
	
	ldx #$280 ;port DMA dst
	stx MEM_TEMPFUNC+6
    
	ldx #$20*3
	stx MEM_TEMPFUNC+2
	ldx #$C0 ;n'id perso
	jsr Collision_perso
	jsr Personnage
	
	
	
	
	ldx #$400 ;port DMA dst
	stx MEM_TEMPFUNC+6
	ldx #$20*4
	stx MEM_TEMPFUNC+2
	ldx #$100 ;n'id perso
	jsr Collision_perso
	jsr Personnage
	
	ldx #$480 ;port DMA dst
	stx MEM_TEMPFUNC+6
	ldx #$20*5
	stx MEM_TEMPFUNC+2
	ldx #$140 ;n'id perso
	jsr Collision_perso
	jsr Personnage
	
	
	ldx #$600 ;port DMA dst
	stx MEM_TEMPFUNC+6
	ldx #$20*6
	stx MEM_TEMPFUNC+2
	ldx #$180 ;n'id perso
	jsr Collision_perso
	jsr Personnage
	
	
	ldx #$680 ;port DMA dst
	stx MEM_TEMPFUNC+6
	ldx #$20*7
	stx MEM_TEMPFUNC+2
	ldx #$1C0 ;n'id perso
	jsr Collision_perso
	jsr Personnage
	
	;------------
	ldx #$800 ;port DMA dst
	stx MEM_TEMPFUNC+6
	ldx #$20*8
	stx MEM_TEMPFUNC+2
	ldx #$200 ;n'id perso
	jsr Collision_perso
	jsr Personnage
	
	
	ldx #$880 ;port DMA dst
	stx MEM_TEMPFUNC+6
	ldx #$20*9
	stx MEM_TEMPFUNC+2
	ldx #$240 ;n'id perso
	jsr Collision_perso
	jsr Personnage
	
	
	ldx #$A00 ;port DMA dst
	stx MEM_TEMPFUNC+6
	ldx #$20*10
	stx MEM_TEMPFUNC+2
	ldx #$280 ;n'id perso
	jsr Collision_perso
	jsr Personnage
	
	
	ldx #$A80 ;port DMA dst
	stx MEM_TEMPFUNC+6
	ldx #$20*11
	stx MEM_TEMPFUNC+2
	ldx #$2C0 ;n'id perso
	jsr Collision_perso
	jsr Personnage
   
	rts

Mode_battle:

	lda s_map+_mode
	cmp #1
	beq +
		rts
	+:
	
	stz LKS_OAM+_nperso2
	
	
	ldx #0
	stx s_ia
    
    
    
	ldx #$20*3
	stx MEM_TEMPFUNC+2
	ldx s_ennemi+_enP1 ;n'id perso
	
	
	
	jsr IA_Ennemy
	jsr Collision_perso
	phx
	ldx #$600 ;port DMA dst
	stx MEM_TEMPFUNC+6
	plx
	jsr Personnage
	jsr Degat_test
	
	
	
	ldx #$20*4
	stx MEM_TEMPFUNC+2
	ldx s_ennemi+_enP2 ;n'id perso
	jsr IA_Ennemy
	jsr Collision_perso
	phx
	ldx #$880 ;port DMA dst
	stx MEM_TEMPFUNC+6
	plx
	jsr Personnage
	jsr Degat_test
	
	
	ldx #$20*5
	stx MEM_TEMPFUNC+2
	ldx s_ennemi+_enP3 ;n'id perso
	jsr IA_Ennemy
	jsr Collision_perso
	phx
	ldx #$C00 ;port DMA dst
	stx MEM_TEMPFUNC+6
	plx
	jsr Personnage
	jsr Degat_test
	
	
	jsl Ennemi_Tri

	rts
   
music_load3:

	
	;track
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_TRACK
	LKS_SPC_Set3_2 LKS_SPC_DATA2,Music3_pattern,Music3_patternEOF-Music3_pattern
	
	;header
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_HEADER
	LKS_SPC_Set3_2 LKS_SPC_DATA2,Music3_header,$100
	
	;sample
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SAMPLE
	LKS_SPC_Set3_2 LKS_SPC_DATA2,BRR_Sample,BRR_SampleEOF-BRR_Sample
	
	;sample dir
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SPLDIR
	LKS_SPC_Set3_2 LKS_SPC_DATA2,SPLDIR2,$400
	
	
	
	rts
	
	
music_load4:

	
	;track
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_TRACK
	LKS_SPC_Set3_2 LKS_SPC_DATA2,Music4_pattern,Music4_patternEOF-Music4_pattern
	
	;header
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_HEADER
	LKS_SPC_Set3_2 LKS_SPC_DATA2,Music4_header,$100
	
	;sample
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SAMPLE
	LKS_SPC_Set3_2 LKS_SPC_DATA2,BRR_Sample,BRR_SampleEOF-BRR_Sample
	
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SAMPLE+BRR_SampleEOF-BRR_Sample
	LKS_SPC_Set3_2 LKS_SPC_DATA2,BRR_Sample2,BRR_Sample2EOF-BRR_Sample2
	
	;sample dir
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SPLDIR
	LKS_SPC_Set3_2 LKS_SPC_DATA2,SPLDIR4,$400
	
	
	
	rts
	
	.include "math.asm"
	
	.include "degat.asm"
	
	.include "IA_ennemy.asm"
	
		
	.include "debug_text.asm"

	.include "oam.asm"

	.include "scrolling.asm"

	.include "gameplay.asm"
	.include "gameplay_ring.asm"
		
	.include "Fenetre.asm"

	.include "personnage.asm"
	
	.include "load.asm"
	.include "map.asm"
	
	.include "zorder.asm"
	
	
	.include "palette.asm"
	
	.include "collision_perso.asm"
	.include "collision_map.asm"
	.include "collision_perso_ia.asm"
	
	.include "weapon.asm"
	
	;.include "degat.asm"
	
	.include "effect.asm"
	
	.include "VBlank.asm"
	
	
	.include "background.asm"
	
	
.bank 1 slot 0
.org 0

	.include "ennemi_tri.asm"
	.include "ennemi_tri_frame.asm"
	.include "level_map.asm"
	.include "menu_icon.asm"
	.include "menu.asm"
	.include "libks.asm"


	.include "music3_data.asm"
	.include "music4_data.asm"
.bank 2 slot 0
.org 0
	
	
	
BRR_Strings:
	.incbin "music/brr/Strings.brr"
BRR_StringsEOF:

BRR_Voice:
	.incbin "music/brr/Voice.brr"
BRR_VoiceEOF:

BRR_OpenHiHat:
	.incbin "music/brr/OpenHiHat.brr"
BRR_OpenHiHatEOF:

BRR_Oboe:
	.incbin "music/brr/Oboe.brr"
BRR_OboeEOF:

BRR_HeavySnare:
	.incbin "music/brr/HeavySnare.brr"
BRR_HeavySnareEOF:

BRR_Flute:
	.incbin "music/brr/Flute.brr"
BRR_FluteEOF:

BRR_ClosedHiHat:
	.incbin "music/brr/ClosedHiHat.brr"
BRR_ClosedHiHatEOF:

BRR_BassGuitar:
	.incbin "music/brr/BassGuitar.brr"
BRR_BassGuitarEOF:

BRR_BassDrum:
	.incbin "music/brr/BassDrum.brr"
BRR_BassDrumEOF:

BRR_Xylophone:
	.incbin "music/brr/Xylophone.brr"
BRR_XylophoneEOF:
	

	
.bank 3 slot 0
.org 0


	.include "music2_data.asm"
	
	
	
	.include "DATA/texte.asm"

mapc3:
	.include "DATA/collision3.asm"
.bank 4 slot 0
.org 0

Jean:
	.include "DATA/Jean.asm"
	
old_man:
	.include "DATA/old_man.asm"
	
	
Soldat:
	.include "DATA/soldat.asm"
	
Papi:
	.include "DATA/Papi.asm"
	
Eagle1:
	.include "DATA/eagle1.asm"
	
	

	
.bank 5 slot 0
.org 0

Man:
	.include "DATA/man.asm"
	
Texte:
	.include "DATA/fontm.asm"
	
Texte2:
	.include "DATA/font8x16.asm"
	
Font3:
	.include "DATA/fontdgt.asm"

	
invocation:
	.include "DATA/invocation.asm"
	
wmenu1:
	.include "DATA/wmenu1.asm"
	
	
	.include "DATA/gris.asm"
	
select_menu:
	.include "DATA/selectmenu.asm"
	
mapc:
	.include "DATA/collision1.asm"

	

roption:
	.include "DATA/roption.asm"

ritem1:
	.include "DATA/ritem1.asm"
	
ritem2:
	.include "DATA/ritem2.asm"
	
ritem3:
	.include "DATA/ritem3.asm"
	
ritem4:
	.include "DATA/ritem4.asm"
	
explosion:
	.include "DATA/explosion.asm"
	
Select:
	.include "DATA/select.asm"
	
	
Pal_fire:
	.include "DATA/effect.asm"
	
Pal_thunder:
	.include "DATA/effect1.asm"
	
foudre:
	.include "DATA/Foudre.asm"
	
foudre2:
	.include "DATA/Foudre2.asm"
	
	
	
.bank 6 slot 0
.org 0
	
tile2:
	.include "DATA/tile2.asm"
	
tile4:
	.include "DATA/tile4.asm"
	
tile5:
	.include "DATA/tile5.asm"
	
tile7:
	.include "DATA/tile7.asm"
	
tile8:
	.include "DATA/tile8.asm"
	
tile9:
	.include "DATA/tile9.asm"
	

	
.bank 7 slot 0
.org 0

	.include "mode7.asm"

SPCROM:
	.incbin "driver.spc"
	
tile13:
	.include "DATA/tile13.asm"
	
tile14:
	.include "DATA/tile14.asm"
	
tile15:
	.include "DATA/tile15.asm"
	
	
.bank 8 slot 0
.org 0
	
	
map1:
	.include "DATA/map2.asm"
	
map2:
	.include "DATA/map3.asm"
	
map4:
	.include "DATA/map4.asm"
	
map5:
	.include "DATA/map5.asm"

.bank 9 slot 0
.org 0
	.include "music1_data.asm"
Map:
	.incbin "DATA/map7"
Tiles:
	.include "DATA/mode7.asm"
	
	
	
.bank 10 slot 0
.org 0



SinCosE:
	.include "rotation/sincose.asm"


BRR_Sample2:
	.incbin "music/s3m/2_String Ensemble.brr"
	;.incbin "music/s3m/3_Chorus .brr"
BRR_Sample2EOF:

.bank 11 slot 0
.org 0
BRR_Sample:
/*
	.incbin "music/brrth/sample_0.brr"
	.incbin "music/brrth/sample_1.brr"
	.incbin "music/brrth/sample_2.brr"
	.incbin "music/brrth/sample_3.brr"
	.incbin "music/brrth/sample_4.brr"
	.incbin "music/brrth/sample_5.brr"
	.incbin "music/brrth/sample_6.brr"
	.incbin "music/brrth/sample_7.brr"
	.incbin "music/brrth/sample_8.brr"
	.incbin "music/brrth/sample_9.brr"
	.incbin "music/brrth/sample_10.brr"
	.incbin "music/brrth/sample_11.brr"
	.incbin "music/brrth/sample_12.brr"
	.incbin "music/brrth/sample_13.brr"
	.incbin "music/brrth/sample_14.brr"
	.incbin "music/brrth/sample_15.brr"
	.incbin "music/brrth/sample_24.brr"
	.incbin "music/brrth/sample_25.brr"
	.incbin "music/brrth/sample_26.brr"
	.incbin "music/brrth/sample_27.brr"
	.incbin "music/brrth/sample_28.brr"
	.incbin "music/brrth/sample_29.brr"	
	*/
	.incbin "music/s3m/0_High Harp.brr"
	.incbin "music/s3m/1_Flute.brr"
	
BRR_SampleEOF:
Randi:
	.include "DATA/randi.asm"
	
.bank 12 slot 0
.org 0


Dragon:
	.include "DATA/dragon.asm"


.bank 13 slot 0
.org 0
mapc2:
	.include "DATA/collision2.asm"
Lapin:
	.include "DATA/Lapin.asm"
	
zoom7:
	.incbin "DATA/m7.bin"
	.include "DATA/zm7.asm"
sincos2:
	.include "rotation/dsincos.asm"
	
SinCosmenu:
	.include "rotation/sincos_menu.asm"
	
SinCos:
	.include "rotation/sincos.asm"	
	
Epee:
	.include "DATA/epee.asm"
.bank 14 slot 0
.org 0

map6:
	.include "DATA/map6.asm"
.bank 15 slot 0
.org 0
map7:
	.include "DATA/map7.asm"
