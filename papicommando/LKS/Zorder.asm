
.MACRO LKS_ZORDER
	
	ldy #0
	
	lda LKS_OAM.y+\1
	
	.if \1 != 0
		cmp LKS_OAM.y+0
		bpl +
			iny
		+:
		.if \1 > 0
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 2	
		cmp LKS_OAM.y+2
		bpl +
			iny
		+:
		
		.if \1 > 2
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 4
		cmp LKS_OAM.y+4
		bpl +
			iny
		+:
		
		.if \1 > 4
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 6
		cmp LKS_OAM.y+6
		bpl +
			iny
		+:
		
		.if \1 > 6
		bne +
			iny
		+:
		.endif
	.endif
	
	
	
	.if \1 != 8
		cmp LKS_OAM.y+8
		bpl +
			iny
		+:
		
		.if \1 > 8
		bne +
			iny
		+:
		.endif
	.endif
	
	
	
	.if \1 != 10
		cmp LKS_OAM.y+10
		bpl +
			iny
		+:
		
		.if \1 > 10
		bne +
			iny
		+:
		.endif
	.endif
	
;Zorder > 6
.if \2 > 6	
	.if \1 != 12
		cmp LKS_OAM.y+12
		bpl +
			iny
		+:
		
		.if \1 > 12
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 14
		cmp LKS_OAM.y+14
		bpl +
			iny
		+:
		
		.if \1 > 14
		bne +
			iny
		+:
		.endif
	.endif
	
	
	.if \1 != 16
		cmp LKS_OAM.y+16
		bpl +
			iny
		+:
		
		.if \1 > 16
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 18
		cmp LKS_OAM.y+18
		bpl +
			iny
		+:
		
		.if \1 > 18
		bne +
			iny
		+:
		.endif
	.endif
.endif

;Zorder > 10
.if \2 > 10	
	.if \1 != 20
		cmp LKS_OAM.y+20
		bpl +
			iny
		+:
		
		.if \1 > 20
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 22
		cmp LKS_OAM.y+22
		bpl +
			iny
		+:
		
		.if \1 > 22
		bne +
			iny
		+:
		.endif
		
	.endif
.endif

;Zorder > 12
.if \2 > 12	
	.if \1 != 24
		cmp LKS_OAM.y+24
		bpl +
			iny
		+:
		
		.if \1 > 24
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 26
		cmp LKS_OAM.y+26
		bpl +
			iny
		+:
		
		.if \1 > 26
		bne +
			iny
		+:
		.endif
		
	.endif
.endif

	tya
	asl
	asl
	asl
	asl
	sta LKS_OAM.oam+\1
	
.ENDM

.MACRO LKS_ZORDER6
	LKS_ZORDER \1,6
.ENDM

.MACRO LKS_ZORDER10
	LKS_ZORDER \1,10
.ENDM

.MACRO LKS_ZORDER12
	LKS_ZORDER \1,12
.ENDM

.MACRO LKS_ZORDER14
	LKS_ZORDER \1,14
.ENDM
LKS_Zorder6:

	rep #$20

	LKS_ZORDER6 0
	LKS_ZORDER6 2
	LKS_ZORDER6 4
	
	LKS_ZORDER6 6
	LKS_ZORDER6 8
	LKS_ZORDER6 10

	sep #$20
	
	rtl
	
LKS_Zorder10:

	rep #$20

	LKS_ZORDER10 0
	LKS_ZORDER10 2
	LKS_ZORDER10 4
	LKS_ZORDER10 6
	
	LKS_ZORDER10 8
	LKS_ZORDER10 10
	LKS_ZORDER10 12
	LKS_ZORDER10 14
	
	LKS_ZORDER10 16
	LKS_ZORDER10 18

		
	sep #$20
	
	rtl

LKS_Zorder12:

	rep #$20

	LKS_ZORDER12 0
	LKS_ZORDER12 2
	LKS_ZORDER12 4
	LKS_ZORDER12 6
	
	LKS_ZORDER12 8
	LKS_ZORDER12 10
	LKS_ZORDER12 12
	LKS_ZORDER12 14
	
	LKS_ZORDER12 16
	LKS_ZORDER12 18
	LKS_ZORDER12 20
	LKS_ZORDER12 22
		
	sep #$20
	
	rtl


LKS_Zorder14:

	rep #$20
/*
	LKS_ZORDER14 0
	LKS_ZORDER14 2
	LKS_ZORDER14 4
	LKS_ZORDER14 6
	
	LKS_ZORDER14 8
	LKS_ZORDER14 10
	LKS_ZORDER14 12
	LKS_ZORDER14 14
	
	LKS_ZORDER14 16
	LKS_ZORDER14 18
	LKS_ZORDER14 20
	LKS_ZORDER14 22

	LKS_ZORDER14 24
	LKS_ZORDER14 26
*/
	sep #$20
	
	rtl
