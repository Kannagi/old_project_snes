
;Library Kannagi for SNES v0.6
	.include "LKS/Unpack.asm"
	.include "LKS/Joypad.asm"
	.include "LKS/Bullet.asm"
	.include "LKS/Printf.asm"
	.include "LKS/OAM.asm"
	.include "LKS/Clear.asm"
	.include "LKS/Fade.asm"
	
	.include "LKS/DMA_BG.asm"
	.include "LKS/PAL.asm"
	.include "LKS/Background.asm"
	.include "LKS/Scrolling.asm"
	.include "LKS/Scrolling_init.asm"
	.include "LKS/template_init.asm"
	
	.include "LKS/Collision_map.asm"
	.include "LKS/Collision_map_bullet.asm"
	.include "LKS/Zorder.asm"
	
	.include "LKS/DMA.asm"
	.include "LKS/Sprite.asm"
	.include "LKS/Sprite_Draw.asm"
	.include "LKS/VBlank.asm"
	.include "LKS/DMA_spd.asm"
	.include "LKS/Ennemy.asm"
	
LKS_font:
	.incbin "DATA/font.spr"
LKS_fontpal:
	.db $E7, $1C, $42, $08, $94, $52, $7b, $6f
	.db $E7, $1C, $80, $10, $08, $52, $60, $6f
