#include <stdio.h>

struct container {
	unsigned int id;
	unsigned int items[32];
	unsigned int type;
	void *data;
};

int main(void)
{
	struct container c;
	/*
	  c.id and c.type are on the stack which grows downwards, 
	  but id, items and type are at consecutive addresses.
	 */
	c.id = 1;
	c.type = 1;
	printf("c.id: %u, c.type: %u\n", c.id, c.type);

	c.items[-1] = 555;
	c.items[32] = 999;
	printf("c.id: %u, c.type: %u\n", c.id, c.type);

	return 0;
}
