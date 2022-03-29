void g(int a, int b)
{
}

void f(int a, int b)
{
	g(3, 4);
}

int main(void)
{
	f(1, 2);
	return 0;
}
