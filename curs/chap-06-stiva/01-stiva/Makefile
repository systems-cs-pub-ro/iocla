
CC = gcc
C_FLAGS = -O2 -m32 -g 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
#LD = ld  -melf_i386
LD=gcc -g -m32

all : stiva 

stiva: stiva.o 
	$(CC) $(C_FLAGS) -o stiva stiva.o

%.o : %.c
	$(CC) -c $(C_FLAGS) -o $@ $<

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f *.o stiva 
