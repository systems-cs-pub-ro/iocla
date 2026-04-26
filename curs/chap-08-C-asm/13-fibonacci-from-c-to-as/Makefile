AS = nasm
CC = gcc
CPPFLAGS = -U_FORTIFY_SOURCE
ASFLAGS = -f elf64 -g -F dwarf
CFLAGS = -fno-PIC -fcf-protection=none -fno-stack-protector -O1 -fno-inline -fno-omit-frame-pointer -Wall -Wno-unused-result -g
LD = gcc
LDFLAGS = -no-pie
BINARY = fibonacci
ASM_OBJS = fibonacci.o
C_OBJS = main.o

.PHONY: all clean

all: $(BINARY)

%.o: %.asm
	$(AS) $(ASFLAGS) -o $@ $<

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(BINARY): $(C_OBJS) $(ASM_OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	-rm -f $(ASM_OBJS) $(C_OBJS)
	-rm -f $(BINARY)
	-rm -f *~
