FILES =  print_flags.c asymmetrical.c do_not_mix.c flags.asm  abs.cpp
OBJS = $(FILES:.c=.o)

CC = gcc
C++ = g++
CFLAGS = -fno-pie -Wextra -O2 -g
# -fno-pie for inline asm to access global vars 
NASM = nasm
ASM_FLAGS = -f elf64 -g -F dwarf
LDFLAGS = -no-pie

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
