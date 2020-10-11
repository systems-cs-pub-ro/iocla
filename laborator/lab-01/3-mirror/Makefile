CC=gcc
CFLAGS=-Wall -Wextra -Werror -m32

build: mirror

mirror: mirror.o
	$(CC) $(CFLAGS) $^ -o $@

mirror.o: mirror.c
	$(CC) $(CFLAGS) -c $^ -o $@

run:
	./mirror

clean:
	rm *.o mirror
