CC = cc
STACK_FLAGS = -Wl,-z,noexecstack
BINARY = arrayfsum_inline.o

all: $(BINARY)

%.o : %.c
	$(CC) -m64 -g -c -o $@ $<

clean:
	rm -f *.o
	rm -f *~

.PHONY: all clean
