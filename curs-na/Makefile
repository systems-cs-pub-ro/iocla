
FILES =  print_flags.c
OBJS = $(FILES:.c=.o)

CC = gcc
C_FLAGS = -O2 -m32 -g 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386

all : print_flags 


print_flags: print_flags.o 
	$(CC) $(C_FLAGS) -o print_flags print_flags.o

print_flags.o : print_flags.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -masm=intel -o $@ $<

clean: 
	rm -f *.o print_flags *~
