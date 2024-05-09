

.define select $400
.define select2 $408
.define select3 $409
.define select3_A $40A
.define spitch $401
.define svolume $402
.define ssrcn $403
.define smvolume $404


LKS_load_font:

	;load font
	LKS_LOAD_VRAM $4000,$00,LKS_font,$600
	LKS_LOAD_CG $00,LKS_fontpal,$10
	rtl

 
SPC_test:
	
    jsl LKS_INIT
	LKS_Clear_VRAM
    jsl LKS_load_font
    
	
	lda #14/2
	
	lda #12*4
	sta spitch
	
	lda #$7F
	sta svolume
	
	lda #0
	sta ssrcn
	
	jsr music_load0
	;jsr sfx_load
	
	lda #3
	sta select
	
	lda #0
	sta select3
	
	
	LKS_SPC_Set LKS_SPC_VOLUME,$7F,$7F
	
	lda	RDNMI
	SNES_INIDISP $00 ;  brigtness 0
	SNES_NMITIMEN $81 ; Enable NMI , enable joypad
	wai
	SNES_INIDISP $0F
   

	Spc:
	
		jsl LKS_Joypad
		
		;control select
		lda LKS_STDCTRL+_UP
		cmp #1
		bne +
			dec select
		+:
		
		lda LKS_STDCTRL+_DOWN
		cmp #1
		bne +
			inc select
		+:
		
		lda select
		cmp #$FF
		bne +
			stz select
		+:
		
		
		lda select
		cmp #4
		bmi +
			stz select
		+:
		
		;control  option
		
		lda LKS_STDCTRL+_LEFT
		cmp #1
		bne +
			lda select
			cmp #0
			bne ++
				dec spitch
			++:
			cmp #1
			bne ++
				dec svolume
			++:
		+:
		
		lda LKS_STDCTRL+_RIGHT
		cmp #1
		bne +
			lda select
			cmp #0
			bne ++
				inc spitch
			++:
			cmp #1
			bne ++
				inc svolume
			++:
		+:
		
		lda LKS_STDCTRL+_LEFT
		cmp #1
		bne +
			lda select
			cmp #2
			bne ++
				dec ssrcn
			++:
			cmp #3
			bne ++
				dec select2
			++:
		+:
		
		lda LKS_STDCTRL+_RIGHT
		cmp #1
		bne +
			lda select
			cmp #2
			bne ++
				inc ssrcn
			++:
			
			cmp #3
			bne ++
				inc select2
			++:
		+:
		
		lda select2
		cmp #$FF
		bne +
			stz select2
		+:
		
		
		lda select2
		cmp #3
		bmi +
			stz select2
		+:
		
		;change music
		stz select3_A
		
		lda LKS_STDCTRL+_L
		cmp #1
		bne +
			inc select3_A
			dec select3
		+:
		
		lda LKS_STDCTRL+_R
		cmp #1
		bne +
			inc select3_A
			inc select3
		+:
		
		lda select3
		cmp #$FF
		bne +
			stz select3
		+:
		
		lda select3
		cmp #6
		bmi +
			stz select3
		+:
		
		
		lda select3_A
		cmp #0
		beq +++
		LKS_SPC_Set LKS_SPC_PLAY,LKS_SPC_OFF,0
		
		
		lda select3
		cmp #0
		bne +
			jsr music_load0
			bra ++
		+:
		cmp #1
		bne +
			jsr music_load1
			bra ++
		+:
		cmp #2
		bne +
			jsr music_load2
			bra ++
		+:
		
		cmp #3
		bne +
			jsr music_load3
			bra ++
		+:
		
		cmp #4
		bne +
			jsr music_load4
			bra ++
		+:
		cmp #5
		bne +
			jsr music_load5
			bra ++
		+:
			
		++:
		LKS_SPC_Set LKS_SPC_PLAY,LKS_SPC_LOOP,0
		+++:
		
		;SPC700
		
		lda svolume
		sta APUIO2
		sta APUIO3
		LKS_SPC_Set1 LKS_SPC_BRR_VOLUME
		
		lda spitch
		sta APUIO2
		
		lda ssrcn
		sta APUIO3
		
		lda LKS_STDCTRL+_START
		cmp #1
		bne +
			lda select
			cmp #3
			beq ++
				
				LKS_SPC_Set1 LKS_SPC_BRR_PLAY_TEST
				bra +
			++:
		
		
			jsr fselect2
			
		+:

		;LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SFX1
		;LKS_SPC_SetD BRR_Sample3,400
		
		jsr Text_draw2

		jsl WaitVBlank

    jmp Spc
  
	
fselect2:
	lda select2
	cmp #0
	bne ++
		LKS_SPC_Set LKS_SPC_PLAY,LKS_SPC_ON,0
	++:
	
	cmp #1
	bne ++
		LKS_SPC_Set LKS_SPC_PLAY,LKS_SPC_OFF,0
	++:
	
	cmp #2
	bne ++
		LKS_SPC_Set LKS_SPC_PLAY,LKS_SPC_LOOP,0
	++:

	rts
    
