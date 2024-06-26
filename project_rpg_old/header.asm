.MEMORYMAP
	SLOTSIZE $8000 ; The slot is $8000 bytes in size. More details on slots later.
	DEFAULTSLOT 0 ; There's only 1 slot in SNES, there are more in other consoles.
	SLOT 0 $8000 ; Defines Slot 0's starting address.
.ENDME

.ROMBANKSIZE $8000
.ROMBANKS 16


.SNESHEADER
	ID    "SNES"
	NAME  "The World of Demon   "
	;     "123456789012345678901"
	LOROM
	SLOWROM
	CARTRIDGETYPE $00
	ROMSIZE $09 ;size rom 08-0c
	SRAMSIZE $00
	COUNTRY $02 ;0 = japan , 1 = US , 2 = Europe
	LICENSEECODE $01
	VERSION 00
.ENDSNES

;65816
.SNESNATIVEVECTOR
	COP    $0000
	BRK    $0000
	ABORT  $0000
	NMI    VBlank
	UNUSED $0000
	IRQ    $0000
.ENDNATIVEVECTOR

;6502
.SNESEMUVECTOR
	COP    $0000
	UNUSED $0000
	ABORT  $0000
	NMI    VBlank
	RESET  Main
	IRQBRK $0000
.ENDEMUVECTOR



.MACRO header
/*
	.db $00,$00 ;Maker Code
	.db "SNES"  ;Game Code ASCII
	.db $00,$00,$00,$00,$00,$00,$00 ;Fixed Value
	.db $00 ; RAM Size
	.db $00 ; Special Version
	.db $00 ; Cartridge Type Sub-Number
	.db "Fighter Fury         " ;Game Title
	;   "123456789012345678901"
	.db $20 ; Mode Map
	.db $00 ; Cartridge Type
	.db $08 ; ROM Size
	.db $00 ; RAM Size
	.db $01 ; Destination Code
	.db $00 ; Fixed Value
	.db $00 ; Mask ROM Value
	.db $E8 , $DC ; Complement Check
	.db $17 , $23 ; Check sum
	
	.db $00,$00,$00,$00
	.dw $0000  ; COP
	.dw $0000  ; BRK
	.dw $0000  ; ABORT
	.dw VBlank ; NMI
	.dw $0000  ; RESET
	.dw $0000  ; IRQ
	
	.db $00,$00,$00,$00
	.dw $0000  ; COP
	.dw $0000  ; BRK
	.dw $0000  ; ABORT
	.dw VBlank ; NMI
	.dw Main   ; RESET
	.dw $0000  ; IRQBRK
	*/
.ENDM

