CC=gcc
CFLAGS=-m32 -g -fno-pie -no-pie
ASM=nasm
ASMFLAGS=-f elf32
MAKEFLAGS += --silent

checker: checker.o task1.o
	$(CC) $(CFLAGS) -o $@ $^

checker.o: checker.c

task1.o: task1.asm
	$(ASM) $(ASMFLAGS) $< -o $@

check:
	./check.sh

clean:
	rm *.o task1