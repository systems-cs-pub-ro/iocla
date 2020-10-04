#include <stdio.h>
#include <stdlib.h>

struct container {
	unsigned int id;
	unsigned int items[32];
	unsigned int type;
	void *data;
};

static struct container c_data = { 1, {0,}, 1, NULL };
static struct container c_bss;

int main(void)
{
	struct container c;
	struct container *c_heap = malloc(sizeof(*c_heap));

	c.id = 1;
	c.type = 1;
	printf("c.id: %u, c.type: %u\n", c.id, c.type);

	c.items[-1] = 555;
	c.items[32] = 999;
	printf("c.id: %u, c.type: %u\n", c.id, c.type);

	printf("c_data.id: %u, c_data.type: %u\n", c_data.id, c_data.type);
	c_data.items[-1] = 555;
	c_data.items[32] = 999;
	printf("c_data.id: %u, c_data.type: %u\n", c_data.id, c_data.type);

	c_bss.id = 1;
	c_bss.type = 1;
	printf("c_bss.id: %u, c_bss.type: %u\n", c_bss.id, c_bss.type);

	c_bss.items[-1] = 555;
	c_bss.items[32] = 999;
	printf("c_bss.id: %u, c._bss.type: %u\n", c_bss.id, c_bss.type);

	c_heap->id = 1;
	c_heap->type = 1;
	printf("c_heap->id: %u, c_heap->type: %u\n", c_heap->id, c_heap->type);

	c_heap->items[-1] = 555;
	c_heap->items[32] = 999;
	printf("c_heap->id: %u, c_heap->type: %u\n", c_heap->id, c_heap->type);

	return 0;
}
