GCCFLAGS=-m32
NASMFLAGS=-f elf32

all: string

string: string.o computeLength.o
	gcc $(GCCFLAGS) -o string string.o computeLength.o

string.o: string.c
	gcc $(GCCFLAGS) -o string.o -c string.c

computeLength.o: computeLength.asm
	nasm $(NASMFLAGS) computeLength.asm

clean:
	rm -f computeLength.o string.o string
