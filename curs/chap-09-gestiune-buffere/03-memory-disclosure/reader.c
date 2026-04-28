// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

static int read_long(long *out)
{
	char buffer[32];
	char *endptr;

	fgets(buffer, 32, stdin);
	if (buffer[strlen(buffer)-1] == '\n')
		buffer[strlen(buffer)-1] = '\0';

	if (buffer[0] == '\0')
		return -1;

	*out = strtol(buffer, &endptr, 10);
	if (*endptr != '\0')
		return -1;

	return 0;
}

static void disclosure_target(uint64_t a, uint64_t b)
{
	size_t i;
	uint64_t buf[4];

	for (i = 0; i < 4; i++)
		buf[i] = (uint64_t)i * i * i;

	while (1) {
		long index;
		printf("Index to disclose: "); fflush(stdout);
		if (read_long(&index) < 0) {
			fprintf(stderr, "Invalid index read. Exiting.\n");
			break;
		}
		printf("buf[%ld] (address: %p) = 0x%016lx\n", index, &buf[index], buf[index]);
	}
}

int main(void)
{
	disclosure_target(0xaabbccddaabbccddUL, 0x5566778855667788UL);
	return 0;
}
