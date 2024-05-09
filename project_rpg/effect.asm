
.MACRO set_draw_OAMe
	
	rep #$20
	
	lda MEM_TEMPFUNC+6
	clc
	adc #\3
	sta LKS_OAM+_sprx
	
	lda MEM_TEMPFUNC+8
	clc
	adc #\4
	sta LKS_OAM+_spry
	
	sep #$20
	
	lda #\1
	clc
	adc MEM_TEMPFUNC+10
	sta LKS_OAM+_sprtile
	
	lda #\2+$3E
	clc
	adc MEM_TEMPFUNC+11
	sta LKS_OAM+_sprext
	
	lda #$10
	sta LKS_OAM+_sprsz
	
	jsl LKS_OAM_Draw
	
.ENDM

.MACRO set_draw_OAMeg

	rep #$20
	
	lda MEM_TEMPFUNC+6
	clc
	adc #\3
	sta LKS_OAM+_sprx
	
	lda MEM_TEMPFUNC+8
	clc
	adc #\4
	sta LKS_OAM+_spry
	
	sep #$20
	
	lda #\1
	clc
	adc MEM_TEMPFUNC+10
	sta LKS_OAM+_sprtile
	
	lda #\2+$3E
	clc
	adc MEM_TEMPFUNC+11
	sta LKS_OAM+_sprext
	
	lda #$21
	sta LKS_OAM+_sprsz
	
	jsl LKS_OAM_Draw
	
	
.ENDM

Effect_init_all:

	
	stz MEM_TEMP
	
	ldx s_effect+_efnsel1
	lda s_perso+_etat,x
	cmp #0
	bne ++
	
		stx s_effect+_efsel1
		lda #1
		sta s_perso+_cstop,x
		
		lda s_perso+_direction,x
		sta s_perso+_gdirection,x

		lda #4
		sta s_perso+_etat,x
		inc MEM_TEMP
		
	++:
	
	ldx s_effect+_efnsel2
	lda s_perso+_etat,x
	cmp #0
	bne ++
	
		stx s_effect+_efsel2
		lda #1
		sta s_perso+_cstop,x
		
		lda s_perso+_direction,x
		sta s_perso+_gdirection,x

		lda #4
		sta s_perso+_etat,x
		inc MEM_TEMP
		
	++:
		
	ldx s_effect+_efnsel3
	lda s_perso+_etat,x
	cmp #0
	bne ++
	
		stx s_effect+_efsel3
		lda #1
		sta s_perso+_cstop,x
		
		lda s_perso+_direction,x
		sta s_perso+_gdirection,x

		lda #4
		sta s_perso+_etat,x
		inc MEM_TEMP
		
	++:
	
		
	lda MEM_TEMP
	cmp #0
	beq +
	
		lda #$FF
		sta s_effect+_efinit
		
		inc s_effect+_eftm
		inc s_effect+_efenable
		
		stz s_effect+_efphase
		stz s_effect+_efpali
		stz s_effect+_efpall
		stz s_effect+_efend
		
		lda #2
		sta s_palette+_pltype
		rts
	+:
	

	rts

Effect:
	
	lda s_menu+_rdraw
	cmp #0
	beq +
		rts
	+:
	
	lda s_map+_mode
	cmp #0
	bne +
		rts
	+:
	
	
	lda s_effect+_efinit
	cmp #1
	bne +
		
		
		ldx s_effect+_efnsel1
		
		lda s_perso+_etat,x
		cmp #4
		beq +
		stx s_effect+_efsel1
		
		lda #1
		sta s_perso+_cstop,x
		
		lda s_perso+_direction,x
		sta s_perso+_gdirection,x

		lda #4
		sta s_perso+_etat,x
		
		
		inc s_effect+_eftm
		inc s_effect+_efenable
		
		stz s_effect+_efphase
		stz s_effect+_efpali
		stz s_effect+_efpall
		stz s_effect+_efend
		
		lda #2
		sta s_palette+_pltype
		
		lda #$FF
		sta s_effect+_efinit
	+:
	
	
	lda s_effect+_efinit
	cmp #2
	bne +
		jsr Effect_init_all
	+:
	
	
	
	lda s_effect+_efenable
	cmp #0
	bne +
		rts
	+:

	
	
	lda s_effect+_eftm
	cmp #$B0
	bne +
		jsr Effect_end
		
		rts
	+:
	
	jsr Effect_type
	
	lda #0
	sta MEM_TEMPFUNC+10
	
	lda #1
	sta MEM_TEMPFUNC+11
	
	phx
	ldx #0
	jsr (s_effect+_eftypeadd1,x)
	plx
	
	stz MEM_TEMP+10
	ldy #$54
	ldx s_effect+_efsel1
	cpx #-1
	beq +
		stx MEM_TEMPFUNC
		phx
		ldx #0
		jsr (s_effect+_eftypeadd2,x)
		plx
		jsr Effect_choix_pal
	+:
	
	
	ldy #$70
	ldx s_effect+_efsel2
	cpx #-1
	beq +
		stx MEM_TEMPFUNC
		phx
		ldx #0
		jsr (s_effect+_eftypeadd2,x)
		plx
		jsr Effect_choix_pal
	+:
	
	ldy #$8C
	ldx s_effect+_efsel3
	cpx #-1
	beq +
		stx MEM_TEMPFUNC
		phx
		ldx #0
		jsr (s_effect+_eftypeadd2,x)
		plx
		jsr Effect_choix_pal
	+:
	
	
	rep #$20
	
	lda s_effect+_efpal
	sta MEM_TEMP
	
	sep #$20
	
	lda s_effect+_efpal+2
	sta MEM_TEMP+2
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$1E0,0
	SNES_DMA_ADD MEM_TEMP,$16,0
	SNES_MDMAEN $01
	
	
	
	lda s_effect+_efpalen
	cmp #0
	bne +
		rts
	+:
	
	
	
	
	;palette ch
	rep #$20
	
	lda s_effect+_efpali
	and #$00FF
	clc
	adc s_effect+_efpal2
	sta MEM_TEMP
	
	sep #$20
	
	lda s_effect+_efpal+2
	sta MEM_TEMP+2
	
	SNES_DMA_ADD MEM_TEMP,$20,0
	SNES_DMA_ADD MEM_TEMP,$20,1
	SNES_DMA_ADD MEM_TEMP,$20,2
	
	SNES_DMA_ADD MEM_TEMP,$20,4
	SNES_DMA_ADD MEM_TEMP,$20,5
	SNES_DMA_ADD MEM_TEMP,$20,6
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$160,0	
	lda MEM_TEMP+10
	and #$01
	sta MDMAEN
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$180,0	
	lda MEM_TEMP+10
	and #$02
	sta MDMAEN
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$1A0,0	
	lda MEM_TEMP+10
	and #$04
	sta MDMAEN
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$100,0	
	lda MEM_TEMP+10
	and #$10
	sta MDMAEN
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$120,0	
	lda MEM_TEMP+10
	and #$20
	sta MDMAEN
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$140,0	
	lda MEM_TEMP+10
	and #$40
	sta MDMAEN
	
    
    jsr Effect_animpal
    

	rts
	
