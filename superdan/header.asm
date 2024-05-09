

.MEMORYMAP
	SLOTSIZE $8000 ; The slot is $8000 bytes in size. More details on slots later.
	DEFAULTSLOT 0 ; There's only 1 slot in SNES, there are more in other consoles.
	SLOT 0 $8000 ; Defines Slot 0's starting address.
.ENDME


.ROMBANKSIZE $8000
.ROMBANKS 32

; R/BANK ko
; 8/8  256
; 9/16  512
; A/32  1024
; B/64  2048
; C/126-112 4096

.SNESHEADER
	ID	"SNES"
	NAME "Super Dan            "
	;            "12345678901234567890"
	LOROM
	FASTROM
	CARTRIDGETYPE $00
	ROMSIZE $0A ;size rom 09-0c
	SRAMSIZE $00
	COUNTRY $01 ;0 = japan , 1 = US , 2 = Europe
	LICENSEECODE $00
	VERSION 00
.ENDSNES

;65816
.SNESNATIVEVECTOR
	COP	IRQ_COP
	BRK	IRQ_BRK
	ABORT  IRQ_ABORT
	NMI	VBlank
	UNUSED Main
	IRQ	HVSync
.ENDNATIVEVECTOR

;6502
.SNESEMUVECTOR
	COP	IRQ_COP
	UNUSED IRQ_BRK
	ABORT  IRQ_ABORT
	NMI	VBlank
	RESET  Main
	IRQBRK HVSync
.ENDEMUVECTOR

.BASE $80
