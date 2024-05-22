;;; Overall sequence of clips
clips_sequence:
        dc.w clip_gfx_40x200_bloc1
        dc.w clip_anim_titre
        dc.w clip_gfx_40x320_bloc2
        dc.w clip_anim_ampoule
        dc.w clip_gfx_40x360_bloc3
        dc.w clip_anim_cul
        dc.w clip_gfx_40x200_bloc4
        dc.w clip_anim_ampoulecul
        dc.w clip_gfx_40x160_bloc5
        dc.w clip_animeAmpouleCul_bloc120
        
;;; specifies on which frame to switch parts
M_C0 = 1000
M_C1 = M_C0 + 250
M_C2 = M_C1 + 1500
M_C3 = M_C2 + 250
M_C4 = M_C3 + 1750
M_C5 = M_C4 + 250
M_C6 = M_C5 + 1000
M_C7 = M_C6 + 150
M_C8 = M_C7 + 1000
M_C9 = 0
clipswitch:
        .word M_C0
        .word M_C1
        .word M_C2
        .word M_C3
        .word M_C4
        .word M_C5
        .word M_C6
        .word M_C7
        .word M_C8
        .word M_C9

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
pfs_anime2Ampoule_01:
	dc.w pic_anime2Ampoule_01 + 0
	dc.w pic_anime2Ampoule_01 + 40
	dc.w pic_anime2Ampoule_01 + 80
	dc.w pic_anime2Ampoule_01 + 120
	dc.w pic_anime2Ampoule_01 + 160
	dc.w pic_anime2Ampoule_01 + 200
pfs_anime2Ampoule_02:
	dc.w pic_anime2Ampoule_02 + 0
	dc.w pic_anime2Ampoule_02 + 40
	dc.w pic_anime2Ampoule_02 + 80
	dc.w pic_anime2Ampoule_02 + 120
	dc.w pic_anime2Ampoule_02 + 160
	dc.w pic_anime2Ampoule_02 + 200
pfs_anime2Ampoule_03:
	dc.w pic_anime2Ampoule_03 + 0
	dc.w pic_anime2Ampoule_03 + 40
	dc.w pic_anime2Ampoule_03 + 80
	dc.w pic_anime2Ampoule_03 + 120
	dc.w pic_anime2Ampoule_03 + 160
	dc.w pic_anime2Ampoule_03 + 200
pfs_anime2Ampoule_04:
	dc.w pic_anime2Ampoule_04 + 0
	dc.w pic_anime2Ampoule_04 + 40
	dc.w pic_anime2Ampoule_04 + 80
	dc.w pic_anime2Ampoule_04 + 120
	dc.w pic_anime2Ampoule_04 + 160
	dc.w pic_anime2Ampoule_04 + 200
pfs_anime2Ampoule_05:
	dc.w pic_anime2Ampoule_05 + 0
	dc.w pic_anime2Ampoule_05 + 40
	dc.w pic_anime2Ampoule_05 + 80
	dc.w pic_anime2Ampoule_05 + 120
	dc.w pic_anime2Ampoule_05 + 160
	dc.w pic_anime2Ampoule_05 + 200
pfs_anime2Ampoule_06:
	dc.w pic_anime2Ampoule_06 + 0
	dc.w pic_anime2Ampoule_06 + 40
	dc.w pic_anime2Ampoule_06 + 80
	dc.w pic_anime2Ampoule_06 + 120
	dc.w pic_anime2Ampoule_06 + 160
	dc.w pic_anime2Ampoule_06 + 200
ptr_anim_ampoule:
	dc.w pfs_anime2Ampoule_01
	dc.w pfs_anime2Ampoule_02
	dc.w pfs_anime2Ampoule_03
	dc.w pfs_anime2Ampoule_04
	dc.w pfs_anime2Ampoule_05
	dc.w pfs_anime2Ampoule_06
seq_anim_ampoule:
	dc.b $00, $01, $02, $03, $04, $05, $04, $05
	dc.b $04, $05, $04, $05, $ff
clip_anim_ampoule:
	dc.b $00	; type animation
	dc.w ptr_anim_ampoule
	dc.w seq_anim_ampoule
pfs_anime4AmpouleCul_01:
	dc.w pic_anime4AmpouleCul_01 + 0
	dc.w pic_anime4AmpouleCul_01 + 40
	dc.w pic_anime4AmpouleCul_01 + 80
	dc.w pic_anime4AmpouleCul_01 + 120
	dc.w pic_anime4AmpouleCul_01 + 160
	dc.w pic_anime4AmpouleCul_01 + 200
pfs_anime4AmpouleCul_02:
	dc.w pic_anime4AmpouleCul_02 + 0
	dc.w pic_anime4AmpouleCul_02 + 40
	dc.w pic_anime4AmpouleCul_02 + 80
	dc.w pic_anime4AmpouleCul_02 + 120
	dc.w pic_anime4AmpouleCul_02 + 160
	dc.w pic_anime4AmpouleCul_02 + 200
