AFILES = arrayfsuma.asm quada.asm fpadd.asm
CFILES = arrayfsumc.c arrayfsum_inline.c quadc.c fpprint.c

OBJS = $(AFILES:.asm=.o) 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = cc -m32 -g
BINARIES = arrayfsumc quadc fp-m32 fp-m32-O2 fpadd fpprint fp-m64 fp-m64-O2

all : $(BINARIES)

arrayfsumc: arrayfsumc.o  arrayfsuma.o
	$(LD) -o $@ $^

quadc: quadc.o quada.o
	$(LD) -o $@ $^

fpadd: fpadd.o
	$(LD) -o $@ $^

fpprint: fpprint.o
	$(LD) -o $@ $^

fp-m32-O2: fp_representation.c
	$(CC) -m32 -O2 -o $@ $^
	$(CC) -m32 -O2 -S -masm=intel -o fp-m32-O2.s $<

fp-m32: fp_representation.c
	$(CC) -m32 -o $@ $^
	$(CC) -m32 -S -masm=intel -o fp-m32.s $<

fp-m64-O2: fp_representation.c
	$(CC) -m64 -O2 -o $@ $^
	$(CC) -m64 -O2 -S -masm=intel -o fp-m64-O2.s $<

fp-m64: fp_representation.c
	$(CC) -m64 -o $@ $^
	$(CC) -m64 -S -masm=intel -o fp-m64.s $<



%.o : %.c
#	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	cc -m32 -g -c -o $@ $<

%.o : %.asm
#	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean:
	rm -f *.o $(BINARIES) *.s
	rm -f *~
