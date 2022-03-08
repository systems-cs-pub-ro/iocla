#include <stdio.h>

void rotate_left(int* number, int bits)
{
	/* TODO */
	int number_shifted = sizeof(int) * 8 - bits, first_shift = *number << bits; 
	int last_shift = *number >> number_shifted;
	*number = first_shift + last_shift;
}

void rotate_right(int *number, int bits)
{
	/* TODO */
	int number_shifted = sizeof(int) * 8 - bits, first_shift = *number >> bits;
	int last_shift = *number << number_shifted;
	*number = first_shift + last_shift;
}

int main()
{
	/* TODO: Test functions */
	int bits, number;
	char type[20];
	scanf("%d %d %s", &number, &bits, type);
	if (strcmp(type, "left") == 0)
		rotate_left(&number, bits);
	else
		rotate_right(&number, bits);
	return 0;
}

