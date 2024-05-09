music_load0: ;zelda3

	;sample
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SAMPLE
	LKS_SPC_SetD BRR_Sample0,BRR_Sample0EOF-BRR_Sample0

	;track
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SMXDIR
	LKS_SPC_SetD music0,music0EOF-music0

	rts
