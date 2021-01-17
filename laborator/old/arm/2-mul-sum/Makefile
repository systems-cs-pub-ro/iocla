AS=armv8l-linux-gnueabihf-as
LD=armv8l-linux-gnueabihf-ld
CC=armv8l-linux-gnueabihf-gcc

L_PATH=/opt/gcc-armv8l/armv8l-linux-gnueabihf/libc/

build:
	@$(AS) mul.asm -o mul.o
	@$(CC) -o mul mul.o

run: build
	@qemu-arm -L $(L_PATH) mul || true

clean:
	rm -f mul.o mul
