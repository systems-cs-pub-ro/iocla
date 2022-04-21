.PHONY: all clean run build

all: checker

build: checker

run: checker
	./checker

simple.o: simple.asm
	nasm -f elf $^ -o $@

check_simple_cipher.o: check_simple_cipher.c
	gcc -c -g -m32 $^ -o $@

checker: check_simple_cipher.o  simple.o
	gcc -m32 -g $^ -o $@
	rm *.o

clean:
	rm -f checker
	rm -f output/simple-*