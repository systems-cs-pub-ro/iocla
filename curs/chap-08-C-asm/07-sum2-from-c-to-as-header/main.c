// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "add.h"

int main(void)
{
	long result;

	result = add(2, 3);
	printf("Sum is: %ld\n", result);

	return 0;
}
