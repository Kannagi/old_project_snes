
Ennemi_TriP1_F:
	lda s_ennemi+_enFrame
	cmp #0
	bne +
		jsl Ennemi_TriP1_F1
		rtl
	+:
	cmp #1
	bne +
		jsl Ennemi_TriP1_F2
		rtl
	+:
	cmp #2
	bne +
		jsl Ennemi_TriP1_F3
		rtl
	+:
	cmp #3
	bne +
		jsl Ennemi_TriP1_F4
		rtl
	+:
	cmp #4
	bne +
		jsl Ennemi_TriP1_F5
		rtl
	+:
	cmp #5
	bne +
		jsl Ennemi_TriP1_F6
		rtl
	+:
	cmp #6
	bne +
		jsl Ennemi_TriP1_F7
		rtl
	+:

	rtl
	
Ennemi_TriP2_F:
	lda s_ennemi+_enFrame
	cmp #0
	bne +
		jsl Ennemi_TriP2_F1
		rtl
	+:
	cmp #1
	bne +
		jsl Ennemi_TriP2_F2
		rtl
	+:
	cmp #2
	bne +
		jsl Ennemi_TriP2_F3
		rtl
	+:
	cmp #3
	bne +
		jsl Ennemi_TriP2_F4
		rtl
	+:
	cmp #4
	bne +
		jsl Ennemi_TriP2_F5
		rtl
	+:
	cmp #5
	bne +
		jsl Ennemi_TriP2_F6
		rtl
	+:
	cmp #6
	bne +
		jsl Ennemi_TriP2_F7
		rtl
	+:

	rtl
	
Ennemi_TriP3_F:
	lda s_ennemi+_enFrame
	cmp #0
	bne +
		jsl Ennemi_TriP3_F1
		rtl
	+:
	cmp #1
	bne +
		jsl Ennemi_TriP3_F2
		rtl
	+:
	cmp #2
	bne +
		jsl Ennemi_TriP3_F3
		rtl
	+:
	cmp #3
	bne +
		jsl Ennemi_TriP3_F4
		rtl
	+:
	cmp #4
	bne +
		jsl Ennemi_TriP3_F5
		rtl
	+:
	cmp #5
	bne +
		jsl Ennemi_TriP3_F6
		rtl
	+:
	cmp #6
	bne +
		jsl Ennemi_TriP3_F7
		rtl
	+:

	rtl
	
;------------------------------------------
Ennemi_TriP1_F1:
	Ennemi_Test_SC_P1 3
	Ennemi_Test_SC_P1 4
	Ennemi_Test_SC_P1 5
	Ennemi_Test_SC_P1 6
	
	Ennemi_Test_SC_P1 7
	Ennemi_Test_SC_P1 8
	Ennemi_Test_SC_P1 9
	Ennemi_Test_SC_P1 10
	rtl
	
Ennemi_TriP1_F2:
	Ennemi_Test_SC_P1 11
	Ennemi_Test_SC_P1 12
	Ennemi_Test_SC_P1 13
	Ennemi_Test_SC_P1 14
	
	Ennemi_Test_SC_P1 15
	Ennemi_Test_SC_P1 16
	Ennemi_Test_SC_P1 17
	Ennemi_Test_SC_P1 18
	Ennemi_Test_SC_P1 19
	Ennemi_Test_SC_P1 20
	rtl
	
Ennemi_TriP1_F3:
	Ennemi_Test_SC_P1 21
	Ennemi_Test_SC_P1 22
	Ennemi_Test_SC_P1 23
	Ennemi_Test_SC_P1 24
	
	Ennemi_Test_SC_P1 25
	Ennemi_Test_SC_P1 26
	Ennemi_Test_SC_P1 27
	Ennemi_Test_SC_P1 28
	Ennemi_Test_SC_P1 29
	Ennemi_Test_SC_P1 30
	rtl
	
