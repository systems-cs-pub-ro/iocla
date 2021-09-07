# IOCLA 2020
# USO remembers

CC=gcc
CFLAGS=-m32 -masm=intel

all: inline_cpuid

inline_for:  inline_cpuid.c
	$(CC) $(CFLAGS) -o $@ $^

asm: inline_cpuid.c
	$(CC) $(CFLAGS) -S $^

clean:
	rm -f *.s inline_cpuid
