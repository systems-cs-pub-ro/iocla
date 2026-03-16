
CC       = gcc
CFLAGS   = -O2 -g -fno-PIC
NASM     = nasm
ASM_FLAGS = -f elf64 -g -F dwarf
LD       = ld -z noexecstack 

# -----------------------------------------------------------------------
# Targets
# -----------------------------------------------------------------------
all: hello hello64

hello: hello.o 
	$(CC) -z noexecstack -no-pie -o hello hello.o

# hello64 – assembled with NASM, linked directly (no libc, entry = _start)
hello64: hello64.o
	$(LD) -z noexecstack -o hello64 hello64.o

# -----------------------------------------------------------------------
# Generic pattern rules
# -----------------------------------------------------------------------
%.o : %.c
	$(warning CC=$(CC) FLAGS=$(CFLAGS))
	$(CC) -c $(CFLAGS) -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<

# -----------------------------------------------------------------------
clean:
	rm -f *.o hello hello64
