CFLAGS = -fno-PIC -m32 -g
LDFLAGS = -nostdlib -nostdinc -no-pie -m32
AS = nasm
ASFLAGS = -f elf32

.DEFAULT_GOAL: all

.PHONY: all clean

all: hello

hello: hello.o start.o puts.o
	$(CC) $(LDFLAGS) -o $@ $^

hello.o: hello.c

start.o: start.asm
	$(AS) $(ASFLAGS) -o $@ $<

puts.o: puts.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	-rm -f hello hello.o start.o puts.o
	-rm -f *~
