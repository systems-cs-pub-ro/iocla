.PHONY: all clean run build

all: checker

build: checker

run: checker
	./checker

points-distance.o: points-distance.asm
	nasm -f elf $^ -o $@

road.o: road.asm
	nasm -f elf $^ -o $@

is_square.o: is_square.asm
	nasm -f elf $^ -o $@

check_points.o: check_points.c
	gcc -c -g -m32 $^ -o $@

checker: check_points.o  points-distance.o road.o is_square.o
	gcc -m32 -g $^ -o $@
	rm *.o

clean:
	rm -f checker
	rm -f output/points-*