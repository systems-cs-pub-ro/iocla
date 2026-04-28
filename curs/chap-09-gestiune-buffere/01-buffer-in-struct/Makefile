CFLAGS = -Wall -g -fno-PIC -fno-stack-protector -Wno-unused-function
LDFLAGS = -no-pie

.PHONY: all clean

all: buffer_in_struct buffer_in_struct_all buffer_in_struct_all_func

buffer_in_struct: buffer_in_struct.o

buffer_in_struct.o: buffer_in_struct.c

buffer_in_struct_all: buffer_in_struct_all.o

buffer_in_struct_all.o: buffer_in_struct_all.c

buffer_in_struct_all_func: buffer_in_struct_all_func.o

buffer_in_struct_all_func.o: buffer_in_struct_all_func.c

clean:
	-rm -f buffer_in_struct buffer_in_struct.o
	-rm -f buffer_in_struct_all buffer_in_struct_all.o
	-rm -f buffer_in_struct_all_func buffer_in_struct_all_func.o
	-rm -f *~
