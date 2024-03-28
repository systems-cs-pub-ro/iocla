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
for_label:
	if (v[i] > max)
		max = v[i];
	i++;
	if (i >= 8)
		goto out_label;
	goto for_label;

out_label:
	printf("Valoarea maxima din vector este %d\n", max);
	return 0;
}
