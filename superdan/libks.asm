
;Library Kannagi for SNES v0.62
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
	.include "LKS/Scrolling2.asm"
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
	
bpp_font:
	.incbin "DATA/fontm.spr"
bpp_fontpal:
	.incbin "DATA/fontm2.pal"
	.incbin "DATA/fontm3.pal"
	;.db $E7, $1C, $42, $08, $94, $52, $7b, $6f
	;.db $E7, $1C, $80, $10, $08, $52, $60, $6f
