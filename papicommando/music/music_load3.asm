music_load3: ;new thunderforce

	;sample
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SAMPLE
	LKS_SPC_SetD BRR_Sample3,BRR_Sample3EOF-BRR_Sample3

	;track
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SMXDIR
	LKS_SPC_SetD music3,music3EOF-music3

	rts
