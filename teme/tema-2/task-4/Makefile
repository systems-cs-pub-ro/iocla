check_spiral: spiral.o checker.o
	gcc -m32 -g $^ -o $@

spiral.o: spiral.asm
	nasm -f elf $^ -o $@

checker.o: check_spiral.c
	gcc -c -g -m32 $^ -o $@	

clean:
	rm check_spiral
	rm checker.o
	rm spiral.o
	rm output/spiral*
