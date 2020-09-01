
FILES =  mult16c.c mult16m.c mult16inline.c inline.c
OBJS = $(FILES:.c=.o)

CC = gcc
C_FLAGS = -O2 -m32 -g 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386

all : hello c.out asm.out inline 

hello: hello.o 
	$(CC) $(C_FLAGS) -o hello hello.o

inline: inline.o 
	$(CC) $(C_FLAGS) -o inline inline.o

asm.out:  mult16m.o mult16inline.o
	$(CC) $(C_FLAGS) -o $@ $^

c.out:  mult16m.o mult16c.o
	$(warning OBJS=$(OBJS) OUT=$@ IN=$^)
	$(CC) $(C_FLAGS) -o $@ $^

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -o $@ $<

inline.o : inline.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -masm=intel -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f *.o
	rm -f *.out hello inline *~
