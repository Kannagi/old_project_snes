
Ennemy:

	;Ennemy1
	LKS_SPRITE_CONFIG 32,32,128,116
	ldy #$20*1
	sty LKS_SPRITE_CTRL.id+0
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy2
	LKS_SPRITE_CONFIG 32,32,128,117
	ldy #$20*2
	sty LKS_SPRITE_CTRL.id+2
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy3
	LKS_SPRITE_CONFIG 32,32,128,118
	ldy #$20*3
	sty LKS_SPRITE_CTRL.id+4
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy4
	LKS_SPRITE_CONFIG 32,32,128,119
	ldy #$20*4
	sty LKS_SPRITE_CTRL.id+6
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy5
	LKS_SPRITE_CONFIG 32,32,128,120
	ldy #$20*5
	sty LKS_SPRITE_CTRL.id+8
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
		
	;Ennemy6
	LKS_SPRITE_CONFIG 32,32,128,121
	ldy #$20*6
	sty LKS_SPRITE_CTRL.id+10
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy7
	LKS_SPRITE_CONFIG 32,32,128,122
	ldy #$20*7
	sty LKS_SPRITE_CTRL.id+12
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy8
	LKS_SPRITE_CONFIG 32,32,128,123
	ldy #$20*8
	sty LKS_SPRITE_CTRL.id+14
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy9
	LKS_SPRITE_CONFIG 32,32,128,124
	ldy #$20*9
	sty LKS_SPRITE_CTRL.id+16
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
		
	;Ennemy10
	LKS_SPRITE_CONFIG 32,32,128,125
	ldy #$20*10
	sty LKS_SPRITE_CTRL.id+18
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy11
	LKS_SPRITE_CONFIG 32,32,128,126
	ldy #$20*11
	sty LKS_SPRITE_CTRL.id+20
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move
	
	;Ennemy12
	LKS_SPRITE_CONFIG 32,32,128,127
	ldy #$20*12
	sty LKS_SPRITE_CTRL.id+22
	jsr Screen_ennemy
	jsl LKS_Sprite_Draw_FastX
	jsl LKS_Sprite_Move

	
	lda SDAN.icollision
	ina
	sta SDAN.icollision
	cmp #3
	bne +
		stz SDAN.icollision
	+:
	
	lda SDAN.ianim
	ina
	sta SDAN.ianim
	cmp #6
	bne +
		stz SDAN.ianim
	+:
	
	lda LKS_BULLET.i+1
	ina
	sta LKS_BULLET.i+1
	cmp #12*4
	bne +
		lda #0
		sta LKS_BULLET.i+1
	+:
	rts
	
	

Screen_ennemy:
	
	rep #$20
	
	lda #0
	sta MEM_TEMP
	
	lda LKS_SPRITE.PX,y
	and #$03F0
	cmp #$03F0
	bne +
		inc MEM_TEMP
	+:
	
	lda LKS_SPRITE.PX,y
	and #$03E0
	bne +
		lda #$0
		sta LKS_SPRITE.VX,y
		
		lda #$9<<2
		sta LKS_SPRITE.PX,y
	+:
	
	
	lda LKS_SPRITE.PY,y
	and #$03F8
	cmp #$E0<<2
	bne +
		inc MEM_TEMP
	+:
	
	
	lda MEM_TEMP
	beq +
		lda #$E0<<2
		sta LKS_SPRITE.PY,y
		
		lda #$9<<2
		sta LKS_SPRITE.PX,y
		
		lda #$E0
		sta LKS_SPRITE.Y,y
		sta LKS_SPRITE.X,y
		
		lda #$0
		sta LKS_SPRITE.VY,y
		sta LKS_SPRITE.VX,y
		
		sep #$20
		
		jsr Ennemy_Wait
		rts
		rep #$20
	+:
	
	
	
	;lda #$01
	;sta LKS_SPRITE.VY,y
	
	tya
	sec
	sbc #$20
	lsr
	sta SDAN.id
	
	sep #$20
	
	jsr Test_collision_bullet_Ennemi
	
	ldx SDAN.id
	
	
	lda ShipE.flag,x
	sta MEM_TEMP+12
	
	
	
	
	
	lda ShipE.hit,x
	and #$07
	;cmp #0
	beq +
	
	pha
	lda #6<<1
	sta MEM_TEMP+12
	
