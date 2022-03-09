#include <stdio.h>
#include <stdlib.h>

#define NMAX 100

void print_binary(int number, int nr_bits)
{
	printf("0b");
	for (int mask = 1 << (nr_bits - 1); mask; mask >>= 1)
		printf(number & mask ? "1" : "0");
	printf("\n");
}

void check_parity(int *numbers, int n)
{
	for (int i = 0; i < n; ++i)
		if (*(numbers + i) & 1)
			printf("0x%08X\n", *(numbers + i));
		else
			print_binary(*(numbers + i), 8);
}

int main()
{
	int n, v[NMAX];
	scanf("%d", &n);

	for (int i = 0; i < n; ++i)
		scanf("%d", v + i);
	
	check_parity(v, n);
	return 0;
}
