// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

int main() {
	unsigned long long val = 0xFFFFFFFE;
	unsigned long long double_val;

	double_val = compute_double(val);

	printf("2 * %lld = %llx\n", val, double_val);

	return 0;
}
