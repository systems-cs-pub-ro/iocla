#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NMAX 100

void mirror(char *s)
{
	for (int i = 0, l = strlen(s); i < l / 2; ++i)
		// swap s[i] and s[l - i - 1]
		*(s + i) ^= *(s + l - i - 1) ^= *(s + i) ^= *(s + l - i - 1);
}

int main()
{
	char s[NMAX + 1];
	scanf("%s", s);

	mirror(s);

	printf("%s\n", s);
	return 0;
}
