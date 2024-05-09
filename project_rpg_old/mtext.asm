

.MACRO texte1 ARGS _px,_py ;text : test 123
    
    SNES_VMADD $5800 + (_px + _py*32)
    
    
	SNES_VMDATA $2034
	SNES_VMDATA $2025
	SNES_VMDATA $2033
	SNES_VMDATA $2034
	SNES_VMDATA $0000
	SNES_VMDATA $2011
	SNES_VMDATA $2012
	SNES_VMDATA $2013
	
	
.ENDM

.MACRO textec ARGS _px,_py,_val

	SNES_VMADD $5800 + (_px + _py*32)
	SNES_VMDATA _val
.ENDM

.MACRO printfs ARGS _px,_py
	SNES_VMADD $5800 + (_px + _py*32)

	-:
		lda $0000,x
		clc
		sbc #63
		sta VMDATAL

		lda #$20
		sta VMDATAH
		
		inx
		
		lda $0000,x
		cmp #0
	bne -
	
.ENDM

.MACRO printf ARGS _px,_py
	
	SNES_VMADD $5800 + (_px + _py*32)
	SNES_VMDATA $0000
	SNES_VMDATA $0000
	SNES_VMDATA $0000
	SNES_VMDATA $0000

	SNES_VMADD $5800 + (_px + _py*32)
	cmp #0
	bpl +
		eor #$FF
		SNES_VMDATA $200D	
	+:

	ldx #0

	cmp #10
	bmi +
		-:			
			sbc #10
			inx

			cmp	#10
		bpl -		
	+:
	
	
	pha
	
	txa
	ldx #0
	
	cmp #0
	beq +
	
		cmp #10
		bmi ++
-	
			sbc #10
			inx

			cmp #10
			bpl -
	
++

	cpx #0
	beq +++
		pha
		txa
		clc
		adc #$10
		
		sta $2118
		lda #$20
		sta $2119
		
		
		pla
+++
	
	clc
	adc #$10
	
	sta $2118
	lda #$20
	sta $2119
+
	
	pla
	
	

	clc
	adc #$10
	
	sta $2118
	lda #$20
	sta $2119

.ENDM



.MACRO compute_all_digit_for_16_bit_A
; input[register A in 16bits] to be displayed at position _screen(x,y)
; [/!\ WARNING/!\]
;     [1] register A must be in 16bits mode
;     [2] "lda" must be the last instruction before this macro is used

	stz MEM_TEMP + 6
	cmp #0
	bpl +	
		; si A est positif tout il est bon
		; sinon, on inverse son signe
		; [todo] garder le signe pour plus tard
		dea
		eor #$ffff
		
		pha
		lda #1
		sta MEM_TEMP + 6
		pla
	+:
	
	compute_digit_for_base 10000
	stx MEM_TEMP
	compute_digit_for_base  1000
	stx MEM_TEMP + 1
	compute_digit_for_base   100
	stx MEM_TEMP + 2
	compute_digit_for_base    10
	stx MEM_TEMP + 3
	sta MEM_TEMP + 4
.ENDM


.MACRO print_16_bit_integer
	; [note] il est important de passer en mode 16 bits pour A avant l'affectation ! (le lda)
	; [optimize] /!\ ATTENTION /!\ cette fonction est largement sous optimal car elle passe A en 16 bits puis en 8 bits de nouveau juste pour un seul nombre !... à optimiser, ou pas hahahah
	
	rep #$20
	tya
	compute_all_digit_for_16_bit_A
	sep #$20
	print_every_digit \1,\2
.ENDM

.MACRO print_every_digit ARGS _px,_py
	; On affiche ici les 5 chiffres précédemment converti par "compute_all_digit_for_16_bit_A"
	; et qui sont stocké dans s_digit (et jusqu'à s_digit + 4 inclus)
	; [optimize] Ce code est très sous-optimal car j'utilise bêtement, pour gagner du temps, la fonction qui affiche un nombre sur 8 bits... alors que les chiffres sont déjà dispo, il suffirait juste de les afficher un par un (inutile de refaire des calculs à la "con")
	
	
	;Pour envoyer dans la VRAM
	SNES_VMADD $5800 + (_px + _py*32) ;Adresse pour le BG3 DATA (text)
	;clean
	ldx #0
	stx VMDATAL
	stx VMDATAL
	stx VMDATAL
	stx VMDATAL
	stx VMDATAL
	stx VMDATAL
	
	SNES_VMADD $5800 + (_px + _py*32)
	lda MEM_TEMP + 6
	cmp #0
	beq +
		SNES_VMDATA $200D ;signe -
	+:
	
	clc
	lda MEM_TEMP
	adc #$10
	sta VMDATAL
	lda #$20
	sta VMDATAH
	
	lda MEM_TEMP + 1
	adc #$10
	sta VMDATAL
	lda #$20
	sta VMDATAH
	
	lda MEM_TEMP + 2
	adc #$10
	sta VMDATAL
	lda #$20
	sta VMDATAH
	
	lda MEM_TEMP + 3
	adc #$10
	sta VMDATAL
	lda #$20
	sta VMDATAH
	
	lda MEM_TEMP + 4
	adc #$10
	sta VMDATAL
	lda #$20
	sta VMDATAH
	
.ENDM

.MACRO compute_digit_for_base ARGS _base
	; [input] registre A sur 16 bits qui contient le nombre dans la bonne tranche par rapport à _base
	;     Autrement dit, _base <= A < (10 * _base)
	; [output]
	;     [X] le registre X contient le chiffre pour la _base
	;     [A] contient le reste (module _base) ==> donc 0 <= A < _base
	;
	; _base vaut une puissance non nul de 10
	; On détermine les chiffres les uns après les autres depuis le plus grand avec _base = 10000
	; Puis ainsi de suite avec _base = 1000, _base = 100 et enfin _base = 10
	; Les uns, après les autres, on obtient alors les 5 chiffres qui compose le nombre sur 16 bits.
 	
 	.IF _base != 10000
 	cmp #5 * _base
	bmi +
		ldx #5
		sec
		sbc #5 * _base
		bra ++
	+:
 		ldx #0
	++:
	.ELSE
	ldx #0
	.ENDIF
	
 	-:
	cmp #_base
	bmi +
		inx
		sec
		sbc #_base
		bra -
	+:
	
	
.ENDM
