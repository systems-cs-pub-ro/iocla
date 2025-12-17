CFLAGS = -fno-PIC -g -O # -m32
LDFLAGS = -z noexecstack -nostdinc -nostdlib -no-pie -g # -m32
AS = nasm
ASFLAGS = -f elf64 -g -F dwarf # -f elf32 

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
