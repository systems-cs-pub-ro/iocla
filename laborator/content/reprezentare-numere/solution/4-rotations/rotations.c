// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

void rotate_left(int *number, int bits)
{
	unsigned int bit_mask = -1;

	bit_mask <<= (sizeof(*number) * 8 - bits);
	bit_mask &= (*number);
	bit_mask >>= (sizeof(*number) * 8 - bits);
	(*number) <<= bits;
	(*number) |= bit_mask;
}

void rotate_right(int *number, int bits)
{
	unsigned int bit_mask = -1;

	bit_mask >>= (sizeof(*number) * 8 - bits);
	bit_mask &= (*number);
	bit_mask <<= (sizeof(*number) * 8 - bits);
	(*number) >>= bits;
	(*number) |= bit_mask;
}

int main(void)
{
	int number;

	number = 0x80000000;
	rotate_left(&number, 1);
	printf("After left rotation:   %d\n", number);

	number = 0x00000001;
	rotate_right(&number, 16);
	printf("After right rotation:  %d\n", number);


	return 0;
}
