CFLAGS = -m32 -fno-stack-protector -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: backtrace

backtrace: backtrace.o

backtrace.o: backtrace.c

clean:
	-rm -f backtrace backtrace.o
	-rm -f *~
