CFLAGS = -m32 -fno-PIC -Wall
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: jmp je

jmp: jmp.o

jmp.o: jmp.c

je: je.o

je.o: je.c

clean:
	-rm -f *~
	-rm -f jmp.o jmp
	-rm -f je.o je
