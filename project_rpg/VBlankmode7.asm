




VBlankMode7:

	
	
	
	
	
	
	ldx s_mode7+_m7an
		
	lda sincos.l + $80,X
	sta MEM_TEMP+2
	
	lda sincos.l + $40,X
	sta MEM_TEMP+3
	
	lda sincos.l + $00,X
	sta MEM_TEMP+4
	
	lda s_mode7+_m7frm
	ina
	and #$01
	sta s_mode7+_m7frm
	
	cmp #0
	bne +
		jsl R1mode7
		bra ++
	+:
	cmp #1
	bne +
		jsl R2mode7
		bra ++
	+:
	
	++:
	
	
	SNES_DMAX $02
    
	SNES_DMA0_BADD $1B
	SNES_DMA1_BADD $1E
	
	SNES_DMA2_BADD $1C
	SNES_DMA3_BADD $1D
	

	SNES_HDMA_ADD MODE7A,$7E,  0,0 ,0,0,   0
	SNES_HDMA_ADD MODE7D,$7E,  0,0 ,0,0,   1
	
	SNES_HDMA_ADD MODE7B,$7E,  0,0 ,0,0,   2
	SNES_HDMA_ADD MODE7C,$7E,  0,0 ,0,0,   3
	
	SNES_HDMAEN $0F
	
	
	
	jsl CallMode7
	
	
	
	SNES_BGMODE $31
	SNES_TM $12
	
	

	/*
	rep #$20
	
	lda #$100
	sta HTIMEL
	
	lda #$64
	sec
	sbc s_mode7+_m7sy
	sta VTIMEL
	
	sep #$20
	*/
	
	
	
	rts
	
	
.MACRO Set_Mode7_line

		
		
		;M7B
		lda MODE7S+(\1*2)
		sta M7A
		
		lda MODE7S+(\1*2) + 1
		sta M7A
		
		lda MEM_TEMP+2
		sta M7B
				
		ldx MPYM
		stx MODE7B+(3*(\1+$60))+1
		
		;M7C
		lda MEM_TEMP+4
		sta M7B
				
		ldx MPYM
		stx MODE7C+(3*(\1+$60))+1		

		;M7A
		lda MEM_TEMP+3
		sta M7B
			
				
		ldx MPYM
		stx MODE7A+(3*(\1+$60))+1

		;M7D	
		stx MODE7D+(3*(\1+$60))+1		


.ENDM
	
.MACRO Set_Mode7


	;ldx angle
		
	lda sincos.l + $80,X
	sta MEM_TEMP+2
	
	lda sincos.l + $40,X
	sta MEM_TEMP+3
	
	lda sincos.l + $00,X
	sta MEM_TEMP+4
		
	ldx #3*$60
	inx
	ldy #$00
	-:

		rep #$20
		
		phx
		tyx
		lda MODE7S,x
		
		sta MEM_TEMP
		
		
		
		
		
		
		plx
		
		sep #$20
		
		;B
		lda MEM_TEMP
		sta M7A
		
		lda MEM_TEMP + 1
		sta M7A
		
		
		lda MEM_TEMP+2
		sta M7B
		
		
		
		rep #$20
		
		lda MPYM
		sta MODE7B,x

		sep #$20
		
		; C
		lda MEM_TEMP+4
		sta M7B
		
		rep #$20
		
		lda MPYM
		sta MODE7C,x

		sep #$20
		

		; A
		lda MEM_TEMP+3
		sta M7B
		
		rep #$20
		
		lda MPYM
		sta MODE7A,x

		sep #$20
		
		; D
		rep #$20
		
		lda MPYM
		sta MODE7D,x

		sep #$20
		
		
		
		inx
		inx
		inx
		
		iny
		iny
		cpy #\1+\2*2
	bne -

.ENDM

