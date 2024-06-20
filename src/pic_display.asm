;;; Picture display code

LINES_COUNT = 40        ; lines per pic (graphic)
LINES_THICK = 6         ; line width (in pixels)

;;; Picture display kernal macro
        MAC m_pic_kernal
	ldy #(LINES_COUNT-1)
        ldx clip_offset
        jmp .inner
.outer:
	ldx #(LINES_THICK-1)
.inner:
	sta WSYNC
	lda (pic_p0),Y
	sta PF0
	lda (pic_p1),Y
	sta PF1
	lda (pic_p2),Y
	sta PF2
	lda (pic_p3),Y
	sta PF0
	lda (pic_p4),Y
	sta PF1
	lda (pic_p5),Y
	sta PF2
	dex
	bpl .inner
	dey
	bpl .outer

	sta WSYNC
	lda #$00
	sta PF0
	sta PF1
	sta PF2
        jmp RTSBank
        ENDM
