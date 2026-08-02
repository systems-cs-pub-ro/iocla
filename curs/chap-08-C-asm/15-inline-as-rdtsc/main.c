// SPDX-License-Identifier: BSD-3-Clause

/* Inline assembly example: call the rdtsc instruction from C.
 * rdtsc (Read Time-Stamp Counter) returns the number of CPU cycles
 * since reset in edx:eax (high 32 bits in edx, low 32 bits in eax).
 */

#include <stdio.h>
#include <stdint.h>

int main(void)
{
	uint32_t lo, hi;
	uint64_t tsc;

	/* Call rdtsc; result in edx:eax. */
	__asm__ volatile (
		"rdtsc"
		: "=a"(lo), "=d"(hi)
	);

	tsc = ((uint64_t)hi << 32) | lo;
	printf("TSC value: %lu\n", tsc);

	return 0;
}
