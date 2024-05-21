;;; Picture display code

LINES_COUNT = 40        ; lines per pic (graphic)
LINES_THICK = 6         ; line width (in pixels)

;;; Setup picture macro
        MAC m_pic_setup
        ;; Address of picture to display is passed in ptr
        ;; Address points to 6 addresses, one for each playfield
        lda #$00
        sta COLUBK
        lda #$fe
        sta COLUPF

        ldy #(12-1)
.setup_loop:
        lda (ptr),Y
        sta pic_p0,Y
        dey
        bpl .setup_loop
        ENDM

;;; Picture display kernal macro
        MAC m_pic_kernal
	ldy #(LINES_COUNT-1)
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
        ENDM
