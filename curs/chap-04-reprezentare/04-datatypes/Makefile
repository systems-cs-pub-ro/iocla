
CC = gcc
CFLAGS = -O2 -m32 -g -fno-PIC
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386 -no-pie

all : dt 

dt: dt.o 
	$(CC) -m32 -no-pie -o dt dt.o

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(CFLAGS))
	$(CC) -c $(CFLAGS) -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f *.o dt 
