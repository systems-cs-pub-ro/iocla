NASM = nasm
AFILES = strings.asm 
OBJS = $(AFILES:.asm=.o) 
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = strings

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 