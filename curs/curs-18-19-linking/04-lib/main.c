#include "inc.h"

int main(void)
{
	unsigned int ret;

	init();
	increment();
	ret = read();

	return 0;
}
