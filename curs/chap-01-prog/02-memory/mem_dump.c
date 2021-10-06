#include <stdio.h>

unsigned int value = 0xabcdef01;

unsigned int num_votes[] = { 1883, 8382, 2759, 7321, 2731, 0, 10, 16 };

struct my_struct {
	unsigned int salary;
	unsigned char sex;
	unsigned int passport_number;
	unsigned char age;
};

static struct my_struct ben = {
	5691,
	1,
	839291123,
	42,
};

static void dump(const void *start, size_t len, const char *id)
{
	unsigned int i;

	printf("\nDumping %s from address %p (%zu bytes):\n", id, start, len);
	for (i = 0; i < len; i++) {
		/* Add a newline every 8 bytes. */
		if (i % 8 == 0)
			puts("");
		printf(" %02x", *((const unsigned char *) start + i));
	}
	/* And newline at the end. */
	puts("");
}

int main(void)
{
	dump(&value, sizeof(value), "value");
	dump(&ben, sizeof(ben), "ben (struct)");
	dump(&num_votes, sizeof(num_votes), "num_votes (array)");
	dump(&main, 32, "main (function)");

	return 0;
}
