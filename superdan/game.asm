
	
Game:

	jsl LKS_INIT
	
	
	
	
	LKS_Clear_VRAM
	SNES_OBJSEL $23
	
	jsl Map_Tile1

	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;load bullet
	LKS_LOAD_VRAM $7C00,$00,Bullet,$800
	
	
	;load font
	LKS_LOAD_VRAM $4200,$00,bpp_font,$400
	LKS_LOAD_CG $00,bpp_fontpal,$10
	
	;load pal
	LKS_LOAD_CG $80,SHIP_PAL,$20
	LKS_LOAD_CG $90,SHIPE1A_PAL,$20
	LKS_LOAD_CG $A0,SHIPE2A_PAL,$20
	LKS_LOAD_CG $B0,SHIPE3A_PAL,$20
	LKS_LOAD_CG $C0,SHIPE4A_PAL,$20
	LKS_LOAD_CG $D0,SHIPE5A_PAL,$20
	LKS_LOAD_CG $E0,EXPLOSION_PAL,$20
	LKS_LOAD_CG $F0,Bullet_pal,$20
	
	;LKS_LOAD_CG $D0,BLANK,$20
	
	;LKS_LOAD_VRAM $6000,$00,SHIP,$800
	;LKS_LOAD_VRAM $6400,$00,SHIPE,$800
	
	;LKS_LOAD_VRAM $6C00,$00,EXPLOSION,$1C00
	
	;load boss
	LKS_LOAD_VRAM $4400,$00,BOSS1,$2000
	LKS_LOAD_CG $70,BOSS1_PAL,$20
	
	LKS_LOAD_VRAM $5400,$00,BOSS_TILE1,$20
	LKS_LOAD_VRAM $5420,$00,BOSS_TILE2,$20
	LKS_LOAD_VRAM $5440,$00,BOSS_TILE3,$20
	LKS_LOAD_VRAM $5460,$00,BOSS_TILE4,$20
	LKS_LOAD_VRAM $5480,$00,BOSS_TILE5,$20
	LKS_LOAD_VRAM $54A0,$00,BOSS_TILE6,$20
	LKS_LOAD_VRAM $54C0,$00,BOSS_TILE7,$20
	LKS_LOAD_VRAM $54E0,$00,BOSS_TILE8,$20
	
	
	jsl Load_tile
	

	jsr Init_Game
	jsl Bullet_Init
	

	lda #3
	sta Ship.weapon
	
	lda #0
	sta Ship.hit
	
	ldx #0
	LKS_SPRITE_INIT 128,128,$00,$00,$0A
	LKS_DMA_INIT SHIP,$80,128,$6000 ,1 ;Data,Size,largeur,VRAM,Func DMA
	LKS_SPRITE_ANIM_INIT 0,2,3
	
	jsl ennemy_init
	
	ldx #128
	stx LKS_BG.y1
	
	ldx #$20*100
	LKS_DMA_INIT Bullet,$20,128,$7C00+$100,-1
	
	;bullet impact
	ldx #$20*14
	LKS_SPRITE_INIT 0,-16,$D4,$0F,$0A
	
	ldx #$20*15
	LKS_SPRITE_INIT 0,-16,$D4,$0F,$0A
	ldy #0
	ldx #5
	lda #$E0
	-:
		sta Impact.y+1,y
		
		iny
		iny
		dex
		cpx #0
	bne -
	
	;power up
	ldx #$20*16
	LKS_SPRITE_INIT 128,160,$E4,$0F,$00
	lda #-1
	sta LKS_SPRITE.VX,x
	sta LKS_SPRITE.VY,x
	
	ldx #$20*17
	LKS_SPRITE_INIT 1,64,$E6,$0F,$00
	lda #-1
	sta LKS_SPRITE.VX,x
	sta LKS_SPRITE.VY,x
	
	ldx #$20*18
	LKS_SPRITE_INIT 1,128,$E4,$0F,$00
	lda #1
	sta LKS_SPRITE.VX,x
	sta LKS_SPRITE.VY,x
	
	lda #1
	sta Bonus.power+1
	
	
	LKS_printf_setpal 1
	ldx #text_score
	LKS_printfs 1,0
	
	ldx #text_high
	LKS_printfs 27,0
	
	LKS_printf_setpal 0
	

	ldx #ENNEMY_STAGE1E-ENNEMY_STAGE1-6
	stx SDAN.cursor
	;-------------
	jsl LKS_GAMELOOP_INIT
	GameLoop:
		
		jsl LKS_Fade_in
		
		jsl LKS_Joypad
		lda LKS_STDCTRL+_START
		cmp #1
		bne +
			jsr Pause
		+:

		
		;SNES_DMAX $00
		;SNES_DMAX_BADD $80
		
		
		
		lda LKS_STDCTRL+_Y
		cmp #1
		bne +
			jsl ennemy_init
		+:
		
		jsr Gameplay
		
		rep #$20
		lda LKS.clockf
		bit #$1
		bne +
			dec LKS_BG.y2
			dec LKS_BG.y
		+:
		
		lda LKS_BG.y
		cmp #$0
		bpl +
			lda #$100
			sta LKS_BG.y
			
			lda LKS_BG.y2
			clc
			adc #$100
			sta LKS_BG.y2
		+:
		
		stz LKS_BG.x2
		sep #$20
		
		;-----------
		LKS_SPRITE_CONFIG 16,16,128,104
		ldy #$20*16
		jsr Power_up
		
		LKS_SPRITE_CONFIG 16,16,128,108
		ldy #$20*17
		jsr Power_up
		
		LKS_SPRITE_CONFIG 16,16,128,112
		ldy #$20*18
		jsr Power_up
		
		jsr Power_up_collision
		;------------
		LKS_SPRITE_CONFIG 32,32,128,100
		ldy #0
		lda Ship.hit
		cmp #0
		beq +
			inc Ship.hit
		+:
		lda Ship.hit
		cmp #100
		bne +
			stz Ship.hit
		+:
		bit #$1
		bne +
			jsl LKS_Sprite_Draw_Fast
		+:
		jsr ship_upload
		jsl LKS_Sprite_Move
		jsr Test_collision_bullet_Player
		
		
		jsr Ennemy
		
		
		;jsr SFX2
		lda #2
		sta LKS_BG.EnableY
		jsl LKS_ScrollingV2
		
		jsl Bullet_Tile
		
		jsl LKS_Background_Update2

	
		;jsl Bullet_Slow
		jsl Bullet_Anim
		jsl Bullet_Impact
		
		
		
		jsl Draw_Bullet
		
		
		jsr Text_draw
		jsl LKS_DMA_SORT
		

		;jsr SFX1
		jsl WaitVBlank
		
		
		;SNES_INIDISP $08
		

		jmp GameLoop
	
	rtl

