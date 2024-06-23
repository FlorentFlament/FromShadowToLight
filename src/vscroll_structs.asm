ptr_gfx_40x240_bloc1:
	dc.w pf0_gfx_40x240_bloc1
	dc.w pf1_gfx_40x240_bloc1
	dc.w pf2_gfx_40x240_bloc1
	dc.w pf3_gfx_40x240_bloc1
	dc.w pf4_gfx_40x240_bloc1
	dc.w pf5_gfx_40x240_bloc1
clip_gfx_40x240_bloc1:
	dc.b 1	; type vertical scroller
	dc.w ptr_gfx_40x240_bloc1
	dc.w 320	; picture height
        ;; Duration 1280
	dc.b 53	; scroll speed

ptr_gfx_40x320_bloc2:
	dc.w pf0_gfx_40x320_bloc2
	dc.w pf1_gfx_40x320_bloc2
	dc.w pf2_gfx_40x320_bloc2
	dc.w pf3_gfx_40x320_bloc2
	dc.w pf4_gfx_40x320_bloc2
	dc.w pf5_gfx_40x320_bloc2
clip_gfx_40x320_bloc2:
	dc.b 1	; type vertical scroller
	dc.w ptr_gfx_40x320_bloc2
	dc.w 400	; picture height
        ;; Duration 1536
	dc.b 57	; scroll speed

ptr_gfx_40x360_bloc3:
	dc.w pf0_gfx_40x360_bloc3
	dc.w pf1_gfx_40x360_bloc3
	dc.w pf2_gfx_40x360_bloc3
	dc.w pf3_gfx_40x360_bloc3
	dc.w pf4_gfx_40x360_bloc3
	dc.w pf5_gfx_40x360_bloc3
clip_gfx_40x360_bloc3:
	dc.b 1	; type vertical scroller
	dc.w ptr_gfx_40x360_bloc3
	dc.w 440	; picture height
        ;; Duration 1792
	dc.b 54	; scroll speed

ptr_gfx_40x200_bloc4:
	dc.w pf0_gfx_40x200_bloc4
	dc.w pf1_gfx_40x200_bloc4
	dc.w pf2_gfx_40x200_bloc4
	dc.w pf3_gfx_40x200_bloc4
	dc.w pf4_gfx_40x200_bloc4
	dc.w pf5_gfx_40x200_bloc4
clip_gfx_40x200_bloc4:
	dc.b 1	; type vertical scroller
	dc.w ptr_gfx_40x200_bloc4
	dc.w 280	; picture height
        ;; Duration 1024
	dc.b 57	; scroll speed

ptr_gfx_40x160_bloc5:
	dc.w pf0_gfx_40x160_bloc5
	dc.w pf1_gfx_40x160_bloc5
	dc.w pf2_gfx_40x160_bloc5
	dc.w pf3_gfx_40x160_bloc5
	dc.w pf4_gfx_40x160_bloc5
	dc.w pf5_gfx_40x160_bloc5
clip_gfx_40x160_bloc5:
	dc.b 1	; type vertical scroller
	dc.w ptr_gfx_40x160_bloc5
	dc.w 280	; picture height
        ;; Duration 1024
	dc.b 57	; scroll speed

