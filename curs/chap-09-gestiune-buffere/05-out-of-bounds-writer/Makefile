CFLAGS = -Wall -g -fno-PIC -fno-stack-protector -Wno-unused-function
LDFLAGS = -no-pie

.PHONY: all clean

all: writer

writer: writer.o

writer.o: writer.c

clean:
	-rm -f  writer.o writer
	-rm -f *~
