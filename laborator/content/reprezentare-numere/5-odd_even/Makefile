CC=gcc
CFLAGS=-Wall -Wextra -Werror -m32

build: odd_even

odd_even: odd_even.o
	$(CC) $(CFLAGS) $^ -o $@

odd_even.o: odd_even.c
	$(CC) $(CFLAGS) -c $^ -o $@

run:
	./odd_even

clean:
	rm *.o odd_even
