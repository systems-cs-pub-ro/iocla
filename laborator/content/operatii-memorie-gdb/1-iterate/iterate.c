// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>

/*
 * Afisati adresele elementelor din vectorul "v" impreuna cu valorile
 * de la acestea.
 * Parcurgeti adresele, pe rand, din octet in octet,
 * din 2 in 2 octeti si apoi din 4 in 4.
 */

int main(void)
{
	int v[] = {0xCAFEBABE, 0xDEADBEEF, 0x0B00B135, 0xBAADF00D, 0xDEADC0DE};
	int nr_elem = sizeof(v)/sizeof(int);
	printf("nr elemente: %d\n", nr_elem);
	(void) v;
	unsigned char *char_ptr = v;
	//octet cu octet
	printf("%s", "din octet in octet:\n");
	for (int i = 1; i <= 4*nr_elem; i++){
		printf("%p -> 0x%hx\n", char_ptr, *char_ptr);
		char_ptr++;
	}
	//din 2 in 2 octeti
	printf("%s", "din 2 in 2 octeti:\n");
	short *ptr = v;
	for (int i = 1; i <= 2*nr_elem; i++){
		printf("%p -> 0x%hx\n", ptr, *ptr);
		ptr++;
	}
	//din 4 in 4 octeti
	printf("%s", "din 4 in 4 octeti:\n");
	int *int_ptr = v;
	for (int i = 1; i <= nr_elem; i++){
		printf("%p -> 0x%x\n", int_ptr, *int_ptr);
		int_ptr++;
	}
	return 0;
}
