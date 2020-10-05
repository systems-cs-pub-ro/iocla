CFLAGS = -Wall -fno-PIC
LDFLAGS = -no-pie

.PHONY: all clean

all: inspect_vars inspect_array inspect_ptr inspect_func

inspect_vars: inspect_vars.o

inspect_vars.o: inspect_vars.c

inspect_array: inspect_array.o

inspect_array.o: inspect_array.c

inspect_ptr: inspect_ptr.o

inspect_ptr.o: inspect_ptr.c

inspect_func: inspect_func.o

inspect_func.o: inspect_func.c

clean:
	-rm -f inspect_vars.o inspect_array.o inspect_func.o
	-rm -f inspect_vars inspect_array inspect_func
	-rm -f *~
