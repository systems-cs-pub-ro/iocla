#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned char char_array[8] = {0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88};
unsigned short short_array[4];
unsigned int int_array[2];
unsigned long long ll_array[1];

int main(void)
{
	size_t j;

	memcpy(short_array, char_array, sizeof(char_array));
	memcpy(int_array, char_array, sizeof(char_array));
	memcpy(ll_array, char_array, sizeof(char_array));

	printf("s:");
	for (j = 0; j < sizeof(short_array) / sizeof(short_array[0]); j++)
		printf(" 0x%04x", short_array[j]);
	printf("\n");

	printf("i:");
	for (j = 0; j < sizeof(int_array) / sizeof(int_array[0]); j++)
		printf(" 0x%08x", int_array[j]);
	printf("\n");

	printf("ll:");
	for (j = 0; j < sizeof(ll_array) / sizeof(ll_array[0]); j++)
		printf(" 0x%016llx", ll_array[j]);
	printf("\n");

	return 0;
}
