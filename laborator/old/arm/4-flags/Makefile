AS=armv8l-linux-gnueabihf-as
LD=armv8l-linux-gnueabihf-ld
CC=armv8l-linux-gnueabihf-gcc

L_PATH=/opt/gcc-armv8l/armv8l-linux-gnueabihf/libc/

build:
	@$(AS) flags.asm -o flags.o
	@$(CC) -o flags flags.o

run: build
	@qemu-arm -L $(L_PATH) flags || true

clean:
	rm -f flags.o flags
