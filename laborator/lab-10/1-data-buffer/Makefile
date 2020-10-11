# IOCLA 2016
# USO remembers

CC=gcc
CFLAGS=-m32 -masm=intel
ASM=nasm
ASMFLAGS=-f elf32

all: data_buffer

data_buffer:  data_buffer.o
	$(CC) $(CFLAGS) -o $@ $^

data_buffer.o: data_buffer.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.o data_buffer
