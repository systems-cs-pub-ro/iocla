CFLAGS = -Wall -g -m32 -fno-PIC -fno-stack-protector -Wno-unused-function -mpreferred-stack-boundary=2
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: vuln

vuln: vuln.o

vuln.o: vuln.c

clean:
	-rm -f vuln vuln.o
	-rm -f *~
