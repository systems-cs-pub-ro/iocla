CFLAGS = -m32 -fno-PIC -Wall
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: data_interp

data_interp: data_interp.o

data_interp.o: data_interp.c

clean:
	-rm -f *~ data_interp.o data_interp
