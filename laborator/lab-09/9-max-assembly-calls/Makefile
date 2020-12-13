# IOCLA 2020
# USO remembers

CC=gcc
ASM=nasm
ASMFLAGS=-f elf64
LDFLAGS=-no-pie

mainmax: main.o max.o
	$(CC) -o $@ $^ $(LDFLAGS)
main.o: main.asm
	$(ASM) $(ASMFLAGS) $< -o $@

max.o: max.c

clean:
	rm -f *.o mainmax
