// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>

#ifndef ARRAY_SIZE
#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
#endif

static int sum_array_inline(const int *arr, int n)
{
	int sum;

	/* %0 = sum (output, eax), %1 = arr (pointer), %2 = n (int) */
	__asm__ volatile (
		"xor %k0, %k0\n\t"                              /* sum = 0          */
		"xor r8d, r8d\n\t"                              /* index i = 0      */
		"test %k2, %k2\n\t"                             /* if (n <= 0) skip */
		"jle 2f\n\t"
		"1:\n\t"
		"add %k0, dword ptr [%q1 + r8 * 4]\n\t"        /* sum += arr[i]    */
		"inc r8d\n\t"                                   /* i++              */
		"cmp r8d, %k2\n\t"                              /* if (i < n) loop  */
		"jl 1b\n\t"
		"2:\n\t"
		: "=&r" (sum)
		: "r" (arr), "r" (n)
		: "r8", "cc", "memory"
	);

	return sum;
}

int main(void)
{
	int values[] = {8, 1, -3, 20, 4};
	int n = (int)ARRAY_SIZE(values);
	int sum = sum_array_inline(values, n);

	printf("inline_asm sum = %d\n", sum);

	return 0;
}
