// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

int main(void)
{
	char rdtscp_str[13];

	__asm__ (""
	/* TODO: Make rdtscp call and copy string in rdtscp_str.
	 * After rdtscp call result is placed in (EDX:EAX registers).
	 */
	);

	rdtscp_str[12] = '\0';

	printf("rdtscp string: %s\n", rdtscp_str);

	return 0;
}
