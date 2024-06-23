INCDIRS=inc src msx gen
DFLAGS=$(patsubst %,-I%,$(INCDIRS)) -f3 -d

# asm files
SRC=$(wildcard src/*.asm)

VSCROLL_GFX_GEN=\
gen/data_vscroll_bloc1.asm \
gen/data_vscroll_bloc2.asm \
gen/data_vscroll_bloc3.asm \
gen/data_vscroll_bloc4.asm \
gen/data_vscroll_bloc5.asm

VSCROLL_GFX_SRC=\
gfx/gfx-40x240-bloc1.gif \
gfx/gfx-40x320-bloc2.gif \
gfx/gfx-40x360-bloc3.gif \
gfx/gfx-40x200-bloc4.gif \
gfx/gfx-40x160-bloc5.gif

all: main.bin

gen/data_vscroll_bloc1.asm: gfx/gfx-40x240-bloc1.gif
gen/data_vscroll_bloc2.asm: gfx/gfx-40x320-bloc2.gif
gen/data_vscroll_bloc3.asm: gfx/gfx-40x360-bloc3.gif
gen/data_vscroll_bloc4.asm: gfx/gfx-40x200-bloc4.gif
gen/data_vscroll_bloc5.asm: gfx/gfx-40x160-bloc5.gif
$(VSCROLL_GFX_GEN):
	tools/png40pf.py -p $< > $@

# Moved to src for fine tuning
#gen/vscroll_structs.asm: $(VSCROLL_GFX_SRC)
#	echo -n > $@
#	for i in $^; do tools/png40pf.py $$i >> $@; echo >> $@; done

main.bin: src/main.asm $(SRC) $(VSCROLL_GFX_GEN) # gen/vscroll_structs.asm
	dasm $< -o$@ -l$(patsubst %.bin,%,$@).lst -s$(patsubst %.bin,%,$@).sym $(DFLAGS)

run: main.bin
	stella $<

clean:
	rm -f gen/* \
	main.bin main.lst main.sym
