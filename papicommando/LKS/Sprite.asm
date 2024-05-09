
LKS_Sprite_limite:
	
	rep #$20
	lda #0
	sta MEM_RETURN
		
	lda LKS_SPRITE.PX,y
	clc
	adc LKS_SPRITE.VX,y
	bit #$8000
	beq +
		lda #0
		sta LKS_SPRITE.VX,y
		
		lda #1
		sta MEM_RETURN
	+:
	
	lda LKS_SPRITE.PY,y
	clc
	adc LKS_SPRITE.VY,y
	bit #$8000
	beq +
		lda #0
		sta LKS_SPRITE.VY,y
		lda #1
		sta MEM_RETURN
	+:
	
	lda LKS_SPRITE.PX,y
	clc
	adc LKS_SPRITE.VX,y
	lsr
	lsr
	clc
	adc LKS_SPRITE_CTRL.width
	cmp LKS_BG.limitex
	bmi +

		lda #0
		sta LKS_SPRITE.VX,y
		
		lda #1
		sta MEM_RETURN
	+:
	
	
	lda LKS_SPRITE.PY,y
	clc
	adc LKS_SPRITE.VY,y
	lsr
	lsr
	clc
	adc LKS_SPRITE_CTRL.height
	cmp LKS_BG.limitey
	bmi +
		lda #0
		sta LKS_SPRITE.VY,y
		
		lda #1
		sta MEM_RETURN
	+:
	
	sep #$20
	
	rtl
	
LKS_Sprite_Anim:

	tyx
	
	stz MEM_RETURN
	
	lda LKS_SPRITE.Anim_type,x
	bit #$80
	bne +
	lda LKS_SPRITE.Anim_act,x
	cmp LKS_SPRITE.Anim_old,x
	beq +
		sta LKS_SPRITE.Anim_old,x
		stz LKS_SPRITE.Anim_l,x
		stz LKS_SPRITE.Anim_i,x
		lda #$80
		sta MEM_RETURN
	+:

	inc LKS_SPRITE.Anim_l,x
	lda LKS_SPRITE.Anim_l,x
	cmp LKS_SPRITE.Anim_v,x
	bne +
		stz LKS_SPRITE.Anim_l,x
		inc LKS_SPRITE.Anim_i,x
		lda #$80
		sta MEM_RETURN
	+:

	stz LKS_SPRITE.Anim_end,x
	lda LKS_SPRITE.Anim_i,x
	cmp LKS_SPRITE.Anim_n,x
	bne +
		stz LKS_SPRITE.Anim_l,x
		stz LKS_SPRITE.Anim_i,x
		lda #$80
		sta LKS_SPRITE.Anim_end,x
		sta MEM_RETURN
	+:
	
	lda LKS_SPRITE.Anim_type,x
	and #$40
	cmp #0
	beq +
		lda #$80
		sta MEM_RETURN
		lda LKS_SPRITE.Anim_type,x
		and #$FF-$40
		sta LKS_SPRITE.Anim_type,x
	+:
	
	
	lda LKS_SPRITE.Anim_flg,x
	and #$7F
	ora MEM_RETURN
	sta LKS_SPRITE.Anim_flg,x
 
	rtl
	


LKS_Sprite_DMA:
	tyx
	
	lda LKS_SPRITE.Anim_flg,x
	bit #$80
	bne +
		rtl
	+:
	
	lda LKS_SPRITE.Anim_act,x
	sta MEM_TEMP+8
	
	lda LKS_SPRITE.Anim_type,x
	and #$0F
	cmp #0
	beq +
		sta MEM_TEMP
		lda LKS_SPRITE.Anim_i,x
		sta MEM_TEMP+10
		cmp #4
		bmi ++
			sec
			sbc #4
			sta MEM_TEMP+10
			
			lda MEM_TEMP+8
			clc
			adc MEM_TEMP
			sta MEM_TEMP+8
		bra ++
	+:
		lda LKS_SPRITE.Anim_i,x
		sta MEM_TEMP+10
	++:
	
	;Anim Y
	lda MEM_TEMP+8
	sta WRMPYA

	lda LKS_SPRITE_CTRL.height
	asl
	sta WRMPYB
	
	nop
	nop
	nop
	rep #$20
	
	lda RDMPYL
	asl
	asl
	asl
	asl
	sta MEM_TEMP+4
	
	sep #$20
	
	;Anim X
	lda MEM_TEMP+10
	sta WRMPYA
	
	lda LKS_SPRITE_CTRL.pitch
	sta WRMPYB
	
	nop
	nop
	rep #$20
	stx MEM_TEMP

	lda RDMPYL
	asl
	sta MEM_TEMP+2
	
	;Send
	lda LKS_SPRITE.Address,x
	clc
	adc MEM_TEMP+2
	adc MEM_TEMP+4
	sta LKS_DMA.Src1,x
	
	lda LKS_DMA_SEND.i
	tax
	adc #2
	sta LKS_DMA_SEND.i
	
	lda MEM_TEMP
	sta LKS_DMA_SEND.index,x
	
	sep #$20
	
	rtl
	
LKS_Sprite_Move:
	tyx

	rep #$20
	clc
	lda LKS_SPRITE.PX,x
	adc LKS_SPRITE.VX,x
	sta LKS_SPRITE.PX,x
	bit #$8000
	beq +
		lsr
		lsr 
		ora #$F000
		sta LKS_SPRITE.X,x
		bra ++
	+:
		lsr
		lsr 
		sta LKS_SPRITE.X,x
	++:

	clc
	lda LKS_SPRITE.PY,x
	adc LKS_SPRITE.VY,x
	sta LKS_SPRITE.PY,x
	bit #$8000
	beq +
		lsr
		lsr 
		ora #$F000
		sta LKS_SPRITE.Y,x
		bra ++
	+:
		lsr
		lsr 
		sta LKS_SPRITE.Y,x
	++:
	sep #$20
	
	rtl
