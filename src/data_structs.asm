;;; Overall sequence of clips
clips_sequence:
        dc.w clip_anim_titre
        dc.w clip_anim_cul

;;; specifies on which frame to switch parts
M_C0 = 250
M_C1 = 0
clipswitch:
        .word M_C0
        .word M_C1

pfs_anime3Cul_01:
	dc.w pic_anime3Cul_01 + 0
	dc.w pic_anime3Cul_01 + 40
	dc.w pic_anime3Cul_01 + 80
	dc.w pic_anime3Cul_01 + 120
	dc.w pic_anime3Cul_01 + 160
	dc.w pic_anime3Cul_01 + 200
pfs_anime3Cul_02:
	dc.w pic_anime3Cul_02 + 0
	dc.w pic_anime3Cul_02 + 40
	dc.w pic_anime3Cul_02 + 80
	dc.w pic_anime3Cul_02 + 120
	dc.w pic_anime3Cul_02 + 160
	dc.w pic_anime3Cul_02 + 200
pfs_anime3Cul_03:
	dc.w pic_anime3Cul_03 + 0
	dc.w pic_anime3Cul_03 + 40
	dc.w pic_anime3Cul_03 + 80
	dc.w pic_anime3Cul_03 + 120
	dc.w pic_anime3Cul_03 + 160
	dc.w pic_anime3Cul_03 + 200
pfs_anime3Cul_04:
	dc.w pic_anime3Cul_04 + 0
	dc.w pic_anime3Cul_04 + 40
	dc.w pic_anime3Cul_04 + 80
	dc.w pic_anime3Cul_04 + 120
	dc.w pic_anime3Cul_04 + 160
	dc.w pic_anime3Cul_04 + 200
pfs_anime3Cul_05:
	dc.w pic_anime3Cul_05 + 0
	dc.w pic_anime3Cul_05 + 40
	dc.w pic_anime3Cul_05 + 80
	dc.w pic_anime3Cul_05 + 120
	dc.w pic_anime3Cul_05 + 160
	dc.w pic_anime3Cul_05 + 200
pfs_anime3Cul_06:
	dc.w pic_anime3Cul_06 + 0
	dc.w pic_anime3Cul_06 + 40
	dc.w pic_anime3Cul_06 + 80
	dc.w pic_anime3Cul_06 + 120
	dc.w pic_anime3Cul_06 + 160
	dc.w pic_anime3Cul_06 + 200
pfs_anime3Cul_07:
	dc.w pic_anime3Cul_07 + 0
	dc.w pic_anime3Cul_07 + 40
	dc.w pic_anime3Cul_07 + 80
	dc.w pic_anime3Cul_07 + 120
	dc.w pic_anime3Cul_07 + 160
	dc.w pic_anime3Cul_07 + 200
pfs_anime3Cul_08:
	dc.w pic_anime3Cul_08 + 0
	dc.w pic_anime3Cul_08 + 40
	dc.w pic_anime3Cul_08 + 80
	dc.w pic_anime3Cul_08 + 120
	dc.w pic_anime3Cul_08 + 160
	dc.w pic_anime3Cul_08 + 200
pfs_blank:
	dc.w pic_blank + 0
	dc.w pic_blank + 40
	dc.w pic_blank + 80
	dc.w pic_blank + 120
	dc.w pic_blank + 160
	dc.w pic_blank + 200
ptr_anim_cul:
	dc.w pfs_anime3Cul_01
	dc.w pfs_anime3Cul_02
	dc.w pfs_anime3Cul_03
	dc.w pfs_anime3Cul_04
	dc.w pfs_anime3Cul_05
	dc.w pfs_anime3Cul_06
	dc.w pfs_anime3Cul_07
	dc.w pfs_blank
	dc.w pfs_anime3Cul_08
seq_anim_cul:
	dc.b $00, $00, $00, $00, $01, $01, $01, $01
	dc.b $02, $03, $04, $05, $06, $07, $07, $07
	dc.b $07, $08, $07, $08, $07, $08, $ff
clip_anim_cul:
	dc.b $00	; type animation
	dc.w ptr_anim_cul
	dc.w seq_anim_cul
pfs_anime1Titre_01:
	dc.w pic_anime1Titre_01 + 0
	dc.w pic_anime1Titre_01 + 40
	dc.w pic_anime1Titre_01 + 80
	dc.w pic_anime1Titre_01 + 120
	dc.w pic_anime1Titre_01 + 160
	dc.w pic_anime1Titre_01 + 200
pfs_anime1Titre_02:
	dc.w pic_anime1Titre_02 + 0
	dc.w pic_anime1Titre_02 + 40
	dc.w pic_anime1Titre_02 + 80
	dc.w pic_anime1Titre_02 + 120
	dc.w pic_anime1Titre_02 + 160
	dc.w pic_anime1Titre_02 + 200
pfs_anime1Titre_03:
	dc.w pic_anime1Titre_03 + 0
	dc.w pic_anime1Titre_03 + 40
	dc.w pic_anime1Titre_03 + 80
	dc.w pic_anime1Titre_03 + 120
	dc.w pic_anime1Titre_03 + 160
	dc.w pic_anime1Titre_03 + 200
pfs_anime1Titre_04:
	dc.w pic_anime1Titre_04 + 0
	dc.w pic_anime1Titre_04 + 40
	dc.w pic_anime1Titre_04 + 80
	dc.w pic_anime1Titre_04 + 120
	dc.w pic_anime1Titre_04 + 160
	dc.w pic_anime1Titre_04 + 200
pfs_anime1Titre_05:
	dc.w pic_anime1Titre_05 + 0
	dc.w pic_anime1Titre_05 + 40
	dc.w pic_anime1Titre_05 + 80
	dc.w pic_anime1Titre_05 + 120
	dc.w pic_anime1Titre_05 + 160
	dc.w pic_anime1Titre_05 + 200
pfs_anime1Titre_06:
	dc.w pic_anime1Titre_06 + 0
	dc.w pic_anime1Titre_06 + 40
	dc.w pic_anime1Titre_06 + 80
	dc.w pic_anime1Titre_06 + 120
	dc.w pic_anime1Titre_06 + 160
	dc.w pic_anime1Titre_06 + 200
pfs_anime1Titre_07:
	dc.w pic_anime1Titre_07 + 0
	dc.w pic_anime1Titre_07 + 40
	dc.w pic_anime1Titre_07 + 80
	dc.w pic_anime1Titre_07 + 120
	dc.w pic_anime1Titre_07 + 160
	dc.w pic_anime1Titre_07 + 200
pfs_anime1Titre_08:
	dc.w pic_anime1Titre_08 + 0
	dc.w pic_anime1Titre_08 + 40
	dc.w pic_anime1Titre_08 + 80
	dc.w pic_anime1Titre_08 + 120
	dc.w pic_anime1Titre_08 + 160
	dc.w pic_anime1Titre_08 + 200
ptr_anim_titre:
	dc.w pfs_anime1Titre_01
	dc.w pfs_anime1Titre_02
	dc.w pfs_anime1Titre_03
	dc.w pfs_anime1Titre_04
	dc.w pfs_anime1Titre_05
	dc.w pfs_anime1Titre_06
	dc.w pfs_anime1Titre_07
	dc.w pfs_anime1Titre_08
seq_anim_titre:
	dc.b $00, $01, $02, $03, $04, $05, $06, $07
	dc.b $06, $07, $06, $07, $06, $07, $ff
clip_anim_titre:
	dc.b $00	; type animation
	dc.w ptr_anim_titre
	dc.w seq_anim_titre
