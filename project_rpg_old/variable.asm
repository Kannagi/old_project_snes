; file[variable.asm] generated from file[variable.in]
.DEFINE MEM_TEMP $0
.DEFINE MEM_TEMPFUNC $10
.DEFINE MEM_TMPSCROLLING $20
.DEFINE MEM_HSCROLLING $30
.DEFINE MEM_VSCROLLING $32
.DEFINE MEM_BRIGTNESS $34
.DEFINE MEM_TEXT $36
.DEFINE MEM_STDCTRL $46
.DEFINE MEM_DMA $5E
.DEFINE MEM_OAM $7E
.DEFINE MEM_PAL $9E
.DEFINE MEM_VBLANK $BE
.DEFINE s_perso $DE
.DEFINE s_menu $15E
.DEFINE s_oam $16E
.DEFINE s_msb $17E
.DEFINE rand8 $18E
.DEFINE s_oam_id $190
.DEFINE s_map $1A0
.DEFINE s_pnj $200
.DEFINE t_oam $600
.DEFINE end $340


;MEM_TEMP         : temporary memory (16 octets)
;MEM_TEMPFUNC     : temporary memory for function input/output (16 octets)
;MEM_TMPSCROLLING : temporary memory for scrolling
;2 octets scroll X , 2 octets scroll Y
;2 octets scroll X for CH , 2 octets scroll Y for CH
;MEM_HSCROLLING   : H scrolling (2 octets)
;MEM_VSCROLLING   : V scrolling (2 octets)
;MEM_BRIGTNESS    : Brigtness (2 octets)
;MEM_TEXT         : Text
;MEM_STDCTRL      : control joypad
;12 octets 1 joypad , 12 octets 2 joypad
;MEM_DMA          : DMA control
;MEM_OAM          : OAM address 0 - 7 , 8 OAM increment
;MEM_PAL          : Palette control

;s_perso :
; X, Y, tile, tile/pal/flip, temp animation , play anim , nanim , vitesse X , vitesse Y

;s_menu :
; on/off , angle , ? , tmp rotate icon , direction rotate , tmp rotate

;s_pnj
; X low , X high , Y low , Y high

;s_msb
; 0 - 7 , msb modif

