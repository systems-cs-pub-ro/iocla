#include <stdio.h>

unsigned char uc = 0xaa;
signed char sc = 0xaa;

short int si = -1;
unsigned int ui;

int main(void)
{
	printf("%hhu, %hhd\n", uc, sc);

	ui = si;
	printf("si (%p): 0x%08x, si: %u, si: %d\n", &si, si, si, si);
	printf("ui (%p): 0x%08x, ui: %u, ui: %d\n", &ui, ui, ui, ui);

	return 0;
}
