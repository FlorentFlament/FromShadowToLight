; TIATracker music player
; Copyright 2016 Andre "Kylearan" Wichmann
; Website: https://bitbucket.org/kylearan/tiatracker
; Email: andre.wichmann@gmx.de
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;   http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

; Song author: Glafouk
; Song name: In your ass

; @com.wudsn.ide.asm.hardware=ATARI2600

; =====================================================================
; TIATracker melodic and percussion instruments, patterns and sequencer
; data.
; =====================================================================
tt_TrackDataStart:

; =====================================================================
; Melodic instrument definitions (up to 7). tt_envelope_index_c0/1 hold
; the index values into these tables for the current instruments played
; in channel 0 and 1.
; 
; Each instrument is defined by:
; - tt_InsCtrlTable: the AUDC value
; - tt_InsADIndexes: the index of the start of the ADSR envelope as
;       defined in tt_InsFreqVolTable
; - tt_InsSustainIndexes: the index of the start of the Sustain phase
;       of the envelope
; - tt_InsReleaseIndexes: the index of the start of the Release phase
; - tt_InsFreqVolTable: The AUDF frequency and AUDV volume values of
;       the envelope
; =====================================================================

; Instrument master CTRL values
tt_InsCtrlTable:
        dc.b $01, $04, $0c, $06, $04, $0c


; Instrument Attack/Decay start indexes into ADSR tables.
tt_InsADIndexes:
        dc.b $00, $08, $08, $0c, $11, $11


; Instrument Sustain start indexes into ADSR tables
tt_InsSustainIndexes:
        dc.b $04, $08, $08, $0d, $14, $14


; Instrument Release start indexes into ADSR tables
; Caution: Values are stored with an implicit -1 modifier! To get the
; real index, add 1.
tt_InsReleaseIndexes:
        dc.b $05, $09, $09, $0e, $15, $15


; AUDVx and AUDFx ADSR envelope values.
; Each byte encodes the frequency and volume:
; - Bits 7..4: Freqency modifier for the current note ([-8..7]),
;       8 means no change. Bit 7 is the sign bit.
; - Bits 3..0: Volume
; Between sustain and release is one byte that is not used and
; can be any value.
; The end of the release phase is encoded by a 0.
tt_InsFreqVolTable:
; 0: ---
        dc.b $8b, $8b, $8b, $89, $81, $00, $80, $00
; 1+2: ---
        dc.b $83, $00, $83, $00
; 3: ---
        dc.b $84, $84, $00, $84, $00
; 4+5: ---
        dc.b $8c, $8b, $87, $82, $00, $80, $00



; =====================================================================
; Percussion instrument definitions (up to 15)
;
; Each percussion instrument is defined by:
; - tt_PercIndexes: The index of the first percussion frame as defined
;       in tt_PercFreqTable and tt_PercCtrlVolTable
; - tt_PercFreqTable: The AUDF frequency value
; - tt_PercCtrlVolTable: The AUDV volume and AUDC values
; =====================================================================

; Indexes into percussion definitions signifying the first frame for
; each percussion in tt_PercFreqTable.
; Caution: Values are stored with an implicit +1 modifier! To get the
; real index, subtract 1.
tt_PercIndexes:
        dc.b $01, $05


; The AUDF frequency values for the percussion instruments.
; If the second to last value is negative (>=128), it means it's an
; "overlay" percussion, i.e. the player fetches the next instrument note
; immediately and starts it in the sustain phase next frame. (Needs
; TT_USE_OVERLAY)
tt_PercFreqTable:
; 0: KickShort
        dc.b $05, $09, $0c, $00
; 1: SnareShort
        dc.b $05, $1c, $08, $02, $01, $02, $00


; The AUDCx and AUDVx volume values for the percussion instruments.
; - Bits 7..4: AUDC value
; - Bits 3..0: AUDV value
; 0 means end of percussion data.
tt_PercCtrlVolTable:
; 0: KickShort
        dc.b $6f, $6d, $69, $00
; 1: SnareShort
        dc.b $8f, $cf, $6e, $8b, $87, $84, $00


        
