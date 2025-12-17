
CC = gcc
CFLAGS = -O2 -g -fno-PIC
NASM = nasm
ASM_FLAGS = -f elf64 -g -F dwarf
LD = ld -z noexecstack -no-pie

all : hello 

hello: hello.o 
	$(CC) -z noexecstack -no-pie -o hello hello.o

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(CFLAGS))
	$(CC) -c $(CFLAGS) -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f *.o hello 
