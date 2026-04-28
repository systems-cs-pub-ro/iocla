CFLAGS = -Wall -g -fno-PIC -fno-stack-protector -Wno-unused-function
LDFLAGS = -no-pie

.PHONY: all clean

all: overflow_disclose

overflow_disclose: overflow_disclose.o

overflow_disclose.o: overflow_disclose.c

clean:
	-rm -f overflow_disclose overflow_disclose.o
	-rm -f *~
