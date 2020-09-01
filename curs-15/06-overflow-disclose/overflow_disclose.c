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

/* 
   buffer[32..35] = 0xdd 0xcc 0xbb 0xaa 
   buffer[36..39] = 0, probably for alignment
   buffer[40..43] = EBP from main
   buffer[44..47] = 0x9d 0x85 0x04 0x08 - return address, verify
   = 0 old EBP 
   = 0x37 0x26 0x57 0xf7 = return outside main 
   = 0x01 0x00 0x00 0x00 = argc = 1 argument 
   = 0xb4 0x7a 0x9d 0xff = **argv 
 */

int main(int argc, char **argv)
{
	see_beyond();

	return 0;
}
