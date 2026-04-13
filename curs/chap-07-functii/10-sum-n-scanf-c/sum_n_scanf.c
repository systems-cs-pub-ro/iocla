// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

static long sum_n(long N)
{
	long i;
	long sum;

	sum = 0;
	for (i = 1; i <= N; i++)
		sum += i;

	return sum;
}

int main(void)
{
	long N;
	long sum;

	printf("Introduce N: ");
	scanf("%ld", &N);

	sum = sum_n(N);

	printf("Sum is: %ld\n", sum);

	return 0;
}