; =====================================================================
; Track definition
; The track is defined by:
; - tt_PatternX (X=0, 1, ...): Pattern definitions
; - tt_PatternPtrLo/Hi: Pointers to the tt_PatternX tables, serving
;       as index values
; - tt_SequenceTable: The order in which the patterns should be played,
;       i.e. indexes into tt_PatternPtrLo/Hi. Contains the sequences
;       for all channels and sub-tracks. The variables
;       tt_cur_pat_index_c0/1 hold an index into tt_SequenceTable for
;       each channel.
;
; So tt_SequenceTable holds indexes into tt_PatternPtrLo/Hi, which
; in turn point to pattern definitions (tt_PatternX) in which the notes
; to play are specified.
; =====================================================================

; ---------------------------------------------------------------------
; Pattern definitions, one table per pattern. tt_cur_note_index_c0/1
; hold the index values into these tables for the current pattern
; played in channel 0 and 1.
;
; A pattern is a sequence of notes (one byte per note) ending with a 0.
; A note can be either:
; - Pause: Put melodic instrument into release. Must only follow a
;       melodic instrument.
; - Hold: Continue to play last note (or silence). Default "empty" note.
; - Slide (needs TT_USE_SLIDE): Adjust frequency of last melodic note
;       by -7..+7 and keep playing it
; - Play new note with melodic instrument
; - Play new note with percussion instrument
; - End of pattern
;
; A note is defined by:
; - Bits 7..5: 1-7 means play melodic instrument 1-7 with a new note
;       and frequency in bits 4..0. If bits 7..5 are 0, bits 4..0 are
;       defined as:
;       - 0: End of pattern
;       - [1..15]: Slide -7..+7 (needs TT_USE_SLIDE)
;       - 8: Hold
;       - 16: Pause
;       - [17..31]: Play percussion instrument 1..15
;
; The tracker must ensure that a pause only follows a melodic
; instrument or a hold/slide.
; ---------------------------------------------------------------------
TT_FREQ_MASK    = %00011111
TT_INS_HOLD     = 8
TT_INS_PAUSE    = 16
TT_FIRST_PERC   = 17

; b0a
tt_pattern0:
        dc.b $37, $08, $37, $08, $08, $08, $37, $08
        dc.b $08, $08, $37, $08, $08, $08, $37, $08
        dc.b $3f, $08, $3f, $08, $08, $08, $3f, $08
        dc.b $08, $08, $3f, $08, $08, $08, $3f, $08
        dc.b $33, $08, $33, $08, $08, $08, $33, $08
        dc.b $08, $08, $33, $08, $08, $08, $33, $08
        dc.b $3a, $08, $3a, $08, $08, $08, $3a, $08
        dc.b $38, $08, $38, $08, $08, $08, $38, $08
        dc.b $00

; b0b
tt_pattern1:
        dc.b $37, $08, $37, $08, $08, $08, $37, $08
        dc.b $08, $08, $37, $08, $08, $08, $37, $08
        dc.b $3f, $08, $3f, $08, $08, $08, $3f, $08
        dc.b $08, $08, $3f, $08, $08, $08, $3f, $08
        dc.b $33, $08, $33, $08, $08, $08, $33, $08
        dc.b $08, $08, $33, $08, $08, $08, $33, $08
        dc.b $31, $08, $31, $08, $08, $08, $31, $08
        dc.b $31, $08, $31, $08, $33, $08, $31, $08
        dc.b $00

; b0c
tt_pattern2:
        dc.b $37, $08, $37, $08, $08, $08, $37, $08
        dc.b $08, $08, $37, $08, $08, $08, $37, $08
        dc.b $3f, $08, $3f, $08, $08, $08, $3f, $08
        dc.b $08, $08, $3f, $08, $08, $08, $3f, $08
        dc.b $33, $08, $33, $08, $08, $08, $33, $08
        dc.b $08, $08, $33, $08, $08, $08, $33, $08
        dc.b $31, $08, $31, $08, $08, $08, $31, $08
        dc.b $37, $08, $37, $08, $33, $08, $37, $08
        dc.b $00

