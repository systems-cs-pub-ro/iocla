FILES = getput.asm tst_gtpt.asm ijump.asm str_test.asm string.asm shift_types.asm
OBJS = $(FILES:.asm=.o) 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf  -I ../../Linux_IOfiles/ 
LD = ld  -melf_i386 ../../Linux_IOfiles/io.o 

all: getput ijump str_test shift_types size

getput: getput.o tst_gtpt.o
	$(LD) -o getput  getput.o tst_gtpt.o

str_test: str_test.o string.o
	$(LD) -o str_test string.o str_test.o 

ijump: ijump.o
	$(LD) -o ijump ijump.o

shift_types: shift_types.o
	gcc -m32 -o $@ $<

size: size.o
	gcc -m32 -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean:
	rm -f $(OBJS)
	rm -f getput ijump str_test size shift_types *~
