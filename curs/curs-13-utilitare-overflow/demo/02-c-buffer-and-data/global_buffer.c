#include <stdio.h>

static unsigned int buf[32];
static unsigned int type = 1111;
static unsigned int length = 2222;

/*
	buf in .bss, type, length in .data
	objdump -t ./global_buffer | sort
*/

int main(void)
{
	printf("buf[-16]: %u, buf[-17]: %u\n", buf[-16], buf[-17]);
	printf("type: %u, length: %u\n", type, length);

	buf[-16] = 5555; buf[-17] = 6666;
	printf("type: %u, length: %u\n", type, length);

	return 0;
}
