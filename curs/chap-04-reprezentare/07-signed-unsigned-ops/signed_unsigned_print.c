#include <stdio.h>

int v1 = -1;
unsigned int v2 = -2;

int sum1;
unsigned int sum2;

int main(void)
{
	printf("v1 (%%d): %d, v1 (%%u): %u, v1 (%%08x): 0x:%08x\n", v1, v1, v1);
	printf("v2 (%%d): %d, v2 (%%u): %u, v2 (%%08x): 0x:%08x\n", v2, v2, v2);
	printf("-1 (%%d): %d, -1 (%%u): %u, -1 (%%08x): 0x:%08x\n", -1, -1, -1);

	sum1 = v1 + 20;
	sum2 = v2 + 20;

	printf("sum1 (%%d): %d, sum1 (%%u): %u, sum1 (%%08x): 0x:%08x\n", sum1, sum1, sum1);
	printf("sum2 (%%d): %d, sum2 (%%u): %u, sum2 (%%08x): 0x:%08x\n", sum2, sum2, sum2);

	// MAXINT MAXINT-1
	if (v1 < v2)
		printf("-1 < -2\n");
	else
		printf("-1 > -2\n");

	//10      MAXINT-1
	v1 = 10;
	if (v1 < v2)
		printf("10 < -2\n");
	else
		printf("10 > -2\n");

	return 0;
}
