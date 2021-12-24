#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned char c[8] = {0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88};
unsigned short s[4];
unsigned int i[2];
unsigned long long ll[1];

int main(void)
{
	size_t j;

	memcpy(s, c, sizeof(c));
	memcpy(i, c, sizeof(c));
	memcpy(ll, c, sizeof(c));

	printf("s:");
	for (j = 0; j < sizeof(s) / sizeof(s[0]); j++)
		printf(" 0x%04x", s[j]);
	printf("\n");

	printf("i:");
	for (j = 0; j < sizeof(i) / sizeof(i[0]); j++)
		printf(" 0x%08x", i[j]);
	printf("\n");

	printf("ll:");
	for (j = 0; j < sizeof(ll) / sizeof(ll[0]); j++)
		printf(" 0x%016llx", ll[j]);
	printf("\n");

	return 0;
}
