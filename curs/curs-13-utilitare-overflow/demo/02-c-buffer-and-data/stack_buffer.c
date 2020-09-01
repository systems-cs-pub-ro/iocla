#include <stdio.h>

int main(void)
{
	unsigned int length = 2222;
	unsigned int type = 1111;
	unsigned int buf[32];

	printf("buf[32]: %u, buf[33]: %u\n", buf[32], buf[33]);
	printf("type: %u, length: %u\n", type, length);

	buf[32] = 5555; buf[33] = 6666;
	printf("type: %u, length: %u\n", type, length);

	return 0;
}
