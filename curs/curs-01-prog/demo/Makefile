CFLAGS = -Wall -fno-PIC
LDFLAGS = -no-pie

.PHONY: all clean

all: inspect_vars

inspect_vars: inspect_vars.o

inspect_vars.o: inspect_vars.c

clean:
	-rm -f inspect_vars.o
	-rm -f inspect_vars
	-rm -f *~
