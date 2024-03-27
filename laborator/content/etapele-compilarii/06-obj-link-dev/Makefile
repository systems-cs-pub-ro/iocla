CC = gcc
CFLAGS = -g -Wall -Wextra -Werror -fno-pic -masm=intel

.PHONY: all clean

all: main


# TODO: Add dependecies here so that the Makefile works
main: main.o shop.o
	$(CC) $(CFLAGS) -o $@ $^
main.o: main.c


clean:
	-rm -f main main.o