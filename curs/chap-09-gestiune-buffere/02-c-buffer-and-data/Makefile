CFLAGS = -Wall -g -m32 -fno-PIC -fno-stack-protector -Wno-unused-function -mpreferred-stack-boundary=2
LDFLAGS = -m32 

.PHONY: all clean

all: global_buffer stack_buffer stack_buffer_char

global_buffer: global_buffer.o

global_buffer.o: global_buffer.c

stack_buffer: stack_buffer.o

stack_buffer.o: stack_buffer.c

stack_buffer_char: stack_buffer_char.o

stack_buffer_char.o: stack_buffer_char.c

clean:
	-rm -f global_buffer global_buffer.o
	-rm -f stack_buffer stack_buffer.o
	-rm -f stack_buffer_char stack_buffer_char.o
	-rm -f *~
