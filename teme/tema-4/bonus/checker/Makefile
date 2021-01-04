.PHONY: all clean run build

all: checker

build: checker

run: checker
	./checker

vector_c.o: $(SKEL_FOLDER)vector_c.c
	gcc -mavx2 -c $^ -lm

vector_asm.o: $(SKEL_FOLDER)vector_asm.asm
	nasm -f elf64 $^ -o $@

checker.o: checker.c
	gcc -mavx2 -c -g $^ -o $@ -lm

checker: checker.o vector_c.o vector_asm.o
	gcc -mavx2 -g $^ -o $@ -lm -no-pie
	rm *.o

clean:
	rm checker
	