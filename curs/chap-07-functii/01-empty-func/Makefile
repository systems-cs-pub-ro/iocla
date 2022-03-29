CFLAGS = -Wall -m32 -fno-stack-protector -fomit-frame-pointer -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: empty_func

empty_func: empty_func.o

empty_func.o: empty_func.c

clean:
	-rm -f empty_func empty_func.o
	-rm -f *~
