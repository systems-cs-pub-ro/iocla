#include <stdio.h>
#include "state.h"

int main(void)
{
	size_t i;

	shopping_list();
	for (i = 0; i < sizeof(init_shopping) / sizeof(init_shopping[0]); i++)
		printf("%s\n", init_shopping[i]);

	return 0;
}
