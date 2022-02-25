ASFLAGS=-f elf64
LDFLAGS= -no-pie
CFLAGS = -g -Wall -Wextra -Werror -fno-pic -masm=intel
PROGNAME := mainmax

build: $(PROGNAME)

include ../../utils/Makefile.single

$(PROGNAME): $(OBJECTS)
	$(CC) $^ -o $@ $(LDFLAGS)

