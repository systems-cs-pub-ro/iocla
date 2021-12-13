ASM=nasm
ASMFLAGS=-f elf64
MAKEFLAGS=--silent

build: checker

check:
	./check.sh

checker: checker.o bonus_x64.o
 
bonus_x64.o: bonus_x64.asm
	$(ASM) $(ASMFLAGS) $^

checker.o: checker.c

copy:
	if [ -f ../../bonus_x64.asm ]; then cp ../../bonus_x64.asm .; else cp ../bonus_x64.asm .; fi

clean:
	rm checker *.o
