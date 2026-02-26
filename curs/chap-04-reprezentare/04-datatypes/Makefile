
CC = gcc
CFLAGS = -O2 -g -fno-PIC
NASM = nasm
ASM_FLAGS = -f elf64 -g -F dwarf
LD = ld -no-pie -z noexecstack 

all : dt 

dt: dt.o 
#	$(LD) -no-pie -o dt dt.o
	$(CC) -z noexecstack  -no-pie -o dt dt.o

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(CFLAGS))
	$(CC) -c $(CFLAGS) -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f *.o dt 
