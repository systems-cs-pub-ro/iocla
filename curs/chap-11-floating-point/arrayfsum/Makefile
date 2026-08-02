NASM = nasm
ASM_FLAGS = -f elf64 -g -F dwarf
STACK_FLAGS = -Wl,-z,noexecstack
LD = cc -m64 -g -no-pie $(STACK_FLAGS)
CC = cc
BINARY = arrayfsumc

all: $(BINARY)

$(BINARY): arrayfsumc.o arrayfsuma.o
	$(LD) -o $@ $^

%.o : %.c
	$(CC) -m64 -g -c -o $@ $<

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean:
	rm -f *.o $(BINARY)
	rm -f *~

.PHONY: all clean
