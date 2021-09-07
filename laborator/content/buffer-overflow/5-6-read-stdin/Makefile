# IOCLA 2016
# USO remembers

CC=gcc
CFLAGS=-m32 -masm=intel
ASM=nasm
ASMFLAGS=-f elf32

all: read_stdin

read_stdin:  read_stdin.o
	$(CC) $(CFLAGS) -o $@ $^

read_stdin.o: read_stdin.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.o read_stdin
