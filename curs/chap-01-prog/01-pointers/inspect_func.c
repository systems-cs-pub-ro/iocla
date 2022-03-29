#include <stdio.h>

static void my_func(void)
{
	printf("Haha\n");

	/* Do nothing, successfully. */
}

int main(void)
{
	void (*f)(void);

	f = my_func;

	printf("my_func: %p\n", my_func);
	printf("&my_func: %p\n", &my_func);
	printf("main: %p\n", main);
	printf("&main: %p\n", &main);
	printf("f: %p\n", f);
	printf("&f: %p\n", &f);
	printf("*f: %p\n", *f);

	(*f)();
	f();

	return 0;
}
