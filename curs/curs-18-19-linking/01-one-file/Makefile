CFLAGS = -fno-PIC -m32 -g
LDFLAGS = -nostdinc -nostdlib -no-pie -m32
ASFLAGS = --32

.DEFAULT_GOAL: all

.PHONY: all clean

all: one

one: one.o start.o

one.o: one.c

start.o: start.s

clean:
	-rm -f one one.o start.o
	-rm -f *~
