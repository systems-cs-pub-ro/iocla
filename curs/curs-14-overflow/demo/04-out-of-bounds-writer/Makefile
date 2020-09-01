CFLAGS = -Wall -g -m32 -fno-PIC -fno-stack-protector -Wno-unused-function -mpreferred-stack-boundary=2
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: writer

writer: writer.o

writer.o: writer.c

clean:
	-rm -f writer writer.o
	-rm -f *~
