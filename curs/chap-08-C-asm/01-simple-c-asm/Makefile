AS = nasm
ASFLAGS = -f elf64
CFLAGS = -fno-PIC -mcmodel=large
LDFLAGS = -no-pie

.PHONY: all clean

all: main

main: main.o sum_n.o

sum_n.o: sum_n.asm
	$(AS) $(ASFLAGS) -o $@ $<

main.o: main.c

clean:
	-rm -f main main.o sum_n.o
	-rm -f *~
