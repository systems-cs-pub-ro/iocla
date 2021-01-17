GCCFLAGS=-m32
NASMFLAGS=-f elf32

all: profile

profile: profile.o
	gcc $(GCCFLAGS) -o profile profile.o

profile.o: profile.asm
	nasm $(NASMFLAGS) profile.asm

clean:
	rm -f profile.o profile
