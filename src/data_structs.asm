;;; Overall sequence of clips
clips_sequence:
        dc.w clip_gfx_40x240_bloc1
        dc.w clip_anim_titre
        dc.w clip_gfx_40x320_bloc2
        dc.w clip_anim_ampoule
        dc.w clip_gfx_40x360_bloc3
        dc.w clip_anim_cul
        dc.w clip_gfx_40x200_bloc4
        dc.w clip_anim_ampoulecul
        dc.w clip_animeAmpouleCul_bloc120
        dc.w clip_gfx_40x160_bloc5
        dc.w clip_anim_in_your_ass

;;; specifies on which frame to switch parts
M_C0 = 1024
M_C1 = M_C0 + 256
M_C2 = M_C1 + 1024
M_C3 = M_C2 + 256
M_C4 = M_C3 + 1024
M_C5 = M_C4 + 256
M_C6 = M_C5 + 1024
M_C7 = M_C6 + 64
M_C8 = M_C7 + 192
M_C9 = M_C8 + 1024
M_C10 = 0
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
        .word M_C10

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
ptr_anim_in_your_ass:
	dc.w pfs_blank
	dc.w pfs_anime3Cul_08
seq_anim_cul:
	dc.b 0, 0, 0, 0, 0, 0, 0, 0
        dc.b 1, 1, 1, 1, 1, 1, 1, 1
        dc.b 2, 2, 3, 3, 4, 5, 6, 7
        dc.b 7, 7, 7, 7, 7, 7, 8, 8
	dc.b $ff, 28
clip_anim_cul:
	dc.b $00	; type animation
	dc.w ptr_anim_cul
	dc.w seq_anim_cul
seq_anim_in_your_ass:
	dc.b 1, 1, 0, 0, 1, 1, 0, 0
	dc.b 1, 1, 0, 0, 1, 1, 0, 0
	dc.b 1, 1, 0, 0, 1, 1, 0, 0
	dc.b 1, 1, 0, 0, 1, 1, 0, 0
	dc.b 1, 0, 1, 0, 1, 0, 1, 0
	dc.b 1, 0, 1, 0, 1, 0, 1, 0
	dc.b 1, 0, 1, 0, 1, 0, 1, 0
	dc.b 1, 0, 1, 0, 1, 0, 1, 0
	dc.b 1, 1, 1, 1, 0, 0, 0, 0
	dc.b 1, 1, 1, 1, 0, 0, 0, 0
	dc.b 1, 1, 1, 1, 0, 0, 0, 0
	dc.b 1, 1, 1, 1, 0, 0, 0, 0
        dc.b $ff, 0
clip_anim_in_your_ass:
	dc.b $00	; type animation
	dc.w ptr_anim_in_your_ass
	dc.w seq_anim_in_your_ass
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
	dc.b 0, 1, 0, 1, 2, 3, 2, 3
        dc.b 4, 5, 4, 5, 6, 7, 6, 7
        dc.b 6, 6, 7, 7
	dc.b $ff, 16
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
	dc.b 0, 0, 0, 0, 0, 0, 0, 0
        dc.b 1, 1, 1, 1, 1, 1, 1, 1
        dc.b 2, 2, 2, 2, 2, 2, 2, 2
        dc.b 3, 3, 3, 3, 3, 3, 3, 3
        dc.b 4, 4, 5, 5, 4, 4, 5, 5
        dc.b 4, 4, 5, 5, 4, 4, 5, 5
        dc.b 4, 5
	dc.b $ff, 48
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
	dc.b 0, 0, 0, 0, 0, 0, 1, 1
        dc.b 1, 1, 1, 1, 2, 2, 3, 4
        dc.b $ff, 15
clip_anim_ampoulecul:
	dc.b $00	; type animation
	dc.w ptr_anim_ampoulecul
	dc.w seq_anim_ampoulecul
ptr_gfx_40x240_bloc1:
	dc.w pf0_gfx_40x240_bloc1
	dc.w pf1_gfx_40x240_bloc1
	dc.w pf2_gfx_40x240_bloc1
	dc.w pf3_gfx_40x240_bloc1
	dc.w pf4_gfx_40x240_bloc1
	dc.w pf5_gfx_40x240_bloc1
clip_gfx_40x240_bloc1:
	dc.b $01	; type vertical scroller
	dc.w ptr_gfx_40x240_bloc1
	dc.w $118	; picture height
        dc.b 65         ; scroll speed 65/40
        ;; Formula is ceil(40 * (6*pic_height - 240) / (1024-128))
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
	dc.w $168	; picture height
        dc.b 86
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
	dc.w $190	; picture height
        dc.b 97
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
	dc.w $f0	; picture height
        dc.b 54
ptr_animeAmpouleCul_bloc120:
	dc.w pf0_animeAmpouleCul_bloc120
	dc.w pf1_animeAmpouleCul_bloc120
	dc.w pf2_animeAmpouleCul_bloc120
	dc.w pf3_animeAmpouleCul_bloc120
	dc.w pf4_animeAmpouleCul_bloc120
	dc.w pf5_animeAmpouleCul_bloc120
clip_animeAmpouleCul_bloc120:
	dc.b $02	; type vertical scroller bottom up
	dc.w ptr_animeAmpouleCul_bloc120
	dc.w $78	; picture height
        dc.b 160
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
	dc.w $f0	; picture height
        dc.b 54
