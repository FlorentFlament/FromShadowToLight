;;; Clip setup macro
;;; Uses clip_index, clip_state, clip_counter
        MAC m_clip_setup
        ;; Address of clip to display is passed in ptr
        lda #$00
        sta COLUBK
        lda #$fe
        sta COLUPF

        ldy #$03
        lda (ptr),Y
        sta ptr1
        ldy #$04
        lda (ptr),Y
        sta ptr1+1              ; ptr1 strores sequence pointer

        ldy clip_state
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

        ;; Update clip_counter and clip_state
        lda clip_counter
        sec
        sbc #30                 ; Random value
        sta clip_counter
        bcs .skip
        inc clip_state
.skip:
        ENDM
;;; End of clip setup macro


        MAC m_init
        lda #$ff
        sta clip_counter
        ENDM

        MAC m_vblank
        SET_POINTER ptr, clip_anim_cul
        m_clip_setup
        ENDM

        MAC m_kernal
        m_pic_kernal_meta
        ENDM

        MAC m_overscan
        ENDM
