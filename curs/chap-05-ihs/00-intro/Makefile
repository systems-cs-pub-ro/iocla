CC = gcc
CFLAGS = -O2 -m32 -g -fno-PIC
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386 -no-pie

all : hello 

sum_array: sum_array.o 
	$(CC) -m32 -no-pie -o sum_array sum_array.o


mul: mul.o 
	$(CC) -m32 -no-pie -o mul mul.o

subreg: subreg.o 
	$(CC) -m32 -no-pie -o subreg subreg.o

declarations: declarations.o 
	$(CC) -m32 -no-pie -o declarations declarations.o

decl: decl.o 
	$(CC) -m32 -no-pie -o decl decl.o

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(CFLAGS))
	$(CC) -c $(CFLAGS) -o $@ $<

sum_array.o : sum_array.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
	

declarations.o : declarations.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
	
mul.o : mul.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<

subreg.o : subreg.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f *.o subreg declarations decl mul sum_array
