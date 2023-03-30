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

	goto loop;

update:
	max = v[i];
	goto inc;

inc:
	i++;
	goto loop;

loop:
	if (i > 7) goto out;
	if (v[i] > max) goto update;
	goto inc;

out:
	printf("%d\n", max);
	return 0;
}