pfs_anime4AmpouleCul_03:
	dc.w pic_anime4AmpouleCul_03 + 0
	dc.w pic_anime4AmpouleCul_03 + 40
	dc.w pic_anime4AmpouleCul_03 + 80
	dc.w pic_anime4AmpouleCul_03 + 120
	dc.w pic_anime4AmpouleCul_03 + 160
	dc.w pic_anime4AmpouleCul_03 + 200
pfs_anime4AmpouleCul_04:
	dc.w pic_anime4AmpouleCul_04 + 0
	dc.w pic_anime4AmpouleCul_04 + 40
	dc.w pic_anime4AmpouleCul_04 + 80
	dc.w pic_anime4AmpouleCul_04 + 120
	dc.w pic_anime4AmpouleCul_04 + 160
	dc.w pic_anime4AmpouleCul_04 + 200
pfs_anime4AmpouleCul_05:
	dc.w pic_anime4AmpouleCul_05 + 0
	dc.w pic_anime4AmpouleCul_05 + 40
	dc.w pic_anime4AmpouleCul_05 + 80
	dc.w pic_anime4AmpouleCul_05 + 120
	dc.w pic_anime4AmpouleCul_05 + 160
	dc.w pic_anime4AmpouleCul_05 + 200
ptr_anim_ampoulecul:
	dc.w pfs_anime4AmpouleCul_01
	dc.w pfs_anime4AmpouleCul_02
	dc.w pfs_anime4AmpouleCul_03
	dc.w pfs_anime4AmpouleCul_04
	dc.w pfs_anime4AmpouleCul_05
seq_anim_ampoulecul:
	dc.b $00, $01, $02, $03, $04, $ff
clip_anim_ampoulecul:
	dc.b $00	; type animation
	dc.w ptr_anim_ampoulecul
	dc.w seq_anim_ampoulecul
ptr_gfx_40x200_bloc1:
	dc.w pf0_gfx_40x200_bloc1
	dc.w pf1_gfx_40x200_bloc1
	dc.w pf2_gfx_40x200_bloc1
	dc.w pf3_gfx_40x200_bloc1
	dc.w pf4_gfx_40x200_bloc1
	dc.w pf5_gfx_40x200_bloc1
clip_gfx_40x200_bloc1:
	dc.b $01	; type vertical scroller
	dc.w ptr_gfx_40x200_bloc1
	dc.w $c8	; picture height
ptr_gfx_40x320_bloc2:
	dc.w pf0_gfx_40x320_bloc2
	dc.w pf1_gfx_40x320_bloc2
	dc.w pf2_gfx_40x320_bloc2
	dc.w pf3_gfx_40x320_bloc2
	dc.w pf4_gfx_40x320_bloc2
	dc.w pf5_gfx_40x320_bloc2
clip_gfx_40x320_bloc2:
	dc.b $01	; type vertical scroller
	dc.w ptr_gfx_40x320_bloc2
	dc.w $140	; picture height
ptr_gfx_40x360_bloc3:
	dc.w pf0_gfx_40x360_bloc3
	dc.w pf1_gfx_40x360_bloc3
	dc.w pf2_gfx_40x360_bloc3
	dc.w pf3_gfx_40x360_bloc3
	dc.w pf4_gfx_40x360_bloc3
	dc.w pf5_gfx_40x360_bloc3
clip_gfx_40x360_bloc3:
	dc.b $01	; type vertical scroller
	dc.w ptr_gfx_40x360_bloc3
	dc.w $168	; picture height
ptr_gfx_40x200_bloc4:
	dc.w pf0_gfx_40x200_bloc4
	dc.w pf1_gfx_40x200_bloc4
	dc.w pf2_gfx_40x200_bloc4
	dc.w pf3_gfx_40x200_bloc4
	dc.w pf4_gfx_40x200_bloc4
	dc.w pf5_gfx_40x200_bloc4
clip_gfx_40x200_bloc4:
	dc.b $01	; type vertical scroller
	dc.w ptr_gfx_40x200_bloc4
	dc.w $c8	; picture height
ptr_animeAmpouleCul_bloc120:
	dc.w pf0_animeAmpouleCul_bloc120
	dc.w pf1_animeAmpouleCul_bloc120
	dc.w pf2_animeAmpouleCul_bloc120
	dc.w pf3_animeAmpouleCul_bloc120
	dc.w pf4_animeAmpouleCul_bloc120
	dc.w pf5_animeAmpouleCul_bloc120
clip_animeAmpouleCul_bloc120:
	dc.b $01	; type vertical scroller
	dc.w ptr_animeAmpouleCul_bloc120
	dc.w $78	; picture height
ptr_gfx_40x160_bloc5:
	dc.w pf0_gfx_40x160_bloc5
	dc.w pf1_gfx_40x160_bloc5
	dc.w pf2_gfx_40x160_bloc5
	dc.w pf3_gfx_40x160_bloc5
	dc.w pf4_gfx_40x160_bloc5
	dc.w pf5_gfx_40x160_bloc5
clip_gfx_40x160_bloc5:
	dc.b $01	; type vertical scroller
	dc.w ptr_gfx_40x160_bloc5
	dc.w $c8	; picture height