Ennemi_TriP1_F4:
	Ennemi_Test_SC_P1 31
	Ennemi_Test_SC_P1 32
	Ennemi_Test_SC_P1 33
	Ennemi_Test_SC_P1 34
	
	Ennemi_Test_SC_P1 35
	Ennemi_Test_SC_P1 36
	Ennemi_Test_SC_P1 37
	Ennemi_Test_SC_P1 38
	Ennemi_Test_SC_P1 39
	Ennemi_Test_SC_P1 40
	rtl
	
Ennemi_TriP1_F5:
	Ennemi_Test_SC_P1 41
	Ennemi_Test_SC_P1 42
	Ennemi_Test_SC_P1 43
	Ennemi_Test_SC_P1 44
	
	Ennemi_Test_SC_P1 45
	Ennemi_Test_SC_P1 46
	Ennemi_Test_SC_P1 47
	Ennemi_Test_SC_P1 48
	Ennemi_Test_SC_P1 49
	Ennemi_Test_SC_P1 50
	
	rtl
	
Ennemi_TriP1_F6:
	Ennemi_Test_SC_P1 51
	Ennemi_Test_SC_P1 52
	Ennemi_Test_SC_P1 53
	Ennemi_Test_SC_P1 54
	
	Ennemi_Test_SC_P1 55
	Ennemi_Test_SC_P1 56
	Ennemi_Test_SC_P1 57
	Ennemi_Test_SC_P1 58
	Ennemi_Test_SC_P1 59
	Ennemi_Test_SC_P1 60
	
	rtl
	
Ennemi_TriP1_F7:
	Ennemi_Test_SC_P1 61
	Ennemi_Test_SC_P1 62
	Ennemi_Test_SC_P1 63
	
	rtl
	
;------------------------------------------
Ennemi_TriP2_F1:
	Ennemi_Test_SC_P2 3
	Ennemi_Test_SC_P2 4
	Ennemi_Test_SC_P2 5
	Ennemi_Test_SC_P2 6
	
	Ennemi_Test_SC_P2 7
	Ennemi_Test_SC_P2 8
	Ennemi_Test_SC_P2 9
	Ennemi_Test_SC_P2 10
	rtl
	
Ennemi_TriP2_F2:
	Ennemi_Test_SC_P2 11
	Ennemi_Test_SC_P2 12
	Ennemi_Test_SC_P2 13
	Ennemi_Test_SC_P2 14
	
	Ennemi_Test_SC_P2 15
	Ennemi_Test_SC_P2 16
	Ennemi_Test_SC_P2 17
	Ennemi_Test_SC_P2 18
	Ennemi_Test_SC_P2 19
	Ennemi_Test_SC_P2 20
	rtl
	
Ennemi_TriP2_F3:
	Ennemi_Test_SC_P2 21
	Ennemi_Test_SC_P2 22
	Ennemi_Test_SC_P2 23
	Ennemi_Test_SC_P2 24
	
	Ennemi_Test_SC_P2 25
	Ennemi_Test_SC_P2 26
	Ennemi_Test_SC_P2 27
	Ennemi_Test_SC_P2 28
	Ennemi_Test_SC_P2 29
	Ennemi_Test_SC_P2 30
	rtl
	
Ennemi_TriP2_F4:
	Ennemi_Test_SC_P2 31
	Ennemi_Test_SC_P2 32
	Ennemi_Test_SC_P2 33
	Ennemi_Test_SC_P2 34
	
	Ennemi_Test_SC_P2 35
	Ennemi_Test_SC_P2 36
	Ennemi_Test_SC_P2 37
	Ennemi_Test_SC_P2 38
	Ennemi_Test_SC_P2 39
	Ennemi_Test_SC_P2 40
	rtl
	
Ennemi_TriP2_F5:
	Ennemi_Test_SC_P2 41
	Ennemi_Test_SC_P2 42
	Ennemi_Test_SC_P2 43
	Ennemi_Test_SC_P2 44
	
	Ennemi_Test_SC_P2 45
	Ennemi_Test_SC_P2 46
	Ennemi_Test_SC_P2 47
	Ennemi_Test_SC_P2 48
	Ennemi_Test_SC_P2 49
	Ennemi_Test_SC_P2 50
	
	rtl
	
