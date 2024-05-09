music_load5: ;SNESWorldOfDemonKingTheodoreCastle

	;sample
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SAMPLE
	LKS_SPC_SetD BRR_Sample5,BRR_Sample5EOF-BRR_Sample5

	;track
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SMXDIR
	LKS_SPC_SetD music5,music5EOF-music5

	rts
