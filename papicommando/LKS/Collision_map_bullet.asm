
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
	lsr
	lsr
	lsr
	lsr
	and #$00FF
	ora #$1000
	sta WRMPYA
	
	LKS_cycle8

	lda RDMPYL
	asl
	asl
	clc
	adc MEM_TEMP+0
	tay
	lda [LKS_BG.Addressc],y
	

	
.ENDM
.ACCU 8


LKS_Collision_Map_Bullet:
	
	rep #$20
	
	LKS_COLLISION_MAP_BULLET
	bit #$01
	beq +
		lda #0
		sta LKS_BULLET.VX,x
		sta LKS_BULLET.VY,x
		
		lda #$E000
		sta LKS_BULLET.Y,x
	+:
	

	sep #$20

	rtl
	
