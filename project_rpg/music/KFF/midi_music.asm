;Super Kannagi Sound Music Format for WLA-DX
;By KungFuFurby
;Start date: 12/21/16

;Low 4 bits of note conversion listed below (TODO replace this...)
;C C#D D#E F F#G G#A A#B
;0 1 2 3 4 6 7 8 A B D F

.MACRO MIDI_Note
	;\1 is the delay before the note.
	;\2 is note ID.
		;Upper 4 bits are the octave,
		;lower 4 bits are the note value.
	;\3 is the velocity.
	;\4 is the duration of the note.
	.IF \1 >= 128
		.db >\1 | $80
		.db <\1
	.ELSE
		.db \1
	.ENDIF
	.db \2
	.db \3
	.IF \4 >= 128
		.db >\4 | $80
		.db <\4
	.ELSE
		.db \4
	.ENDIF
.ENDM

.MACRO MIDI_EOF
	.db $FF
	.db $FF
	.db $FF
.ENDM
