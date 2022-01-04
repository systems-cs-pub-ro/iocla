ASM = nasm
ASMFLAGS = -f elf64
SOURCE = bonus_vectorial.asm

build: checker

check: 
	./check.sh

checker: checker.o bonus_vectorial.o
 
bonus_vectorial.o: $(SOURCE)
	$(ASM) $(ASMFLAGS) $^

checker.o: checker.c

copy:
	if [ -f ../../$(SOURCE) ]; then cp ../../$(SOURCE) .; else cp ../$(SOURCE) .; fi

clean:
	rm checker *.o