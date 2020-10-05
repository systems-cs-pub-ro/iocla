#include <stdio.h>

int main(void)
{
	int a = 10;
	int *p;

	p = (int *) 0x100;
	printf("\n   p = 0x100\n\n");
	printf("p: %p\n", p);
	printf("&p: %p\n", &p);

	p = &a;
	printf("\n   p = &a\n\n");
	printf("p: %p\n", p);
	printf("&p: %p\n", &p);
	printf("*p: %d\n", *p);

	return 0;
}
