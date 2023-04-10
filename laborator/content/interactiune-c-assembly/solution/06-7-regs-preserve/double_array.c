#include <stdio.h>

void double_array(unsigned int *array, unsigned int len)
{
	size_t i;

	for (i = 0; i < len; i++)
		*(array + i) *= 2;
}
