CC = gcc
CFLAGS = -g -Wall -Wextra -Werror -fno-pic -masm=intel

.PHONY: all clean

all: main


# TODO: Add dependecies here so that the Makefile works
main: main.c
	$(CC) $(CFLAGS) -o $@ $^


clean:
	-rm -f main main.o