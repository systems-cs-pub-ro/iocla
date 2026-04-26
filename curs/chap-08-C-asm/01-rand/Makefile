AS = nasm
AFILES = main.asm
OBJS = $(AFILES:.asm=.o)
BINARY = rand
ASFLAGS = -f elf64 -g -F dwarf
LD = gcc
LDFLAGS = -no-pie

.PHONY: all clean

all: $(BINARY)

%.o: %.asm
	$(AS) $(ASFLAGS) -o $@ $<

$(BINARY): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	-rm -f $(OBJS)
	-rm -f $(BINARY)
	-rm -f *~
