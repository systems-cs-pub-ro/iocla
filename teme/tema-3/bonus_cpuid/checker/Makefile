CC = gcc
CFLAGS = -m32
ASM = nasm
ASMFLAGS = -f elf

build: checker

check: 
	./check.sh

checker: checker.o bonus_cpuid.o
	$(CC) $(CFLAGS) $^ -o $@
 
bonus_cpuid.o: bonus_cpuid.asm
	$(ASM) $(ASMFLAGS) $^

checker.o: checker.c
	$(CC) -c $(CFLAGS) $^

copy: ../../bonus_cpuid.asm
	cp $^ .

clean:
	rm checker *.o