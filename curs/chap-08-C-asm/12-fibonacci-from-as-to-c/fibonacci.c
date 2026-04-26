// SPDX-License-Identifier: BSD-3-Clause

/* Recursive Fibonacci implementation in C.
 * Returns 1 for N < 2, fibonacci(N-1) + fibonacci(N-2) otherwise.
 */
unsigned long fibonacci(unsigned long N)
{
	if (N < 2)
		return 1;
	return fibonacci(N - 1) + fibonacci(N - 2);
}
