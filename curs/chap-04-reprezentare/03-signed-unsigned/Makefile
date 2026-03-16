CFLAGS = -fno-PIC -Wall
LDFLAGS = -no-pie

.PHONY: all clean

all: signed_unsigned

signed_unsigned: signed_unsigned.o

signed_unsigned.o: signed_unsigned.c

clean:
	-rm -f *~ signed_unsigned.o signed_unsigned
