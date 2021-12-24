
FILES = bblsort.asm  procfib1.asm procswap.asm procfib2.asm  varpara.asm fact_pentium.asm qsort_pentium.asm 

OBJS = $(FILES:.asm=.o) 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf -I ../../Linux_IOfiles/
LD = ld -g  -melf_i386 ../../Linux_IOfiles/io.o
BINARIES = procfib1 procfib2 procswap varpara bblsort fact_pentium qsort_pentium

all : $(BINARIES)

procfib1: procfib1.o
	$(LD) -o procfib1  procfib1.o 
procfib2: procfib2.o
	$(LD) -o procfib2  procfib2.o 
procswap: procswap.o
	$(LD) -o procswap  procswap.o 
modules: module1.o module2.o
	$(LD) -o modules  module1.o module2.o 
varpara: varpara.o
	$(LD) -o varpara  varpara.o 
bblsort: bblsort.o
	$(LD) -o bblsort  bblsort.o 
fact_pentium: fact_pentium.o
	$(LD) -o fact_pentium  fact_pentium.o 
qsort_pentium: qsort_pentium.o
	$(LD) -o qsort_pentium  qsort_pentium.o 


%.o : %.asm
#	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f $(OBJS) $(BINARIES)
	rm -f *~ 
