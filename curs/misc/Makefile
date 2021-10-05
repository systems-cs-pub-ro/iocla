ASM_FLAGS = -f elf32 -g -F dwarf
C_FLAGS = -g -m32 -O3
NASM=nasm
CC=gcc
CPP=g++
BINARIES = test_freq test_rdtsc lock xor_cache 

all: $(BINARIES)

test_freq: test_freq.o 
	gcc -g -m32 -o $@ $^ 

test_rdtsc: test_rdtsc.o 
	gcc -g -m32 -o $@ $^ 

lock: lock.o 
	g++ -g -pthread -m32 -o $@ $^

xor_cache: xor_cache.c
	gcc -g -O2 -fPIC -o xor_cache xor_cache.c




%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -o $@ $<

%.o : %.cc
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CPP) -c $(C_FLAGS) -std=c++11 -masm=intel  -o $@ $<

clean:
	rm -f $(BINARIES) *.o  *~
