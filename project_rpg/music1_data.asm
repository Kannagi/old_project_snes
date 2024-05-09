.include "music/KFF/midi_music.asm"
Music1_track0:
	.incbin "music/KFF/track0.sns"
	;.include "music/KFF/track0.asm"
Music1_track0_EOF:

Music1_track1:
	.include "music/KFF/track1.asm"
Music1_track1_EOF:

Music1_track2:
	.include "music/KFF/track2.asm"
Music1_track2_EOF:

Music1_track3:
	.include "music/KFF/track3.asm"
Music1_track3_EOF:

Music1_track4:
	.include "music/KFF/track4.asm"
Music1_track4_EOF:

Music1_track5:
	.include "music/KFF/track5.asm"
Music1_track5_EOF:

Music1_index:
;$A0
.db $72 ;pitch
.db $00 ;srcn
.db $FF ;adsr1
.db $F2 ;adsr2
.db $9F ;gain
;$A5
.db $00 ;pitch
.db $00 ;srcn
.db $FF ;adsr1
.db $F2 ;adsr2
.db $91 ;gain

;AA
.db $00 ;pitch
.db $00 ;srcn
.db $FF ;adsr1
.db $F2 ;adsr2
.db $91 ;gain

;etc
	
Music1_track0_info:
.db $00 ;srcn
.db $FF ;adsr1
.db $F2 ;adsr2
.db $91 ;gain

Music1_track4_info:
.db $00 ;srcn
.db $FF ;adsr1
.db $EE ;adsr2
.db $8D ;gain

Music1_info:
.db $00 ;flg
.db $3F ;kon
.db $00 ;pmon
.db $00 ;non

.db $00 ;esa
.db $00 ;edl
.db $00 ;eon
.db $00 ;efb

.db $00 ;evoll
.db $00 ;evolr
.db $00 ;c0
.db $00 ;c1

.db $00 ;c2
.db $00 ;c3
.db $00 ;c4
.db $00 ;c5

.db $00 ;c6
.db $00 ;c7
.db $00 ;end music
.db $09 ;end music+1

BRRharpsichord:
.incbin "music/KFF/harpsichord.brr"
BRRharpsichord_EOF:
