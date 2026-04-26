AS = nasm
ASFLAGS = -f elf64
CFLAGS = -g -fno-PIC -mcmodel=large -fcf-protection=none -fno-stack-protector -O1 -fno-omit-frame-pointer
LDFLAGS = -no-pie -z noexecstack 

.PHONY: all clean

all: main

main: main.o proc.o

proc.o: proc.asm
	$(AS) $(ASFLAGS) -o $@ $<

main.o: main.c

clean:
	-rm -f main main.o proc.o
	-rm -f *~
