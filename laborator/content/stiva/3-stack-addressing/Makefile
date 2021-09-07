NASM = nasm
AFILES = stack-addressing.asm 
OBJS = $(AFILES:.asm=.o) 
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = stack-addressing

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

stack-addressing: stack-addressing.o
	$(LD) $(LDFLAGS) -o $@ $^

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 
