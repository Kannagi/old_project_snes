

LKS_Unpack_Map_BG1:

	ldy #0
	ldx #0
	rep #$20
	lda LKS_BG.size
	asl
	sta MEM_TEMP+6
	sep #$20
	
	stz MEM_TEMP+1
	
	-:
		stz MEM_TEMP+2
		stz MEM_TEMP+3
		
		lda [LKS_BG.Address2],y
		sta MEM_TEMP
		bit #$01
		beq +
			iny
			lda [LKS_BG.Address2],y
			sta MEM_TEMP+1
			
			iny
			lda [LKS_BG.Address2],y
			sta MEM_TEMP+2
			bit #$80
			beq +
				iny
				lda [LKS_BG.Address2],y
				sta MEM_TEMP+3
		+:
		
		iny
		
		
		rep #$20
		phy
		
		lda MEM_TEMP+2
		and #$7F
		tay
		iny
		
		lda MEM_TEMP+2
		bit #$80
		beq +
			lda MEM_TEMP+1
			sta MEM_TEMP+4
			
			lda MEM_TEMP
			and #$FFFE
			sta MEM_TEMP
			
			lda MEM_TEMP+3
			and #$FFFE
			sta MEM_TEMP+3
			
			
			--:
				lda MEM_TEMP
				sta $7F0000,x
				inx
				inx
				lda MEM_TEMP+3
				sta $7F0000,x
				inx
				inx
				dey
			bne --

			bra ++
		+:
			lda MEM_TEMP
			and #$FFFE
			--:
				sta $7F0000,x
				inx
				inx
				dey
			bne --
		++:
		ply
		sep #$20
		
		
		cpy MEM_TEMP+6
	bmi -
	
	stz LKS_BG.Address2+0
	
	lda #$00
	sta LKS_BG.Address2+1
	
	lda #$7F
	sta LKS_BG.Address2+2
	
	rtl
	
LKS_Unpack_Map_BG2:

	ldy #0
	ldx #$8000
	
	rep #$20
	lda LKS_BG.size
	asl
	sta MEM_TEMP+6
	sep #$20
	
	stz MEM_TEMP+1
	
	-:
		stz MEM_TEMP+2
		stz MEM_TEMP+3
		
		lda [LKS_BG.Address1],y
		sta MEM_TEMP
		bit #$01
		beq +
			iny
			lda [LKS_BG.Address1],y
			sta MEM_TEMP+1
			
			iny
			lda [LKS_BG.Address1],y
			sta MEM_TEMP+2
			bit #$80
			beq +
				iny
				lda [LKS_BG.Address1],y
				sta MEM_TEMP+3
		+:
		
		iny
		
		
		rep #$20
		phy
		
		lda MEM_TEMP+2
		and #$7F
		tay
		iny
		
		lda MEM_TEMP+2
		bit #$80
		beq +
			lda MEM_TEMP+1
			sta MEM_TEMP+4
			
			lda MEM_TEMP
			and #$FFFE
			sta MEM_TEMP
			
			lda MEM_TEMP+3
			and #$FFFE
			sta MEM_TEMP+3
			
			
			--:
				lda MEM_TEMP
				sta $7F0000,x
				inx
				inx
				lda MEM_TEMP+3
				sta $7F0000,x
				inx
				inx
				dey
			bne --

			bra ++
		+:
			lda MEM_TEMP
			and #$FFFE
			--:
				sta $7F0000,x
				inx
				inx
				dey
			bne --
		++:
		ply
		sep #$20
		
		
		cpy MEM_TEMP+6
	bmi -
	
	stz LKS_BG.Address1+0
	
	lda #$80
	sta LKS_BG.Address1+1
	
	lda #$7F
	sta LKS_BG.Address1+2
	
	rtl
	
LKS_Unpack_Map_BGC:

	ldy #0
	ldx #0
	stz MEM_TEMP+1
	stz MEM_TEMP+3
	-:
		stz MEM_TEMP+2
		stz MEM_TEMP+3
		
		lda [LKS_BG.Addressc],y
		sta MEM_TEMP
		bit #$80
		beq +
			iny
			lda [LKS_BG.Addressc],y
			sta MEM_TEMP+2
		+:
		
		iny
		
		
		rep #$20
		phy
		
		lda MEM_TEMP+2
		tay
		iny
		sep #$20
		

		lda MEM_TEMP
		and #$7F
		--:
			sta $7EC000,x
			inx
			dey
		bne --
		
		ply
		
		cpy LKS_BG.size
	bmi -
	
	stz LKS_BG.Addressc+0
	
	lda #$C0
	sta LKS_BG.Addressc+1
	
	lda #$7E
	sta LKS_BG.Addressc+2
	
	rtl
	
LKS_Unpack_Map
	jsl LKS_Unpack_Map_BG1
	jsl LKS_Unpack_Map_BG2
	jsl LKS_Unpack_Map_BGC

	rtl
