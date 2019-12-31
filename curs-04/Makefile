CC = gcc
C_FLAGS = -O2 -m32 -g 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386

all: endian mem

endian: endian.o
	$(CC) $(C_FLAGS) -o endian endian.o

mem: mem.o
	$(CC) $(C_FLAGS) -o mem mem.o

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean:
	rm -f *.o endian mem
