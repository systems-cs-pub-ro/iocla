CFLAGS = -Wall -g -fno-PIC -fno-stack-protector -Wno-unused-function
LDFLAGS = -no-pie

.PHONY: all clean

all: no_null_byte

no_null_byte: no_null_byte.o

no_null_byte.o: no_null_byte.c

clean:
	-rm -f no_null_byte no_null_byte.o
	-rm -f *~
