# IOCLA 2016
# USO remembers

CC=gcc
ASM=nasm
ASMFLAGS=-f elf64

mainmax: main.o max.o
	$(CC) -o $@ $^
main.o: main.asm
	$(ASM) $(ASMFLAGS) $< -o $@

max.o: max.c

clean:
	rm -f *.o mainmax
