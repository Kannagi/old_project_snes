
Draw_menu:
		;Menu
		
		lda s_menu + 6
		cmp #$00
		bne +
			rts
		+:
		
		stz MEM_TEMP
		stz MEM_TEMP + 1
		
		lda s_menu + 5
		cmp #$00
		bne ++
			lda STDCONTROL1L	; read joypad 1 L
			and #$20
			cmp #$20
			bne +
				lda #01
				sta s_menu + 4
			+:
			
			lda STDCONTROL1L	; read joypad 1 R
			and #$10
			cmp #$10
			bne +
				lda #02
				sta s_menu + 4
			+:
		++:
		
		lda s_menu + 4
		cmp #$01
		bne +
			lda s_menu + 5
			clc
			adc #04
			sta s_menu + 5
			
			lda #04
			sta MEM_TEMP
			
		+:
		
		lda s_menu + 4
		cmp #$02
		bne +
			lda s_menu + 5
			clc
			adc #04
			sta s_menu + 5
			
			lda #04
			sta MEM_TEMP + 1
			
		+:
		
		;------
		lda s_menu + 5
		cmp #$24
		bmi +
		
			lda s_menu + 4
			cmp #$01
			bne ++
				dec s_menu + 7
				bra +++
			++:
				inc s_menu + 7
			+++:
			
			stz s_menu + 4
			stz s_menu + 5
		+:
		
		

		;select
		lda #$08
		sta OAMADDL
		stz OAMADDH
		Draw_select 30 $E0 $31
		
		;incremente
		inc $1401
		lda $1401
		cmp #100
		bne +
			stz $1401
			inc $1400
		+:
		
		lda $1400
		cmp #10
		bne +
			stz $1400
		+:
		
		;Menu
		lda #$10
		sta OAMADDL
		stz OAMADDH
		clc
		
		lda #24
		sta s_menu + 3
		;lda $1400
		;sta WRMPYA
		;lda #7
		;sta WRMPYB
		;ondine
		Draw_icon $00 $82 $3F ; angle ,tileset ,palette
		Draw_icon $24 $86 $3F
		Draw_icon $48 $80 $3D
		Draw_icon $6C $84 $3D
		Draw_icon $90 $88 $3D
		Draw_icon $B4 $8A $3F
		Draw_icon $D8 $8E $3F
		
		;gnome
		;Draw_icon $E0 $86 $3F
		;Draw_icon $55 $86 $3F
		
		;ifrit
		;Draw_icon $C0 $80 $3D
		;Draw_icon $AA $80 $3D
		
		;foudre
		;Draw_icon $A0 $84 $3D
		
		;Lumiere
		;Draw_icon $80 $88 $3D
		
		;shadow
		;Draw_icon $60 $8A $3F
		
		;Lune
		;Draw_icon $40 $8C $3D
		
		;Dryade
		;Draw_icon $20 $8E $3F

		clc
		;rotate
		lda s_menu + 1
		sec
		sbc MEM_TEMP + 1
		clc
		adc MEM_TEMP
		sta s_menu + 1
		
		;nombre objet
		lda #7
		sta s_menu + 2
		
		
		;si on a un chiffre négative
		lda s_menu + 7
		cmp #$00
		bpl +
			lda s_menu + 2
			dec A
			sta s_menu + 7
		+:
		
		;si on a un chiffre positive > n
		lda s_menu + 7
		cmp s_menu + 2
		bmi +
			stz s_menu + 7
		+:
		
		lda s_menu + 7
		sta $1325
		
		lda s_menu + 5
		cmp #$00
		beq ++
			rts
		++:
		
		jsr Menu_condition_rotation
	rts
	
Menu_condition_rotation:
	
	
	;condition spécifique pour 3 objet
		lda s_menu + 2
		cmp #$03
		bne ++
			lda s_menu + 7
			cmp #$00
			bne +
				lda #$40
				sta s_menu + 1
				bra ++
			+:
			cmp #$01
			bne +
				lda #$EC
				sta s_menu + 1
				bra ++
			+:
			cmp #$02
			bne +
				lda #$97
				sta s_menu + 1
			+:
		++:
		
		;condition spécifique pour 5 objet
		lda s_menu + 2
		cmp #$05
		bne ++
			lda s_menu + 7
			cmp #$00
			bne +
				lda #$40
				sta s_menu + 1
				bra ++
			+:
			cmp #$01
			bne +
				lda #$0D
				sta s_menu + 1
				bra ++
			+:
			cmp #$02
			bne +
				lda #$DB
				sta s_menu + 1
			+:
			cmp #$03
			bne +
				lda #$A8
				sta s_menu + 1
			+:
			cmp #$04
			bne +
				lda #$75
				sta s_menu + 1
			+:
		++:
		
		;condition spécifique pour 6 objet
		lda s_menu + 2
		cmp #$06
		bne ++
			lda s_menu + 7
			cmp #$00
			bne +
				lda #$40
				sta s_menu + 1
				bra ++
			+:
			cmp #$01
			bne +
				lda #$16
				sta s_menu + 1
				bra ++
			+:
			cmp #$02
			bne +
				lda #$EB
				sta s_menu + 1
				bra ++
			+:
			cmp #$03
			bne +
				lda #$C2
				sta s_menu + 1
				bra ++
			+:
			cmp #$04
			bne +
				lda #$97
				sta s_menu + 1
				bra ++
			+:
			cmp #$05
			bne +
				lda #$6D
				sta s_menu + 1
			+:
		++:
		
		;condition spécifique pour 7 objet
		lda s_menu + 2
		cmp #$07
		bne ++
			lda s_menu + 7
			cmp #$00
			bne +
				lda #$40
				sta s_menu + 1
				bra ++
			+:
			cmp #$01
			bne +
				lda #$19
				sta s_menu + 1
				bra ++
			+:
			cmp #$02
			bne +
				lda #$F8
				sta s_menu + 1
				bra ++
			+:
			cmp #$03
			bne +
				lda #$D4
				sta s_menu + 1
				bra ++
			+:
			cmp #$04
			bne +
				lda #$B0
				sta s_menu + 1
				bra ++
			+:
			cmp #$05
			bne +
				lda #$8C
				sta s_menu + 1
				bra ++
			+:
			cmp #$06
			bne +
				lda #$68
				sta s_menu + 1
			+:
		++:

	rts
	
