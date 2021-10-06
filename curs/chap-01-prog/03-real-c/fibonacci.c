#include "fibonacci.h"

unsigned int fibonacci(unsigned int num)
{
	if (num > FIBO_LIMIT)
		return 0;

	if (num == 0)
		return 1;

	if (num == 1)
		return 1;

	return fibonacci(num-1) + fibonacci(num-2);
}

unsigned int fibonacci_iter(unsigned int num)
{
	unsigned int prev, prev_prev, current;
	unsigned int i;

	if (num > FIBO_LIMIT)
		return 0;

	if (num == 0)
		return 1;

	if (num == 1)
		return 1;

	prev = 1;
	prev_prev = 1;
	for (i = 2; i <= num; i++) {
		current = prev + prev_prev;
		prev_prev = prev;
		prev = current;
	}

	return current;
}
