CFLAGS = -fno-PIC -Wall
LDFLAGS =  -no-pie

.PHONY: all clean

all: data_interp

data_interp: data_interp.o

data_interp.o: data_interp.c

clean:
	-rm -f *~ data_interp.o data_interp
