

SPLDIR2:
	.incbin "music/thunderforce_sampledir.sks"
	
Music3_pattern:
	.incbin "music/thunderforce.sks"
Music3_patternEOF:

Music3_header:
	.incbin "music/thunderforce_header.sks"
Music3_headerEOF:

SPLDIR3:
;BRR_Piano
.dw  $4000
.dw  $4000

Music3_header2:
.db $00 ;flg
.db $01 ;kon
.db $00 ;esa
.db $00 ;edl

.db $00 ;efb
.db $00 ;evoll
.db $00 ;evolr
.db $00 ;firc0

.db $00 ;firc1
.db $00 ;firc2
.db $00 ;firc3
.db $00 ;firc4

.db $00 ;firc5
.db $00 ;firc6
.db $00 ;firc7
.db $00 ;emusic
.db $41 ;emusic+1
.db $00,$00,$00,$00,$00,$00,$00 ;unused

.db $16 ;track 0
.db $00 ;track 1
.db $00 ;track 2
.db $00 ;track 3

.db $00 ;track 4
.db $00 ;track 5
.db $00 ;track 6
.db $00 ;track 7


;INDEX
.db $00 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $00 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $01 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $02 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $03 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $04 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $05 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $06 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $07 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $08 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $09 ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $0A ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $0B ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $0C ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

.db $0D ;srcn
.db $FF ;adsr1
.db $E0 ;adsr2
.db $7F ;gain

