
FILES = getput.asm tst_gtpt.asm ijump.asm str_test.asm string.asm
OBJS = $(FILES:.asm=.o) 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386

all : getput ijump str_test

getput: getput.o tst_gtpt.o
	$(LD) -o getput  io.o getput.o tst_gtpt.o 

str_test: str_test.o string.o
	$(LD) -o str_test string.o str_test.o io.o

ijump: ijump.o
	$(LD) -o ijump io.o ijump.o  

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f $(OBJS)
	rm -f getput ijump str_test *~
