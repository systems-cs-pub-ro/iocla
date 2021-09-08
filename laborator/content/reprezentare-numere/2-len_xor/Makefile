CC=gcc
CFLAGS=-Wall -Wextra -Werror -m32

build: len_xor

len_xor: len_xor.o
	$(CC) $(CFLAGS) $^ -o $@

len_xor.o: len_xor.c
	$(CC) $(CFLAGS) -c $^ -o $@

run:
	./len_xor

clean:
	rm *.o len_xor