; b0a+mel0a
tt_pattern3:
        dc.b $37, $7d, $37, $08, $78, $08, $37, $08
        dc.b $6e, $08, $37, $08, $73, $08, $37, $70
        dc.b $3f, $70, $3f, $08, $73, $08, $3f, $08
        dc.b $71, $08, $3f, $08, $70, $08, $3f, $08
        dc.b $33, $7d, $33, $08, $78, $08, $33, $08
        dc.b $6e, $08, $33, $08, $73, $08, $33, $08
        dc.b $3a, $75, $3a, $73, $70, $08, $3a, $08
        dc.b $38, $75, $38, $08, $73, $08, $38, $7d
        dc.b $00

; b0b+mel0a
tt_pattern4:
        dc.b $37, $7d, $37, $08, $78, $08, $37, $08
        dc.b $6e, $08, $37, $08, $73, $08, $37, $70
        dc.b $3f, $70, $3f, $08, $73, $08, $3f, $08
        dc.b $71, $08, $3f, $08, $70, $08, $3f, $08
        dc.b $33, $7d, $33, $08, $78, $08, $33, $08
        dc.b $7d, $08, $33, $08, $73, $08, $33, $08
        dc.b $31, $75, $31, $73, $70, $08, $31, $08
        dc.b $31, $75, $31, $08, $33, $08, $31, $7d
        dc.b $00

; b0c+mel0a
tt_pattern5:
        dc.b $37, $7d, $37, $08, $78, $08, $37, $08
        dc.b $75, $08, $37, $08, $73, $08, $37, $75
        dc.b $3f, $75, $3f, $08, $70, $08, $3f, $08
        dc.b $73, $08, $3f, $08, $75, $08, $3f, $08
        dc.b $33, $7d, $33, $08, $78, $08, $33, $08
        dc.b $75, $08, $33, $08, $78, $08, $33, $08
        dc.b $31, $7d, $31, $73, $70, $08, $31, $08
        dc.b $37, $73, $37, $75, $33, $78, $37, $7d
        dc.b $00

; b0a+mel1a
tt_pattern6:
        dc.b $37, $73, $37, $08, $73, $08, $37, $08
        dc.b $75, $08, $37, $08, $73, $08, $37, $75
        dc.b $3f, $08, $3f, $08, $78, $08, $3f, $08
        dc.b $75, $08, $3f, $08, $7d, $08, $3f, $08
        dc.b $33, $73, $33, $08, $73, $08, $33, $08
        dc.b $70, $08, $33, $08, $75, $08, $33, $78
        dc.b $3a, $75, $3a, $08, $73, $08, $3a, $08
        dc.b $38, $7d, $38, $08, $78, $08, $38, $08
        dc.b $00

; b0b+mel1b
tt_pattern7:
        dc.b $37, $73, $37, $08, $73, $08, $37, $08
        dc.b $75, $08, $37, $08, $73, $08, $37, $75
        dc.b $3f, $08, $3f, $08, $78, $08, $3f, $08
        dc.b $75, $08, $3f, $08, $7d, $08, $3f, $08
        dc.b $33, $73, $33, $08, $73, $08, $33, $08
        dc.b $70, $08, $33, $08, $6e, $08, $33, $70
        dc.b $31, $73, $31, $08, $75, $08, $31, $08
        dc.b $31, $7d, $31, $08, $33, $08, $31, $08
        dc.b $00

; b0c+mel1c
tt_pattern8:
        dc.b $37, $73, $37, $08, $73, $08, $37, $08
        dc.b $75, $08, $37, $08, $78, $08, $37, $7d
        dc.b $3f, $08, $3f, $08, $78, $08, $3f, $08
        dc.b $73, $08, $3f, $08, $7d, $08, $3f, $08
        dc.b $33, $73, $33, $08, $73, $08, $33, $08
        dc.b $70, $08, $33, $08, $6e, $08, $33, $70
        dc.b $31, $6e, $31, $08, $73, $08, $31, $08
        dc.b $37, $75, $37, $78, $33, $7d, $37, $08
        dc.b $00

