


	
LKS_Unpack_Map_BGC:

	ldy #0
	ldx #0
	
	lda [LKS_BG.Addressc],y
	sta MEM_TEMP+6+0
	iny
	lda [LKS_BG.Addressc],y
	sta MEM_TEMP+6+1
	iny
	
	stz MEM_TEMP+1
	
	stz MEM_TEMP+3
	-:
		stz MEM_TEMP+2
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
		
		cpy MEM_TEMP+6
	bmi -
	
	stz LKS_BG.Addressc+0
	
	lda #$C0
	sta LKS_BG.Addressc+1
	
	lda #$7E
	sta LKS_BG.Addressc+2
	
	rtl
	
LKS_Unpack_Map:
	jsl LKS_Unpack_Map_BG1
	jsl LKS_Unpack_Map_BG2
	jsl LKS_Unpack_Map_BGC

	rtl
	
	
;-----------------------------------------------------------------
LKS_Unpack_Map_BG1:

	ldy #0
	ldx #0
	
	lda [LKS_BG.Address2],y
	sta MEM_TEMP+6+0
	iny
	lda [LKS_BG.Address2],y
	sta MEM_TEMP+6+1
	iny
	
	stz MEM_TEMP+3
	-:
		stz MEM_TEMP+2
		
		lda [LKS_BG.Address2],y
		sta MEM_TEMP+5
		and #$FE
		sta MEM_TEMP
		iny
		
		lda [LKS_BG.Address2],y
		sta MEM_TEMP+1
		iny
		
		lda MEM_TEMP+5
		bit #$01
		beq +
			
			lda [LKS_BG.Address2],y
			sta MEM_TEMP+2
			iny
		+:

		rep #$20
		phy
		
		lda MEM_TEMP+2
		and #$3F
		tay
		iny
		
		lda MEM_TEMP+2
		bit #$80
		beq +
			lda MEM_TEMP
			inc a
			inc a
			sta MEM_TEMP+3
			dey
			
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
		bit #$40
		beq +			
			
			lda MEM_TEMP
			--:
				sta $7F0000,x
				inc a
				inc a
				inx
				inx
				dey
			bne --

			bra ++
		+:
		
			lda MEM_TEMP
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
	
	stz LKS_BG.Address2
	
	lda #$00
	sta LKS_BG.Address2+1
	
	lda #$7F
	sta LKS_BG.Address2+2
	sta LKS_BG.Address2org+2
	
	ldx LKS_BG.Address2
	stx LKS_BG.Address2org
	
	rtl
	
	
;-----------------------------------------------------------------
LKS_Unpack_Map_BG2:

	ldy #0
	ldx #$8000
	
	lda [LKS_BG.Address1],y
	sta MEM_TEMP+6+0
	iny
	lda [LKS_BG.Address1],y
	sta MEM_TEMP+6+1
	iny
	
	stz MEM_TEMP+3
	-:
		stz MEM_TEMP+2
		
		lda [LKS_BG.Address1],y
		sta MEM_TEMP+5
		and #$FE
		sta MEM_TEMP
		iny
		
		lda [LKS_BG.Address1],y
		sta MEM_TEMP+1
		iny
		
		lda MEM_TEMP+5
		bit #$01
		beq +
			
			lda [LKS_BG.Address1],y
			sta MEM_TEMP+2
			iny
		+:
		
		rep #$20
		phy
		
		lda MEM_TEMP+2
		and #$3F
		tay
		iny
		
		lda MEM_TEMP+2
		bit #$80
		beq +
			lda MEM_TEMP
			inc a
			inc a
			sta MEM_TEMP+3
			dey
			
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
		bit #$40
		beq +			
			
			lda MEM_TEMP
			--:
				sta $7F0000,x
				inc a
				inc a
				inx
				inx
				dey
			bne --

			bra ++
		+:
		
			lda MEM_TEMP
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
	
	stz LKS_BG.Address1
	
	lda #$80
	sta LKS_BG.Address1+1
	
	lda #$7F
	sta LKS_BG.Address1+2
	sta LKS_BG.Address1org+2
	
	ldx LKS_BG.Address1
	stx LKS_BG.Address1org
	
	rtl
