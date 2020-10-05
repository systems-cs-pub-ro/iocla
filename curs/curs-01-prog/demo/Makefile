CFLAGS = -Wall -fno-PIC
LDFLAGS = -no-pie

.PHONY: all clean

all: inspect_vars inspect_array inspect_ptr

inspect_vars: inspect_vars.o

inspect_vars.o: inspect_vars.c

inspect_array: inspect_array.o

inspect_array.o: inspect_array.c

inspect_ptr: inspect_ptr.o

inspect_ptr.o: inspect_ptr.c

clean:
	-rm -f inspect_vars.o inspect_array.o inspect_ptr.o
	-rm -f inspect_vars inspect_array inspect_ptr
	-rm -f *~
