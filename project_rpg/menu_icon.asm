

.MACRO Set_item		
		
	lda #\2
	sta s_item+_itemID+\1
	
	lda #\3
	sta s_item+_itemType+\1
	
	lda #\4
	sta s_item+_itemNb+\1
	
	lda #\5
	sta s_item+_itemTile+\1
	
	
		
.ENDM

.MACRO Set_item_page	
		
	lda #\2
	sta s_menu+_itemN+0+\1*4
	
	lda #\3
	sta s_menu+_itemN+1+\1*4
	
	lda #\4
	sta s_menu+_itemN+2+\1*4
	
	lda #\5
	sta s_menu+_itemN+3+\1*4
	
	
		
.ENDM

Menu_init_icon:

	Set_item _itemSum+4*0,0,3,0,$60
	Set_item _itemSum+4*1,0,0,0,$71
	Set_item _itemSum+4*2,1,3,0,$62
	Set_item _itemSum+4*3,0,0,0,$73
	
	Set_item _itemSum+4*4,0,0,0,$64
	Set_item _itemSum+4*5,0,0,0,$75
	Set_item _itemSum+4*6,0,0,0,$66
	Set_item _itemSum+4*7,0,0,0,$77
	
	
	Set_item _itemOption+4*0,0,0,0,$60
	Set_item _itemOption+4*1,0,0,0,$71
	Set_item _itemOption+4*2,0,0,0,$62
	Set_item _itemOption+4*3,0,0,0,$73
	
	Set_item _itemOption+4*4,0,0,0,$64
	Set_item _itemOption+4*5,0,0,0,$75
	Set_item _itemOption+4*6,0,0,0,$66
	Set_item _itemOption+4*7,0,0,0,$77
	
	Set_item _itemItem+4*0,0,0,0,$40
	Set_item _itemItem+4*1,0,0,0,$41
	Set_item _itemItem+4*2,0,0,0,$42
	Set_item _itemItem+4*3,0,0,0,$53
	
	Set_item _itemItem+4*4,0,0,0,$54
	Set_item _itemItem+4*5,0,0,0,$55
	Set_item _itemItem+4*6,0,0,0,$66
	Set_item _itemItem+4*7,0,0,0,$67
	
	
	Set_item_page 0,3,8,8,1

	rtl



