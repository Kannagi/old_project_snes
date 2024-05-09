
.STRUCT SSHIP
direction 	db
attack		db
chrono 		db
hp		  	db

enable	  	db
laser	  	db
flagcol	  	db
type		db

zonex		dw
lasery		dw

weapon		db
hit			db
invincible	db
void	  	db
bomb	db
ianim	  db
.ENDST

.STRUCT SSHIPE
hp		  	db
hit			db

type			db
address		dsb 3

flag			db
dep			db
void	 		dsb 8
.ENDST


.STRUCT SSDAN
icollision		db
ianim	  	db
load_shipe	db
id			dw
ibullet		dw
islow		dw
cursor		dw
score		dsb 8
.ENDST

.STRUCT SIMPACT
x		dsb 12
y		dsb 12
n		dw
n1		dw
n2		dw
i1		db
i2		db
.ENDST

.STRUCT SBONUS
x		dsb 6
y		dsb 6
n		dw
n1		dw
n2		dw
i1		db
i2		db
power	dsb 4
.ENDST

.STRUCT SSFX
i1		  	db
i2			db

enable1		  db
enable2		db

pitch1		  db
pitch2		db
.ENDST
;-----------------------
.ENUM $0200
SDAN		INSTANCEOF SSDAN
SFX			INSTANCEOF SSFX
Impact		INSTANCEOF SIMPACT
Bonus		INSTANCEOF SBONUS
Ship			INSTANCEOF SSHIP
ShipE		INSTANCEOF SSHIPE 12
_END_RAM_2 db
.ENDE


.PRINTT " - "
.PRINTV HEX _END_RAM_2















