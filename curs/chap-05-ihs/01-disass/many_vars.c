#include <stdio.h>
#include <string.h>

unsigned int age = 10;
unsigned short new_age;

struct {
	unsigned int age;
	unsigned short occupation;
	unsigned int new_age;
	unsigned char location;
} s;

unsigned int v[4] = {10, 20, 30, 40};
unsigned int *p;

void g(void)
{
	s.age = 10;
	s.occupation = 20;
	s.new_age = 30;
	s.location = 40;

	v[2] = 1000;
	p = &v[2];
}

void f(void)
{
	new_age = age + 4;
}

unsigned long long alfa(void)
{
	return 119328984948393;
}

int main(void)
{
	return 0;
}
