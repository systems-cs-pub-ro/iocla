CFLAGS = -fno-PIC -m32 -g
LDFLAGS = -no-pie -m32

.DEFAULT_GOAL: all

.PHONY: all clean

all: main

main: main.o state.o
	$(CC) $(LDFLAGS) -o $@ $^

main.o: main.c state.h

state.o: state.c

clean:
	-rm -f main main.o state.o
	-rm -f *~
