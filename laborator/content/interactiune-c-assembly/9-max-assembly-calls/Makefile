ASFLAGS=-f elf64
LDFLAGS= -no-pie
CFLAGS = -g -Wall -Wextra -Werror -fno-pic -masm=intel
PROGNAME := mainmax

build: $(PROGNAME)

include ../../utils/Makefile.inc

$(PROGNAME): $(OBJECTS)
	$(CC) $^ -o $@ $(LDFLAGS)

