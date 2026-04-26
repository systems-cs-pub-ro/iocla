// SPDX-License-Identifier: BSD-3-Clause

#include <stddef.h>

/* Implements sum_array() that receives an array and its length
 * and returns the sum of the elements.
 */
unsigned long sum_array(unsigned long *a, size_t num_items)
{
	size_t i;
	unsigned long sum;

	sum = 0;
	for (i = 0; i < num_items; i++)
		sum += a[i];

	return sum;
}
