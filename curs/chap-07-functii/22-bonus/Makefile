NASM=nasm
GCC=gcc

all: factorial factorial32

factorial: factorial.o
	$(GCC) factorial.o -no-pie -o factorial

factorial.o: factorial.asm
	$(NASM) -felf64 factorial.asm -o factorial.o

factorial32: factorial32.o
	$(GCC) -m32 factorial32.o -no-pie -o factorial32

factorial32.o: factorial32.asm
	$(NASM) -felf32 factorial32.asm -o factorial32.o

clean:
	rm -f factorial.o factorial factorial32.o factorial32
