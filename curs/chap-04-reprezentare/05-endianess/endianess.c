#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	int a = 1; // 0x00000001
	int b = 0xaabbccdd;
	short s1 = 0x1122;
	short s2 = 0xa; // 0x000a
	long long l1 = 5; // 0x0000000000000005
	long long l2 = 0x1122334455667788LL;
	FILE *f;

	f = fopen("f.dat", "w+");
	if (f == NULL) {
		perror("fopen");
		exit(EXIT_FAILURE);
	}
	fwrite(&a, sizeof(a), 1, f);
	fwrite(&b, sizeof(b), 1, f);
	fwrite(&s1, sizeof(s1), 1, f);
	fwrite(&s2, sizeof(s2), 1, f);
	fwrite(&l1, sizeof(l1), 1, f);
	fwrite(&l2, sizeof(l2), 1, f);
	fclose(f);

	return 0;
}
