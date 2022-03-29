CFLAGS = -m32 -fno-stack-protector -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: stack_return

stack_return: stack_return.o

stack_return.o: stack_return.c

clean:
	-rm -f stack_return stack_return.o
	-rm -f *~
