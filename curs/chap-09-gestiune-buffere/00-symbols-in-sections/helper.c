#include <stdio.h>

static int stana;
unsigned short int ana = 2;
static unsigned short int bogdan = 6;

extern unsigned short int bogdan;

void f(void);

static void g(void)
{
	printf("bogdan: %hu\n", bogdan);
	f();
}

void h(void)
{
	g();
}
