// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

int main(void)
{
	int v[] = {4, 1, 2, -17, 15, 22, 6, 2};
	int max;
	int i;

	/* TODO: Implement finding the maximum value in the vector */
	max = v[0];
	i = 1;


	(void) i;
	(void) max;

repeat:
	if(i < 7){
		if( v[i++] > max)
			max = v[i];
	goto repeat;
	}

	printf("%d", max);
}
