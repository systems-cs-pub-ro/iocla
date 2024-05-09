#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	long long l = 0x2211ffeeddccbbaaLL;
	int vi[2] = {0xddccbbaa, 0x2211ffee};
	short vs[4] = {0xbbaa, 0xddcc, 0xffee, 0x2211};
	char vc[8] = {0xaa, 0xbb, 0xcc, 0xdd, 0xee,0xff, 0x11, 0x22};
	FILE *f;

	f = fopen("g.dat", "w+");
	if (f == NULL) {
		perror("fopen");
		exit(EXIT_FAILURE);
	}
	fwrite(&l, sizeof(l), 1, f);
	fwrite(vi, sizeof(vi), 1, f);
	fwrite(vs, sizeof(vs), 1, f);
	fwrite(vc, sizeof(vc), 1, f);
	fclose(f);

	return 0;
}
