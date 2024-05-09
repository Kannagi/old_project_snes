
.DEFINE SPCRAM $200

.DEFINE LKS_SPC_VOLUME  $10
.DEFINE LKS_SPC_PLAY  	$12
.DEFINE LKS_SPC_ADDR	$14
.DEFINE LKS_SPC_DATA	$16

.DEFINE LKS_SPC_RDATA	$18
.DEFINE LKS_SPC_TICKS   $1A
.DEFINE LKS_SPC_DEBUG   $1C
.DEFINE LKS_SPC_RADDR	$1E


.DEFINE LKS_SPC_BRR_VOLUME		$20
.DEFINE LKS_SPC_BRR_PLAY		$22
.DEFINE LKS_SPC_BRR_PLAY_TEST 	$24
.DEFINE LKS_SPC_BRR_PLAY8		$26
.DEFINE LKS_SPC_BRR_PLAY7		$28

;-----------------
.DEFINE LKS_SPC_OFF 	$FF
.DEFINE LKS_SPC_ON 	$01
.DEFINE LKS_SPC_LOOP  	$02

;-----------------

.DEFINE LKS_SPC_SPLDIR $1100
.DEFINE LKS_SPC_SFXDIR $1180
.DEFINE LKS_SPC_SMXDIR $1200
.DEFINE LKS_SPC_HEADER $1280
.DEFINE LKS_SPC_TRACK  $1340 ;size $2D00
.DEFINE LKS_SPC_SAMPLE $4000
.DEFINE LKS_SPC_SFX1   $8000
.DEFINE LKS_SPC_SFX2   $8800
.DEFINE LKS_SPC_SFX3   $9000
.DEFINE LKS_SPC_SFX4   $9800
.DEFINE LKS_SPC_SFX5   $A000
.DEFINE LKS_SPC_SFX6   $A800
.DEFINE LKS_SPC_SFX7   $B000
;----------------------


.MACRO LKS_SPC_WAIT
	lda LKS_SPC_VAR
	sta APUIO0
	-:
		cmp APUIO0
	beq -
	stz APUIO1
	lda APUIO0
	sta LKS_SPC_VAR
	
.ENDM

;----------------------
.MACRO LKS_SPC_Get

	lda #\1
	sta APUIO1
	
	jsr LKS_SPC_Wait
.ENDM


.MACRO LKS_SPC_Set

	lda #\2
	sta APUIO2
	
	lda #\3
	sta APUIO3
	
	lda #\1
	sta APUIO1
	
	jsr LKS_SPC_Wait
.ENDM

.MACRO LKS_SPC_Set1

	lda #\1
	sta APUIO1
	
	jsr LKS_SPC_Wait
.ENDM

.MACRO LKS_SPC_Set2

	ldx #\2
	stx APUIO2
	
	lda #\1
	sta APUIO1
	
	jsr LKS_SPC_Wait
.ENDM




.MACRO LKS_SPC_SetD

	lda LKS_SPC_VAR
	tay
	ldx #0
	--:
		lda #LKS_SPC_DATA
		sta APUIO1
		
		rep #$20
		lda.l \1,x
		sta APUIO2
		sep #$20
		
		;lda.l \1+1,x
		;sta APUIO3
		
		tya
		sta APUIO0

		inx
		inx
		iny

		-:
			cmp APUIO0
		beq -
		stz APUIO1
		
		;jsr LKS_SPC_SetD1
		
		cpx #\2
	bcc --
	
	jsr LKS_SPC_SetD2
	
.ENDM


;----------------------

.MACRO SPC_Procedure 

	rep #$30                       ; (16-bit A and X Y)
	lda #$BBAA
	-:   
		cmp APUIO0
	bne -

	; Initialize transfer ---------
	LDA #\1                  ; Send starting address
	STA APUIO2

	lda #$1CC
	sta APUIO0                     ; Write $CC to 2140 and !0 to 2141
	sep #$20                       ; (8-bit A)
	-:	
		cmp APUIO0                      ; Wait for SPC700 to give the go
	bne -

	; Send data -------------------
	ldx #0                          ; X indexes the current byte being sent
	ldy #$F80                   	; Y = Number of bytes that need to be sent
	--:	
		lda.l \2,X                  ; Send byte
		sta APUIO1
		txa
		sta APUIO0
		-:	
			cmp APUIO0                      ; Wait for transfer
		bne -
		inx
		dey
	bne --

	; Begin execution -------------
	rep #$20                  ; (16-bit A)
	lda #\1                   ; Starting address of execution
	sta APUIO2

	sep #$20                       ; (8-bit A)
	lda #0                         ; JMP to execution address
	sta APUIO1

	lda APUIO0                      ; Break transfer cycle
	adc #2
	sta APUIO0
	
.ENDM
        
