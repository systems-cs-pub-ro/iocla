CFLAGS = -Wall -fno-PIC -g # -m32
LDFLAGS = -no-pie # -m32

.PHONY: all clean

all: mem_dump mem_areas

mem_dump: mem_dump.o

mem_dump.o: mem_dump.c

mem_areas: mem_areas.o

mem_areas.o: mem_areas.c

clean:
	-rm -f mem_dump.o mem_areas
	-rm -f mem_dump mem_areas
	-rm -f *~
