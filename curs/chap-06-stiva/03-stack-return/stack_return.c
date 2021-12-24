#include <stdio.h>

unsigned int *g(void)
{
	unsigned int a = 0xaabbccdd;
	unsigned int *p = &a;

	return p;
}

void f(void)
{
	unsigned int *p;

	p = g();

	//printf("&a: %p\n", p);
	printf("a: 0x%08x\n", *p);
	printf("a: 0x%08x\n", *p);
}

int main(void)
{
	f();

	return 0;
}
