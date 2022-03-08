#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void print_binary(int number, int nr_bits)
{
	/* TODO */
	char buff[32], * s = itoa(number, buff, 2);
	int l = nr_bits - strlen(s);

	printf("0b");
	for (int i = 0; i < l; ++i)
		printf("0");
	printf("%s\n", s);
}

void check_parity(int* numbers, int n)
{
	/* TODO */
	for (int i = 0; i < n; ++i)
		if (*(numbers + i) & 1)
			printf("0x%08X\n", *(numbers + i));
		else
			print_binary(*(numbers + i), 8);
}

int main()
{
	/* TODO: Test functions */
	int numbers[100], n;
	scanf("%d", &n);
	for (int i = 0; i < n; ++i)
		scanf("%d", &numbers[i]);
	check_parity(numbers, n);
	return 0;
}

