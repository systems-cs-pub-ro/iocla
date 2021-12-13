ASM=nasm
ASMFLAGS=-f elf32
MAKEFLAGS=--silent
CC=gcc
CFLAGS=-m32 -fno-pie -no-pie

build: checker

check:
	./check.sh

checker: checker.o task2_p1.o task2_p2.o
	$(CC) $(CFLAGS) $^ -o $@
 
task2_p1.o: task2_p1.asm
	$(ASM) $(ASMFLAGS) $^

task2_p2.o: task2_p2.asm
	$(ASM) $(ASMFLAGS) $^

checker.o: checker.c
	$(CC) -c $(CFLAGS) $^

copy: 
	if [ -f ../../task2_p1.asm ] && [ -f ../../task2_p2.asm ]; then cp ../../task2_p1.asm ../../task2_p2.asm .; else cp ../task2_p1.asm ../task2_p2.asm .; fi

clean:
	rm checker *.o
