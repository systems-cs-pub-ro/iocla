CFLAGS = -fno-PIC -Wall
LDFLAGS = -no-pie

.PHONY: all clean

all: same_data

same_data: same_data.o

same_data.o: same_data.c

clean:
	-rm -f *~ same_data.o same_data
