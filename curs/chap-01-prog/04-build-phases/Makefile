CFLAGS = -Wall -g -m32 
LDFLAGS = -g -m32 

.PHONY: all clean

all: link

link: main

assemble: main.o mtime.o fibonacci.o

compile: main.s mtime.s fibonacci.s

preprocess: main.i mtime.i fibonacci.i

main: main.o mtime.o fibonacci.o

%.o: ../03-real-c/%.c ../03-real-c/mtime.h ../03-real-c/fibonacci.h
	$(CC) $(CFLAGS) -c -o $@ $<

%.s: ../03-real-c/%.c ../03-real-c/mtime.h ../03-real-c/fibonacci.h
	$(CC) $(CFLAGS) -S -o $@ $<

%.i: ../03-real-c/%.c ../03-real-c/mtime.h ../03-real-c/fibonacci.h
	$(CC) -E -o $@ $<

clean:
	-rm -f main
	-rm -f main.o mtime.o fibonacci.o
	-rm -f main.s mtime.s fibonacci.s
	-rm -f main.i mtime.i fibonacci.i
