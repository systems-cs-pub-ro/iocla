// SPDX-License-Identifier: BSD-3-Clause
#include <stddef.h>

int sum_array_c(const int *arr, int n)
{
	int sum = 0;

	for (int i = 0; i < n; i++)
		sum += arr[i];

	return sum;
}
