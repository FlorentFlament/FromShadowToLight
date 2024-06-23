;;; Animation setup macro
        MAC m_animation_setup
        ;; Always large first line
        lda #(LINES_THICK-1)
        sta clip_offset
        ;; Update clip_counter and clip_state
        lda clip_counter
        sec
        sbc #64
        sta clip_counter
        bcs .skip
        inc clip_state
        bne .skip
        inc clip_state+1
.skip:

        ;; ptr stores clip pointer
        ldy #$03
        lda (ptr),Y
        sta ptr1
        ldy #$04
        lda (ptr),Y
        sta ptr1+1              ; ptr1 stores sequence pointer

.load_next_pic:
        ldy clip_state          ; Only using LSB for animations
        lda (ptr1),Y
        cmp #$ff                ; Loop animation marker
        bne .continue
        iny
        lda (ptr1),Y
        sta clip_state
        jmp .load_next_pic
.continue:
        tax                     ; X stores picture index

        ldy #$01
        lda (ptr),Y
        sta ptr1
        ldy #$02
        lda (ptr),Y
        sta ptr1+1              ; ptr1 strores pictures pointer

        txa
        asl
        tay
        lda (ptr1),Y
        sta ptr
        iny
        lda (ptr1),Y
        sta ptr+1               ; ptr stores picture ptr

        ;; ptr points to 6 addresses, one for each playfield
        ldy #(12-1)
.setup_loop:
        lda (ptr),Y
        sta pic_p0,Y
        dey
        bpl .setup_loop
.end:
        ENDM
;;; End animation setup macro


;;; Vscroll common setup
;;; ptr stores clip pointer
;;; prt2 stores the offset in the vscroll picture
;;; At the end, pic_p0, pic_p1, ..., pic_p5 will hold appropriate pointers
;;; ptr1 is used
        MAC m_vscroll_common_setup
        ldy #$01
        lda (ptr),Y
        sta ptr1
        ldy #$02
        lda (ptr),Y
        sta ptr1+1              ; ptr1 strores pictures pointer

        ;; ptr1 points to 6 addresses, one for each playfield
        ;; ptr2 stores the offset in the picture
        ldy #0
.setup_loop:
        lda (ptr1),Y
        clc
        adc ptr2
        sta pic_p0,Y
        iny
        lda (ptr1),Y
        adc ptr2+1
        sta pic_p0,Y
        iny
        cpy #12
        bne .setup_loop
        ENDM
;;; End Vscroll common setup macro

;;; Picture State Remain
;;; ptr points to a clip structure
;;; -> ptr1 = pic_height - 40
;;; -> ptr2 = pic_height - 40 - clip_state
        MAC m_picture_state_remain
        ;; Fetch picture height
        ldy #$03
        lda (ptr),Y
        sta ptr1
        ldy #$04
        lda (ptr),Y
        sta ptr1+1
        ;; substract screen height (40 lines)
        sec
        lda ptr1
        sbc #40
        sta ptr1
        lda ptr1+1
        sbc #0
        sta ptr1+1
        ;; substract clip_state
        sec
        lda ptr1
        sbc clip_state
        sta ptr2
        lda ptr1+1
        sbc clip_state+1
        sta ptr2+1
        ENDM
;;; End Picture State Remain

;;; Vscroll bottom-up setup macro
;;; ptr points to bottom-up vscroll clip
        MAC m_vscroll_bottom_up_setup
        ;; Fetch vscroll speed in ptr1
        ldy #$05
        lda (ptr),Y
        sta ptr1
        ;; Update clip_counter
        lda clip_counter
        sec
        sbc ptr1
        sta clip_counter

.update_offset_loop:
        ;; update clip_offset & clip_state
        lda clip_offset
        beq .inc_state
        dec clip_offset
        jmp .skip
.inc_state:
        lda #(LINES_THICK-1)
        sta clip_offset
        inc clip_state
        bne .skip
        inc clip_state+1
.skip:
        lda clip_counter
        clc
        adc #40 ; Divider step
        sta clip_counter
        bcc .update_offset_loop

        ;; Compute offset in ptr2
        m_picture_state_remain
        ;; Capping
        bcs .positive
        lda #$00
        sta ptr2
        sta ptr2+1
        sta clip_offset
        ;; We could also cap clip_state if required
.positive:
        m_vscroll_common_setup
        ENDM
;;; End Vscroll bottom-up setup macro


;;; Vscroll top-down setup macro
        MAC m_vscroll_top_down_setup
        ;; Fetch vscroll speed in ptr1
        ldy #$05
        lda (ptr),Y
        sta ptr1
        ;; Update clip_counter
        lda clip_counter
        sec
        sbc ptr1
        sta clip_counter

.update_offset_loop:
        ;; update clip_offset & clip_state
        lda clip_offset
        cmp #(LINES_THICK-1)
        beq .inc_state
        inc clip_offset
        jmp .skip
.inc_state:
        lda #0
        sta clip_offset
        inc clip_state
        bne .skip
        inc clip_state+1
.skip:
        lda clip_counter
        clc
        adc #40 ; Divider step
        sta clip_counter
        bcc .update_offset_loop

        m_picture_state_remain
        ;; Capping
        bcc .positive
        lda clip_state
        sta ptr2
        lda clip_state+1
        sta ptr2+1
        jmp .continue
.positive:
        lda ptr1
        sta ptr2
        lda ptr1+1
        sta ptr2+1
        lda #(LINES_THICK-1)
        sta clip_offset
.continue:
        m_vscroll_common_setup
        ENDM
;;; End Vscroll top-down setup macro


;;; Clip setup macro
;;; Uses clip_index, clip_state, clip_counter
        MAC m_clip_setup
        ;; Just sets colors
        lda #$00
        sta COLUBK
        lda #$fe
        sta COLUPF

        lda clip_index
        asl
        tax
        lda clips_sequence,X
        sta ptr
        lda clips_sequence+1,X
        sta ptr+1               ; Address of clip to display stored in ptr

        ldy #$00
        lda (ptr),Y
        bne .vscroll            ; If first byte is not 0 we've got a vscroll
        m_animation_setup
        jmp .end
.vscroll:
        cmp #1
        bne .top_down
        m_vscroll_bottom_up_setup
        jmp .end
.top_down:
        m_vscroll_top_down_setup
.end:
        ENDM
;;; End Clip setup macro


;;; Macro to check whether to switch to next clip
        MAC m_check_clipswitch
	lda clip_index
	asl
	tax
	lda clipswitch,X
	cmp frame_cnt
        bne .no_switch
        lda clipswitch+1,X
        cmp frame_cnt+1
        bne .no_switch
        ; Switch part
        inc clip_index
        lda #$00
        sta clip_state
        sta clip_state+1
        lda #$ff
        sta clip_counter
.no_switch:
        ENDM
;;; End of macro to check whether to switch to next clip

        MAC m_init
        lda #$ff
        sta clip_counter
        ENDM

        MAC m_vblank
        m_check_clipswitch
        m_clip_setup
        ENDM

        MAC m_kernal
        m_pic_kernal_meta
        ENDM

        MAC m_overscan
        inc frame_cnt
        bne .continue
        inc frame_cnt+1
.continue:
        ENDM
