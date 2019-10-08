
FILES = fact_pentium.asm qsort_pentium.asm

OBJS = $(FILES:.asm=.o) 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf -I ../Linux_IOfiles/
LD = ld -g  -melf_i386 ../Linux_IOfiles/io.o
BINARIES = fact_pentium qsort_pentium

all : $(BINARIES)

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
