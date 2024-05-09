.SNESHEADER
	ID    "SNES"
	NAME  "Fighter Fury         "
	;     "123456789012345678901"
	LOROM
	SLOWROM
	CARTRIDGETYPE $00
	ROMSIZE $08 ;size rom 08-0c
	SRAMSIZE $00
	COUNTRY $01 ;0 = japan , 1 = US , 2 = Europe
	LICENSEECODE $00
	VERSION 00
.ENDSNES


.SNESNATIVEVECTOR
	COP    $0000
	BRK    $0000
	ABORT  $0000
	NMI    VBlank
	UNUSED $0000
	IRQ    $0000
.ENDNATIVEVECTOR

.SNESEMUVECTOR
	COP    $0000
	UNUSED $0000
	ABORT  $0000
	NMI    VBlank
	RESET  Main
	IRQBRK $0000
.ENDEMUVECTOR
