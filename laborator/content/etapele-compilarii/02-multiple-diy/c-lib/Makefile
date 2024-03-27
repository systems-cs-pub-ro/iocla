CFLAGS = -fno-PIC -m32 -g
LDFLAGS = -no-pie -m32

.DEFAULT_GOAL: all

.PHONY: all clean

all: main

main: main.o libops.a
	$(CC) $(LDFLAGS) -o $@ $< -L. -lops

main.o: main.c ops.h

libops.a: div.o mul.o
	ar rc $@ $^

div.o: div.c

mul.o: mul.c

clean:
	-rm -f main main.o libops.a div.o mul.o
	-rm -f *~
