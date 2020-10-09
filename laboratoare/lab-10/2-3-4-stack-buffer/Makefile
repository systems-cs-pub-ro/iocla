# IOCLA 2016
# USO remembers

CC=gcc
CFLAGS=-m32 -masm=intel
ASM=nasm
ASMFLAGS=-f elf32

all: stack_buffer

stack_buffer:  stack_buffer.o
	$(CC) $(CFLAGS) -o $@ $^

stack_buffer.o: stack_buffer.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.o stack_buffer
