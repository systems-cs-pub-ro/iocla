// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdint.h>

#include "read_cycles.h"

static unsigned long fibonacci(unsigned long N)
{
	if (N < 2)
		return 1;
	return fibonacci(N - 1) + fibonacci(N - 2);
}

int main(void)
{
	unsigned long N;
	uint64_t start, end;

	printf("Introduce N: ");
	scanf("%lu", &N);

	start = read_cycles();
	fibonacci(N);
	end = read_cycles();

	printf("fibonacci(%lu) took %lu cycles\n", N, end - start);

	return 0;
}
