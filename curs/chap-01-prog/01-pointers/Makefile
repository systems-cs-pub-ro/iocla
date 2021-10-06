CFLAGS = -Wall -fno-PIC -m32 -g
LDFLAGS = -no-pie -m32

.PHONY: all clean

all: inspect_vars inspect_array inspect_ptr inspect_func segfault inspect_struct

inspect_vars: inspect_vars.o

inspect_vars.o: inspect_vars.c

inspect_array: inspect_array.o

inspect_array.o: inspect_array.c

inspect_ptr: inspect_ptr.o

inspect_ptr.o: inspect_ptr.c

inspect_func: inspect_func.o

inspect_func.o: inspect_func.c

segfault: segfault.o

segfault.o: segfault.c

inspect_struct: inspect_struct.o

inspect_struct.o: inspect_struct.c

clean:
	-rm -f inspect_vars.o inspect_array.o inspect_ptr.o inspect_func.o segfault.o inspect_struct.o
	-rm -f inspect_vars inspect_array inspect_ptr inspect_func segfault inspect_struct
	-rm -f *~
