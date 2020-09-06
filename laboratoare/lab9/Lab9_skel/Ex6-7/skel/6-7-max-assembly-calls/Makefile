# IOCLA 2016
# USO remembers

CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf32

mainmax: main.o max.o
	$(CC) $(CFLAGS) -o $@ $^
main.o: main.asm
	$(ASM) $(ASMFLAGS) $< -o $@

max.o: max.c

clean:
	rm *.o mainmax
