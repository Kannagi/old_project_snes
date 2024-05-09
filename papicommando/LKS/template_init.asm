
LKS_MODE_ALPHA:
	SNES_TS $11
		
	SNES_CGSWSEL $02
	SNES_CGADSUB $42
	rtl
	
LKS_GAMELOOP_INIT:
	
	lda	RDNMI
	SNES_INIDISP $00 ;  brigtness 0
	SNES_NMITIMEN $81 ; Enable NMI , enable joypad
	wai
	
	rtl


LKS_INIT:
	
	SNES_INIDISP $80 ; FORCED BLANK , brigtness 0
	;INITIAL SETTINGS

	;background
	SNES_BGMODE $31+8+0 ; mode 1 , prio BG 3 ,BG 1& 2 16x16

	SNES_BG4SC $50 ; address data BG4 $5000
	SNES_BG1SC $54 ; address data BG1 $5400
	SNES_BG2SC $58 ; address data BG2 $5800
	SNES_BG3SC $5C ; address data BG3 $5C00
	

	SNES_BGNBA $00 $04; address BG1,2,3,4 (2,1 / 4,3)

	;general init
	SNES_SETINI $00
	SNES_MEMSEL $00
	SNES_WRIO $FF
	SNES_TM $17 ; bg 1,2,3 ,obj enable
	SNES_COLDATA $E0

	;object
	SNES_OBJSEL $03+(0<<5) ;$30 : 16/32 ; 8/16 , $6000 address
	
		
	SNES_VMAINC $80
	rtl

LKS_OAM_Address_Init:
	rep #$20
	lda #$FFFF
	sta LKS_OAM.Address+0
	sta LKS_OAM.Address+2
	sta LKS_OAM.Address+4
	sta LKS_OAM.Address+6
	
	sta LKS_OAM.Address+8
	sta LKS_OAM.Address+10
	sta LKS_OAM.Address+12
	sta LKS_OAM.Address+14
	
	sta LKS_OAM.Address+16
	sta LKS_OAM.Address+18
	sta LKS_OAM.Address+20
	sta LKS_OAM.Address+22
	
	sta LKS_OAM.Address+24
	sta LKS_OAM.Address+26
	sep #$20
	rtl
