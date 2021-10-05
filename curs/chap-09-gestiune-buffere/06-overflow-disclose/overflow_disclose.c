#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

static unsigned char g_buffer[64];

static void see_beyond(void)
{
	int value = 0xaabbccdd;
	char buffer[32];
	size_t i;

	printf("gimme data: ");
	fgets(buffer, 32, stdin);

	memcpy(g_buffer, buffer, 64);
	printf("g buffer is [ ");
	for (i = 0; i < 64; i++)
		printf("0x%02x ", g_buffer[i]);
	printf("]\n");
}

int main(int argc, char **argv)
{
	see_beyond();

	return 0;
}
