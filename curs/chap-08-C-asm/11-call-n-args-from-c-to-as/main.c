// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "sums.h"

int main(void)
{
	printf("sum2(1,2) = %ld\n",               sum2(1, 2));
	printf("sum3(1,2,3) = %ld\n",             sum3(1, 2, 3));
	printf("sum4(1,2,3,4) = %ld\n",           sum4(1, 2, 3, 4));
	printf("sum5(1,2,3,4,5) = %ld\n",         sum5(1, 2, 3, 4, 5));
	printf("sum6(1,2,3,4,5,6) = %ld\n",       sum6(1, 2, 3, 4, 5, 6));
	printf("sum7(1,2,3,4,5,6,7) = %ld\n",     sum7(1, 2, 3, 4, 5, 6, 7));
	printf("sum8(1,2,3,4,5,6,7,8) = %ld\n",   sum8(1, 2, 3, 4, 5, 6, 7, 8));

	return 0;
}
