CFLAGS = -m32 -Wall -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: main

main: main.o add.o

main.o: main.c add.h

add.o: add.c add.h

clean:
	-rm -f add.o main.o
	-rm -f main
	-rm -f *~
