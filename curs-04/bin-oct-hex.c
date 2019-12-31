#include <stdio.h>

int main(void)
{
	unsigned char h = 0xab;  // 0b 1010 (a) 1011 (b)
	unsigned char o = 063;   // 0b 00 (padding) 110 (6) 011 (3)

	printf("h: 0x%02x, h: 0%02o\n", h, h);
	printf("o: 0x%02x, o: 0%03o\n", o, o);

	return 0;
}
