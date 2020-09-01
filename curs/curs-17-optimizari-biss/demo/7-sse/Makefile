ASM_FLAGS = -f elf32 -g -F dwarf
C_FLAGS = -g -m32 -O3
NASM=nasm
CC=gcc
CPP=g++
BINARIES = test_sse  

all: $(BINARIES)

test_sse: test_sse.o sse.o
	gcc -g -m32 -o $@ $^

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

%.o : %.c
	$(CC) -c $(C_FLAGS) -o $@ $<

%.o : %.cc
	$(CPP) -c $(C_FLAGS) -std=c++11 -masm=intel  -o $@ $<

clean:
	rm -f $(BINARIES) *.o  *~
