#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NMAX 100

int my_strlen(const char *str)
{
	const char *p = str;
	while(*(p++));
	return p - str - 1;
}

void equality_check(const char *str)
{
	for (int i = 0, l = my_strlen(str); i < l; ++i)
		// if (str[i] == str[(i + 2^i) % l])
		if (!(*(str + i) ^ *(str + (i + (1 << i)) % l)))
			printf("Address of %c: %p\n", *(str + i), str + i);
}

int main(void)
{
	char s[NMAX + 1];
	scanf("%s", &s);
	printf("length = %d\n", my_strlen(s));
	equality_check(s);
	return 0;
}

