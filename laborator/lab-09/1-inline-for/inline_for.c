#include <stdio.h>

#define NUM	100

int main(void)
{
	size_t n = NUM;
	size_t sum = 0;



	__asm__ (
	"xor eax, eax\n\t" /* collect the sum in eax */
	/* use ecx to go through items, start from n */
	"mov ecx, %1\n"
	"add_to_sum:\n\t"
	"add eax, ecx\n\t"
	"loopnz add_to_sum\n\t"
	/* place sum in output register */
	"mov %0, eax\n\t"
	: "=r" (sum) /* output variable */
	: "r" (n) /* input variable */
	: "eax", "ecx" ); /* registers used in the assembly code */

	printf("sum(%u): %u\n", n, sum);

	return 0;
}
