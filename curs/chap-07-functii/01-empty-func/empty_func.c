int h(int a)
{
	return 10;
}

void g(int a)
{
	h(300);
}

void f(int a)
{
	g(200);
}

int main(void)
{
	f(100);
	return 0;
}
