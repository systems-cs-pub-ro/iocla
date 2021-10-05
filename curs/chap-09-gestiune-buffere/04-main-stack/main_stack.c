#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	argv[0][strlen(argv[0])-1] = 'u';
	if (argv[0][strlen(argv[0])-1] == 'u')
		puts(argv[0]);

	puts(getenv("PATH"));
	setenv("PATH", ".", 1);
	puts(getenv("PATH"));
	system("ps");

	return 0;
}
