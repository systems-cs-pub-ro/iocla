// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void)
{
	/* Initialize the random number generator with the current time as seed. */
	srand(time(NULL));

	/* Generate a random number and print it. */
	printf("Random number: %d\n", rand());

	return 0;
}
