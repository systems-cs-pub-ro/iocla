// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "fibonacci.h"

int main(void)
{
	unsigned long N;

	printf("Introduce N: ");
	scanf("%lu", &N);
	printf("Fibonacci(%lu) = %lu\n", N, fibonacci(N));

	return 0;
}
