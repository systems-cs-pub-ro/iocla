#include <stdio.h>

void g(void)
{
	unsigned int a = 0xaabbccdd;
}

void f(void)
{
	const unsigned int b = 0x01020304;
	unsigned int *p = &b;

	printf("before: 0x%08x\n", b);
	//b = 500;
	*p = 500;

	printf("after: 0x%08x\n", b);
	g();
}

int main(void)
{
	unsigned int c = 0x99887766;

	f();

	return 0;
}
