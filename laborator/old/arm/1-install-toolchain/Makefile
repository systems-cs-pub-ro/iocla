AS=armv8l-linux-gnueabihf-as
LD=armv8l-linux-gnueabihf-ld
CC=armv8l-linux-gnueabihf-gcc

L_PATH=/opt/gcc-armv8l/armv8l-linux-gnueabihf/libc/

build:
	@$(AS) helloworld.asm -o helloworld.o
	@$(LD) -o hello helloworld.o

run: build
	@qemu-arm -L $(L_PATH) hello || true

clean:
	rm -f helloworld.o hello
