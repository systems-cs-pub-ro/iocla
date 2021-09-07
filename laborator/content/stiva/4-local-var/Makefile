NASM = nasm
AFILES = merge-arrays.asm 
OBJS = $(AFILES:.asm=.o) 
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = merge-arrays

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

merge-arrays: merge-arrays.o
	$(LD) $(LDFLAGS) -o $@ $^

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 