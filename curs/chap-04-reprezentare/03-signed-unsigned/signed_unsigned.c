#include <stdio.h>

unsigned char unsigned_char = 0xaa;
signed char signed_char = 0xaa;

short int short_int = -1;
unsigned int unsigned_int;

int main(void)
{
	printf("%hhu, %hhd\n", unsigned_char, signed_char);

	unsigned_int = short_int;
	printf("short_int (%p): 0x%08x, short_int: %u, short_int: %d\n", &short_int, short_int, short_int, short_int);
	printf("unsigned_int (%p): 0x%08x, unsigned_int: %u, unsigned_int: %d\n", &unsigned_int, unsigned_int, unsigned_int, unsigned_int);

	return 0;
}
