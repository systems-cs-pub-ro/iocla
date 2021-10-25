FILES =  endianess.c endianess2.c
OBJS = $(FILES:.c=.o)

CC = gcc
C_FLAGS = -O2 -m32 -g
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386

all : endianess endianess2

endianess : endianess.o
	$(CC) $(C_FLAGS) -o $@ $^

endianess2 : endianess2.o
	$(CC) $(C_FLAGS) -o $@ $^

endianess.o : endianess.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -masm=intel -o $@ $<

endianess2.o : endianess2.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -masm=intel -o $@ $<

clean:
	rm -f *.o endianess endianess2 *~
