AS = nasm
ASFLAGS = -f elf32
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: sum_n sum_n_arg

sum_n: sum_n.o

sum_n.o: sum_n.asm
	$(AS) $(ASFLAGS) -o $@ $<

sum_n_arg: sum_n_arg.o

sum_n_arg.o: sum_n_arg.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	-rm -f sum_n sum_n.o
	-rm -f sum_n_arg sum_n_arg.o
	-rm -f *~
