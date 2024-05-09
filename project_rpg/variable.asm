
;Use $00-$20 for the temporary variable
;LKS use $20 - $FF

.DEFINE s_mode7   $100

.DEFINE s_menu    $100
.DEFINE s_text    $140
.DEFINE s_game    $150
.DEFINE s_ia	  $1A0

.DEFINE s_map     $240


.DEFINE s_degat   $300
.DEFINE s_effect  $500

.DEFINE s_item 	$800
.DEFINE s_ennemi $900

;LKS use $D00 - $D80
.DEFINE s_perso $1000



;-----------------------


;s_ennemi
.DEFINE	_enP1		$00
.DEFINE	_enP2		$02
.DEFINE	_enP3		$04
.DEFINE	_enFrame	$06


;s_effect

.DEFINE	_efinit 	$01
.DEFINE	_efi 		$02
.DEFINE	_efl 		$03
.DEFINE	_eftm 		$04
.DEFINE	_efenable 	$05
.DEFINE	_efphase	$06
.DEFINE	_efend		$07
.DEFINE	_efpali 	$08
.DEFINE	_efpall 	$09
.DEFINE	_efsel1 	$0A
.DEFINE	_efsel2		$0C
.DEFINE	_efsel3 	$0E
.DEFINE	_efvadd 	$10
.DEFINE	_efdmai		$12
.DEFINE	_eftypeadd1	$14
.DEFINE	_eftypeadd2	$16
.DEFINE	_eftype		$18
.DEFINE	_efpalen	$19
.DEFINE	_efpal		$1A
.DEFINE	_efpal2		$1D

.DEFINE	_efnsel1 	$20
.DEFINE	_efnsel2	$22
.DEFINE	_efnsel3 	$24

;s_degat
.DEFINE	_ch1 	$02
.DEFINE	_dch1	$03
.DEFINE	_dl		$04
.DEFINE	_ch2	$06
.DEFINE	_dch2	$07
.DEFINE	_di		$08
.DEFINE	_ch3	$0A
.DEFINE	_dch3	$0B

;s_text
.DEFINE	_phase		$00
.DEFINE	_phasei		$02
.DEFINE	_defi		$04
.DEFINE	_defl		$06
.DEFINE	_defr		$08
.DEFINE	_defsv		$0A
.DEFINE	_texton		$0C
.DEFINE	_tdraw		$0E

;s_menu
.DEFINE	_angle		$00
.DEFINE	_eangle		$02
.DEFINE	_ering		$04
.DEFINE	_ring_dir	$06
.DEFINE	_nring		$07
.DEFINE	_rdraw		$08
.DEFINE	_ringi		$09
.DEFINE	_ringl		$0B
.DEFINE	_ring		$0C
.DEFINE	_ringload	$0D
.DEFINE	_page		$0E
.DEFINE	_ringdma	$0F

.DEFINE	_rselect	$10
.DEFINE	_rselect2	$11
.DEFINE	_rselecte	$12
.DEFINE	_meffect	$14
.DEFINE	_mvoid		$16

.DEFINE	_rx			$18
.DEFINE	_mx			$1A
.DEFINE	_mselect	$1C

.DEFINE	_rdelay		$1E
.DEFINE	_rpal		$20
.DEFINE	_rpalend	$2F

.DEFINE	_rtile		$30
.DEFINE	_rtileend	$3F

;s_game
.DEFINE	_stopall	$00
.DEFINE	_language	$02

;s_map
.DEFINE	_bg1		$00
.DEFINE	_bg2		$03
.DEFINE	_mapc		$06
.DEFINE	_mlevel		$09
.DEFINE	_madd		$0B
.DEFINE	_mode		$0D
.DEFINE	_ix			$10
.DEFINE	_iy			$12
.DEFINE	_imx		$14
.DEFINE	_imy		$16
.DEFINE	_beginp		$18



;s_perso
.DEFINE	_x			$00
.DEFINE	_y			$02
.DEFINE	_tile		$04
.DEFINE	_flip		$05
.DEFINE	_vx			$06
.DEFINE	_vy			$08
.DEFINE	_add		$0A
.DEFINE	_bankadd	$0C
.DEFINE	_tadd		$0D ; for pnj
.DEFINE	_tbankadd	$0F ; for pnj


;.DEFINE	_typeia		$0F ; for ennemi

.DEFINE	_animi 		$10
.DEFINE	_animl 		$11 
.DEFINE	_animact 	$12
.DEFINE	_animactold	$13
.DEFINE	_oam    	$14
;.DEFINE	_draw    	$16
.DEFINE	_dma		$17
.DEFINE	_direction  $18
.DEFINE	_text 		$1A
.DEFINE	_tag 		$1B
.DEFINE	_anims 		$1C
.DEFINE	_etat 		$1D
.DEFINE	_animend 	$1E
.DEFINE	_animv   	$1F

.DEFINE	_mt		 	$20
.DEFINE	_dgt		$22
.DEFINE	_gdirection	$24
.DEFINE	_cstop		$25

.DEFINE	_type		$26


.DEFINE	_vtmp		$28
.DEFINE	_vlim		$29

.DEFINE	_animn		$2A
.DEFINE	_cgold		$2B
.DEFINE	_exp		$2D

.DEFINE	_hp			$30
.DEFINE	_hpmax		$32
.DEFINE	_mp			$34
.DEFINE	_mpmax		$35
.DEFINE	_lvl		$36
.DEFINE	_atk		$37
.DEFINE	_def		$38
.DEFINE	_mag		$39
.DEFINE	_esp		$3A
.DEFINE	_esq		$3B
.DEFINE	_prc		$3C
.DEFINE	_luck		$3D
.DEFINE	_item		$3E

;s_ia
.DEFINE	_pattern	$02
.DEFINE	_patterni	$03
.DEFINE	_patternl	$04


;s_item
.DEFINE	_itemItem	$00*4
.DEFINE	_itemSum	$0C*4
.DEFINE	_itemOption	$14*4
.DEFINE	_itemArm	$1C*4
.DEFINE	_itemBody	$28*4
.DEFINE	_itemHeah	$34*4
.DEFINE	_itemArmet	$40*4
.DEFINE	_itemBot	$4C*4
.DEFINE	_itemMagic1	$58*4
.DEFINE	_itemMagic2	$5C*4
.DEFINE	_itemMagic3	$60*4
.DEFINE	_itemMagic4	$64*4
.DEFINE	_itemMagic5	$68*4
.DEFINE	_itemMagic6	$6C*4
.DEFINE	_itemMagic7	$70*4
.DEFINE	_itemMagic8	$74*4

.DEFINE	_itemN		$1E0

.DEFINE	_itemID		$00
.DEFINE	_itemType	$01
.DEFINE	_itemNb		$02
.DEFINE	_itemTile	$03

;s_mode7
.DEFINE	_m7a	$00
.DEFINE	_m7b	$02
.DEFINE	_m7c	$04
.DEFINE	_m7d	$06
.DEFINE	_m7x	$08
.DEFINE	_m7y	$0A
.DEFINE	_m7sx	$0C
.DEFINE	_m7sy	$0E
.DEFINE	_m7an 	$10
.DEFINE	_m7frm 	$12

.DEFINE	_m7vx 	$14
.DEFINE	_m7vy 	$16

.DEFINE	_m7px 	$18
.DEFINE	_m7py 	$1B

