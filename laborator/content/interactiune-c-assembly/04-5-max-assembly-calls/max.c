// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

unsigned int get_max(unsigned int *arr, unsigned int len, unsigned int *pos)
{
	unsigned int max = 0;
	size_t i;

	for (i = 0; i < len; i++) {
		if (max < arr[i])
			max = arr[i];
    }

    for (i = 0; i < len; i++) {
        if (arr[i] == max)
            *pos = i;
    }

	return max;
}
