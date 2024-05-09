
.MACRO draw_oam1
		;OAM 1
		lda \1
		sta OAMDATA
		
		lda \1 + 1
		sta OAMDATA
		
		clc
		lda \1 + 2
		adc #\2
		sta OAMDATA
		
		lda #$20
		ora \1 + 3
		ora \1 + 4
		sta OAMDATA
.ENDM

.MACRO draw_oam2
		;OAM 2
		clc
		lda \1
		adc #$10
		sta OAMDATA
		
		lda \1 + 1
		sta OAMDATA
		
		clc
		lda \1 + 2
		adc #\2
		sta OAMDATA
		
		lda #$20
		ora \1 + 3
		ora \1 + 4
		sta OAMDATA
.ENDM

.MACRO draw_oam3

		;OAM 3
		clc
		lda \1
		sta OAMDATA
		
		lda \1 + 1
		adc #$10
		sta OAMDATA
		
		clc
		lda \1 + 2
		adc #\2
		sta OAMDATA
		
		lda #$20
		ora \1 + 3
		sta OAMDATA
.ENDM

.MACRO draw_oam4
		;OAM 4
		clc
		lda \1
		adc #$10
		sta OAMDATA
		
		clc
		lda \1 + 1
		adc #$10
		sta OAMDATA
		
		clc
		lda \1 + 2
		adc #\2
		sta OAMDATA
		
		lda #$20
		ora \1 + 3
		sta OAMDATA
.ENDM

.MACRO draw_oam5
		;OAM 4
		clc
		lda \1
		adc #$08
		;sbc #$10
		sta OAMDATA
		clc
		lda \1 + 1
		;adc #$10
		sta OAMDATA
		
		clc
		lda \1 + 2
		adc #\2
		sta OAMDATA
		clc
		lda #$20
		ora \1 + 3
		sta OAMDATA
.ENDM

.MACRO Draw_icon		
		lda s_menu + 1
		adc #\1
		sta s_menu + 2
		
		ldx s_menu + 2
		lda SinCos.l ,X
		sbc #24
		;sta WRMPYB
		;nop
		;nop
		;lda RDMPYL
		;clc
		
		adc s_perso
		bcs +
		sta OAMDATA

		
		
		lda SinCos.l + $40,X
		;sbc #23
		;sta WRMPYB
		;nop
		;nop
		;lda RDMPYL
		;clc
		adc s_perso + 1
		bcs ++
		
		cmp #-32
		bmi ++++
			cmp #-120
			bpl ++
		++++:
		
		sta OAMDATA
		
		
		bra +++

		+:
			lda #0
			sta OAMDATA
		++:
			lda #-24
			sta OAMDATA
		+++:
		
		
		
		lda #\2
		sta OAMDATA
		
		lda #\3
		sta OAMDATA
.ENDM

.MACRO Draw_select
		;OAM 1	
		clc	
		lda #$01
		adc s_perso
		sta OAMDATA
		
		lda #$00
		adc s_perso + 1
		sbc #\1
		sta OAMDATA
		
		lda #\2
		sta OAMDATA
		
		lda #\3
		sta OAMDATA
		
		;OAM 2	
		lda #$00
		adc s_perso
		adc #16
		sta OAMDATA
		
		lda #$00
		adc s_perso + 1
		sbc #\1
		sta OAMDATA
		
		lda #\2
		sta OAMDATA
		
		lda #\3
		ora #$40
		sta OAMDATA
		
		;OAM 3
		lda #$00
		adc s_perso
		adc #16
		sta OAMDATA
		
		lda #$00
		adc s_perso + 1
		adc #16
		sbc #\1
		sta OAMDATA
		
		lda #\2
		sta OAMDATA
		
		lda #\3
		ora #$C0
		sta OAMDATA
		
		;OAM 4
		lda #$00
		adc s_perso
		sta OAMDATA
		
		lda #$00
		adc s_perso + 1
		adc #16
		sbc #\1
		sta OAMDATA
		
		lda #\2
		sta OAMDATA
		
		lda #\3
		ora #$80
		sta OAMDATA
		
.ENDM

;-----------out CPU-----------------
.MACRO draw_oam1_ram
		;OAM 1
		lda \1
		sta 0,X
		inx
		
		lda \1 + 1
		sta 0,X
		inx
		
		clc
		lda \1 + 2
		adc #\2
		sta 0,X
		inx
		
		lda #$20
		ora \1 + 3
		ora \1 + 4
		sta 0,X
		inx
.ENDM

.MACRO draw_oam2_ram
		;OAM 2
		clc
		lda \1
		adc #$10
		sta 0,X
		inx
		
		lda \1 + 1
		sta 0,X
		inx
		
		clc
		lda \1 + 2
		adc #\2
		sta 0,X
		inx
		
		lda #$20
		ora \1 + 3
		ora \1 + 4
		sta 0,X
		inx
.ENDM

.MACRO draw_oam3_ram

		;OAM 3
		clc
		lda \1
		sta 0,X
		inx
		
		lda \1 + 1
		adc #$10
		sta 0,X
		inx
		
		clc
		lda \1 + 2
		adc #\2
		sta 0,X
		inx
		
		lda #$20
		ora \1 + 3
		sta 0,X
		inx
.ENDM

.MACRO draw_oam4_ram
		;OAM 4
		clc
		lda \1
		adc #$10
		sta 0,X
		inx
		
		clc
		lda \1 + 1
		adc #$10
		sta 0,X
		inx
		
		clc
		lda \1 + 2
		adc #\2
		sta 0,X
		inx
		
		lda #$20
		ora \1 + 3
		sta 0,X
		inx
.ENDM
