#include <stdio.h>
#include <stdlib.h>

static void away(int a)
{
	if (a == 1000)
		exit(0);
}

static void hidden2(void)
{
	puts("bye");
}

static void hidden(void)
{
	puts("gotcha");
}

static void reader(void)
{
	char buf[32];

	puts("reader");
	fgets(buf, 128, stdin);
}

int main(void)
{
	puts("main");
	reader();
	return 0;
}
