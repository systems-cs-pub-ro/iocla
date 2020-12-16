#include <stdio.h>

void alpha(unsigned int a);
unsigned int beta(unsigned int b);
void omega(unsigned int c);

int main(void)
{
	unsigned int ret;

	alpha(0);
	ret = beta(0);
	printf("ret: %u\n", ret);
	omega(0); 

	return 0;
}
