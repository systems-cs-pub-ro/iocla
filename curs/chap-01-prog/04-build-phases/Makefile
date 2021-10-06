CFLAGS = -Wall -g

.PHONY: all clean

all: link

link: main

compile: main.o mtime.o fibonacci.o

assemble: main.s mtime.s fibonacci.s

preprocess: main.i mtime.i fibonacci.i

main: main.o mtime.o fibonacci.o

%.o: ../03-real-c/%.c ../03-real-c/mtime.h ../03-real-c/fibonacci.h
	$(CC) -c -o $@ $<

%.s: ../03-real-c/%.c ../03-real-c/mtime.h ../03-real-c/fibonacci.h
	$(CC) -S -o $@ $<

%.i: ../03-real-c/%.c ../03-real-c/mtime.h ../03-real-c/fibonacci.h
	$(CC) -E -o $@ $<

clean:
	-rm -f main
	-rm -f main.o mtime.o fibonacci.o
	-rm -f main.s mtime.s fibonacci.s
	-rm -f main.i mtime.i fibonacci.i
