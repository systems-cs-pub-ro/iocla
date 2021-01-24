#include <stdio.h>

static void hi(void)
{
	puts("Hi!");
}

static void bye(void)
{
	puts("Bye!");
}

int my_main(void)
{
	hi();
	bye();
}
