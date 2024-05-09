music_load1: ;mana_beast_song

	;sample
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SAMPLE
	LKS_SPC_SetD BRR_Sample1,BRR_Sample1EOF-BRR_Sample1

	;track
	LKS_SPC_Set2 LKS_SPC_ADDR,LKS_SPC_SMXDIR
	LKS_SPC_SetD music1,music1EOF-music1

	rts
