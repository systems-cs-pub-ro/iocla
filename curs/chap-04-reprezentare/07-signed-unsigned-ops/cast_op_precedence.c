#include <stdio.h>

int main(void)
{
  signed int a, b, c, d;
  signed char c1 = 100, c2 = 100, c3, c4 = 127, c5 = 127, c6;

	c3 = c1 + c2;
	a = c3;
	b = c1 + c2;

	printf("a: 0x%08x\n", a);
	printf("b: 0x%08x\n", b);

	c6 = ++c4;
	c = c6;
	d = ++c5;

	printf("c: 0x%08x\n", c);
	printf("d: 0x%08x\n", d);

	return 0;
}