; intro-b0
tt_pattern9:
        dc.b $96, $08, $08, $08, $08, $08, $08, $08
        dc.b $08, $08, $08, $08, $08, $08, $08, $08
        dc.b $08, $08, $08, $08, $08, $08, $08, $08
        dc.b $08, $08, $08, $08, $08, $08, $08, $08
        dc.b $92, $08, $08, $08, $08, $08, $08, $08
        dc.b $08, $08, $08, $08, $08, $08, $08, $08
        dc.b $90, $08, $08, $08, $08, $08, $08, $08
        dc.b $08, $08, $08, $08, $92, $08, $08, $08
        dc.b $00

; intro-b+d0a
tt_pattern10:
        dc.b $11, $08, $96, $08, $08, $08, $08, $08
        dc.b $11, $08, $96, $08, $08, $08, $08, $08
        dc.b $11, $08, $96, $08, $08, $08, $08, $08
        dc.b $11, $08, $96, $08, $08, $08, $11, $08
        dc.b $11, $08, $92, $08, $08, $08, $08, $08
        dc.b $11, $08, $92, $08, $08, $08, $08, $08
        dc.b $11, $08, $90, $08, $08, $08, $08, $08
        dc.b $11, $08, $90, $08, $11, $08, $11, $08
        dc.b $00

; intro-b+d0b
tt_pattern11:
        dc.b $11, $08, $96, $08, $11, $08, $96, $08
        dc.b $11, $08, $96, $08, $11, $08, $96, $08
        dc.b $11, $08, $96, $08, $11, $08, $96, $08
        dc.b $11, $08, $96, $08, $11, $08, $96, $08
        dc.b $11, $08, $92, $08, $11, $08, $92, $08
        dc.b $11, $08, $92, $08, $11, $08, $92, $08
        dc.b $11, $08, $90, $08, $11, $08, $90, $08
        dc.b $11, $08, $90, $08, $12, $12, $12, $08
        dc.b $00

; b+d0a
tt_pattern12:
        dc.b $11, $08, $96, $08, $12, $08, $96, $08
        dc.b $11, $08, $11, $08, $12, $08, $96, $08
        dc.b $11, $08, $96, $08, $12, $08, $96, $08
        dc.b $11, $08, $11, $08, $12, $08, $98, $08
        dc.b $11, $08, $92, $08, $12, $08, $92, $08
        dc.b $11, $08, $11, $08, $12, $08, $92, $08
        dc.b $11, $08, $90, $08, $12, $08, $90, $08
        dc.b $11, $08, $11, $08, $12, $12, $12, $08
        dc.b $00

; d+mel0a
tt_pattern13:
        dc.b $11, $b5, $08, $08, $12, $b2, $08, $b5
        dc.b $11, $08, $11, $b8, $12, $08, $bd, $08
        dc.b $11, $08, $b8, $08, $12, $08, $ca, $08
        dc.b $11, $08, $11, $08, $12, $08, $08, $08
        dc.b $11, $bd, $08, $08, $12, $bd, $08, $b8
        dc.b $11, $08, $11, $b5, $12, $08, $b2, $08
        dc.b $11, $08, $b8, $08, $12, $08, $b5, $08
        dc.b $11, $08, $11, $b8, $12, $12, $12, $08
        dc.b $00

; d+mel0b
tt_pattern14:
        dc.b $11, $b8, $08, $08, $12, $b5, $08, $b2
        dc.b $11, $08, $11, $b5, $12, $08, $bd, $08
        dc.b $11, $08, $b8, $08, $12, $08, $ca, $08
        dc.b $11, $08, $11, $08, $12, $08, $08, $08
        dc.b $11, $bd, $08, $08, $12, $bd, $08, $b8
        dc.b $11, $08, $11, $b5, $12, $08, $b2, $08
        dc.b $11, $08, $b8, $08, $12, $08, $b5, $08
        dc.b $11, $08, $11, $b8, $12, $12, $12, $08
        dc.b $00

