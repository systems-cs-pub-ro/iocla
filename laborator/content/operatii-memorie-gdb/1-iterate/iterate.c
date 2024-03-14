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

	short *s;
	s=(short*)v;

	int i;
	for (i = 0; i < 10; i++)
	{
		printf("Adresa: %p\nValoare: %hx\n\n",s+i,*(s+i));
	}
	
	char *c;
	c=(char*)v;

	for (i = 0; i < 20; i++)
	{
		printf("Adresa: %p\nValoare: %hhx\n\n",c+i,*(c+i));
	}
	
	(void) v;

	return 0;
}
