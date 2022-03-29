#include <stdio.h>

static int a = 10;
static int *p;

int main(void)
{
	p = (int *) 0x100;
	printf("\n   p = 0x100\n\n");
	printf("p: %p\n", p);
	printf("&p: %p\n", &p);
	printf("&a: %p\n", &a);

	p = &a;
	printf("\n   p = &a\n\n");
	printf("p: %p\n", p);
	printf("&p: %p\n", &p);
	printf("*p: %d\n", *p);

	*p = (int) &a;
	printf("*p: 0x%08x\n", *p);
	printf("a: 0x%08x\n", a);

	return 0;
}
