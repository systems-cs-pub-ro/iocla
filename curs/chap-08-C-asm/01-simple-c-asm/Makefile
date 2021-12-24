AS = nasm
ASFLAGS = -f elf32
CFLAGS = -m32 -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: main

main: main.o sum_n.o

sum_n.o: sum_n.asm
	$(AS) $(ASFLAGS) -o $@ $<

main.o: main.c

clean:
	-rm -f main main.o sum_n.o
	-rm -f *~
