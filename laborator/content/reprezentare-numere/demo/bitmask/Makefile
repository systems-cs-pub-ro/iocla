CFLAGS = -m32 -fno-PIC -Wall
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: bitmask

bitmask: bitmask.o

bitmask.o: bitmask.c

clean:
	-rm -f *~
	-rm -f bitmask.o bitmask
