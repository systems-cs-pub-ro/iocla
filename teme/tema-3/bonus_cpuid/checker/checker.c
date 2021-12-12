#include <stdio.h>

extern void cpu_manufact_id(char *s);
extern void features(int *vmx, int *rdrand, int *avx);
extern void l2_cache_info(int *line_size, int *cache_size);

int main(void)
{
	char id[13] = { 0 };
	int vmx = -1, rdrand = -1, avx = -1;
	int line_size = -1, cache_size = -1;

	cpu_manufact_id(id);
	printf("Manufacturer ID: %s\n", id);

	features(&vmx, &rdrand, &avx);
	printf("VMX: %d, RDRAND: %d, AVX: %d\n", vmx, rdrand, avx);

	l2_cache_info(&line_size, &cache_size);
	printf("Line size: %d B, Cache Size: %d KB\n", line_size, cache_size);

	return 0;
}