#include <stdio.h>

unsigned int fibonacci(unsigned int n)
{
	if (n == 0 || n == 1)
		return 1;
	else
		return fibonacci(n-1) + fibonacci(n-2);
}

int main(void)
{
	fibonacci(10);

	return 0;
}
