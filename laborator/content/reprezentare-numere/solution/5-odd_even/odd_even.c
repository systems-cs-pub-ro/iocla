// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

void print_binary(int number, int nr_bits)
{
	int   i;
	char *bits = malloc(sizeof(*bits) * nr_bits);

	if (bits == NULL) {
		perror("malloc() failed while allocating `bits`");
		exit(errno);
	}

	for (i = 0; i < nr_bits; ++i) {
		*(bits + i) = 1 & number;
		number >>= 1;
	}

	printf("0b");
	for (i = nr_bits - 1; i >= 0; --i)
		printf("%d", *(bits + i));
	printf("\n");

	free(bits);
}

void check_parity(int *numbers, int n)
{
	int i, curr_nr;

	for (i = 0; i < n; ++i) {
		curr_nr = *(numbers + i);
		printf("%5d: ", curr_nr);
		if (curr_nr & 1)
			printf("0x%08X\n", curr_nr);
		else
			print_binary(curr_nr, 8);
	}
}

int main(void)
{
	int *numbers, i, n;

	printf("Size of array: "); scanf("%d", &n);

	numbers = malloc(sizeof(*numbers) * n);

	if (numbers == NULL) {
		perror("malloc() failed while allocating `numbers`");
		exit(errno);
	}

	for (i = 0; i < n; ++i) {
		printf("Number %d: ", i + 1);
		scanf("%d", numbers + i);
	}

	check_parity(numbers, n);

	free(numbers);

	return EXIT_SUCCESS;
}
