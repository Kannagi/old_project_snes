.MACRO PortDMA 


	ldx #\1
    stx MEM_TEMPFUNC
    ldy #\2*$06
    jsr Port_DMA0a


.ENDM

.MACRO PortDMA1 


	ldx #\1
    stx MEM_TEMPFUNC
    ldy #\2*$06
    jsr Port_DMA1


.ENDM

.MACRO PortDMA2


	
    ldy #\1*$06
    jsr Port_DMA2


.ENDM

	
	
Port_DMA_Menu:

	lda s_menu+_rdraw
	cmp #0
	bne +
		rts
	+:
	
	lda s_menu+_ringdma
	cmp #0
	bne +
		rts
	+:
	stz s_menu+_ringdma
	
	
	lda s_menu+_ringload
	cmp #0
	bne +
		SNES_VMADD $7A00
    
		SNES_DMA0_ADD invocation $400
		
		SNES_MDMAEN $01
	+:
	lda s_menu+_ringload
	cmp #1
	bne +
	/*
		SNES_VMADD $7A00
    
		SNES_DMA0_ADD roption $400
		
		SNES_MDMAEN $01
		*/
	+:
	lda s_menu+_ringload
	cmp #2
	bne +
		SNES_VMADD $7A00
    
		SNES_DMA0_ADD ritem1 $C0
		SNES_DMA1_ADD ritem2 $C0
		SNES_DMA2_ADD ritem3 $80
		
		SNES_MDMAEN $07
		
		SNES_VMADD $7B00
    
		SNES_DMA_ADDM ritem1,$C0,0,$C0
		SNES_DMA_ADDM ritem2,$C0,1,$C0
		SNES_DMA_ADDM ritem3,$80,2,$C0
		
		SNES_MDMAEN $07
	+:

	rts
	
	

	
Port_DMA0:

	lda MEM_DMAT
	cmp #$80
	bmi +
		rts
	+:
	lda LKS_DMA+_dmaEnable,x
	cmp #0
	bne +
		rts
	+:
	
	
		
	lda #0
	sta LKS_DMA+_dmaEnable,x

	lda LKS_DMA+_dmaBank,x
	sta MEM_TEMP
	stz MEM_TEMP+1
	
	
    
	rep #$20
    
    
    lda LKS_DMA+_dmaDst1,x
	sta MEM_TEMPFUNC
	
	
	lda LKS_DMA+_dmaSrc1,x
    sta MEM_TEMP+2
    clc
    
    ldx MEM_TEMP
    ldy #$0080
    
    ;--------------
    ;lda #$6000
    lda MEM_TEMPFUNC
    sta VMADDL
    
    lda MEM_TEMP+2
    
    
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    adc #$400
    
    stx DMA_BANK+$10
    sta DMA_ADDL+$10
    sty DMA_SIZEL+$10
    
    SNES_MDMAEN $03
   
    ;--------------
    lda MEM_TEMPFUNC
    adc #$100
    sta VMADDL
    
    lda MEM_TEMP+2
    adc #$200
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    adc #$400
    
    stx DMA_BANK+$10
    sta DMA_ADDL+$10
    sty DMA_SIZEL+$10
    
    SNES_MDMAEN $03
    
    sep #$20
    
    lda MEM_DMAT
    adc #$20
    sta MEM_DMAT
    
    rts



