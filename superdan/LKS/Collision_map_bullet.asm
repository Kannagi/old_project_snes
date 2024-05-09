
.ACCU 16
.MACRO LKS_COLLISION_MAP_BULLET
	
	
	lda LKS_BULLET.X+1,x
	and #$FF
	clc
	adc #4
	adc LKS_BG.x
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP+0
	
	;----------------
	lda LKS_BULLET.Y+1,x 
	and #$FF
	clc
	adc #4
	adc LKS_BG.y
	sta MEM_TEMP+2
	lsr
	lsr
	lsr
	lsr
	and #$00FF
	ora #$1000
	sta WRMPYA
	
	lda MEM_TEMP+2
	and #$F000
	clc
	nop
	
	adc RDMPYL
	adc MEM_TEMP+0
	
	tay
	lda [LKS_BG.Addressc],y

	
.ENDM
.ACCU 8


LKS_Collision_Map_Bullet:
	
	
	lda LKS_BULLET.Y+1,x 
	cmp #$E0
	bne +
		rtl
	+:
	rep #$20
	
	LKS_COLLISION_MAP_BULLET
	bit #$10
	beq +
		sty MEM_TEMP+8
		lda #0
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		sta LKS_BULLET.X,x
		
		lda #$E000
		sta LKS_BULLET.Y,x
		
		sep #$20
		lda #0
		sta [LKS_BG.Addressc],y
		rep #$20
		
		tya
		asl
		tay
		lda [LKS_BG.Address2org],y
		ina
		ina
		sta [LKS_BG.Address2org],y
		
		inc MEM_RETURN
	+:
	

	sep #$20

	rtl
	
