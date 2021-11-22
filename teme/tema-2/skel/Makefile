.PHONY: all clean run build

all: checker

build: checker

run: checker
	./checker

rotp.o: rotp.asm
	nasm -f elf $^ -o $@

ages.o: ages.asm
	nasm -f elf $^ -o $@

columnar.o: columnar.asm
	nasm -f elf $^ -o $@

cache.o: cache.asm
	nasm -f elf $^ -o $@


checker.o: checker.c
	gcc -c -g -m32 $^ -o $@



checker: checker.o  ages.o rotp.o columnar.o cache.o
	gcc -m32 -g $^ -o $@
	rm *.o

clean:
	rm -f checker
	rm -f output/*
