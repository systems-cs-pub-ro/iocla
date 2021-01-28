ASM = nasm
ASM_FLAGS = -f elf32 -g -Fdwarf
CC = gcc
CFLAGS = -Wall -Wno-unused-function -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -fno-PIC -static
LDFLAGS = -m32 -no-pie


.PHONY: all clean

all: program

program: program.o functions.o
	$(CC) $(CFLAGS) -o $@ $^

program.o: program.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

functions.o: functions.c

clean:
	-rm -f *~
	-rm -f *.o program
