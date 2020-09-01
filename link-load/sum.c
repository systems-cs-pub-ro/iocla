static int val = 3;
int gogu = 4;
int diff(int a, int b);
int (*p)(int, int) = diff;

int sum(int a, int b)
{
	return val+a+b;
}

int diff(int a, int b)
{
	return gogu+a-b;
	//return a-b;
}

int mul(int a, int b)
{
	return a*b;
}
