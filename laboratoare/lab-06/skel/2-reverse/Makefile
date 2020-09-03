NASM = nasm
AFILES = reverse-array.asm 
OBJS = $(AFILES:.asm=.o) 
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = reverse-array

all : $(BINARIES)


#%.o : %.c
#	gcc -m32 -g -c -o $@ $<
%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

0-recap-mean: reverse-array.o
	$(LD) $(LDFLAGS) -o $@ $^

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 
