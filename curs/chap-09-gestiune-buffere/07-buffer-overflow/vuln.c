#include <stdio.h>

static const char secret_message[] = "Acknowledged H.Q.";
static const char can_do_things[] = "Let's crash";

static void secret_param_func(unsigned int p, unsigned int q)
{
	if (p == 0x12345678 && q == 0xabcdef01)
		puts("Systems functional.");
}

static void secret_func(void)
{
	puts("Channel open.");
}

static void visible_func(void)
{
	unsigned int s = 0x42424242;
	char buffer[64];

	printf("Please enter your message: ");
	fgets(buffer, 128, stdin);
	printf("You've entered: %s\n", buffer);

	if (s == 0x5a5a5a5a)
		puts("Comm-link online.");
}

int main(int argc, char **argv)
{
	puts("Go ahead, TACCOM");
	visible_func();
	return 0;
}
