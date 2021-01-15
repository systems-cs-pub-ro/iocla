CFLAGS=-mavx2 -O0 -g
CC=gcc
ASM=nasm
ASMFLAGS=-f elf64

.PHONY: all clean run build

all: checker

build: checker

run: checker
	./checker

vector_c.o: $(SKEL_FOLDER)vector_c.c
	$(CC) $(CFLAGS) -c $^ -lm

vector_asm.o: $(SKEL_FOLDER)vector_asm.asm
	$(ASM) $(ASMFLAGS) $^ -o $@

checker.o: checker.c
	$(CC) $(CFLAGS) -c $^ -o $@ -lm

checker: checker.o vector_c.o vector_asm.o
	$(CC) $(CFLAGS) $^ -o $@ -lm -no-pie
	rm *.o

clean:
	rm checker