
.include "LKS/STRUCT.asm"
.STRUCT SLKS
cpu			db
mcpu		db
pcpu		db
printpal	db
clockf		db
clocks		db
clockm		db
clockh		db
bg3i		db
rand		db
mode		 db 
VBlankEnable db
VBlankWait	 db
VBlankType	 db
VBlankTime	 dw
VBlankTimeS	 dw
.ENDST

.STRUCT SLKS3D
frame_i			db

.ENDST

;mode
;0 : BG1&2
;1 : BG1 only ,BG2 dynamic
;2 : BG1&BG2 dynamic
;7 : mode 7

.ENUM $0000
MEM_TEMP		DSB $10
MEM_TEMPFUNC  	DSB $0A
MEM_RETURN 		DSB $06
LKS_ZP  			DSB $06
LKS_DEBUG	  	DSB $06
LKS_BG		  	INSTANCEOF SLKS_BG
LKS_SPRITE_CTRL	INSTANCEOF SLKS_SPRITE_CTRL

RAMSTART		DB
.ENDE

.ENUM $1000
LKS_SPRITE   INSTANCEOF SLKS_SPRITE
.ENDE

.ENUM $1F00
LKS				INSTANCEOF SLKS
LKS_PAL		  	INSTANCEOF SLKS_PAL
LKS_STDCTRL		DSB $0040
LKS_SPC_CTRL		DB
LKS_SPC_VAR		DW
_END_RAM_B db
.ENDE



.DEFINE LKS_IRQ	$100

.ENUM $7E8000
LKS_DMA		 INSTANCEOF SLKS_DMA 128
LKS_BUF_BG3  DSB $0800
LKS_BUF_PAL  DSB $0200
LKS_BUF_BGS1 DSB $0080
LKS_BUF_BGS2 DSB $0080
LKS_BUF_OAML DSB $0200
LKS_BUF_OAMH DSB $0020
LKS_DMA_SEND INSTANCEOF SLKS_DMA_SEND
LKS_BULLET   INSTANCEOF SLKS_BULLET
LKS_OAM 	 INSTANCEOF SLKS_OAM
LKS3D		 INSTANCEOF SLKS3D
LKS_FADE		INSTANCEOF SLKS_FADE
_END_RAM_ db
.ENDE

.PRINTV HEX RAMSTART
.PRINTT " - "
.PRINTV HEX _END_RAM_B
.PRINTT " - "
.PRINTV HEX _END_RAM_

.DEFINE LKS_BUF_COL  $7EC000
.DEFINE LKS_BUF_BG1  $7F0000
.DEFINE LKS_BUF_BG2  $7F8000





