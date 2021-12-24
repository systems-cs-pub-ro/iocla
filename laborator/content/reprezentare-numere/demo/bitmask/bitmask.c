#include <stdio.h>

static unsigned int v = 0x1827921;

static unsigned int what(unsigned int num)
{
	size_t i;
	unsigned int m = 0x1;
	unsigned int count = 0;

	for (i = 0; i < 8 * (sizeof(num)); i++) {
		if (m & num)
			count++;
		m <<= 1;
	}

	return count;
}

int main(void)
{
	printf("value: %u, what: %u\n", v, what(v));
	return 0;
}
