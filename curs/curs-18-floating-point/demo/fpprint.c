#include <stdio.h>

static void print_bits(unsigned int m, unsigned int len)
{
	size_t i;

	for (i = len; i > 0; i--)
		printf("%u", (m & (1 << (i-1))) >> (i-1));
}

static void print_long_bits(unsigned long long m, unsigned int len)
{
	size_t i;

	for (i = len; i > 0; i--)
		printf("%llu", (m & (1ULL << (i-1))) >> (i-1));
}

static void print_float(float f)
{
	unsigned int s, e, m;
	unsigned int equiv = * ((unsigned int *) &f);

	s = equiv >> 31;
	e = (equiv & 0x7fffffff) >> 23;
	m = (equiv & 0x007fffff);

	printf("f: %f (0x%08x)\n", f, equiv);
	printf("s: %u, e: %u, m: %u (0x%08x) (", s, e, m, m);
	print_bits(m, 23);
	printf(")\n");
}

static void print_double(double d)
{
	unsigned long long s, e, m;
	unsigned long long equiv = * ((unsigned long long *) &d);

	s = equiv >> 63;
	e = (equiv & 0x7fffffffffffffffULL) >> 52;
	m = (equiv & 0x000fffffffffffffULL);

	printf("f: %lf (0x%016llx)\n", d, equiv);
	printf("s: %llu, e: %llu, m: %llu (0x%016llx) (", s, e, m, m);
	print_long_bits(m, 52);
	printf(")\n");
}

int main(void)
{
	print_float(2);
	print_float(4);
	print_float(0.5);
	print_float(0.125);
	print_float(6.125);
	print_float(4608);
	print_float(1.0/0.0);
	print_float(-10000.0/0.0);
	print_float(0.0/0.0);

	print_double(2);
	print_double(4);
	print_double(0.5);
	print_double(0.125);
	print_double(6.125);
	print_double(4608);
	print_double(1.0/0.0);
	print_double(-10000.0/0.0);
	print_double(0.0/0.0);

	{
		long double ld = 2;

		printf("ld: %Lf\n", ld);
		printf("sizeof(ld): %d\n", sizeof(ld));
	}

	return 0;
}
