NASM = nasm
AFILES = fibonacci.asm
OBJS = $(AFILES:.asm=.o)
ASM_FLAGS = -f elf32 -g -F dwarf
LD = gcc
LDFLAGS = -m32 -g -fno-pie -no-pie
BINARIES = fibonacci

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

% : %.o
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	rm -f *.o $(BINARIES) *.s
	rm -f *~
