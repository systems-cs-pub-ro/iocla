NASM = nasm
AFILES = flags.asm
OBJS = $(AFILES:.asm=.o)
ASM_FLAGS = -f elf64 -g -F dwarf
LD = gcc -z noexecstack
LDFLAGS = -g -fno-PIC -no-pie
BINARIES = flags

.PHONY: all clean

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

%: %.o
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	-rm -f *.o $(BINARIES) *.s
	-rm -f *~