Port_DMA0a:

	lda MEM_DMAT
	cmp #$80
	bmi +
		rts
	+:
	
	lda MEM_DMA,y
	cmp #1
	beq +
		rts
	+:
		
	lda #0
	sta MEM_DMA,y

	lda MEM_DMA+_badress,y
	sta MEM_TEMP
	stz MEM_TEMP+1
    
	rep #$20
    
    lda MEM_DMA+_sadress,y
    sta MEM_TEMP+2
    clc
    
    ldx MEM_TEMP
    ldy #$0080
    
    ;--------------
    ;lda #$6000
    lda MEM_TEMPFUNC
    sta VMADDL
    
    lda MEM_TEMP+2
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    adc #$400
    
    stx DMA_BANK+$10
    sta DMA_ADDL+$10
    sty DMA_SIZEL+$10
    
    SNES_MDMAEN $03
    
    ;--------------
    lda MEM_TEMPFUNC
    adc #$100
    sta VMADDL
    
    lda MEM_TEMP+2
    adc #$200
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    adc #$400
    
    stx DMA_BANK+$10
    sta DMA_ADDL+$10
    sty DMA_SIZEL+$10
    
    SNES_MDMAEN $03
    
    sep #$20
    
    lda MEM_DMAT
    adc #$20
    sta MEM_DMAT
    
    rts
    

Port_DMA1:

	lda MEM_DMAT
	cmp #$80
	bmi +
		rts
	+:
	
	lda MEM_DMA,y
	cmp #1
	beq +
		rts
	+:
	
	lda #0
	sta MEM_TEMP+4
	-:
	
	lda #0
	sta MEM_DMA,y
	
	lda MEM_DMA+_badress,y
	sta MEM_TEMP
	stz MEM_TEMP+1
	
	
	rep #$20
	
	lda MEM_DMA+_adress,y
    sta MEM_TEMP+2
	
	lda MEM_TEMPFUNC
    sta VMADDL
    
    ;---------
    phy
    
    lda MEM_TEMP+2
    ldx MEM_TEMP
    ldy #$0020
    
    
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    SNES_MDMAEN $01
    
    lda MEM_TEMPFUNC
    clc
    adc #$100
    sta VMADDL
    
    lda MEM_TEMP+2
    adc #$200
    
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL
    
    SNES_MDMAEN $01
    
    ply
    
    tya
    clc
    adc #6
    tay
    
    lda #0
    sta MEM_TEMP+8
    
    lda MEM_TEMPFUNC
    and #$00FF
    cmp #$E0
    bne +
		lda #$100
		sta MEM_TEMP+8
    +:
    
    lda MEM_TEMPFUNC
    clc
    adc #$20
    adc MEM_TEMP+8
    sta MEM_TEMPFUNC
    
    sep #$20
    
    
    
    inc MEM_TEMP+4
    lda MEM_TEMP+4
    cmp #3
    bne -
    
    
    
    lda MEM_DMAT
    adc #$20
    sta MEM_DMAT	
	
	
    
    rts
    
Port_DMA2:

	lda MEM_DMAT
	cmp #$80
	bmi +
		rts
	+:
	
	lda MEM_DMA,y
	cmp #1
	beq +
		rts
	+:
		
	lda #0
	sta MEM_DMA,y

	lda MEM_DMA+_badress,y
	sta MEM_TEMP
	stz MEM_TEMP+1
    
	rep #$20
	
	lda MEM_DMA+_sadress,y
	sta MEM_TEMP+4
    
    lda MEM_DMA+_adress,y
    sta MEM_TEMP+2
    clc
    
    ldx MEM_TEMP
    ldy #$0080
    
    ;--------------
    
    
    lda MEM_TEMP+2    
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    adc MEM_TEMP+4
    
    stx DMA_BANK+$10
    sta DMA_ADDL+$10
    sty DMA_SIZEL+$10
    
    adc MEM_TEMP+4
    
    stx DMA_BANK+$20
    sta DMA_ADDL+$20
    sty DMA_SIZEL+$20
    
    adc MEM_TEMP+4
    
    stx DMA_BANK+$30
    sta DMA_ADDL+$30
    sty DMA_SIZEL+$30
    
    lda s_effect+_efvadd
    sta VMADDL
    SNES_MDMAEN $01
    
    lda s_effect+_efvadd
    adc #$100
    sta VMADDL
    SNES_MDMAEN $02
    
    lda s_effect+_efvadd
    adc #$200
    sta VMADDL
    SNES_MDMAEN $04
    
    lda s_effect+_efvadd
    adc #$300
    sta VMADDL
    SNES_MDMAEN $08
    

    
    sep #$20
    
    lda MEM_DMAT
    adc #$2
    sta MEM_DMAT
    
    rts
    
    
    
