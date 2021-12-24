
AFILES = update_max.asm
CFILES = test_update_max.c 

OBJS = $(AFILES:.asm=.o) 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf 
LD = cc -m32 -g
BINARIES = test_update_max

all : $(BINARIES)

test_update_max: test_update_max.o update_max.o
	$(LD) -o $@ $^ 

%.o : %.c
	cc -m32 -g -c -o $@ $<

%.o : %.asm
#	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
clean: 
	rm -f *.o $(BINARIES)
	rm -f *~ 
