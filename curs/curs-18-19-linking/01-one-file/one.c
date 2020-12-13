unsigned int num_items = 10;

void increment(void)
{
	num_items++;
}

int main(void)
{
	num_items = 5;
	increment();

	return 0;
}
