CFLAGS  = -Wall -g -fno-PIC -fno-stack-protector -Wno-unused-function -Wno-unused-const-variable
LDFLAGS = -no-pie

.PHONY: all clean

all: vuln

vuln: vuln.o

vuln.o: vuln.c

clean:
	-rm -f vuln.o vuln
	-rm -f *~
