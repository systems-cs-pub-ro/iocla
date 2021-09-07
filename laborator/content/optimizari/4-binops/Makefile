CC=gcc
CFLAGS=-m32 -Wall -masm=intel

binops: binops.o
	$(CC) $(CFLAGS) $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f binops.o binops
