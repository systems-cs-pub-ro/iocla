#include <stdio.h>

int main(void)
{
	unsigned char *p;
	size_t i;

	puts("Hello, World!");

	p = (unsigned char *) main;
	printf("main: %p\n", p);
	for (i = 0; i < 24; i++)
		printf("\\x%02x", p[i]);
	puts("");
	//*p = 0x99;

	return 0;
}
