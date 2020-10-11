# IOCLA 2016
# USO remembers

CC=gcc
CFLAGS=-m32 -masm=intel
ASM=nasm
ASMFLAGS=-f elf32

all: read_stdin_fgets

read_stdin_fgets:  read_stdin_fgets.o
	$(CC) $(CFLAGS) -o $@ $^

read_stdin_fgets.o: read_stdin_fgets.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.o read_stdin_fgets