Text_draw2:
	
	;pitch
	lda select
	cmp #0
	bne +
		LKS_printf_setpal 1
		bra ++
	+:
		LKS_printf_setpal 0
	++:
	
	ldx	#text_s1
	LKS_printfs 1,3
	lda spitch
	LKS_printf8h 18,3
	
	;volume
	lda select
	cmp #1
	bne +
		LKS_printf_setpal 1
		bra ++
	+:
		LKS_printf_setpal 0
	++:
	
	ldx	#text_s2
	LKS_printfs 1,4	
	lda svolume
	LKS_printf8h 18,4
	
	;srcn
	lda select
	cmp #2
	bne +
		LKS_printf_setpal 1
		bra ++
	+:
		LKS_printf_setpal 0
	++:
	
	ldx	#text_s3
	LKS_printfs 1,5	
	lda ssrcn
	LKS_printf8h 18,5
	
	;control
	lda select
	cmp #3
	bne +
		LKS_printf_setpal 1
		bra ++
	+:
		LKS_printf_setpal 0
	++:
	
	ldx	#text_s7
	LKS_printfs 1,6	
	
	lda select2
	cmp #0
	bne +
		ldx	#text_s4
	+:
	
	lda select2
	cmp #1
	bne +
		ldx	#text_s5
	+:
	
	lda select2
	cmp #2
	bne +
		ldx	#text_s6
	+:
	
	LKS_printfs 16,6	
	
	
	
	LKS_printf_setpal 0
	
	lda select3
	cmp #0
	bne +
		ldx	#text_name1
		bra ++
	+:
	cmp #1
	bne +
		ldx	#text_name2
		bra ++
	+:
	cmp #2
	bne +
		ldx	#text_name3
		bra ++
	+:
	cmp #3
	bne +
		ldx	#text_name4
		bra ++
	+:
	cmp #4
	bne +
		ldx	#text_name5
		bra ++
	+:
	cmp #5
	bne +
		ldx	#text_name6
		bra ++
	+:
		
	++:
		
	LKS_printfs 2,8	
	
	
	
	;-------------------------------
	LKS_printf_setpal 0
	LKS_SPC_Get LKS_SPC_TICKS
	ldy APUIO2
	phy
	LKS_printf16 6,1
	ply
	rep #$20
	tya
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	tay
	sep #$20
	
	LKS_printf8 9,2
	
	LKS_SPC_Get LKS_SPC_DEBUG
	ldy APUIO2
	LKS_printf16h 1,0
		
	ldx	#text_ticks
	LKS_printfs 1,1
	
	ldx	#text_second
	LKS_printfs 1,2
	
	ldx	#text_start
	LKS_printfs 5,14

	lda LKS.cpu
	;LKS_printf8 1,2
	
	rts
	
	
text_s1:
	.db "sound brr pitch",0

text_s2:
	.db "sound brr volume",0
	
text_s3:
	.db "sound brr srcn",0
	
text_s7:
	.db "sound control",0
	
text_s4:
	.db "play",0
	
text_s5:
	.db "stop",0	
	
text_s6:
	.db "loop",0

text_name6:
	.db "World of demon",0
		
text_name5:
	.db "Castlevania   ",0
	
text_name3:
	.db "Zelda gb      ",0
	
text_name4:
	.db "Thunder force ",0
	
text_name2:
	.db "Secret of mana",0
	
text_name1:
	.db "Zelda 3 snes  ",0
	
text_ticks:
	.db "tick",0
	
text_second:
	.db "second",0
    
    
text_start:
	.db "press the start button",0
    
SPCROM:
	.incbin "driver.spc"
	
	.include "music/music_load0.asm"
	.include "music/music_load1.asm"
	.include "music/music_load2.asm"
	.include "music/music_load3.asm"
	.include "music/music_load4.asm"
	.include "music/music_load5.asm"
	
.bank 12 slot 0
.org 0
	.include "music/music_track0.asm"
	.include "music/music_track1.asm"
	.include "music/music_track2.asm"
	.include "music/music_track3.asm"
	.include "music/music_track4.asm"
	.include "music/music_track5.asm"
	.include "music/music_data5.asm"
.bank 13 slot 0
.org 0
	.include "music/music_data0.asm"
	.include "music/music_data2.asm"
	.include "music/music_data3.asm"
	.include "music/music_data4.asm"
	

.bank 14 slot 0
.org 0
	.include "music/music_data1.asm"
	

.bank 15 slot 0
.org 0
BRR_SFXDIR:
.incbin "digits/sfxdir.sks"

BRR_SFX:
.incbin "digits/SFX0.brr"
.incbin "digits/SFX1.brr"
.incbin "digits/SFX2.brr"
.incbin "digits/SFX3.brr"
.incbin "digits/SFX4.brr"
.incbin "digits/SFX5.brr"
.incbin "digits/SFX6.brr"
.incbin "digits/SFX7.brr"
.incbin "digits/SFX8.brr"
.incbin "digits/SFX9.brr"
.incbin "digits/SFX10.brr"
.incbin "digits/SFX11.brr"
.incbin "digits/SFX12.brr"
.incbin "digits/SFX13.brr"
.incbin "digits/SFX14.brr"
.incbin "digits/SFX15.brr"
.incbin "digits/SFX16.brr"
BRR_SFXEOF:
