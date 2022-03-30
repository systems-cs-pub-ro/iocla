#include <stdio.h>

int main(void)
{
	int v[] = {4, 1, 2, -17, 15, 22, 6, 2};
	int max;
	int i;
	int dim = sizeof(v)/sizeof(v[0]);
	/* TODO: Implement finding the maximum value in the vector */
	max = v[0];
	i = 1;

change_max:
	max = v[i];
again:
if(i == dim)
	goto out;
if(max < v[i])
	goto change_max;
i++;
goto again;
out:
printf("%d\n", max);
}
