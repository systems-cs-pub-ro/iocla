FILES = fact.c  fib.c

ASMS = $(FILES:.c=.s) 
LD = ld -g  -melf_i386 
BINARIES = fact fib

all : $(BINARIES)
asm: $(ASMS)


fib: fib.c
	gcc -m32 -g -o fib  fib.c 
fact: fact.c
	gcc -m32 -g  -o fact  fact.c 


%.s : %.c
#	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	gcc  -S -O2 -masm=intel -m32 -o $@ $<
clean: 
	rm -f $(OBJS) $(BINARIES) $(ASMS)
	rm -f *~ 
