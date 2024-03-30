CFLAGS = -m32 -fno-PIC -Wall
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: signed_unsigned

signed_unsigned: signed_unsigned.o

signed_unsigned.o: signed_unsigned.c

clean:
	-rm -f *~ signed_unsigned.o signed_unsigned
