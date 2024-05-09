
.MACRO joypad_event
	lda \3	; read joypad
	and #\1
	cmp #\1
	beq +
		stz MEM_STDCTRL + \2
	+:
	bne +
	
		lda MEM_STDCTRL + \2
		cmp #$00
		bne ++
			lda #01
			sta MEM_STDCTRL + \2
			bra +
		++:
		
		lda #02
		sta MEM_STDCTRL + \2
	+:
.ENDM
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
