CFLAGS  = -Wall -g -fno-PIC -fno-stack-protector -Wno-unused-function
LDFLAGS = -no-pie

.PHONY: all clean

all: rop_target

rop_target: rop_target.o

rop_target.o: rop_target.c

clean:
	-rm -f rop_target rop_target.o
	-rm -f *~
