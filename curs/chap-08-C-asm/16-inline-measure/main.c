// SPDX-License-Identifier: BSD-3-Clause

/* Inline assembly example: use rdtsc to measure cycles taken by fibonacci(). */

#include <stdio.h>
#include <stdint.h>

static unsigned long fibonacci(unsigned long N)
{
	if (N < 2)
		return 1;
	return fibonacci(N - 1) + fibonacci(N - 2);
}

static uint64_t read_tsc(void)
{
	uint32_t lo, hi;

	__asm__ volatile (
		"rdtsc"
		: "=a"(lo), "=d"(hi)
	);
	return ((uint64_t)hi << 32) | lo;
}

int main(void)
{
	unsigned long N;
	uint64_t start, end;

	printf("Introduce N: ");
	scanf("%lu", &N);

	start = read_tsc();
	fibonacci(N);
	end = read_tsc();

	printf("fibonacci(%lu) took %lu cycles\n", N, end - start);

	return 0;
}
