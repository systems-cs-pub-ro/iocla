CC=gcc
CFLAGS=-m32
ASM=nasm
ASMFLAGS=-f elf32

build: task4

check:
	./check.sh

task4: checker.o task4.o
	$(CC) $(CFLAGS) -o $@ $^

checker.o: checker.c

task4.o: task4.asm
	$(ASM) $(ASMFLAGS) $< -o $@

copy: ../../task4.asm
	cp $^ .

clean:
	rm *.o task4
