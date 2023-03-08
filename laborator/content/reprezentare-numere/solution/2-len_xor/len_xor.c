// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define STR_SIZE 512

char *new_string(const char *cont_str)
{
	char *res;

	res = calloc(STR_SIZE, sizeof(char));
	strcpy(res, cont_str);

	return res;
}

int my_strlen(const char *str)
{
	int res;

	for (res = 0; *str; ++str)
		++res;

	return res;
}

void xor_check(const char *str)
{
	int i, n;
	char curr_char, check_char;

	n = my_strlen(str);
	for (i = 0; i < n; ++i) {
		curr_char = *(str + i);
		check_char = *(str + ((i + (1 << i)) % n));
		if (!(curr_char ^ check_char))
			printf("Address of %c: %p\n", curr_char, str + i);
	}
	printf("\n");
}

int main(void)
{
	char *str;

	str = new_string("ababababacccbacbacbacbacbabc");

	printf("len(\"%s\") = %d\n", str, my_strlen(str));
	xor_check(str);

	// free memory
	free(str);

	return 0;
}
