
Tri_joypad:
	
	
	joypad_event $80 $00 STDCONTROL1L ; A
	joypad_event $40 $03 STDCONTROL1L ; X
	joypad_event $20 $04 STDCONTROL1L ; L
	joypad_event $10 $05 STDCONTROL1L ; R
	
	joypad_event $10 $06 STDCONTROL1H ; START
	joypad_event $20 $07 STDCONTROL1H ; SELECT
	joypad_event $40 $02 STDCONTROL1H ; Y
	joypad_event $80 $01 STDCONTROL1H ; B
	
	joypad_event $01 $08 STDCONTROL1H ; RIGHT
	joypad_event $02 $09 STDCONTROL1H ; LEFT
	joypad_event $04 $0A STDCONTROL1H ; DOWN
	joypad_event $08 $0B STDCONTROL1H ; UP
	
	rts
	
Joypad:

	;joypad_event $80 $00 STDCONTROL1L ; A
	;joypad_event $40 $03 STDCONTROL1L ; X
	;joypad_event $20 $04 STDCONTROL1L ; L
	;joypad_event $10 $05 STDCONTROL1L ; R
	
	;joypad_event $10 $06 STDCONTROL1H ; START
	;joypad_event $20 $07 STDCONTROL1H ; SELECT
	;joypad_event $40 $02 STDCONTROL1H ; Y
	;joypad_event $80 $01 STDCONTROL1H ; B
	
	;joypad_event $01 $08 STDCONTROL1H ; RIGHT
	;joypad_event $02 $09 STDCONTROL1H ; LEFT
	;joypad_event $04 $0A STDCONTROL1H ; DOWN
	;joypad_event $08 $0B STDCONTROL1H ; UP

	stz s_perso + 5
	
	lda MEM_BRIGTNESS
	and #$0F
	cmp #$0F
	beq +
		rts
	+:
	
	lda MEM_STDCTRL
	cmp #1
	bne +
		lda MEM_TEXT + 15
		cmp #0
		bne ++
			lda #1
			sta s_perso + 14
		++:
		
		lda MEM_TEXT + 15
		cmp #3
		bne ++
			lda #4
			sta MEM_TEXT + 15
		++:
		
		lda MEM_TEXT + 1
		cmp #7
		bne ++
			lda #8
			sta MEM_TEXT + 1
		++:
	+:
	

	lda MEM_STDCTRL + $06	; read joypad 1 Start
	cmp #1
	bne +	
	
	+:
	;---------------------------
	
	lda MEM_STDCTRL + $02	; read joypad 1 Y
	cmp #1
	bne +
		
		;ldx #Man + $0800
		;stx s_pnj + $18 + $40
	+:
	
	lda MEM_STDCTRL + $03	; read joypad 1 B
	cmp #1
	bne +

		
		;lda #-1
		;sta s_pnj + $04 + $00
		
		;ldx #Man + $0800
		;stx s_pnj + $18 + $40
	+:
	
	;---------------------------
	
	lda MEM_STDCTRL + $06	; read joypad 1 X
	cmp #1
	bne +
		;ldx #Man
		;stx s_pnj + $18 + $40
		
		;lda #1
		;sta s_pnj + $06 + $00
	+:
	
	
	
	
	lda MEM_STDCTRL + $00	; read joypad 1 A
	cmp #1
	bne +

		;;lda #1
		;sta s_perso + 14
		
		;ldx #Man + $1000
		;stx s_pnj + $18 + $40
		
		;lda #-1
		;sta s_pnj + $06 + $00
	+:
	
	lda MEM_TEXT + 15
	cmp #0
	beq +
		rts
	+:

		
	lda MEM_STDCTRL + $00	; read joypad 1 A
	cmp #1
	bne +

		lda #$01
		sta s_map + $0D
	+:
	
	
	
	lda MEM_STDCTRL + $03	; read joypad 1 X
	cmp #1
	bne +
		
		lda s_menu + 6
		cmp #0
		beq ++
			lda #0
			sta s_menu + 6
			bra +
		++:
			lda #1
			sta s_menu + 6		
	+:
	
	;---------------------------
	
	
	
	lda MEM_STDCTRL + $0A	; read joypad 1 Down
	cmp #2
	bne +
		;Vitesse
		lda #2
		sta s_perso + 13
		
		;play anim
		lda #1
		sta s_perso + 5
		
		;DMA
		ldx #Eagle1
		stx s_perso + 7 
		
		;direction bas
		lda #0
		sta s_perso + 15				
	+:

	lda MEM_STDCTRL + $0B	; read joypad 1 High
	cmp #2
	bne +
		;Vitesse
		lda #1
		sta s_perso + 13
		
		;play anim
		lda #1
		sta s_perso + 5
		
		;DMA
		ldx #Eagle1 + $1000
		stx s_perso + 7 
		
		;direction haut
		lda #1
		sta s_perso + 15
	+:


	lda MEM_STDCTRL + $08	; read joypad 1 Right
	cmp #2
	bne +
		;Vitesse
		lda #1
		sta s_perso + 12
		
		;Flip X
		lda s_perso + 3
		and #$30
		sta s_perso + 3
		
		;play anim
		lda #1
		sta s_perso + 5
		
		;DMA
		ldx #Eagle1 + $0800
		stx s_perso + 7 	
		
		;direction droite
		lda #2
		sta s_perso + 15	
	+:

	lda MEM_STDCTRL + $09	; read joypad 1 Left
	cmp #2
	bne +
		;Flip x
		lda s_perso + 3
		ora #$40
		sta s_perso + 3
		
		;play anim
		lda #1
		sta s_perso + 5
		
		;Vitesse
		lda #2
		sta s_perso + 12

		;DMA
		ldx #Eagle1 + $0800
		stx s_perso + 7 	
		
		;direction gauche
		lda #3
		sta s_perso + 15
	+:

	rts
	
