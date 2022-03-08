#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int my_strlen(const char* str)
{
	/* TODO */
    int nr = 0;
    while (*(str + nr++));
	return nr - 1;
}

void equality_check(const char* str)
{
	/* TODO */
	int p = 1;
	int n = my_strlen(str);
	for (int i = 0; i < n; ++i) {
		if (!(*(str + i) ^ *(str + ((i + p) % n))))
			printf("The address of %c is %p\n", *(str + i), str + i);
        p <<= 1;
	}
}

int main(void)
{
	/* TODO: Test functions */
	char str[100];
	scanf("%s", str);
	printf("The length of str is %d \n", my_strlen(str));
	equality_check(str);
	return 0;
}
