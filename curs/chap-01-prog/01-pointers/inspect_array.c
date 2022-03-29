#include <stdio.h>

static int key[256];

int main(void)
{
	printf("key: %p\n", key);
	printf("&key: %p\n", &key);
	printf("key + 10: %p\n", key + 10);
	printf("key[10]: %d\n", key[10]);
	printf("*(key + 10): %d\n", *(key + 10));
	printf("10[key]: %d\n", 10[key]);
	printf("&key[10]: %p\n", &key[10]);
	printf("sizeof(key): %zu\n", sizeof(key));
	printf("sizeof(key[10]): %zu\n", sizeof(key[10]));

	return 0;
}