.MACRO Set_Mode7_line_bloc


	Set_Mode7_line $00+\1
	Set_Mode7_line $01+\1
	Set_Mode7_line $02+\1
	Set_Mode7_line $03+\1
	Set_Mode7_line $04+\1
	Set_Mode7_line $05+\1
	Set_Mode7_line $06+\1
	Set_Mode7_line $07+\1
	Set_Mode7_line $08+\1
	
	Set_Mode7_line $09+\1
	Set_Mode7_line $0A+\1
	Set_Mode7_line $0B+\1
	Set_Mode7_line $0C+\1
	Set_Mode7_line $0D+\1
	Set_Mode7_line $0E+\1
	Set_Mode7_line $0F+\1

.ENDM
	


	
	
CallMode7:
/*
	lda s_mode7+_m7a
	sta M7A
	
	lda s_mode7+_m7a+1
	sta M7A
	
	lda s_mode7+_m7b
	sta M7B
	
	lda s_mode7+_m7b+1
	sta M7B
	
	lda s_mode7+_m7c
	sta M7C
	
	lda s_mode7+_m7c+1
	sta M7C
	
	lda s_mode7+_m7d
	sta M7D
	
	lda s_mode7+_m7d+1
	sta M7D
	*/
	lda s_mode7+_m7x
	sta M7X
	
	lda s_mode7+_m7x+1
	sta M7X
	
	lda s_mode7+_m7y
	sta M7Y
	
	lda s_mode7+_m7y+1
	sta M7Y
	
	
	rtl
   
CalMode7:
	
	;ldx angle
	
	; Calculate B and C (sin's)
	; B
	
	lda s_mode7+_m7sx
	sta M7A
	
	lda s_mode7+_m7sx + 1
	sta M7A
	
	lda sincos.l + $80,X	;sin (x)
	sta M7B
	
	ldy MPYM
	sty s_mode7+_m7b
	
	; C
	lda s_mode7+_m7sy			; low byte scale_y
	sta M7A
	
	lda s_mode7+_m7sy+1		; high byte scale_y
	sta M7A
	
	lda sincos.l,X	; sin(x)
	sta M7B
	
	ldy MPYM
	sty s_mode7+_m7c
	
	; Calculate A and D (cos's)
	; A
	lda s_mode7+_m7sx
	sta M7A
	
	lda s_mode7+_m7sx + 1
	sta M7A
	
	lda sincos.l + $40,X	; Cos (x)
	sta M7B
	
	ldy MPYM
	sty s_mode7+_m7a
	
	; D
	lda s_mode7+_m7sy
	sta M7A
	
	lda s_mode7+_m7sy+1
	sta M7A
	
	lda sincos.l + $40,X	; Cos (x)
	sta M7B
	
	ldy MPYM
	sty s_mode7+_m7d
	
	
	
	
	; Store results as Matrix Parameters
	lda s_mode7+_m7a
	sta M7A
	
	lda s_mode7+_m7a+1
	sta M7A
	
	lda s_mode7+_m7b
	sta M7B
	
	lda s_mode7+_m7b+1
	sta M7B
	
	lda s_mode7+_m7c
	sta M7C
	
	lda s_mode7+_m7c+1
	sta M7C
	
	lda s_mode7+_m7d
	sta M7D
	
	lda s_mode7+_m7d+1
	sta M7D
	
	
	
	
	lda s_mode7+_m7x
	sta M7X
	
	lda s_mode7+_m7x+1
	sta M7X
	
	lda s_mode7+_m7y
	sta M7Y
	
	lda s_mode7+_m7y+1
	sta M7Y 
	
	
	rtl
	
	
IRQ:
Timer:
	
	;sei
	phd
	rep #$20
	pha
    phx
    phy
    sep #$20
	
	
	lda TIMEUP
	
	lda LKS_VBLANK
	cmp #$1
	bne +
		SNES_BGMODE $07
		SNES_TM $11
		
	+:
	

	rep #$20
	ply
	plx
	pla
	sep #$20
	
	
	pld
	
	rti

	



