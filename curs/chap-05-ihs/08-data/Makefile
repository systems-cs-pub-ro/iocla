CFLAGS = -m32 -fno-PIC -Wall
LDFLAGS = -m32 -no-pie
ASFLAGS = -f elf32
AS = nasm

.PHONY: all clean

all: data_c data_asm data_c.s

data_c: data_c.o

data_c.o: data_c.c

data_c.s: data_c.c
	$(CC) -S -o $@ $<

data_asm: data_asm.o

data_asm.o: data_asm.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	-rm -f *~
	-rm -f data_c.o data_c
	-rm -f data_asm.o data_asm
