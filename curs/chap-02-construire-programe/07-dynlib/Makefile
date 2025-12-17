CFLAGS =  # -m32
LDFLAGS = -z noexecstack -no-pie # -m32
AS = nasm
ASFLAGS = -f elf64 -F dwarf 

.DEFAULT_GOAL: all

.PHONY: all clean

all: main

main: main.o libinc.so
	$(CC) $(LDFLAGS) -L. -o $@ main.o -linc

main: main.o inc.o

main.o: main.c

libinc.so: inc.o
	$(CC) -shared -o $@ $^

inc.o: inc.c

clean:
	-rm -f main main.o inc.o libinc.so
	-rm -f *~