Effect_choix_pal:
	
	lda s_perso+_flip,x
	and #$0E
	
	cmp #$00
	bne +
		lda MEM_TEMP+10
		ora #$10
		sta MEM_TEMP+10
		rts
	+:
	
	cmp #$02
	bne +
		lda MEM_TEMP+10
		ora #$20
		sta MEM_TEMP+10
		rts
	+:
	
	cmp #$04
	bne +
		lda MEM_TEMP+10
		ora #$40
		sta MEM_TEMP+10
		rts
	+:
	
	cmp #$06
	bne +
		lda MEM_TEMP+10
		ora #1
		sta MEM_TEMP+10
		rts
	+:
	
	cmp #$08
	bne +
		lda MEM_TEMP+10
		ora #2
		sta MEM_TEMP+10
		rts
	+:
	
	cmp #$0A
	bne +
		lda MEM_TEMP+10
		ora #4
		sta MEM_TEMP+10
		rts
	+:

	rts


	
Effect_end:
	stz s_effect+_eftm
	stz s_effect+_efenable
	stz s_effect+_efinit
	stz s_effect+_efdmai
	stz s_effect+_efi
	stz s_effect+_efl
	stz s_effect+_efend
	stz s_effect+_efphase
	stz s_effect+_efpalen
	
	ldx s_effect+_efsel1
	cpx #-1
	beq ++
		stz s_perso+_cstop,x
	
		rep #$20
		lda #876
		sta s_perso+_dgt,x
		sep #$20
	++:
	
	ldx s_effect+_efsel2
	cpx #-1
	beq ++
		stz s_perso+_cstop,x
	
		rep #$20
		lda #876
		sta s_perso+_dgt,x
		sep #$20
	++:
	
	ldx s_effect+_efsel3
	cpx #-1
	beq ++
		stz s_perso+_cstop,x
	
		rep #$20
		lda #876
		sta s_perso+_dgt,x
		sep #$20
	++:
	
	ldx #-1
	stx s_effect+_efsel1 
	stx s_effect+_efsel2 
	stx s_effect+_efsel3 
	
	
	SNES_WMADD LKS_BUF_PAL&$FFFF+$160,0

	SNES_DMA_ADD s_palette+_spl4,$20,0
	SNES_DMA_ADD s_palette+_spl5,$20,1
	SNES_DMA_ADD s_palette+_spl6,$20,2
	
	SNES_MDMAEN $07
	
	lda #2
	sta s_palette+_pltype
		
	rts


	
Effect_animpal:

	inc s_effect+_efpall
    lda s_effect+_efpall
    cmp #3
    bne +
		stz s_effect+_efpall
		inc s_effect+_efpali
		inc s_effect+_efpali
		
		lda #2
		sta s_palette+_pltype
	+:
	
	lda s_effect+_efpali
    cmp #$20
    bne +
		stz s_effect+_efpali
		stz s_effect+_efpall
	+:
	
	rts


Effect_type:

	lda s_effect+_eftype
	
	sta WRMPYA
	
	lda #5
	sta WRMPYB
	ora 0
	ora 0

	rep #$20
	
	lda RDMPYL
	clc
	adc #Effect_Nphase
	sta s_effect+_eftypeadd1
	
	lda RDMPYL
	clc
	adc #Effect_NDraw
	sta s_effect+_eftypeadd2
	
	sep #$20
	

	rts
	
Effect_Nphase:

	jsl Explosion_phase
	rts
	
	jsl Foudre_phase
	rts
	
	rts
	

Effect_NDraw:
	
	jsl Explosion
	rts
	
	jsl Foudre
	rts
	
	rts
	
	.include "effect_type.asm"
