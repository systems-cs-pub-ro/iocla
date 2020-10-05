CFLAGS = -Wall -fno-PIC
LDFLAGS = -no-pie

.PHONY: all clean

all: inspect_vars inspect_array

inspect_vars: inspect_vars.o

inspect_vars.o: inspect_vars.c

inspect_array: inspect_array.o

inspect_array.o: inspect_array.c

clean:
	-rm -f inspect_vars.o inspect_array.o
	-rm -f inspect_vars inspect_array
	-rm -f *~
