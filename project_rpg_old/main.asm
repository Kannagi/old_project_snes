.include "header.asm"
.include "snes.asm"

.include "mtext.asm"
.include "init.asm"
.include "mdraw.asm"
.include "mjoypad.asm"
.include "mzorder.asm"
.include "mdma.asm"
.include "random.asm"
.include "variable.asm"

.define LIMIT_CAMERAX    54
.define LIMIT_CAMERAW    -72
.define LIMIT_CAMERAY    48
.define LIMIT_CAMERAH    -104

.define SPC_FILE "music/theme.spc"
;.define SPC_FILE "music/01plain.spc"

.bank 0 slot 0
.org 0

Main:
	clc
    xce
    
	;lda 	#0
	;jsr 	LoadSPC
	
	rep #$10	;16 bit xy
	
	ldx #0
	stx s_map + $0E
	init_rand


	Begin:
	jsr Map_choix

    SNES_INIT
	    
    ;INITIAL SETTINGS
	
	;object
	SNES_OBJSEL $63 ; 16x16 , $6000 address
	
	;background
	SNES_BGMODE $39 ; BG 1 & 2 16x16, BG 3 8x8,mode 1 , BG 3 pri
	
	SNES_BG1SC $50 ; address data BG1 $5000
	SNES_BG2SC $54 ; address data BG2 $5400
	SNES_BG3SC $58 ; address data BG3 $5800
	
	SNES_BGNBA $20 $04; address BG1,2,3,4 (2,1 / 4,3)
	
	;general init
	SNES_SETINI $00
	SNES_MEMSEL $00
    SNES_TM $17 ; obj & bg 1,2,3 enable
    SNES_COLDATA $E0
	
    SNES_VMAINC $80
    SNES_INIDISP $8F ; FORCED BLANK , brigtness 15
    ;FORCED BLANK
        
    ;Load Object
    SNES_DMAX $01
	SNES_DMAX_BADD $18
    

    
    ldx #s_map + $20
    jsr (0,X)
    

  
    ;initialisation
    init_bg $0000
    init_britgness
    init_oam
    init_zoam
    init_scrolling
    init_control
    init_dma
    init_text
    init_msb
    init_perso
    init_menu
    stz MEM_PAL + 0
	stz MEM_PAL + 1
	stz MEM_PAL + 2
	stz MEM_PAL + 3
	stz MEM_PAL + 4
	
	ldx #Eagle1
	stx MEM_DMA + 2
	
	ldx #s_map + $22
	jsr (0,X)
	
	
	
	;Vblank call
	ldx #0
	stx MEM_VBLANK
	
	SNES_NMITIMEN $81 ; Enable NMI , enable joypad

	
	SNES_INIDISP $0F ;  brigtness 0
	
	
	lda #-32
	ldx #0
	-:
		sta t_oam,X
		inx
	cpx #128
	bne -
	
	stz $1400
	stz $1401
	stz $1402
	stz $1403
	
	
	lda #$1F
		sta MEM_BRIGTNESS
		stz MEM_BRIGTNESS + 1
	;Begin game
	Game:	
	
		
		
		stz MEM_OAM + $08
		stz MEM_OAM + $09
		stz MEM_OAM + $0A
		
		stz $1325
		stz $1328
		stz $1330
		stz $1338
		
		jsr precalcul_scrolling_ch
		stz s_map + $0D
		
		;SNES_INIDISP $8F
		
		
		; Joypad
		jsr Joypad
		
	
		; Draw hero 1
		jsr Draw_hero
		inc MEM_OAM + $08 ; pour le hero n'2
				
		;Map pnj
		ldx #s_map + $24
		jsr (0,X)
		
		;Menu
		;jsr Draw_menu
		
		;SNES_INIDISP $0F
		
		;jsr Luminosite_clair
		
		
		
		;collision
		ldx #$00 ; hero 1
		stx MEM_TEMPFUNC
		

		jsr Deplacement_hero
		
		
		
		;Scrolling
		jsr Scrolling
		
		;Tri
		jsr Tri_zorder



		wai
		
		

		
		
		
		
    jmp Game

Random:
	mRand8
	rts
	
Map_transition:
	
	

	rts

Text:
		;text
		
		textec 2,2,$2038 ; X
		textec 2,3,$2039 ; Y

		;texte1 0,0 ; test 123

		lda s_perso
		printf 4,2

		lda s_perso + 1
		printf 4,3
		
		lda MEM_HSCROLLING
		printf 2,4
		
		lda MEM_VSCROLLING
		printf 6,4
		
		;test string
		ldx	#text_s1
		printfs 2,5,text_s1
		
		lda $1325
		printf 2,6
		
		lda $1328
		printf 8,6
		
		lda $1330
		printf 14,6
		
		lda $1338
		printf 20,6
		
		;mRand8
		;lda rand8
		;printf 0,9
		
		lda #8
		sta WRMPYA
		lda #7
		sta WRMPYB
	
	
		; Affichage d'un nombre sur 16 bits
		;ldy #18000
		ldy RDMPYL
		print_16_bit_integer 10,2	; ça marche même avec -32768 mais je ne sais pas pourquoi alors que la limite est normalement dépassée ! bref.
	
	rts
	
