// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

int main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[2]; /* 15 */
	int start = 0;
	int mid;
	int end = sizeof(v) / sizeof(int) - 1;

	/* TODO: Implement binary search */
start_while:
	if (start > end)
	{
		printf("Nu a fost gasit elementul dat");
		goto return_label;
	}
	mid = (start + end) / 2;
	if (v[mid] == dest)
		goto end_while;
	if (dest < v[mid])
	{
		end = mid - 1;
		goto start_while;
	}
	if (dest > v[mid])
	{
		start = mid + 1;
		goto start_while;
	}
end_while:
	printf("Elementul dat se afla pe pozitia: %d", mid);

return_label:
	return 0;
}
