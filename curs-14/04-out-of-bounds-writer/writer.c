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

void hidden_function(void)
{
	printf("Well done, you called me.\n");
	exit(EXIT_SUCCESS);
}

void secret_function(unsigned int a, unsigned int b)
{
	if (a == 0x42424242 && b == 0x6a6a6a6a)
		printf("pwned! Aw3s0m3 sk1llz!\n");
	exit(EXIT_SUCCESS);
}

void stealth_function(unsigned int a, unsigned int b)
{
  if (a != 0x42424242 || b != 0x6a6a6a6a){
    exit(2);
  }
  printf("called stealth function\n");
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
			fprintf(stderr, "Invalid index read. Ending.\n");
			break;
		}
		printf("buf[%d] (address: %p) = 0x%08x\n", index, &buf[index], buf[index]);
	}

	while (1) {
		int index;
		int value;
		printf("Index to overwrite: "); fflush(stdout);
		if (read_int(&index) < 0) {
			fprintf(stderr, "Invalid index read. Ending.\n");
			break;
		}
		printf("Value to overwrite: "); fflush(stdout);
		if (read_int(&value) < 0) {
			fprintf(stderr, "Invalid value read. Ignoring.\n");
			continue;
		}
		buf[index] = value;
	}

	printf("i = %u\n", i);
}

int main(void)
{
	disclosure_target(0xaabbccdd, 0x55667788);
	printf("exit to shell\n");
	return 1;
}
