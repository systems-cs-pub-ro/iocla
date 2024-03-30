#include <stdio.h>

unsigned int i = 0x12345678;
unsigned short int s[2] = {0x5678, 0x1234};
unsigned char c[4] = {0x78, 0x56, 0x34, 0x12};

static void dump(const void *start, size_t len, const char *id)
{
	unsigned int i;

	printf("\nDumping %s from address %p (%zu bytes):\n", id, start, len);
	for (i = 0; i < len; i++) {
		/* Add a newline every 8 bytes. */
		if (i % 8 == 0)
			printf("\n");
		printf(" %02x", *((const unsigned char *) start + i));
	}
	/* And newline at the end. */
	printf("\n");
}


int main(void)
{
	dump(&i, sizeof(i), "i (unsigned int)");
	dump(&s, sizeof(s), "s (unsigned short int)");
	dump(&c, sizeof(c), "c (unsigned char)");

	return 0;
}
