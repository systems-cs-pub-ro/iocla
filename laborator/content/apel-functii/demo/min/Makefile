AS = nasm
ASFLAGS = -f elf32
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: min

min: min.o

min.o: min.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	-rm -f min.o min
	-rm -f *~
