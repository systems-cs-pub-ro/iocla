// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>

#include "c_call_asm_sum.h"

#ifndef ARRAY_SIZE
#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
#endif

int g_values[] = {3, 4, -1, 9, 12, 5};
int g_values_len = (int)ARRAY_SIZE(g_values);

int main(void)
{
	int sum = sum_array_asm(g_values, g_values_len);

	printf("c_call_asm sum = %d\n", sum);
	return 0;
}
