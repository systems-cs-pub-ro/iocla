#include <stdio.h>

static void disclosure_target(unsigned int a, unsigned int b)
{
	size_t i;
	unsigned int buf[4];

	for (i = 0; i < 4; i++)
		buf[i] = i * i * i;

	for (i = 10; i != 0; i--)
		printf("buf[%02u] (address: %p) = 0x%08x\n", i, &buf[i], buf[i]);
}

int main(void)
{
  /* practically a textbook drawing of the stack */ 
	disclosure_target(0xaabbccdd, 0x55667788);
	return 0;
}
