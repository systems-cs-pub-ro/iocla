// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static unsigned char g_buffer[128];

static void see_beyond(void)
{
	int value = 0xaabbccdd;
	char buffer[32];
	size_t i;

	printf("gimme data: ");
	fgets(buffer, 32, stdin);

	memcpy(g_buffer, buffer, 128);
	printf("g_buffer is [\n");
	for (i = 0; i < 128; i++)
		printf("  [%02zu] 0x%02x\n", i, g_buffer[i]);
	printf("]\n");
}

int main(int argc, char **argv)
{
	see_beyond();
	return 0;
}
