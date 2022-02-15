CC = gcc
C_FLAGS = -O2 -m32 -g
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386

all: endian mem bin-oct-hex signed-unsigned print_code

endian: endian.o
	$(CC) $(C_FLAGS) -o $@ $^

mem: mem.o
	$(CC) $(C_FLAGS) -o $@ $^

bin-oct-hex: bin-oct-hex.o
	$(CC) $(C_FLAGS) -o $@ $^

signed-unsigned: signed-unsigned.o
	$(CC) $(C_FLAGS) -o $@ $^

print_code: print_code.o
	$(CC) $(C_FLAGS) -o $@ $^

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean:
	-rm -f *.o endian mem bin-oct-hex signed-unsigned print_code
