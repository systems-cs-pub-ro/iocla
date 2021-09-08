AS=armv8l-linux-gnueabihf-as
LD=armv8l-linux-gnueabihf-ld
CC=armv8l-linux-gnueabihf-gcc

L_PATH=/opt/gcc-armv8l/armv8l-linux-gnueabihf/libc/

build:
	@$(AS) mem.asm -o mem.o
	@$(CC) -o mem mem.o

run: build
	@qemu-arm -L $(L_PATH) mem || true

clean:
	rm -f mem.o mem
