
LKS_Ennemy_Enable:
	rep #$20
	lda LKS_SPRITE_CTRL.nmax
	asl
	tax
	sep #$20
	
	-:
		dex
		dex
		lda LKS_OAM.enable,x
		cmp #0
		beq ++
		
		cpx #0
	bne -
	lda #0
	rtl

	++:
	rep #$20
	lda MEM_TEMPFUNC
	sta LKS_OAM.Address+4,x
	sep #$20
	
	lda #1
	sta LKS_OAM.enable,x
	
	
	rtl

.MACRO LKS_Ennemy_Screen_Sort_MC

	

	
	lda LKS_SPRITE.Enable,y
	bit #$08
	beq ++
	
	
	jsl LKS_Ennemy_SC
	cmp #0
	bne +
		lda LKS_SPRITE.Enable,y
		and #$FF-4
		sta LKS_SPRITE.Enable,y
		
		bra ++
	+:
		cmp #\1
		bne ++
			lda LKS_SPRITE_CTRL.n
			cmp LKS_SPRITE_CTRL.nmax
			bmi +
				bra ++
			+:
			lda LKS_SPRITE.Enable,y
			bit #$4
			bne ++
				
				sty MEM_TEMPFUNC
				jsl LKS_Ennemy_Enable
				cmp #1
				bne ++
				
					lda LKS_SPRITE.Enable,y
					ora #$04
					sta LKS_SPRITE.Enable,y
					
					inc LKS_SPRITE_CTRL.n	
							
	++:
	
	rep #$20
	tya
	clc
	adc #$20
	tay
	sep #$20

.ENDM

LKS_Ennemy_Screen_Sort_Inv:
	
	LKS_Ennemy_Screen_Sort_MC 2
	LKS_Ennemy_Screen_Sort_MC 2
	LKS_Ennemy_Screen_Sort_MC 2
	LKS_Ennemy_Screen_Sort_MC 2
	
	LKS_Ennemy_Screen_Sort_MC 2
	LKS_Ennemy_Screen_Sort_MC 2
	LKS_Ennemy_Screen_Sort_MC 2
	LKS_Ennemy_Screen_Sort_MC 2

	rtl

LKS_Ennemy_Screen_Sort:
	
	LKS_Ennemy_Screen_Sort_MC 1
	LKS_Ennemy_Screen_Sort_MC 1
	LKS_Ennemy_Screen_Sort_MC 1
	LKS_Ennemy_Screen_Sort_MC 1
	
	LKS_Ennemy_Screen_Sort_MC 1
	LKS_Ennemy_Screen_Sort_MC 1
	LKS_Ennemy_Screen_Sort_MC 1
	LKS_Ennemy_Screen_Sort_MC 1

	rtl

LKS_Ennemy_SC:


	rep #$20
	
	lda LKS_SPRITE.X,y
	sec
	sbc LKS_BG.x
	sta MEM_TEMPFUNC+$2
	
	cmp #-64
	bpl +
		bra ++
	+:
	cmp #256+64
	bmi +
		bra ++
	+:
	
	lda LKS_SPRITE.Y,y
	sec
	sbc LKS_BG.y
	sta MEM_TEMPFUNC+$0
	
	cmp #-64
	bpl +
		bra ++
	+:
	cmp #224+64
	bmi +
		bra ++
	+:
	
	sep #$20
	
	jsl LKS_Ennemy_SC2
	
	rtl
	
	++:
	sep #$20
	lda #0
	rtl

	
LKS_Ennemy_SC2:

	
	;Y
	rep #$20
	lda MEM_TEMPFUNC+$0
	clc
	adc #$10
	sta MEM_TEMP
	adc #$10
	sta MEM_TEMP+2
	sep #$20
	
	lda MEM_TEMP+1
	cmp #$01
	bmi +
		lda #1
		rtl
	+:
	
	lda MEM_TEMP+1+2
	cmp #$00
	bpl +
		lda #1
		rtl
	+:
	
	;X right
	lda MEM_TEMPFUNC+$2+1
	cmp #$01
	bmi +
		lda #1
		rtl
	+:
	
	;X left
	rep #$20
	lda MEM_TEMPFUNC+$2
	clc
	adc #$30
	sta MEM_TEMP
	sep #$20
		
	lda MEM_TEMP+1
	cmp #$0
	bpl +
		lda #1
		rtl
	+:
	
	lda #2
	rtl
	
