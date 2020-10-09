NASM = nasm
AFILES = reverse-array.asm 
OBJS = $(AFILES:.asm=.o) 
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = reverse-array

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

reverse-array: reverse-array.o
	$(LD) $(LDFLAGS) -o $@ $^

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 
