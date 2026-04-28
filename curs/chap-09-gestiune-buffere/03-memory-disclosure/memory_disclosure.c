// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>
#include <stdint.h>

static void disclosure_target(uint64_t a, uint64_t b)
{
	size_t i;
	uint64_t buf[4];

	for (i = 0; i < 4; i++)
		buf[i] = (uint64_t)i * i * i;

	/* Walk backward from buf[9] to buf[1] to reveal the stack frame. */
	for (i = 9; i != 0; i--)
		printf("buf[%02zu] (address: %p) = 0x%016lx\n", i, &buf[i], buf[i]);
}

int main(void)
{
	/* The arguments are passed in RDI and RSI (64-bit calling convention). */
	disclosure_target(0xaabbccddaabbccddUL, 0x5566778855667788UL);
	return 0;
}
