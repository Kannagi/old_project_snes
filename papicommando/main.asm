
.include "header.asm"
.include "snes.asm"
.include "SPC/spc.asm"
.include "MC_libks.asm"

.include "variable.asm"


Main:
	SNES_INIT
	
	SPC_Procedure SPCRAM,SPCROM
	jsl LKS_Clear_RAM
		
	;jsl SNES3D
	
	lda #1
	sta LKS.VBlankType
	;jsr SPC_test
	
GameAll:
	jsr Game
	;menu etc etc

	jmp GameAll
	
sfx_load:

	;sample
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SFX1
	LKS_SPC_SetD BRR_SFX,BRR_SFXEOF-BRR_SFX
	
	;dir
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SFXDIR
	LKS_SPC_SetD BRR_SFXDIR,$80
	

	rts
	
	.include "init.asm"
	.include "game.asm"
	.include "bullet.asm"
	.include "text.asm"
	.include "libksIRQ.asm"
	
	.include "load_map.asm"
	.include "gameplay.asm"
	.include "player.asm"
	.include "ennemy.asm"
	.include "collision.asm"
	.include "IA.asm"
	.include "IA_move.asm"
	
	.include "spc.asm"
	.include "3D.asm"


.bank 1 slot 0
.org 0
	.include "libks.asm"

	
	.include "data.asm"

	

