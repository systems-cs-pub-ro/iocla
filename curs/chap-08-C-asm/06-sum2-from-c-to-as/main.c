// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

/* Declaration of the assembly add() function. */
long add(long a, long b);

int main(void)
{
	long result;

	result = add(2, 3);
	printf("Sum is: %ld\n", result);

	return 0;
}
