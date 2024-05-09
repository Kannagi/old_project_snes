
.include "header.asm"
.include "snes.asm"
.include "MC_libks.asm"

.include "variable.asm"
.include "SPC/spc.asm"
;Score attack
;Score attack 112


.bank 0 slot 0
.org 0


Main:
	
	SNES_INIT
	
	lda #$1
	sta MEMSEL
		
	;SPC_Procedure SPCRAM,SPCROM
	
	jsl LKS_Clear_RAM
	
	lda #1
	sta LKS.VBlankType
	
	;jsr sfx_load
	;jsr music_load0

	;LKS_SPC_Set LKS_SPC_VOLUME,$7F,$7F
	;LKS_SPC_Set LKS_SPC_BRR_VOLUME,$60,$50
	
	;jsr LKSD
	
	
	
GameAll:
	jsr Game
	;menu etc etc

	jmp GameAll
	
	
;------------------------

LKSD:
	jsl LKS_INIT
	LKS_Clear_VRAM
	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;load font
	LKS_LOAD_VRAM $4200,$00,bpp_font,$400
	LKS_LOAD_CG $00,bpp_fontpal,$10
	
	
	lda #1
	sta APUIO3
	
	lda #$20-4
	sta APUIO2
	LKS_SPC_Set2 LKS_SPC_PLAY,LKS_SPC_ON
	;LKS_SPC_Set1 LKS_SPC_BRR_PLAY
	
	;LKS_SPC_Set LKS_SPC_BRR_PLAY_TEST,$40,$0
	
	lda #0
	sta LKS.VBlankWait
	
	LKS_printf_setpal 0
	jsl LKS_GAMELOOP_INIT
	-:
		jsl LKS_Fade_in
		
		LKS_SPC_Get LKS_SPC_DEBUG
		lda APUIO2
		LKS_printf8h 1,2
		lda APUIO3
		LKS_printf8h 1,3
		
		lda #1
		sta APUIO3
		
		lda #$20-4
		sta APUIO2
		;LKS_SPC_Set1 LKS_SPC_BRR_PLAY
		jsl WaitVBlank
	jmp -



	rts
	
;------------------------

LKS_SPC_Wait:

	lda LKS_SPC_VAR
	sta APUIO0
	-:
		cmp APUIO0
	beq -
	stz APUIO1
	lda APUIO0
	sta LKS_SPC_VAR

	rts

LKS_SPC_SetD2:

	lda #$FF
	sta APUIO1
	
	tya
	sta LKS_SPC_VAR
	
	lda #0
	-:
		cmp APUIO1
	bne -
	stz APUIO1

	rts

LKS_SPC_SetD1:
	inx
	inx
	iny

	-:
		cmp APUIO0
	beq -
	stz APUIO1
		
	rts
	
	.include "libksIRQ.asm"

	
	
	.include "collision.asm"
	.include "init.asm"
	
	.include "game.asm"
	.include "text.asm"
	
	.include "gameplay.asm"
	.include "load_map.asm"
	.include "IA.asm"

	.include "ennemy.asm"
	.include "ennemy2.asm"
	.include "powerup.asm"
	
	.include "digit/sfx_dir.asm"
	.include "digit/sfx_load.asm"
	
	.include "music/music_load0.asm"

SPCROM:
	.incbin "driver.spc"

.bank 1 slot 0
.org 0

	.include "libks.asm"

	.include "data.asm"

BRR_Sample:
.include "digit/sfx_data.asm"

.include "music/music_track0.asm"


