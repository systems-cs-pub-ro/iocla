AS=armv8l-linux-gnueabihf-as
LD=armv8l-linux-gnueabihf-ld
CC=armv8l-linux-gnueabihf-gcc

L_PATH=/opt/gcc-armv8l/armv8l-linux-gnueabihf/libc/

build:
	@$(AS) strings.asm -o strings.o
	@$(CC) -o strings strings.o

run: build
	@qemu-arm -L $(L_PATH) strings || true

clean:
	rm -f strings.o strings