; d+mel0c
tt_pattern15:
        dc.b $11, $ae, $08, $08, $12, $b0, $08, $b5
        dc.b $11, $08, $11, $b8, $12, $08, $b5, $08
        dc.b $11, $08, $ae, $08, $12, $08, $b0, $08
        dc.b $11, $08, $11, $08, $12, $08, $08, $08
        dc.b $11, $bd, $08, $08, $12, $bd, $08, $b8
        dc.b $11, $08, $11, $bd, $12, $b8, $08, $08
        dc.b $11, $b5, $08, $b0, $12, $b2, $08, $b8
        dc.b $11, $b5, $11, $b5, $12, $12, $12, $08
        dc.b $00

; d+mel1a
tt_pattern16:
        dc.b $11, $bd, $08, $bd, $12, $b8, $08, $08
        dc.b $11, $b8, $11, $08, $12, $ca, $08, $bd
        dc.b $11, $08, $bd, $08, $12, $b5, $08, $08
        dc.b $11, $b8, $11, $b8, $12, $bd, $08, $08
        dc.b $11, $ca, $08, $08, $12, $08, $bd, $08
        dc.b $11, $08, $11, $08, $12, $ce, $08, $08
        dc.b $11, $ca, $08, $08, $12, $b8, $08, $bd
        dc.b $11, $08, $11, $08, $12, $12, $12, $08
        dc.b $00

; d+mel1b
tt_pattern17:
        dc.b $11, $bd, $08, $bd, $12, $ca, $08, $08
        dc.b $11, $bd, $11, $08, $12, $ce, $08, $ca
        dc.b $11, $08, $08, $08, $12, $bd, $08, $08
        dc.b $11, $b8, $11, $b8, $12, $bd, $08, $08
        dc.b $11, $ca, $08, $08, $12, $08, $bd, $08
        dc.b $11, $08, $11, $08, $12, $b8, $08, $08
        dc.b $11, $ca, $08, $08, $12, $ce, $08, $bd
        dc.b $11, $08, $11, $08, $12, $12, $12, $08
        dc.b $00

; d+mel1c
tt_pattern18:
        dc.b $11, $b8, $08, $b8, $12, $b5, $08, $08
        dc.b $11, $b5, $11, $08, $12, $b8, $08, $bd
        dc.b $11, $08, $08, $08, $12, $ce, $08, $08
        dc.b $11, $ca, $11, $b5, $12, $b8, $08, $08
        dc.b $11, $ca, $08, $bd, $12, $08, $b8, $08
        dc.b $11, $08, $11, $08, $12, $b8, $08, $08
        dc.b $11, $ca, $08, $08, $12, $b8, $08, $bd
        dc.b $11, $ca, $11, $ce, $12, $12, $12, $08
        dc.b $00

; d+mel2a
tt_pattern19:
        dc.b $11, $d3, $08, $08, $12, $dd, $08, $d8
        dc.b $11, $08, $11, $d3, $12, $d0, $08, $d3
        dc.b $11, $08, $ce, $08, $12, $d0, $08, $d3
        dc.b $11, $08, $11, $d0, $12, $08, $08, $08
        dc.b $11, $ce, $08, $08, $12, $ca, $08, $ce
        dc.b $11, $08, $11, $d0, $12, $ce, $08, $d0
        dc.b $11, $08, $d3, $08, $12, $dd, $08, $d8
        dc.b $11, $dd, $11, $dd, $12, $12, $12, $08
        dc.b $00

; d+mel2b
tt_pattern20:
        dc.b $11, $d0, $08, $08, $12, $ce, $08, $d3
        dc.b $11, $08, $11, $d5, $12, $d3, $08, $d3
        dc.b $11, $08, $ce, $08, $12, $d3, $08, $d0
        dc.b $11, $08, $11, $d3, $12, $08, $08, $08
        dc.b $11, $d5, $08, $08, $12, $d3, $08, $d0
        dc.b $11, $08, $11, $ce, $12, $ce, $08, $ca
        dc.b $11, $08, $bd, $08, $12, $ca, $08, $d0
        dc.b $11, $ce, $11, $d3, $12, $12, $12, $08
        dc.b $00

