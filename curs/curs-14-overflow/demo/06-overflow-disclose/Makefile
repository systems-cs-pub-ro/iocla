CFLAGS = -Wall -g -m32 -fno-PIC -fno-stack-protector -Wno-unused-function -mpreferred-stack-boundary=2
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: overflow_disclose

overflow_disclose: overflow_disclose.o

overflow_disclose.o: overflow_disclose.c

clean:
	-rm -f overflow_disclose overflow_disclose.o
	-rm -f *~
