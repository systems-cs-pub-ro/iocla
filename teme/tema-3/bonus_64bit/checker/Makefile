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

copy: ../../bonus_x64.asm
	cp $^ .

clean:
	rm checker *.o
