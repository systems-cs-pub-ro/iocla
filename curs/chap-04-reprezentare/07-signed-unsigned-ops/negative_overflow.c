#include <stdio.h>

int main(void)
{
	signed char c = -120;
	unsigned char cu = c;

	printf("0x%02x\n", c);
	printf("0x%02x\n", cu);

	return 0;
}
