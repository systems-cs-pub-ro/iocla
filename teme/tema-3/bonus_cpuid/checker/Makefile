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

copy:
	if [ -f ../../bonus_cpuid.asm ]; then cp ../../bonus_cpuid.asm .; else cp ../bonus_cpuid.asm .; fi

clean:
	rm checker *.o