; d+mel2c
tt_pattern21:
        dc.b $11, $d0, $08, $08, $12, $ce, $08, $ca
        dc.b $11, $08, $11, $d0, $12, $ce, $08, $d3
        dc.b $11, $08, $d0, $08, $12, $d3, $08, $d0
        dc.b $11, $08, $11, $d3, $12, $08, $08, $08
        dc.b $11, $bd, $08, $08, $12, $ca, $08, $bd
        dc.b $11, $08, $11, $ce, $12, $ce, $08, $d0
        dc.b $11, $08, $ca, $08, $12, $d0, $08, $d3
        dc.b $11, $ce, $11, $d3, $12, $12, $12, $08
        dc.b $00




; Individual pattern speeds (needs TT_GLOBAL_SPEED = 0).
; Each byte encodes the speed of one pattern in the order
; of the tt_PatternPtr tables below.
; If TT_USE_FUNKTEMPO is 1, then the low nibble encodes
; the even speed and the high nibble the odd speed.
    IF TT_GLOBAL_SPEED = 0
tt_PatternSpeeds:
%%PATTERNSPEEDS%%
    ENDIF


; ---------------------------------------------------------------------
; Pattern pointers look-up table.
; ---------------------------------------------------------------------
tt_PatternPtrLo:
        dc.b <tt_pattern0, <tt_pattern1, <tt_pattern2, <tt_pattern3
        dc.b <tt_pattern4, <tt_pattern5, <tt_pattern6, <tt_pattern7
        dc.b <tt_pattern8, <tt_pattern9, <tt_pattern10, <tt_pattern11
        dc.b <tt_pattern12, <tt_pattern13, <tt_pattern14, <tt_pattern15
        dc.b <tt_pattern16, <tt_pattern17, <tt_pattern18, <tt_pattern19
        dc.b <tt_pattern20, <tt_pattern21
tt_PatternPtrHi:
        dc.b >tt_pattern0, >tt_pattern1, >tt_pattern2, >tt_pattern3
        dc.b >tt_pattern4, >tt_pattern5, >tt_pattern6, >tt_pattern7
        dc.b >tt_pattern8, >tt_pattern9, >tt_pattern10, >tt_pattern11
        dc.b >tt_pattern12, >tt_pattern13, >tt_pattern14, >tt_pattern15
        dc.b >tt_pattern16, >tt_pattern17, >tt_pattern18, >tt_pattern19
        dc.b >tt_pattern20, >tt_pattern21        


; ---------------------------------------------------------------------
; Pattern sequence table. Each byte is an index into the
; tt_PatternPtrLo/Hi tables where the pointers to the pattern
; definitions can be found. When a pattern has been played completely,
; the next byte from this table is used to get the address of the next
; pattern to play. tt_cur_pat_index_c0/1 hold the current index values
; into this table for channels 0 and 1.
; If TT_USE_GOTO is used, a value >=128 denotes a goto to the pattern
; number encoded in bits 6..0 (i.e. value AND %01111111).
; ---------------------------------------------------------------------
tt_SequenceTable:
        ; ---------- Channel 0 ----------
        dc.b $00, $01, $00, $02, $03, $04, $03, $05
        dc.b $03, $04, $03, $05, $06, $07, $06, $08
        dc.b $03, $04, $03, $05, $06, $07, $06, $08
        dc.b $03, $04, $03, $08, $06, $07, $06, $08
        dc.b $84

        
        ; ---------- Channel 1 ----------
        dc.b $09, $09, $0a, $0b, $0c, $0c, $0c, $0c
        dc.b $0d, $0e, $0d, $0f, $10, $11, $10, $12
        dc.b $0d, $0e, $0d, $0f, $13, $14, $13, $15
        dc.b $0d, $0e, $0d, $0f, $0c, $0c, $0a, $0b
        dc.b $a5


        echo "Track size: ", *-tt_TrackDataStart
