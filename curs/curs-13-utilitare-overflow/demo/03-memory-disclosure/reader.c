#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

static int read_int(int *out)
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

static void disclosure_target(unsigned int a, unsigned int b)
{
	size_t i;
	unsigned int buf[4];

	for (i = 0; i < 4; i++)
		buf[i] = i * i * i;

	while (1) {
		int index;
		printf("Index to disclose: "); fflush(stdout);
		if (read_int(&index) < 0) {
			fprintf(stderr, "Invalid index read. Exiting.\n");
			break;
		}
		printf("buf[%d] (address: %p) = 0x%08x\n", index, &buf[index], buf[index]);
	}
}

int main(void)
{
	disclosure_target(0xaabbccdd, 0x55667788);
	return 0;
}
