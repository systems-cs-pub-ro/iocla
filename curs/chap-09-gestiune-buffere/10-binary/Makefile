ASM       = nasm
ASM_FLAGS = -f elf64 -g -Fdwarf
CFLAGS    = -Wall -fno-stack-protector -fno-PIC
LDFLAGS   = -no-pie

.PHONY: all clean

all: test

test: test.o diggers.o

test.o: test.c

diggers.o: diggers.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

clean:
	-rm -f *~
	-rm -f test.o test diggers.o