Ennemi_TriP2_F6:
	Ennemi_Test_SC_P2 51
	Ennemi_Test_SC_P2 52
	Ennemi_Test_SC_P2 53
	Ennemi_Test_SC_P2 54
	
	Ennemi_Test_SC_P2 55
	Ennemi_Test_SC_P2 56
	Ennemi_Test_SC_P2 57
	Ennemi_Test_SC_P2 58
	Ennemi_Test_SC_P2 59
	Ennemi_Test_SC_P2 60
	
	rtl
	
Ennemi_TriP2_F7:
	Ennemi_Test_SC_P2 61
	Ennemi_Test_SC_P2 62
	Ennemi_Test_SC_P2 63
	
	rtl
	
;------------------------------------------
Ennemi_TriP3_F1:
	Ennemi_Test_SC_P3 3
	Ennemi_Test_SC_P3 4
	Ennemi_Test_SC_P3 5
	Ennemi_Test_SC_P3 6
	
	Ennemi_Test_SC_P3 7
	Ennemi_Test_SC_P3 8
	Ennemi_Test_SC_P3 9
	Ennemi_Test_SC_P3 10
	rtl
	
Ennemi_TriP3_F2:
	Ennemi_Test_SC_P3 11
	Ennemi_Test_SC_P3 12
	Ennemi_Test_SC_P3 13
	Ennemi_Test_SC_P3 14
	
	Ennemi_Test_SC_P3 15
	Ennemi_Test_SC_P3 16
	Ennemi_Test_SC_P3 17
	Ennemi_Test_SC_P3 18
	Ennemi_Test_SC_P3 19
	Ennemi_Test_SC_P3 20
	rtl
	
Ennemi_TriP3_F3:
	Ennemi_Test_SC_P3 21
	Ennemi_Test_SC_P3 22
	Ennemi_Test_SC_P3 23
	Ennemi_Test_SC_P3 24
	
	Ennemi_Test_SC_P3 25
	Ennemi_Test_SC_P3 26
	Ennemi_Test_SC_P3 27
	Ennemi_Test_SC_P3 28
	Ennemi_Test_SC_P3 29
	Ennemi_Test_SC_P3 30
	rtl
	
Ennemi_TriP3_F4:
	Ennemi_Test_SC_P3 31
	Ennemi_Test_SC_P3 32
	Ennemi_Test_SC_P3 33
	Ennemi_Test_SC_P3 34
	
	Ennemi_Test_SC_P3 35
	Ennemi_Test_SC_P3 36
	Ennemi_Test_SC_P3 37
	Ennemi_Test_SC_P3 38
	Ennemi_Test_SC_P3 39
	Ennemi_Test_SC_P3 40
	rtl
	
Ennemi_TriP3_F5:
	Ennemi_Test_SC_P3 41
	Ennemi_Test_SC_P3 42
	Ennemi_Test_SC_P3 43
	Ennemi_Test_SC_P3 44
	
	Ennemi_Test_SC_P3 45
	Ennemi_Test_SC_P3 46
	Ennemi_Test_SC_P3 47
	Ennemi_Test_SC_P3 48
	Ennemi_Test_SC_P3 49
	Ennemi_Test_SC_P3 50
	
	rtl
	
Ennemi_TriP3_F6:
	Ennemi_Test_SC_P3 51
	Ennemi_Test_SC_P3 52
	Ennemi_Test_SC_P3 53
	Ennemi_Test_SC_P3 54
	
	Ennemi_Test_SC_P3 55
	Ennemi_Test_SC_P3 56
	Ennemi_Test_SC_P3 57
	Ennemi_Test_SC_P3 58
	Ennemi_Test_SC_P3 59
	Ennemi_Test_SC_P3 60
	
	rtl
	
Ennemi_TriP3_F7:
	Ennemi_Test_SC_P3 61
	Ennemi_Test_SC_P3 62
	Ennemi_Test_SC_P3 63
	
	rtl
	
