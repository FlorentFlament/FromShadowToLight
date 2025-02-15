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
        INCLUDE "InYourAss-01k_variables.asm"
        INCLUDE "variables.asm"
        echo "Used RAM:", (* - RAM_START)d, "bytes"

;;; ----------------------------------------------------------------------------
;;; Bank switching macro by Tjoppen (slightly adapted)
RTSBank equ $1FD9
JMPBank equ $1FE6

;39 byte bootstrap macro
;Includes RTSBank, JMPBank routines and JMP to Start in Bank 7
	MAC END_SEGMENT_CODE
	;RTSBank
	;Perform a long RTS
	tsx
	lda $02,X
	;decode bank
	;bank 0: $1000-$1FFF
	;bank 1: $3000-$3FFF
	;...
	;bank 7: $F000-$FFFF
	lsr
	lsr
	lsr
	lsr
	lsr
	tax
	nop $1FF4,X ;3 B
	rts
	;JMPBank
	;Perform a long jmp to (ptr)
	;The bank number is stored in the topmost three bits of (ptr)
	;Example usage:
	;   SET_POINTER ptr, Address
	;   jsr JMPBank
	;
	;$1FE6-$1FED
	lda banksw_ptr+1
	lsr
	lsr
	lsr
	lsr
	lsr
	tax
	;$1FEE-$1FF3
	nop $1FF4,X ;3 B
	jmp (banksw_ptr)   ;3 B
	ENDM

	MAC END_SEGMENT
.BANK	SET {1}
	echo "Bank",(.BANK)d,":", ((RTSBank + (.BANK * 8192)) - *)d, "free"

	ORG RTSBank + (.BANK * 4096)
	RORG RTSBank + (.BANK * 8192)
	END_SEGMENT_CODE
;$1FF4-$1FFB - These are the bankswitching hotspots
	.byte 0,0,0,0
	.byte 0,0,0,$4C ;JMP Start (reading the instruction jumps to bank 7, i.e init address)
;$1FFC-1FFF
	.word $1FFB
	.word $1FFB
;Bank .BANK+1
	ORG $1000 + ((.BANK + 1) * 4096)
	RORG $1000 + ((.BANK + 1) * 8192)
	ENDM
; End of bank switching macro definitions

;;; Other useful macros
        MAC m_wait_timint
.wait_timint
	lda TIMINT
	beq .wait_timint
        sta WSYNC
        ENDM

;;; Demo specific macros
        INCLUDE "pic_display.asm"

;-----------------------------------------------------------------------------
; Code segment
	SEG code
	ORG $1000
	RORG $1000
; Bank 0
pic_kernal_bank0:       SUBROUTINE
        m_pic_kernal
        INCLUDE "data_anim_cul.asm"
        INCLUDE "data_anim_ampoulecul.asm"
	END_SEGMENT 0
; Bank 1
pic_kernal_bank1:       SUBROUTINE
        m_pic_kernal
        INCLUDE "data_anim_titre.asm"
        INCLUDE "data_anim_ampoule.asm"
	END_SEGMENT 1
; Bank 2
pic_kernal_bank2:       SUBROUTINE
        m_pic_kernal
        INCLUDE "data_vscroll_bloc1.asm"
        INCLUDE "data_vscroll_bloc2.asm"
	END_SEGMENT 2
; Bank 3
pic_kernal_bank3:       SUBROUTINE
        m_pic_kernal
        INCLUDE "data_vscroll_bloc3.asm"
        INCLUDE "data_vscroll_bloc4.asm"
	END_SEGMENT 3
; Bank 4
pic_kernal_bank4:       SUBROUTINE
        m_pic_kernal
        INCLUDE "data_vscroll_ampoulecul.asm"
        INCLUDE "data_vscroll_bloc5.asm"
        INCLUDE "data_calage_beamer.asm"
	END_SEGMENT 4
; Bank 5
pic_kernal_bank5:       SUBROUTINE
        m_pic_kernal
	END_SEGMENT 5
; Bank 6
pic_kernal_bank6:       SUBROUTINE
        m_pic_kernal
	END_SEGMENT 6
; Bank 7
pic_kernal_bank7:       SUBROUTINE
        m_pic_kernal
        INCLUDE "InYourAss-01k_trackdata.asm"
        INCLUDE "data_structs.asm"
        INCLUDE "vscroll_structs.asm"
        INCLUDE "clips_logic.asm"

;;; Bank switching logic
pic_kernal_ptrs:
        dc.w pic_kernal_bank0
        dc.w pic_kernal_bank1
        dc.w pic_kernal_bank2
        dc.w pic_kernal_bank3
        dc.w pic_kernal_bank4
        dc.w pic_kernal_bank5
        dc.w pic_kernal_bank6
        dc.w pic_kernal_bank7

        MAC m_pic_kernal_meta
        ;; picture to configure needs to be in ptr
        lda pic_p0+1            ; Loading MSB
        and #$e0                ; Extract bank number *2
        REPEAT 4
        lsr
        REPEND
        tax
        lda pic_kernal_ptrs,X
        sta banksw_ptr
        lda pic_kernal_ptrs+1,X
        sta banksw_ptr+1
	jsr JMPBank
        ENDM

init:
        CLEAN_START		; Initializes Registers & Memory
        INCLUDE "InYourAss-01k_init.asm"
        m_init
main_loop:
	VERTICAL_SYNC		; 4 scanlines Vertical Sync signal
.vblank:
	lda #48
	sta TIM64T
        lda clip_index
        bne .play_the_music
        jmp nosound
.play_the_music:
        INCLUDE "InYourAss-01k_player.asm"
nosound:
        m_vblank
	m_wait_timint
.kernel:
	lda #18
	sta T1024T
        m_kernal
	m_wait_timint
.overscan:
	lda #28
	sta TIM64T
        m_overscan
	m_wait_timint
	jmp main_loop

;;; Bank 7 END_SEGMENT
	echo "Bank 7 :", ((RTSBank + (7 * 8192)) - *)d, "free"
	ORG RTSBank + $7000
	RORG RTSBank + $E000
	END_SEGMENT_CODE
	;$1FF4-$1FFB
	.byte 0,0,0,0
	.byte 0,0,0,$4C
	;$1FFC-1FFF
	.word init
	.word init
