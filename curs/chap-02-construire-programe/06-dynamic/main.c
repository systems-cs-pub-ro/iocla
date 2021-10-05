#include "inc.h"

int main(void)
{
	unsigned int ret;

	init();
	increment();
	ret = read();
	print();

	return 0;
}
