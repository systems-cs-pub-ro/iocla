// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

int main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[2]; /* 15 */
	int start = 0;
	int end = sizeof(v) / sizeof(int) - 1;

	/* TODO: Implement binary search */
	(void) dest;
	(void) start;
	(void) end;

bsearch:

	int mijloc = (start+end)/2;
	if (dest == v[mijloc])
	{
		printf("\nElementul %d gasit la pozitia %d.\n",dest,mijloc);
		return 0;
	}
	if (dest<v[mijloc])
	{
		end = mijloc;
		goto bsearch;
	}
	if (dest>v[mijloc])
	{
		start = mijloc;
		goto bsearch;
	}
	
	printf("Elementul nu s-a gasit\n");

return 0;
}
