# IOCLA 2020
# USO remembers

CC=gcc
CFLAGS=-m32 -masm=intel

all: inline_rotate

inline_for:  inline_rotate.c
	$(CC) $(CFLAGS) -o $@ $^

asm: inline_rotate.c
	$(CC) $(CFLAGS) -S $^

clean:
	rm -f *.s inline_rotate
