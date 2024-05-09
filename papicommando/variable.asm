
.STRUCT SCHARACTER
direction 	db
attack		db
chrono 		db
hp		  	db

enable	  	db
oldanim	  	db
flagcol	  	db
type		db

zonex		dw
zoney		dw
void	  	dsb $04
.ENDST

.STRUCT SCHARACTER_EXT
index		  dw
idbullet	  dw
framediv	  dw
frameenable	  dw
cadence	  	  dsw 8
.ENDST


;-----------------------
.ENUM $0100
SCharacterExt	INSTANCEOF SCHARACTER_EXT
SCharacter		INSTANCEOF SCHARACTER 64
.ENDE


















