ASM = nasm
ASM_FLAGS = -f elf32 -g -Fdwarf
CFLAGS = -Wall -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: test

test: test.o diggers.o

test.o: test.c

clean:
	-rm -f *~
	-rm -f test.o test
