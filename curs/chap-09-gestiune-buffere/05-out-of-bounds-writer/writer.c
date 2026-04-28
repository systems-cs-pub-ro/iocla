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

	if (strncmp(buffer, "0x", 2) == 0)
		*out = strtol(buffer, &endptr, 16);
	else
		*out = strtol(buffer, &endptr, 10);
	if (*endptr != '\0')
		return -1;

	return 0;
}

void hidden_function(void)
{
	printf("Well done, you called me.\n");
	exit(EXIT_SUCCESS);
}

static void disclosure_target(uint64_t a, uint64_t b)
{
	size_t i;
	uint64_t buf[4];

	for (i = 0; i < 4; i++)
		buf[i] = (uint64_t)i * i * i;

	/* Phase 1 – arbitrary read: explore the stack frame. */
	while (1) {
		long index;

		printf("Index to disclose: "); fflush(stdout);
		if (read_long(&index) < 0) {
			fprintf(stderr, "Invalid index. Ending read phase.\n");
			break;
		}
		printf("buf[%ld] (address: %p) = 0x%016lx\n",
		       index, &buf[index], buf[index]);
	}

	/* Phase 2 – arbitrary write: overwrite any stack slot. */
	while (1) {
		long index;
		long value;

		printf("Index to overwrite: "); fflush(stdout);
		if (read_long(&index) < 0) {
			fprintf(stderr, "Invalid index. Ending write phase.\n");
			break;
		}
		printf("Value to overwrite: "); fflush(stdout);
		if (read_long(&value) < 0) {
			fprintf(stderr, "Invalid value. Ignoring.\n");
			continue;
		}
		buf[index] = (uint64_t)value;
	}

	printf("i = %zu\n", i);
}

int main(void)
{
	disclosure_target(0xaabbccddaabbccddUL, 0x5566778855667788UL);
	printf("exit to shell\n");
	return 1;
}
