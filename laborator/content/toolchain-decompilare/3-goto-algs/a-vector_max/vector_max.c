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

begin_pseudofor:
	
	if (i<=7)
	{
		if (max<v[i])
		{
			max=v[i];
		}
		i++;
		goto begin_pseudofor;
	}
		
	printf("%d",max);

	(void) i;
	(void) max;
}
