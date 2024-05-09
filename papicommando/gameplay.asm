

Gameplay:
	
	lda LKS_BULLET.i
	ina
	sta LKS_BULLET.i
	
	lda LKS_SPRITE.Anim_act
	cmp #20
	bne +
		ldx #0
		stx LKS_SPRITE.VY
		stx LKS_SPRITE.VX
		
		lda #6
		sta LKS_SPRITE.Anim_n
		lda #2
		sta LKS_SPRITE.Anim_type
		
		lda LKS_SPRITE.Anim_i
		cmp #5
		bne ++
			stz LKS_SPRITE.Anim_l
			lda LKS_STDCTRL+_SELECT
			cmp #1
			bne ++
				lda #4
				sta LKS_SPRITE.Anim_n
				lda #0
				sta LKS_SPRITE.Anim_type
				sta LKS_SPRITE.Anim_act
				
				lda #10
				sta SCharacter.hp
				
				lda #0
				sta SCharacter.direction
				sta SCharacter.oldanim

		++:
		
		ldx #0
		stx LKS_SPRITE.VY
		stx LKS_SPRITE.VX
		rts
	+:
	
	
	
	lda #1
	sta MEM_TEMP
	
	ldx #0
	ldy #0
	
	lda LKS_STDCTRL+_UP
	cmp #2
	bne +
		ldx #-$04-2
		
		lda #1
		sta SCharacter.direction
		
		lda #2*2
		sta MEM_TEMP
	+:
	
	lda LKS_STDCTRL+_DOWN
	cmp #2
	bne +
		ldx #$04+2
		
		lda #0
		sta SCharacter.direction
		
		lda #2*0
		sta MEM_TEMP
		
		
	+:
	
	lda LKS_STDCTRL+_LEFT
	cmp #2
	bne +
		ldy #-$04-2
		
		lda #2
		sta SCharacter.direction
		
		lda #2*1
		sta MEM_TEMP
		
		lda LKS_SPRITE.Flip
		and #$3F
		sta LKS_SPRITE.Flip
		
		
		lda LKS_STDCTRL+_DOWN
		cmp #2
		bne ++
			lda #2*3
			sta MEM_TEMP
			
			lda SCharacter.direction
			clc
			adc #4
			sta SCharacter.direction
		++:
		
		lda LKS_STDCTRL+_UP
		cmp #2
		bne ++
			lda #2*4
			sta MEM_TEMP
			
			lda SCharacter.direction
			clc
			adc #5
			sta SCharacter.direction
		++:
	+:
	
	
	lda LKS_STDCTRL+_RIGHT
	cmp #2
	bne +
		ldy #$04+2
		
		lda #3
		sta SCharacter.direction
		
		lda #2*1
		sta MEM_TEMP
		
		lda LKS_SPRITE.Flip
		ora #$40
		sta LKS_SPRITE.Flip
		
		lda LKS_STDCTRL+_DOWN
		cmp #2
		bne ++
			lda #2*3
			sta MEM_TEMP
			
			inc SCharacter.direction
		++:
		
		lda LKS_STDCTRL+_UP
		cmp #2
		bne ++
			lda #2*4
			sta MEM_TEMP
			
			inc SCharacter.direction
			inc SCharacter.direction
		++:
	+:
	
	stx LKS_SPRITE.VY
	sty LKS_SPRITE.VX
	
	phy
	ldy #0
	lda MEM_TEMP
	cmp #1
	beq +
		sta LKS_SPRITE.Anim_act,y
		sta SCharacter.oldanim
	+:
	ply
	
	
	cpx #0
	bne +
		cpy #0
		bne +
		
		lda LKS_SPRITE.Anim_act
		cmp #0
		bne ++
			
			lda #2*5
			sta LKS_SPRITE.Anim_act
			bra +
		++:
		cmp #2
		bne ++
			
			lda #2*6
			sta LKS_SPRITE.Anim_act
			bra +
		++:
		cmp #4
		bne ++
			
			lda #2*7
			sta LKS_SPRITE.Anim_act
			bra +
		++:
		
		cmp #6
		bne ++
			
			lda #2*8
			sta LKS_SPRITE.Anim_act
			bra +
		++:
		
		cmp #8
		bne ++
			
			lda #2*9
			sta LKS_SPRITE.Anim_act
			bra +
		++:
	+:
		
	;tir
	lda LKS_STDCTRL+_A
	cmp #2
	bne +
		jsr Gameplay_Tir
		
		lda LKS_BULLET.i
		cmp LKS_BULLET.n
		bcc +
		
		LKS_BULLET_FIRE_INIT 7
		
		lda #0
		sta MEM_TEMP+6
		lda #4
		sta MEM_TEMP+7
		
		lda SCharacter.direction
		sta MEM_TEMP+4
		stz MEM_TEMP+5
		
		ldy #0
		jsr bullet_init_direction
		jsr bullet_init_pos
		jsr bullet_init_speed

	+:
		
	rts
	
Gameplay_Tir:
	lda LKS_SPRITE.Anim_act
	cmp #2*5
	bne ++
		
		lda #0
		sta LKS_SPRITE.Anim_act
		
		bra +
	++:
	
	cmp #2*6
	bne ++
		
		lda #2
		sta LKS_SPRITE.Anim_act
		bra +
	++:
	cmp #2*7
	bne ++
		
		lda #4
		sta LKS_SPRITE.Anim_act
		bra +
	++:
	
	cmp #2*8
	bne ++
		
		lda #6
		sta LKS_SPRITE.Anim_act
		bra +
	++:
	
	cmp #2*9
	bne ++
		
		lda #8
		sta LKS_SPRITE.Anim_act
		bra +
	++:
	rts
	+:
	lda #0
	sta LKS_SPRITE.Anim_i

	rts

