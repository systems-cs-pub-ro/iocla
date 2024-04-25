NASM = nasm
AFILES = hello_world.asm
OBJS = $(AFILES:.asm=.o)
ASM_FLAGS = -f elf32 -g -F dwarf
LD = gcc
LDFLAGS = -m32 -g -fno-PIC -no-pie
BINARIES = sum

.PHONY: all clean

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

%: %.o
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	-rm -f *.o $(BINARIES) *.s
	-rm -f *~
