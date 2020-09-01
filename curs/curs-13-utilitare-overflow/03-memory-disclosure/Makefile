CFLAGS = -Wall -g -m32 -fno-PIC -fno-stack-protector -Wno-unused-function -mpreferred-stack-boundary=2
LDFLAGS = -m32 

.PHONY: all clean

all: memory_disclosure reader

memory_disclosure: memory_disclosure.o

memory_disclosure.o: memory_disclosure.c

reader: reader.o

reader.o: reader.c

clean:
	-rm -f memory_disclosure memory_disclosure.o
	-rm -f reader reader.o
	-rm -f *~