SFX1:
	lda SFX.i1
	ina
	and #$07
	sta SFX.i1
	cmp #1
	beq +
		rts
	+:
	
	
	lda SFX.enable1
	cmp #0
	bne +
		rts
	+:
	dea
	sta APUIO3
	stz SFX.enable1
	
	lda #$10-4
	clc
	adc SFX.pitch1
	sta APUIO2
	
	LKS_SPC_Set1 LKS_SPC_BRR_PLAY
	
	rts

SFX2:
	lda SFX.i2
	ina
	and #$F
	sta SFX.i2
	cmp #1
	beq +
		rts
	+:
	
	lda SFX.enable2
	cmp #0
	bne +
		rts
	+:
	dea
	sta APUIO3
	stz SFX.enable2
	
	lda #$20-4
	sta APUIO2
	
	LKS_SPC_Set1 LKS_SPC_BRR_PLAY
	
	rts
	
Pause:
	
	jsl LKS_Joypad
	lda LKS_STDCTRL+_START
	cmp #1
	beq +
	
	jsl WaitVBlank
	jml Pause
	+:

	rts

ENNEMY_STAGE1:
	.incbin "DATA/MAP1/map1_tag.ktm"
ENNEMY_STAGE1E:
	
SHIP_ANIM:
	.dw $0000,$0080,$0100,$0080
ship_upload:
	
	jsl LKS_Sprite_Anim
	
	
	lda MEM_RETURN
	cmp #$00
	bne +
		rts
	+:
	
	stz MEM_TEMP
	stz MEM_TEMP+1
	
	lda LKS_SPRITE.Flip
	and #$FF-$40
	sta LKS_SPRITE.Flip
	
	lda Ship.direction
	cmp #1
	bne +
		lda #8
		sta MEM_TEMP+1
		bra ++
	+:
	cmp #2
	bne ++
		lda #8
		sta MEM_TEMP+1
		
		lda LKS_SPRITE.Flip
		ora #$40
		sta LKS_SPRITE.Flip
	++:
	
	
	lda LKS_SPRITE.Anim_i,x
	
	phy
	rep #$20
	and #$FF
	asl
	tay
	
	lda SHIP_ANIM,y
	sta MEM_TEMPFUNC
	ply
	tyx
	lda #SHIP
	clc
	adc MEM_TEMP
	sta LKS_SPRITE.Address,x
	
	sep #$20
	
	lda #:SHIP
	sta LKS_DMA.Bank,x
	
	lda #1
	jsl LKS_Sprite_DMA_Fast
	
	rts
	
SinCos:
	.include "DATA/sincos.asm"

BLANK:
	.dw $FFFF,$7BDE,$7BDE,$7BDE,$7BDE
	
/*
.MACRO DATA_TILE
.dw $1F00+\1,$1F02+\1,$1F04+\1,$1F06+\1,$1F08+\1,$1F0A+\1,$1F0C+\1,$1F0E+\1
.dw $5F0E+\1,$5F0C+\1,$5F0A+\1,$5F08+\1,$5F06+\1,$5F04+\1,$5F02+\1,$5F00+\1
.ENDM
*/

.MACRO DATA_TILE
.dw $1C40+\1,$1C42+\1,$1C44+\1,$1C46+\1,$1C48+\1,$1C4A+\1,$1C4C+\1,$1C4E+\1
.dw $5C4E+\1,$5C4C+\1,$5C4A+\1,$5C48+\1,$5C46+\1,$5C44+\1,$5C42+\1,$5C40+\1
.ENDM

BOSS_TILE1:
	DATA_TILE $00
BOSS_TILE2:
	DATA_TILE $20
BOSS_TILE3:
	DATA_TILE $40
BOSS_TILE4:
	DATA_TILE $60
BOSS_TILE5:
	DATA_TILE $80
BOSS_TILE6:
	DATA_TILE $A0
BOSS_TILE7:
	DATA_TILE $C0
BOSS_TILE8:
	DATA_TILE $E0
	



