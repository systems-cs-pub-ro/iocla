#include <stdio.h>

int main(void)
{
	unsigned char u = 0x99;
	signed char s = -19;

	printf("u: %u s: %u\n", u, (unsigned char) s);
	printf("u: %d s: %d\n", (signed char) u, s);

	return 0;
}
