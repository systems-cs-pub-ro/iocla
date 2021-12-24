/* export */
unsigned int num_items = 10;

/* import */
extern void increment(void);

/* export */
int main(void)
{
	num_items = 5;
	increment();

	return 0;
}
