AS = nasm
AFILES = fibonacci_bad1.asm fibonacci_bad2.asm fibonacci_good3.asm
OBJS = $(AFILES:.asm=.o)
BINARIES = $(AFILES:.asm=)
ASFLAGS = -f elf64 -g -F dwarf
LD = gcc
LDFLAGS = -no-pie

.PHONY: all clean

all: $(BINARIES)

# Pattern rule: build .o from .asm
%.o: %.asm
	$(AS) $(ASFLAGS) -o $@ $<

# Pattern rule: build binary from .o
%: %.o
	$(LD) $(LDFLAGS) -o $@ $<

clean:
	-rm -f $(OBJS)
	-rm -f $(BINARIES)
	-rm -f *~
