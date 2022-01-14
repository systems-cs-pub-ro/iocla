AS := nasm
CC := gcc

SOURCES ?= $(wildcard *.asm) $(wildcard *.c)
A_SRCS  := $(filter %.asm,$(SOURCES))
C_SRCS  := $(filter %.c,$(SOURCES))

A_OBJS  := $(A_SRCS:.asm=.o)
C_OBJS  := $(C_SRCS:.c=.o)
OBJECTS := $(A_OBJS) $(C_OBJS)

ASFLAGS ?= -f elf32 -F dwarf -I "$(UTILSDIR)"
CFLAGS  ?= -m32 -g -Wall -Wextra -Werror -fno-pic -masm=intel
LDFLAGS ?= -m32 -no-pie

$(A_OBJS): %.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

$(C_OBJS): %.o: %.c
	$(CC) $(CFLAGS) $< -c -o $@

.PHONY: clean
clean:
	@rm -f $(BINARIES) $(PROGNAME) $(OBJECTS)
