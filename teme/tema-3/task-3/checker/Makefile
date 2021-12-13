CC=gcc
CFLAGS=-m32 -fno-pie -no-pie
ASM=nasm
ASMFLAGS=-f elf32
MAKEFLAGS=--silent


checker: checker.o task3.o
	$(CC) $(CFLAGS) -o checker $^
task3.o: task3.asm
	$(ASM) $(ASMFLAGS) $< -o $@
checker.o: checker.c

check:
	./check.sh

clean: 
	rm checker *.o