/*
	lda LKS.clockf
	and #1
	beq ++
		lda LKS_SPRITE.X,y
		clc
		adc #2
		sta  LKS_SPRITE.X,y
		bra +++
	++:
		lda LKS_SPRITE.X,y
		sec
		sbc #2
		sta  LKS_SPRITE.X,y
	+++:
*/
	pla
	
	inc a
	sta ShipE.hit,x
	cmp #4
	bne +
		stz ShipE.hit,x
	+:
	
	lda ShipE.hp,x
	;cmp #0
	beq +
		lda #$20
		ora MEM_TEMP+12
		sta LKS_SPRITE.Flip,y
	+:
	
	
	
	rep #$20
	lda #127<<2
	sec
	sbc LKS_SPRITE_CTRL.oam
	sta MEM_TEMP+10
	lsr
	
	lsr
	lsr
	
	sep #$20
	
	cmp SDAN.ianim 
	bne +
		ldx SDAN.id
		lda ShipE.hp,x
		;cmp #0
		beq ++
			
			jsr ennemy_type3
			bra +
		++:
		stz ShipE.hit,x
		jsr ennemy_dead0
		rts
	+:
	
	
	ldx SDAN.id
	lda ShipE.hp,x
	;cmp #0
	beq +
	
	lda MEM_TEMP+10
	cmp LKS_BULLET.i+1
	bne +
		jsr Fire_EnnemyT
	+:
	
	;jsr Fire_EnnemyT
	
	rts

ennemy_type3:
	
	lda ShipE.address+2,x
	sta MEM_TEMP+6
	
	
	rep #$20
	lda #$100
	lda #$0
	sta MEM_TEMPFUNC
	
	
	lda  ShipE.address,x
	tyx
	sta LKS_SPRITE.Address,x

	lda #4*32
	sta LKS_DMA.SrcR,x
	
	sep #$20
	
	lda MEM_TEMP+6
	;lda #$7E
	sta LKS_DMA.Bank,x
	
	lda #1
	jsl LKS_Sprite_DMA_Fast
	
	rts
	
ennemy_dead0:
	
	rep #$20
	lda #0
	sta LKS_SPRITE.VX,y
	sta LKS_SPRITE.VY,y
	sep #$20
	
	lda #$20+(6<<1)
	sta LKS_SPRITE.Flip,y
	
	tyx
	lda LKS_SPRITE.Anim_i,y
	
	rep #$20
	and #$FF
	asl
	tax
	lda.l EXPLOSION_TILE2,x
	sta MEM_TEMPFUNC
	
	tyx
	lda #EXPLOSION
	sta LKS_SPRITE.Address,x
	
	lda #4*128
	sta LKS_DMA.SrcR,x
	
	sep #$20
	
	lda #:EXPLOSION
	sta LKS_DMA.Bank,x
	
	
	
	lda #1
	jsl LKS_Sprite_DMA_Fast
	
	lda LKS_SPRITE.Anim_i,y
	cmp #0
	bne +
		lda #2
		sta SFX.enable2
	+:
	
	lda LKS_SPRITE.Anim_i,y
	ina
	sta LKS_SPRITE.Anim_i,y
	cmp #7
	bne +
		lda #0
		sta LKS_SPRITE.Anim_i,y
		
		rep #$20
		lda #$E0<<2
		sta LKS_SPRITE.PY,y
		sep #$20
	+:

	rts
	
