// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "sum_array.h"

static unsigned long num_array[] = {10, 20, 30, 40, 50, 60, 70, 80};

int main(void)
{
	unsigned long result;

	result = sum_array(num_array, sizeof(num_array) / sizeof(num_array[0]));
	printf("Sum of array elements is: %lu\n", result);

	return 0;
}
