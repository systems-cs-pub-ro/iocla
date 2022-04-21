check_beaufort: beaufort.o checker.o
	gcc -m32 -g $^ -o $@

beaufort.o: beaufort.asm
	nasm -f elf $^ -o $@

checker.o: check_beaufort.c
	gcc -c -g -m32 $^ -o $@

clean:
	rm check_beaufort
	rm beaufort.o
	rm checker.o
	rm output/beaufort*
