CFLAGS = -fno-PIC -m32 -g -O
LDFLAGS = -nostdinc -nostdlib -no-pie -m32 -g 
AS = nasm
ASFLAGS = -f elf32 -g -F dwarf

.DEFAULT_GOAL: all

.PHONY: all clean

all: one

one: one.o start.o

one.o: one.c

start.o: start.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	-rm -f one one.o start.o
	-rm -f *~
