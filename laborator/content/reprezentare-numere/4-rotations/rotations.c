#include <stdio.h>

void rotate_left(int *number, int bits)
{
	bits %= sizeof(int) * 8;
	*number = (*number << bits) | (*number >> (sizeof(int) * 8 - bits));
}

void rotate_right(int *number, int bits)
{
	bits %= sizeof(int) * 8;
	*number = (*number >> bits) | (*number << (sizeof(int) * 8 - bits));
}

int main()
{
	int n, copy, bits;
	scanf("%d%d", &n, &bits);
	copy = n;

	rotate_left(&n, bits);
	printf("%d\n", n);

	rotate_right(&copy, bits);
	printf("%d\n", copy);
	
	return 0;
}
