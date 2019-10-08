
AFILES = hll_arraysum2a.asm  hll_arraysuma.asm  hll_minmaxa.asm  hll_test.asm
CFILES = hll_arraysum2c.c  hll_arraysum_inline2.c  hll_ex1c.c        hll_minmaxc.c hll_arraysumc.c   hll_arraysum_inline.c   hll_ex1_inline.c

OBJS = $(AFILES:.asm=.o) 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf -I ../Linux_IOfiles/
LD = cc -m32 -g
BINARIES = hll_ex1 hll_ex1_inline hll_arraysum hll_arraysum2 hll_minmax hll_arraysum_inline hll_arraysum_inline2

all : $(BINARIES)

hll_ex1: hll_ex1c.o hll_test.o
	$(LD) -o $@ $^ 
hll_ex1_inline: hll_ex1_inline.o 
	$(LD) -o $@ $^ 
hll_minmax: hll_minmaxc.o hll_minmaxa.o 
	$(LD) -o $@ $^ 
hll_arraysum: hll_arraysumc.o hll_arraysuma.o 
	$(LD) -o $@ $^ 
hll_arraysum2: hll_arraysum2c.o hll_arraysum2a.o 
	$(LD) -o $@ $^ 
hll_arraysum_inline: hll_arraysum_inline.o 
	$(LD) -o $@ $^ 


%.o : %.c
#	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	cc -m32 -g -c -o $@ $<

%.o : %.asm
#	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f *.o $(BINARIES)
	rm -f *~ 
