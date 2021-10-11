#include <stdio.h>

long a = 10;
char c = 'a';
char message[128];
int key[256];

int main(void)
{
	printf("a (value): %ld, a (address): %p, a (size): %zu\n", a, &a, sizeof(a));
	printf("c (value): %hhd, a (address): %p, a (size): %zu\n", c, &c, sizeof(c));
	printf("message (address): %p (%p), message (size): %zu\n", message, &message, sizeof(message));
	printf("key (address): %p (%p), key (size): %zu\n", key, &key, sizeof(key));
	printf("main (address): %p (%p), main (size): %zu\n", main, &main, sizeof(main));
	printf("sizeof(&a): %zu, sizeof(&key): %zu\n", sizeof(&a), sizeof(&key));

	return 0;
}
