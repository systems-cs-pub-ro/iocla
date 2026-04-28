// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>
#include <stdlib.h>

static const char secret_message[] = "Acknowledged H.Q.";

static void secret_func(void)
{
	puts("Channel open.");
	exit(EXIT_SUCCESS);
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
