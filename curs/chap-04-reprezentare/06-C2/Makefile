FILES =  print_flags.c asymmetrical.c do_not_mix.c flags.asm  abs.cpp
OBJS = $(FILES:.c=.o)

CC = gcc
C++ = g++
CFLAGS = -Wextra -O2 -m32 -g
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LDFLAGS = -m32

all : print_flags asymmetrical do_not_mix flags abs


.cpp.o:
	$(C++) $(CFLAGS) -o $@ $^

.c.o:
	$(CC) $(CFLAGS) -o $@ $^

print_flags.o : print_flags.c
	$(warning CC=$(CC) FLAGS=$(CFLAGS))
	$(CC) -c $(CFLAGS) -masm=intel -o $@ $<


flags.o : flags.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean:
	rm -f *.o print_flags do_not_mix asymmetrical flags  abs *~
