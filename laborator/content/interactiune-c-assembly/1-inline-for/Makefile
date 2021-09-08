# IOCLA 2020
# USO remembers

CC=gcc
CFLAGS=-m32 -masm=intel

all: inline_for

inline_for:  inline_for.c
	$(CC) $(CFLAGS) -o $@ $^

asm: inline_for.c
	$(CC) $(CFLAGS) -S $^

clean:
	rm -f *.s inline_for
