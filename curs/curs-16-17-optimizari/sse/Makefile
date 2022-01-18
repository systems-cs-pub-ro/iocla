ASM_FLAGS = -f elf32 -g -F dwarf
C_FLAGS = -g -m32 -O3
NASM=nasm
CC=gcc
CPP=g++

all: test_sse

test_sse: test_sse.o sse.o
	gcc -g -O3 -m32 -o $@ $^

# test_sa.o: test_sa.asm
# 	nasm -f elf32 -g -F dwarf test_sa.asm

sse.o : sse.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<

test_sse.o : test_sse.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -o $@ $<

clean:
	rm -f test_sse *.o  *~
