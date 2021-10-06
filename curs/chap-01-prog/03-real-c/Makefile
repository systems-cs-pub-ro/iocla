CFLAGS = -Wall -g

.PHONY: all clean

all: main

main: main.o fibonacci.o mtime.o

main.o: main.c fibonacci.h mtime.h

fibonacci.o: fibonacci.c fibonacci.h

mtime.o: mtime.c mtime.h

clean:
	-rm -f fibonacci.o main.o mtime.o
	-rm -f main
	-rm -f *~
