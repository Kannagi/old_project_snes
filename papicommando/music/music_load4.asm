music_load4: ;Castlevania 3

	;sample
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SAMPLE
	LKS_SPC_SetD BRR_Sample4,BRR_Sample4EOF-BRR_Sample4

	;track
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SMXDIR
	LKS_SPC_SetD music4,music4EOF-music4

	rts
