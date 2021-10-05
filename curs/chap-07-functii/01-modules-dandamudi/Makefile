
FILES = module2.asm  procex2.asm  module1.asm  procex1.asm  procex3.asm
OBJS = $(FILES:.asm=.o) 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf -I ../../Linux_IOfiles/
LD = ld -g  -melf_i386 ../../Linux_IOfiles/io.o
BINARIES = procex1 procex2 procex3 modules 

all : $(BINARIES)

procex1: procex1.o
	$(LD) -o procex1  procex1.o 
procex2: procex2.o
	$(LD) -o procex2  procex2.o 
procex3: procex3.o
	$(LD) -o procex3  procex3.o 

procswap: procswap.o
	$(LD) -o procswap  procswap.o 
modules: module1.o module2.o
	$(LD) -o modules  module1.o module2.o 


%.o : %.asm
#	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f $(OBJS) $(BINARIES)
	rm -f *~ 
