CFLAGS = -Wall -g

.PHONY: all clean

all: link

link: main

compile: main.o mtime.o fibonacci.o

assemble: main.s mtime.s fibonacci.s

preprocess: main.i mtime.i fibonacci.i

main: main.o mtime.o fibonacci.o

%.o: ../real-c/%.c ../real-c/mtime.h ../real-c/fibonacci.h
	$(CC) -c -o $@ $<

%.s: ../real-c/%.c ../real-c/mtime.h ../real-c/fibonacci.h
	$(CC) -S -o $@ $<

%.i: ../real-c/%.c ../real-c/mtime.h ../real-c/fibonacci.h
	$(CC) -E -o $@ $<

clean:
	-rm -f main
	-rm -f main.o mtime.o fibonacci.o
	-rm -f main.s mtime.s fibonacci.s
	-rm -f main.i mtime.i fibonacci.i
