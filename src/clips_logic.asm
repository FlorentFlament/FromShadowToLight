;;; Animation setup macro
        MAC m_animation_setup
        ;; Update clip_counter and clip_state
        lda clip_counter
        sec
        sbc #50                 ; Random value
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

        ldy clip_state          ; Only using LSB for animations
        lda (ptr1),Y
        cmp #$ff                ; End of animation marker
        bne .continue
        dec clip_state
        jmp .end
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


;;; Vscroll setup macro
        MAC m_vscroll_setup
        ;; Update clip_counter and clip_state
;        lda clip_counter
;        sec
;        sbc #255                 ; Random value
;        sta clip_counter
;        bcs .skip
        ;; increase clip_offset or clip_state
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

        ;; Compute offset in ptr2
        ;; Fetch picture height
        ldy #$03
        lda (ptr),Y
        sta ptr2
        ldy #$04
        lda (ptr),Y
        sta ptr2+1
        ;; substract picture height (40)
        sec
        lda ptr2
        sbc #40
        sta ptr2
        lda ptr2+1
        sbc #0
        sta ptr2+1
        ;; substract clip_state
        sec
        lda ptr2
        sbc clip_state
        sta ptr2
        lda ptr2+1
        sbc clip_state+1
        sta ptr2+1
        bcs .positive
        lda #$00
        sta ptr2
        sta ptr2+1
        sta clip_offset
.positive

        ;; ptr stores clip pointer
        ldy #$01
        lda (ptr),Y
        sta ptr1
        ldy #$02
        lda (ptr),Y
        sta ptr1+1              ; ptr1 strores pictures pointer

        ;; ptr1 points to 6 addresses, one for each playfield
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
;;; End Vscroll setup macro


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
        m_vscroll_setup
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
