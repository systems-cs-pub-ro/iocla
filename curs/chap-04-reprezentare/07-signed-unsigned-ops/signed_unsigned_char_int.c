#include <stdio.h>

int main(void)
{
	signed char c1 = -9;
	unsigned char c2 = c1;
	signed int i1;
	unsigned int i2;

	i1 = c1;
	printf("0x%08x\n", i1);
	i1 = c2;
	printf("0x%08x\n", i1);
	i1 = c1 + c2;
	printf("0x%08x\n", i1);

	i2 = c1;
	printf("0x%08x\n", i2);
	i2 = c2;
	printf("0x%08x\n", i2);
	i2 = c1 + c2;
	printf("0x%08x\n", i2);

	i1 = -9;
	i2 = i1;

	c1 = i1;
	printf("0x%02x\n", c1);
	c1 = i2;
	printf("0x%02x\n", c1);

	c2 = i1;
	printf("0x%02x\n", c2);
	c2 = i2;
	printf("0x%02x\n", c2);

	return 0;
}
