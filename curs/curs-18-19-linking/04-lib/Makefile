CFLAGS = -fno-PIC -m32
LDFLAGS = -nostdinc -nostdlib -no-pie -m32
AS = nasm
ASFLAGS = -f elf32

.DEFAULT_GOAL: all

.PHONY: all clean

all: main main_lib

main_lib: main.o start.o libinc.a
	$(CC) $(LDFLAGS) -L. -o $@ main.o start.o -linc

main: main.o start.o inc.o

main.o: main.c

libinc.a: inc.o
	ar rc $@ $^

inc.o: inc.c

start.o: start.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	-rm -f main main.o inc.o start.o
	-rm -f main_lib libinc.a
	-rm -f *~
