CFLAGS = -Wall -g -m32 -fno-PIC -fno-stack-protector -Wno-unused-function -mpreferred-stack-boundary=2
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: no_null_byte

no_null_byte: no_null_byte.o

no_null_byte.o: no_null_byte.c

clean:
	-rm -f no_null_byte no_null_byte.o
	-rm -f *~
