CFLAGS = -Wall -m32 -fno-stack-protector -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: fibonacci

fibonacci: fibonacci.o

fibonacci.o: fibonacci.c

clean:
	-rm -f fibonacci fibonacci.o
	-rm -f *~
