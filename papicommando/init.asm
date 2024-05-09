
Init_Game:

	lda #0
	sta LKS.VBlankWait
	
	ldx #0
	rep #$20
	txa
	sta LKS_OAM.Address+0
	sep #$20
	LKS_SPRITE_INIT 40,40,0,$00,$AA ; X,Y,Tile,Flip+PAL,Ext
	LKS_SPRITE_ANIM_INIT 0,9,4 ; act,cadence,n
	LKS_DMA_INIT Papi,$80,128,$6000,1 ;Data,Size,largeur,VRAM,Func DMA
	lda #10
	sta SCharacter.hp
	
	lda #8
	sta LKS_SPRITE_CTRL.nmax
	
	;---------------
	rep #$20
	lda #$6080
	sta LKS_OAM.evram+0
	lda #$60C0
	sta LKS_OAM.evram+2
	lda #$6400
	sta LKS_OAM.evram+4
	lda #$6440
	sta LKS_OAM.evram+6
	lda #$6480
	sta LKS_OAM.evram+8
	lda #$64C0
	sta LKS_OAM.evram+10
	lda #$6800
	sta LKS_OAM.evram+12
	lda #$6840
	sta LKS_OAM.evram+14
	
	lda #$8
	sta LKS_OAM.etile+0
	lda #$C
	sta LKS_OAM.etile+2
	lda #$40
	sta LKS_OAM.etile+4
	lda #$44
	sta LKS_OAM.etile+6
	lda #$48
	sta LKS_OAM.etile+8
	lda #$4C
	sta LKS_OAM.etile+10
	lda #$80
	sta LKS_OAM.etile+12
	lda #$84
	sta LKS_OAM.etile+14
	
	
	sep #$20
	rts
	
Init_Ennemy:

	phx
	phy
	
	sep #$20
	ldx MEM_TEMPFUNC
	LKS_SPRITE_INIT 1000,1000,8,$02,$AA
	LKS_SPRITE_ANIM_INIT 0,9,4
	LKS_DMA_INIT Officier,$80,128,$6080,1
	
	rep #$20
	
	ldx MEM_TEMPFUNC
	
	lda MEM_TEMPFUNC+2
	sta LKS_SPRITE.X,x
	asl
	asl
	sta LKS_SPRITE.PX,x
	
	lda MEM_TEMPFUNC+4
	sta LKS_SPRITE.Y,x
	asl
	asl
	sta LKS_SPRITE.PY,x
		
	lda MEM_TEMPFUNC
	clc
	adc #$20
	sta MEM_TEMPFUNC
	
	txa
	lsr
	tax
	
	lda MEM_TEMPFUNC+2
	sta SCharacter.zonex,x
	
	lda MEM_TEMPFUNC+4
	sta SCharacter.zoney,x
	sep #$20
	
	lda #8
	sta SCharacter.hp,x
	
	lda MEM_TEMPFUNC+6
	sta SCharacter.type,x
	
	ply
	plx
	rts

Init_Map:

	
	ldy #0
	
	rep #$20
	
	; ntag
	lda [LKS_ZP],y
	and #$FF
	tax
	dex
	iny
	
	;type 0
	lda [LKS_ZP],y
	iny
	iny
	
	;x
	lda [LKS_ZP],y
	sta LKS_SPRITE.X
	asl
	asl
	sta LKS_SPRITE.PX
	iny
	iny
	
	;y
	lda [LKS_ZP],y
	sta LKS_SPRITE.Y
	asl
	asl
	sta LKS_SPRITE.PY
	iny
	iny
	
	
	
	lda #$20*2
	sta MEM_TEMPFUNC
	sta LKS_DEBUG+2
	
	-:
		
		;type
		lda [LKS_ZP],y
		sta MEM_TEMPFUNC+6
		iny
		iny
		
		;x
		lda [LKS_ZP],y
		sta MEM_TEMPFUNC+2
		iny
		iny
		
		;y
		lda [LKS_ZP],y
		sta MEM_TEMPFUNC+4
		iny
		iny
		
		sep #$20
		jsr Init_Ennemy
		rep #$20
		dex
	bne -
	
	sep #$20
	rts