EXPLOSION_TILE1:
.dw $0000,$0080,$0100,$0180,$0800,$0880,$0880
EXPLOSION_TILE2:
.dw $1000,$1080,$1100,$1180,$0900,$0980,$0980

EXPLOSION_TILE3:
.dw $0400,$0420,$0440,$0460,$0800,$0200

ennemy_init2:
	ldx #$20*1
	LKS_SPRITE_INIT 38,-20,$40,$02,$AA 
	LKS_DMA_INIT SHIPE,$80,128,$6400,1 ;Data,Size,largeur,VRAM,Func DMA

	ldx #$20*2
	LKS_SPRITE_INIT 48,32,$44,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6440,1
	
	ldx #$20*3
	LKS_SPRITE_INIT 80,32,$48,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6480,1
	
	ldx #$20*4
	LKS_SPRITE_INIT 100,32,$4C,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$64C0,1
	
	ldx #$20*5
	LKS_SPRITE_INIT 16,64,$80,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6800,1
	
	ldx #$20*6
	LKS_SPRITE_INIT 48,64,$84,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6840,1
	
	ldx #$20*7
	LKS_SPRITE_INIT 80,64,$88,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6880,1
	
	ldx #$20*8
	LKS_SPRITE_INIT 100,64,$8C,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$68C0,1
	
	ldx #$20*9
	LKS_SPRITE_INIT 180,32,$C0,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6C00,1
	
	ldx #$20*10
	LKS_SPRITE_INIT 220,32,$C4,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6C40,1
	
	ldx #$20*11
	LKS_SPRITE_INIT 140,100,$C8,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6C80,1
	
	ldx #$20*12
	LKS_SPRITE_INIT 220,64,$CC,$02,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6CC0,1
	
	lda #8
	sta ShipE.hp + ($10*0)
	sta ShipE.hp + ($10*1)
	sta ShipE.hp + ($10*2)
	sta ShipE.hp + ($10*3)
	
	sta ShipE.hp + ($10*4)
	sta ShipE.hp + ($10*5)
	sta ShipE.hp + ($10*6)
	sta ShipE.hp + ($10*7)
	
	sta ShipE.hp + ($10*8)
	sta ShipE.hp + ($10*9)
	sta ShipE.hp + ($10*10)
	sta ShipE.hp + ($10*11)
	rtl
	
ennemy_init:

	

	ldx #$20*1
	LKS_SPRITE_INIT 16,-32,$40,$00,$AA 
	LKS_DMA_INIT SHIPE,$80,128,$6400,1 ;Data,Size,largeur,VRAM,Func DMA

	ldx #$20*2
	LKS_SPRITE_INIT 48,-32,$44,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6440,1
	
	ldx #$20*3
	LKS_SPRITE_INIT 80,-32,$48,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6480,1
	
	ldx #$20*4
	LKS_SPRITE_INIT 100,-32,$4C,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$64C0,1
	
	ldx #$20*5
	LKS_SPRITE_INIT 16,-32,$80,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6800,1
	
	ldx #$20*6
	LKS_SPRITE_INIT 48,-32,$84,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6840,1
	
	ldx #$20*7
	LKS_SPRITE_INIT 80,-32,$88,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6880,1
	
	ldx #$20*8
	LKS_SPRITE_INIT 100,-32,$8C,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$68C0,1
	
	ldx #$20*9
	LKS_SPRITE_INIT 180,-32,$C0,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6C00,1
	
	ldx #$20*10
	LKS_SPRITE_INIT 220,-32,$C4,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6C40,1
	
	ldx #$20*11
	LKS_SPRITE_INIT 140,-32,$C8,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6C80,1
	
	ldx #$20*12
	LKS_SPRITE_INIT 220,-32,$CC,$00,$AA
	LKS_DMA_INIT SHIPE,$80,128,$6CC0,1


	;jsl ennemy_init2
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
	
	rtl
