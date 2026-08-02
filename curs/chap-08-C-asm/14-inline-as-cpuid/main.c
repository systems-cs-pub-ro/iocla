// SPDX-License-Identifier: BSD-3-Clause

/* Inline assembly example: call the cpuid instruction from C.
 * cpuid returns processor identification and feature information.
 * Input:  eax = leaf (function number)
 * Output: eax, ebx, ecx, edx contain the result.
 */

#include <stdio.h>

int main(void)
{
	unsigned int eax, ebx, ecx, edx;

	/* Call cpuid with leaf 0 (vendor string). */
	__asm__ volatile (
		"cpuid"
		: "=a"(eax), "=b"(ebx), "=c"(ecx), "=d"(edx)
		: "a"(0)
	);

	printf("cpuid leaf 0:\n");
	printf("  eax = 0x%08x\n", eax);
	printf("  ebx = 0x%08x\n", ebx);
	printf("  ecx = 0x%08x\n", ecx);
	printf("  edx = 0x%08x\n", edx);

	/* The vendor string is in ebx, edx, ecx (in that order). */
	printf("Vendor: %.4s%.4s%.4s\n",
		(char *)&ebx, (char *)&edx, (char *)&ecx);

	return 0;
}
