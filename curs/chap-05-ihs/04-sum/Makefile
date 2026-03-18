NASM = nasm
AFILES = sum.asm
OBJS = $(AFILES:.asm=.o)
# 32-bit flags
# ASM_FLAGS = -f elf32 -g -F dwarf
# LDFLAGS = -m32 -g -fno-PIC -no-pie
ASM_FLAGS = -f elf64 -g -F dwarf
LD = gcc
LDFLAGS = -g -fno-PIC -no-pie
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
