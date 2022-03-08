#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void mirror(char* s)
{
	/* TODO */
	int l = strlen(s);
	for (int i = 0; i < l / 2; ++i) {
		char str = *(s + i);
		*(s + i) = *(s + l - i - 1);
		*(s + l - i - 1) = str;
	}
	printf("%s\n", s);
}

int main()
{
	/* TODO: Test function */
	char s[100];
	scanf("%s", s);
	mirror(s);
	return 0;
}

