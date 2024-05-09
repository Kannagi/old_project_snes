
.STRUCT SLKS_DMA
Enable	db
Bank	db
SrcR	dw

Src1	dw
Dst1	dw
Size1	dw

Src2	dw
Dst2	dw
Size2	dw

Src3	dw
Dst3	dw
Size3	dw

Src4	dw
Dst4	dw
Size4	dw

Func	dw
dmat	dw

.ENDST

.STRUCT SLKS_FADE
timer	dw
brg		db
phase	db

vin		db
vout	db
.ENDST


.STRUCT SLKS_BG
EnableX		dw
EnableY		dw
Enablelim	dw

size	dw
widthc	dw
width	dw
height	dw

x			dw
y			dw
H			dw
V			dw

limitex		dw
limitey		dw
addyr		dw
addy		dw

H_vadd1		dw
V_vadd1		dw
Dadd1_1		dw
Dadd2_1		dw

H_vadd2		dw
V_vadd2		dw
Dadd1_2		dw
Dadd2_2		dw

VScrollx 	dsb 3
VScrolly 	dsb 3

Address1	dsb 3
Address2	dsb 3
Addressc	dsb 3
.ENDST

.STRUCT SLKS_BULLET
i		dsb 14
n		dsb 14
X		dsw 64
Y		dsw 64
Tile	dsb 64
Flip	dsb 64
Flag	dsw 64

VX		dsw 64
VY		dsw 64
.ENDST



.STRUCT SLKS_SPRITE
X		dw
Y		dw
PX		dw
PY		dw
Tile	db
Flip	db
VX		dw
VY		dw

Enable		db
Anim_type	db

Anim_i		db
Anim_l		db
Anim_act	db
Anim_old	db

Anim_end	db
Anim_v		db
Anim_n		db
Anim_flg	db

Ext		dw
Address	dw
RX		dw
RY		dw


.ENDST


.STRUCT SLKS_PAL
effect	db
type	db
i		dw
l		dw

bg1		dsb 3
bg2		dsb 3
bg3		dsb 3
bg4		dsb 3
bg5		dsb 3
bg6		dsb 3
bg7		dsb 3
bg8		dsb 3

sp1		dsb 3
sp2		dsb 3
sp3		dsb 3
sp4		dsb 3
sp5		dsb 3
sp6		dsb 3
sp7		dsb 3
sp8		dsb 3
.ENDST



.STRUCT SLKS_DMA_SEND
dma dsw 8
Enable dsw 8
index dsw 128
i dw
.ENDST

.STRUCT SLKS_OAM
Address		dsw 14
oam 		dsw 14
y			dsw 14
enable		dsw 14
eoam		dsw 14
epal		dsw 14
evram		dsw 14
etile		dsw 14
.ENDST

.STRUCT SLKS_SPRITE_CTRL
oam		dw
width	dw
height	dw
pitch	dw
n		dw
nmax	dw
.ENDST

