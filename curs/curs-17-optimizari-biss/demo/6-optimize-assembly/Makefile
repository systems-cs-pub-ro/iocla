GCCFLAGS=-m32
NASMFLAGS=-f elf32

all: main

main: main.o optimize.o
	gcc $(GCCFLAGS) -o main main.o optimize.o

main.o: main.c
	gcc $(GCCFLAGS) -o main.o -c main.c

optimize.o: optimize.asm
	nasm $(NASMFLAGS) optimize.asm

clean:
	rm -f main.o optimize.o main
