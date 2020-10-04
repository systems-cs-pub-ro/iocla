CFLAGS = -Wall -g -m32 -fno-PIC -fno-stack-protector -Wno-unused-function -mpreferred-stack-boundary=2
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: main_stack

main_stack: main_stack.o

clean:
	-rm -f main_stack main_stack.o
	-rm -f *~
