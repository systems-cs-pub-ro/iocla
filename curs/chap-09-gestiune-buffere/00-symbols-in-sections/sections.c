#include <stdio.h>

unsigned short int ana = 1;
static unsigned int stana;
static const unsigned long int laptita;

unsigned short int bogdan = 4;
static unsigned int dan = 6;
static const unsigned long int stan = 7;

const unsigned char age = 20;

void h(void);

void f(void)
{
	static unsigned int local = 500;
	puts("in vino veritas");
}

static void g(void)
{
	static const unsigned int local = 300;
}

int main(void)
{
	unsigned int my;
	static unsigned int local;
	printf("ana = %d bogdan = %d\n", ana, bogdan);
	
	h();

	return 0;
}
