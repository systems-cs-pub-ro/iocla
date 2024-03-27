extern int qty;

void set_price(int );
void print_price();
void print_quantity();

int main(void)
{
	/*
	 * TODO: Make it so you print:
	 *    price is 21
	 *    quantity is 42
	 * without directly calling a printing function from an existing
	 * library(do NOT use printf, fprintf, fwrite, ...).
	 */
	qty = 5;
	set_price(qty);
	print_price();
	print_quantity();

	return 0;
}