text_s1:
	.db "hello world",0

	.include "hero.asm"
	
	.include "choix_map.asm"

	
	.include "map_pnj.asm"
	
	.include "oam.asm"
	
	.include "precalcul.asm"
	
	.include "tri.asm"
		
	.include "collision_perso.asm"
	.include "collision_pnj.asm"

	.include "scrolling.asm"

	.include "joypad.asm"
		
	.include "VBlank.asm"
	
	.include "menu.asm"
	
	.include "text.asm"

	.include "dma.asm"
	
	.include "pnj.asm"
	
	.include "map.asm"
	
	.include "loadspc.asm"
	
Sincos:
	.include "rotation/sincos_menu.asm"
	
Randomp:
	.include "DATA/random.asm"
	
.org $7FB0
	header
.bank 1 slot 0
.org 0

 .incbin SPC_FILE skip $00025 read $0008
 ; DSP register values
 
map1:
	.include "DATA/maps.asm"

mapc2:
	.include "DATA/collision2.asm"
	
 ;.include "DATA/collision.asm"	
 .org $4000
 .incbin SPC_FILE skip $10100 read $0080
 


map2:
	.include "DATA/maps2.asm"
	
mapc:
	.include "DATA/collision.asm"
	
	

.bank 2 slot 0
.org 0

	;.include "DATA/texte.asm"
	.incbin SPC_FILE skip $0100 read $8000


.bank 3 slot 0
.org 0
	
	.incbin SPC_FILE skip $8100 read $8000


	
.bank 4 slot 0
.org 0

Jean:
	.include "DATA/Jean.asm"
	
old_man:
	.include "DATA/old_man.asm"
	
Man:
	.include "DATA/man.asm"
	
Soldat:
	.include "DATA/soldat.asm"
	
Papi:
	.include "DATA/Papi.asm"
	
.bank 5 slot 0
.org 0

tile2:
	.include "DATA/tile2.asm"
	
tile4:
	.include "DATA/tile4.asm"
	
tile5:
	.include "DATA/tile5.asm"
	
    
Texte:
	.include "DATA/text.asm"
	
Texte2:
	.include "DATA/font8x16.asm"
	

	
Menu:
	.include "DATA/menu.asm"
	
	
invocation:
	.include "DATA/invocation.asm"
	
wmenu1:
	.include "DATA/wmenu1.asm"
	
OAM_vide:
	.REPT $200
	.db $E0
	.ENDR
	
Vide:
	.REPT $200
	.db $00
	.ENDR
	
	
Fenetre_data:
.dw $2440,$2441,$2441,$2441,$2441,$2441,$2441,$2441
.dw $2441,$2441,$2441,$2441,$2441,$2441,$2441,$2441
.dw $2441,$2441,$2441,$2441,$2441,$2441,$2441,$2441
.dw $2441,$2441,$2441,$2441,$2441,$6440

Fenetre_data2:
.dw $A440,$2441,$2441,$2441,$2441,$2441,$2441,$2441
.dw $2441,$2441,$2441,$2441,$2441,$2441,$2441,$2441
.dw $2441,$2441,$2441,$2441,$2441,$2441,$2441,$2441
.dw $2441,$2441,$2441,$2441,$2441,$E440

Fenetre_data3:
.dw $2443,$2443,$2443,$2443,$2443,$2443,$2443,$2443
.dw $2443,$2443,$2443,$2443,$2443,$2443,$2443,$2443
.dw $2443,$2443,$2443,$2443,$2443,$2443,$2443,$2443
.dw $2443,$2443,$2443,$2443,$2443,$2443,$2443,$2443

Eagle1:
	.include "DATA/eagle1.asm"
	
.bank 6 slot 0
.org 0
;pallete
	.include "DATA/effect.asm"
	
	.include "DATA/texte.asm"

	.include "background.asm"
	
	
tile7:
	.include "DATA/tile7.asm"
	
tile8:
	.include "DATA/tile8.asm"
	
tile9:
	.include "DATA/tile9.asm"
	

	
.bank 7 slot 0
.org 0

map3:
	.include "DATA/map3.asm"
	
map4:
	.include "DATA/map4.asm"
	
tile13:
	.include "DATA/tile13.asm"
	
tile14:
	.include "DATA/tile14.asm"
	
tile15:
	.include "DATA/tile15.asm"
	
	.include "DATA/eau.asm"
	
.bank 8 slot 0
.org 0
	.include "mode7.asm"

.bank 9 slot 0
.org 0

Map:
	.incbin "DATA/map7"
Tiles:
	.include "DATA/mode7.asm"
	
.bank 10 slot 0
.org 0

SinCos:
	.include "rotation/sincos.asm"
	
SinCosmenu:
	.include "rotation/sincos_menu.asm"

.bank 11 slot 0
.org 0

Randi:
	.include "DATA/randi.asm"
