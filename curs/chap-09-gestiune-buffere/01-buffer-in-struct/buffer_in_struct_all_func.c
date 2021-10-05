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

static void demo_out_of_bounds(struct container *c, const char *suffix)
{
	c->id = 1;
	c->type = 1;
	printf("c_%s->id: %u, c_%s->type: %u\n", suffix, c->id, suffix, c->type);

	c->items[-1] = 555;
	c->items[32] = 999;
	printf("c_%s->id: %u, c_%s->type: %u\n", suffix, c->id, suffix, c->type);

}

int main(void)
{
	struct container c;
	struct container *c_heap = malloc(sizeof(*c_heap));

	demo_out_of_bounds(&c, "stack");
	demo_out_of_bounds(&c_data, "data");
	demo_out_of_bounds(&c_bss, "bss");
	demo_out_of_bounds(c_heap, "heap");

	return 0;
}
