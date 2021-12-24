CFLAGS = -Wall -m32 -fno-stack-protector -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: func_param

func_param: func_param.o

func_param.o: func_param.c

clean:
	-rm -f func_param func_param.o
	-rm -f *~
