#include <stdio.h>

static void my_func(void)
{
	/* Do nothing, successfully. */
}

int main(void)
{
	void (*f)(void) = my_func;

	printf("my_func: %p\n", my_func);
	printf("&my_func: %p\n", &my_func);
	printf("main: %p\n", main);
	printf("&main: %p\n", &main);
	printf("f: %p\n", f);
	printf("&f: %p\n", &f);

	return 0;
}
