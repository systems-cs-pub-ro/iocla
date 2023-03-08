/*
 * Author: Gabriel Mocanu <gabi.mocanu98@gmail.com>
 */


#include <stdio.h>

int main(void)
{
	int var;
	int *p = (int *) 250;

	printf("p : %p\n", p);
	printf("p : %p\n", &p);
	printf("var : %p\n", &var);

	p = &var;
	printf("p : %p\n", p);

	p = p + 4;
	printf("p : %p\n", p);

	*p = &var;
	printf("p : %p\n", &p);
	printf("var : 0x%08x\n", var);

	return 0;
}
