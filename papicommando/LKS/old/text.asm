rep #$20
	lda LKS_OAM.Address+4+0
	tay
	sep #$20
	LKS_printf16h 10,5
	
	rep #$20
	lda LKS_OAM.Address+4+2
	tay
	sep #$20
	LKS_printf16h 10,6
	
	rep #$20
	lda LKS_OAM.Address+4+4
	tay
	sep #$20
	LKS_printf16h 10,7
	
	rep #$20
	lda LKS_OAM.Address+4+6
	tay
	sep #$20
	LKS_printf16h 10,8
	
	rep #$20
	lda LKS_OAM.Address+4+8
	tay
	sep #$20
	LKS_printf16h 10,10
	
	rep #$20
	lda LKS_OAM.Address+4+10
	tay
	sep #$20
	LKS_printf16h 10,11
	
	rep #$20
	lda LKS_OAM.Address+4+12
	tay
	sep #$20
	LKS_printf16h 10,12
	
	rep #$20
	lda LKS_OAM.Address+4+14
	tay
	sep #$20
	LKS_printf16h 10,13
	
	
	lda LKS_OAM.enable+0
	LKS_printf8h 16,5
	
	lda LKS_OAM.enable+2
	LKS_printf8h 16,6
	
	lda LKS_OAM.enable+4
	LKS_printf8h 16,7
	
	lda LKS_OAM.enable+6
	LKS_printf8h 16,8
	
	lda LKS_OAM.enable+8
	LKS_printf8h 16,10
	
	lda LKS_OAM.enable+10
	LKS_printf8h 16,11
	
	lda LKS_OAM.enable+12
	LKS_printf8h 16,12
	
	lda LKS_OAM.enable+14
	LKS_printf8h 16,13