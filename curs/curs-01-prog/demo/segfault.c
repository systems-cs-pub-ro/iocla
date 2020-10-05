#include <stdio.h>

int main(void)
{
	int *p = (int *) 0xabcdef89;

	printf("p: %p\n", p);
	printf("&p: %p\n", &p);
	printf("*p: %d\n", *p);

	return 0;
}
