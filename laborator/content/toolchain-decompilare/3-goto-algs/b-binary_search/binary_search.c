// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

int main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[2]; /* 15 */
	int start = 0;
	int end = sizeof(v) / sizeof(int) - 1;
	int curent;

	goto bin_s;

higher:
	start = curent + 1;
	goto bin_s;

lower:
	end = curent - 1;
	goto bin_s;

not_found:
	printf("not found\n");
	goto out;

equal:
	printf("%d\n", v[curent]);
	goto out;

bin_s:
	if (start > end) goto not_found;
	curent = (start + end) / 2;
	if (v[curent] < dest) goto higher;
	if (v[curent] > dest) goto lower;
	goto equal;

out:
	return 0;
}