.MACRO LKS_DMA_VRAM2


	lda MEM_DMAT
	bit #$80
	bne +
	
	lda LKS_DMA+_dmaEnable+$16*\1
	cmp #0
	beq +
	
		
		ldx #$16*\1
		
		
		jsr LPort_DMA1
		
		
		
		
		lda #0
		sta LKS_DMA+_dmaEnable+$16*\1
	
	+:
	
	
	
.ENDM

LPort_DMA1:

	
	lda LKS_DMA+_dmaBank,x
	sta MEM_TEMP
	stz MEM_TEMP+1
	
	
	lda #0
	sta MEM_TEMP+4
	
	ldy #$0020
	
	-:

	rep #$20
	
	lda LKS_DMA+_dmaSrc1,x
    sta MEM_TEMP+2
	
	lda LKS_DMA+_dmaDst1,x
	sta MEM_TEMPFUNC
    sta VMADDL
    
    ;---------
    phx
    
    lda MEM_TEMP+2
    ldx MEM_TEMP
    
    
    
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    SNES_MDMAEN $01
    
    lda MEM_TEMPFUNC
    clc
    adc #$100
    sta VMADDL
    
    lda MEM_TEMP+2
    adc #$200
    
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL
    
    SNES_MDMAEN $01
    
    plx
    
    txa
    clc
    adc #6
    tax
    
    
    
   
    
    sep #$20
    
    
    
    inc MEM_TEMP+4
    lda MEM_TEMP+4
    cmp #3
    bne -
    
    
    
    lda MEM_DMAT
    adc #$20
    sta MEM_DMAT	
	
	
    
    rts


.MACRO LKS_DMA_VRAM20


	lda MEM_DMAT
	bit #$80
	bne +
	
	lda LKS_DMA+_dmaEnable+$16*\1
	cmp #0
	beq +
	
		
		ldx #$16*\1
		stx MEM_TEMP+2
		
		ldx #LPort_DMA10
		stx 0
		ldx #0
		jsr (0,x)
		
		
		
		lda #0
		sta LKS_DMA+_dmaEnable+$16*\1
	
	+:
	
	
	
.ENDM

LPort_DMA10:

	ldx MEM_TEMP+2
	

	lda LKS_DMA+_dmaBank,x
	sta MEM_TEMP
	stz MEM_TEMP+1
	
	
    
	rep #$20
    
    
    lda LKS_DMA+_dmaDst1,x
	sta MEM_TEMPFUNC
	
	
	lda LKS_DMA+_dmaSrc1,x
    sta MEM_TEMP+2
    
    lda LKS_DMA+_dmaSrcR,x
    sta MEM_TEMP+4
    
    
    clc
    
    ldx MEM_TEMP
    ldy #$0040*2
    
    ;--------------
    ;lda #$6000
    lda MEM_TEMPFUNC
    sta VMADDL
    
    lda MEM_TEMP+2
    
    
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    adc MEM_TEMP+4
    adc MEM_TEMP+4
    
    stx DMA_BANK+$10
    sta DMA_ADDL+$10
    sty DMA_SIZEL+$10
    
    SNES_MDMAEN $03
   
    ;--------------
    lda MEM_TEMPFUNC
    adc #$100
    sta VMADDL
    
    lda MEM_TEMP+2
    adc MEM_TEMP+4
    stx DMA_BANK
    sta DMA_ADDL
    sty DMA_SIZEL 
    
    adc MEM_TEMP+4
    adc MEM_TEMP+4
    
    stx DMA_BANK+$10
    sta DMA_ADDL+$10
    sty DMA_SIZEL+$10
    
    SNES_MDMAEN $03
    
    sep #$20
    
    lda MEM_DMAT
    adc #$20
    sta MEM_DMAT
    
    rts
    
