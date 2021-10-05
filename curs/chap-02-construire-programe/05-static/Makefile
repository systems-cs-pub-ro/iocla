CFLAGS = -fno-PIC -m32
LDFLAGS = -static -no-pie -m32
AS = nasm
ASFLAGS = -f elf32

.DEFAULT_GOAL: all

.PHONY: all clean

all: main main_lib

main_lib: main.o libinc.a
	$(CC) $(LDFLAGS) -L. -o $@ main.o -linc

main: main.o inc.o

main.o: main.c

libinc.a: inc.o
	ar rc $@ $^

inc.o: inc.c

clean:
	-rm -f main main.o inc.o
	-rm -f main_lib libinc.a
	-rm -f *~
