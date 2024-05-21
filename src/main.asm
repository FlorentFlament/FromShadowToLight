;;;-----------------------------------------------------------------------------
;;; Header

	PROCESSOR 6502
	INCLUDE "vcs.h"		; Provides RIOT & TIA memory map
	INCLUDE "macro.h"	; This file includes some helper macros

;;;-----------------------------------------------------------------------------
;;; RAM segment
	SEG.U   ram
	ORG     $0080
RAM_START equ *
        INCLUDE "variables.asm"
        echo "Used RAM:", (* - RAM_START)d, "bytes"

;;;-----------------------------------------------------------------------------
;;; Code segment
	SEG code
	ORG $F000

DATA_START equ *
        INCLUDE "testpic.asm"
        echo "DATA size:", (* - DATA_START)d, "bytes"

CODE_START equ *
        INCLUDE "pic_display.asm"

        MAC m_wait_timint
.wait_timint
	lda TIMINT
	beq .wait_timint
        sta WSYNC
        ENDM

init:
        CLEAN_START		; Initializes Registers & Memory

main_loop:
	VERTICAL_SYNC		; 4 scanlines Vertical Sync signal
.vblank:
	lda #56
	sta TIM64T
	m_wait_timint
.kernel:
	lda #251
	sta TIM64T
        lda #<pf_anime3Cul_01_ptr
        sta ptr
        lda #>pf_anime3Cul_01_ptr
        sta ptr+1
        m_pic_kernal
	m_wait_timint
.overscan:
	lda #56
	sta TIM64T
	m_wait_timint
	jmp main_loop

	echo "CODE size:", (* - CODE_START)d, "bytes"
	echo "Used ROM:", (* - $F000)d, "bytes"
	echo "Remaining ROM:", ($FFFC - *)d, "bytes"

;;;-----------------------------------------------------------------------------
;;; Reset Vector
	SEG reset
	ORG $FFFC
	DC.W init
	DC.W init
