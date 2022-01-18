extern unsigned int num_items;

static void increment(void);
void (*operator)(void) = increment;

static void increment(void)
{
	num_items++;
}
