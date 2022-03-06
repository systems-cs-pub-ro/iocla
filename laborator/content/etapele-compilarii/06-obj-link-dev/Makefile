CFLAGS = -Wall -g

.DEFAULT_GOAL: all

.PHONY: all clean

all: main

main: main.o shop.o

main.o: main.c

clean:
	-rm -f main main.o
	-rm -f *~
