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

copy:
	if [ -f ../../task4.asm ]; then cp ../../task4.asm .; else cp ../task4.asm .; fi

clean:
	rm *.o task4
