CFLAGS = -fno-PIC -m32
LDFLAGS = -nostdinc -nostdlib -no-pie -m32
AS = nasm
ASFLAGS = -f elf32

.DEFAULT_GOAL: all

.PHONY: all clean

all: two

two: two.o inc.o start.o

two.o: two.c

inc.o: inc.c

start.o: start.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	-rm -f two two.o inc.o start.o
	-rm -f *~
